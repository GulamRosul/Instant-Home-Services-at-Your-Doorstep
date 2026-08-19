import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/call_service.dart';
import 'package:protiva502/core/services/location_tracking_service.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/features/chat/screen/single_chat_screen.dart';

class TrackProviderController extends GetxController {
  // Socket.IO Service
  late LocationTrackingService socketService;

  // Role - determined on init
  late Rx<String> userRole = "user".obs; // "user" or "provider"

  // Person Info - Observable rxn fields for dynamic updates
  late Rx<String> personName = "Mike Handyman".obs;
  late Rx<String> serviceName = "Handyman service".obs;
  late Rx<String> location = "Toronto, Canada".obs;
  late Rx<String> rating = "4.8 (170 Reviews)".obs;
  late Rx<String> personCost =
      "৳ 20.00".obs; // Cost for user view, Earnings for provider view
  late Rx<String> bookingId = ''.obs;

  // Tracking Data - Observable for real-time updates
  late Rx<double> providerLatitude = 23.8103.obs;
  late Rx<double> providerLongitude = 90.4125.obs;
  late Rx<double> userLatitude = 23.8110.obs;
  late Rx<double> userLongitude = 90.4140.obs;
  final hasProviderLocation = false.obs;
  final hasUserLocation = false.obs;
  final userLocationDetails = ''.obs;
  late Rx<String> estimatedTime = "12 mins".obs;
  late Rx<String> distance = "2.4 km".obs;
  late Rx<bool> isPersonOnline = true.obs;
  late Rx<String> trackingStatus = "Connected".obs;

  String? _currentUserId;
  String? _otherUserId;
  StreamSubscription<Position>? _providerLocationSubscription;

  @override
  void onInit() {
    super.onInit();
    _loadProviderDetails();
    _initializeSocket();
  }

  void _loadProviderDetails() {
    // Check if role was passed via Get.arguments (priority over storage)
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      if (arguments.containsKey('userRole')) {
        userRole.value = arguments['userRole'];
      } else {
        // Determine user role from storage
        userRole.value = StorageService.getRole() ?? "user";
      }
    } else {
      // Determine user role from storage
      userRole.value = StorageService.getRole() ?? "user";
    }

    // Load person details
    if (arguments != null) {
      if (arguments is Map<String, dynamic>) {
        personName.value =
            arguments['personName'] ??
            arguments['providerName'] ??
            personName.value;
        serviceName.value = arguments['serviceName'] ?? serviceName.value;
        location.value = arguments['location'] ?? location.value;
        rating.value = arguments['rating'] ?? rating.value;
        personCost.value =
            arguments['personCost'] ?? arguments['cost'] ?? personCost.value;
        bookingId.value = _resolveBookingId(arguments);
        _currentUserId = arguments['userId'];
        userLocationDetails.value = _resolveUserLocationDetails(arguments);

        final initialUserLatitude = _resolveCoordinate(
          arguments,
          primaryKey: 'userLocationLatitude',
          fallbackKey: 'locationLatitude',
        );
        final initialUserLongitude = _resolveCoordinate(
          arguments,
          primaryKey: 'userLocationLongitude',
          fallbackKey: 'locationLongitude',
        );

        if (initialUserLatitude != null && initialUserLongitude != null) {
          userLatitude.value = initialUserLatitude;
          userLongitude.value = initialUserLongitude;
          hasUserLocation.value = true;
        }

        // For provider role, other user ID should be clientId
        // For user role, other user ID should be providerId
        if (userRole.value == 'provider') {
          _otherUserId =
              arguments['clientId'] ??
              arguments['personId'] ??
              arguments['providerId'];
        } else {
          _otherUserId = arguments['providerId'] ?? arguments['personId'];
        }
      }
    }

    // Get current user ID from storage if not set
    _currentUserId ??= StorageService.getUserId();

    // Get other user ID from storage as fallback - but NOT from the same userId
    if (_otherUserId == null || _otherUserId!.isEmpty) {
      // This is a fallback - ideally arguments should always have the other user ID
      _otherUserId =
          _currentUserId; // Will be handled in messagePerson with validation
    }
  }

  /// Initialize Socket.IO connection for tracking
  Future<void> _initializeSocket() async {
    socketService = LocationTrackingService();

    // Setup callbacks
    socketService.onLocationBroadcast = _handleLocationBroadcast;
    socketService.onTrackingState = _handleTrackingState;
    socketService.onTrackingError = _handleTrackingError;

    // Join tracking room - extract booking ID
    final rawBookingId = bookingId.value.replaceAll('#', '').trim();
    if (rawBookingId.isEmpty) {
      trackingStatus.value = 'Booking ID missing';
      return;
    }

    trackingStatus.value = 'Connecting...';

    final token = await SecureStorageService.getToken();

    await socketService.connect(
      userId: _currentUserId ?? 'user_123',
      token: token,
      timeout: const Duration(seconds: 30),
    );

    if (!socketService.isConnected) {
      trackingStatus.value = 'Error: Socket connection failed';
      return;
    }

    socketService.joinTrackingRoom(rawBookingId);
    socketService.requestLocationState();
    await _startProviderLocationUpdatesIfNeeded();
  }

  Future<void> _startProviderLocationUpdatesIfNeeded() async {
    if (userRole.value.toLowerCase() != 'provider') {
      return;
    }

    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      trackingStatus.value = 'Enable location service to share live movement';
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      trackingStatus.value = 'Location permission required for live tracking';
      return;
    }

    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _emitProviderLocation(currentPosition);
    } catch (e) {
      print('Unable to fetch provider current location: $e');
    }

    await _providerLocationSubscription?.cancel();
    _providerLocationSubscription =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 5,
          ),
        ).listen(
          _emitProviderLocation,
          onError: (error) {
            trackingStatus.value = 'Provider location stream error';
            print('Provider location stream error: $error');
          },
        );
  }

  void _emitProviderLocation(Position position) {
    final latitude = position.latitude;
    final longitude = position.longitude;
    final accuracy = position.accuracy < 0 ? 0.0 : position.accuracy;
    final speed = position.speed < 0 ? 0.0 : position.speed;
    final heading = position.heading < 0 ? 0.0 : position.heading;

    providerLatitude.value = latitude;
    providerLongitude.value = longitude;
    hasProviderLocation.value = true;

    socketService.updateLocation(
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      speed: speed,
      heading: heading,
    );
  }

  /// Handle location broadcast from provider
  void _handleLocationBroadcast(Map<String, dynamic> data) {
    try {
      final point = data['point'] is Map
          ? Map<String, dynamic>.from(data['point'])
          : <String, dynamic>{};
      final state = data['state'] is Map
          ? Map<String, dynamic>.from(data['state'])
          : <String, dynamic>{};

      final pointRole = point['role']?.toString().toUpperCase();

      // Provider location should be the dynamic location on the map.
      if (pointRole == 'PROVIDER' && point.containsKey('latitude')) {
        providerLatitude.value = (point['latitude'] as num).toDouble();
        hasProviderLocation.value = true;
      }
      if (pointRole == 'PROVIDER' && point.containsKey('longitude')) {
        providerLongitude.value = (point['longitude'] as num).toDouble();
        hasProviderLocation.value = true;
      }

      final providerState = state['provider'] is Map
          ? Map<String, dynamic>.from(state['provider'])
          : <String, dynamic>{};

      if (providerState.containsKey('latitude')) {
        providerLatitude.value = (providerState['latitude'] as num).toDouble();
        hasProviderLocation.value = true;
      }
      if (providerState.containsKey('longitude')) {
        providerLongitude.value = (providerState['longitude'] as num)
            .toDouble();
        hasProviderLocation.value = true;
      }

      // Update distance and ETA from state
      if (state.containsKey('distanceMeters')) {
        double distanceM = (state['distanceMeters'] as num).toDouble();
        distance.value = '${(distanceM / 1000).toStringAsFixed(1)} km';
      }
      if (state.containsKey('etaMinutes')) {
        estimatedTime.value = '${state['etaMinutes']} mins';
      }

      trackingStatus.value = "Live";
    } catch (e) {
      print('Error handling location broadcast: $e');
    }
  }

  /// Handle tracking state update
  void _handleTrackingState(Map<String, dynamic> data) {
    try {
      final state = data['state'] is Map
          ? Map<String, dynamic>.from(data['state'])
          : data;

      final providerState = state['provider'] is Map
          ? Map<String, dynamic>.from(state['provider'])
          : <String, dynamic>{};
      final clientState = state['client'] is Map
          ? Map<String, dynamic>.from(state['client'])
          : (state['user'] is Map
                ? Map<String, dynamic>.from(state['user'])
                : <String, dynamic>{});
      final shouldSetInitialUserLocation = !hasUserLocation.value;

      if (providerState.containsKey('latitude')) {
        providerLatitude.value = (providerState['latitude'] as num).toDouble();
        hasProviderLocation.value = true;
      }
      if (providerState.containsKey('longitude')) {
        providerLongitude.value = (providerState['longitude'] as num)
            .toDouble();
        hasProviderLocation.value = true;
      }

      // Keep user location static when already supplied from booking/map args.
      if (shouldSetInitialUserLocation && clientState.containsKey('latitude')) {
        userLatitude.value = (clientState['latitude'] as num).toDouble();
      }
      if (shouldSetInitialUserLocation &&
          clientState.containsKey('longitude')) {
        userLongitude.value = (clientState['longitude'] as num).toDouble();
      }
      if (shouldSetInitialUserLocation &&
          clientState.containsKey('latitude') &&
          clientState.containsKey('longitude')) {
        hasUserLocation.value = true;
      }

      print(
        'Tracking State: User(${userLatitude.value}, ${userLongitude.value}) Provider(${providerLatitude.value}, ${providerLongitude.value})',
      );
    } catch (e) {
      print('Error handling tracking state: $e');
    }
  }

  /// Handle tracking errors
  void _handleTrackingError(String error) {
    trackingStatus.value = "Error: $error";
    print('Tracking error: $error');
  }

  /// Update User location to socket
  void updateUserLocation(double latitude, double longitude) {
    // Note: Provider uses location:update, but from user side we should
    // send their location if they are the one tracking
    socketService.updateLocation(
      latitude: latitude,
      longitude: longitude,
      accuracy: 10.0,
      speed: 0.0,
      heading: 0.0,
    );
  }

  /// Request current location state from server
  void requestLocationState() {
    socketService.requestLocationState();
  }

  // void callPerson() async {
  //   if (_otherUserId == null || _otherUserId!.trim().isEmpty) {
  //     Get.snackbar('Error', 'Unable to initiate call: Receiver ID not found');
  //     return;
  //   }

  //   if (_otherUserId == _currentUserId) {
  //     Get.snackbar('Error', 'Unable to initiate call: Invalid receiver');
  //     return;
  //   }

  //   final didSendInvitation = await CallService.instance.startAudioCall(
  //     targetUserId: _otherUserId!,
  //     targetUserName: personName.value,
  //     callID: bookingId.value.replaceAll('#', '').trim(),
  //   );

  //   final callId = bookingId.value.replaceAll('#', '').trim();
  //   final currentUserId = (_currentUserId ?? StorageService.getUserId() ?? '')
  //       .trim();
  //   final currentUserName = StorageService.getDisplayName() ?? 'User';

  //   AppLoggerHelper.info(
  //     'Call invitation sent: targetUserId=$_otherUserId, targetUserName=${personName.value}, callID=${bookingId.value}, success=$didSendInvitation',
  //   );

  //   if (currentUserId.isEmpty || callId.isEmpty) {
  //     Get.snackbar('Call Failed', 'Missing local user/call information');
  //     return;
  //   }

  //   if (!didSendInvitation) {
  //     AppLoggerHelper.warning(
  //       'Call invitation failed reason: ${CallService.instance.lastError ?? 'Unknown'}',
  //     );

  //     Get.snackbar(
  //       'Call Invite Failed',
  //       'Receiver may be offline. Opening direct call room...',
  //     );

  //     Get.to(
  //       () => AudioCallPage(
  //         callID: callId,
  //         userID: currentUserId,
  //         userName: currentUserName,
  //         initialStatus: 'Connecting...',
  //       ),
  //     );
  //     return;
  //   }

  //   Get.to(
  //     () => AudioCallPage(
  //       callID: callId,
  //       userID: currentUserId,
  //       userName: currentUserName,
  //       initialStatus: 'Ringing...',
  //     ),
  //   );

  //   print('Call invitation sent to ${personName.value}');
  // }

  // void callPerson() async {
  //   if (_otherUserId == null || _otherUserId!.trim().isEmpty) {
  //     Get.snackbar('Error', 'Unable to initiate call: Receiver ID not found');
  //     return;
  //   }

  //   if (_otherUserId == _currentUserId) {
  //     Get.snackbar('Error', 'Unable to initiate call: Invalid receiver');
  //     return;
  //   }

  //   // ✅ Just send invitation — Zego handles UI automatically
  //   final didSend = await CallService.instance.startAudioCall(
  //     targetUserId: _otherUserId!,
  //     targetUserName: personName.value,
  //     callID: bookingId.value.replaceAll('#', '').trim(),
  //   );

  //   if (!didSend) {
  //     AppLoggerHelper.warning(
  //       'Call invitation failed: ${CallService.instance.lastError ?? 'Unknown'}',
  //     );
  //     Get.snackbar(
  //       'Call Failed',
  //       CallService.instance.lastError ?? 'Unable to reach receiver',
  //     );
  //   }

  //   // ✅ NO Get.to(AudioCallPage) — Zego handles the call screen
  // }

  bool _isCallInProgress = false;

  void callPerson() async {
    if (_isCallInProgress) return;

    final otherUserId = _otherUserId?.trim() ?? '';
    final currentUserId = (_currentUserId ?? StorageService.getUserId() ?? '')
        .trim();
    final baseId = bookingId.value.replaceAll('#', '').trim();

    if (otherUserId.isEmpty || otherUserId == currentUserId) {
      Get.snackbar(
        'Call unavailable',
        'The recipient is not available for a call.',
      );
      return;
    }

    if (baseId.isEmpty) {
      Get.snackbar('Call unavailable', 'Booking information is missing.');
      return;
    }

    _isCallInProgress = true;

    try {
      final uniqueCallId = '${baseId}_${DateTime.now().millisecondsSinceEpoch}';

      final didSend = await CallService.instance.startAudioCall(
        targetUserId: otherUserId,
        targetUserName: personName.value,
        callID: uniqueCallId,
      );
      if (!didSend) {
        Get.snackbar(
          'Call unavailable',
          CallService.instance.lastError ??
              'Unable to start the call. Please try again.',
        );
      }
    } finally {
      _isCallInProgress = false;
    }
  }

  void messagePerson() {
    // Extract raw booking ID without # symbol
    String rawBookingId = bookingId.value.replaceAll('#', '').trim();

    if (rawBookingId.isEmpty) {
      print('Error: Booking ID is missing for chat');
      Get.snackbar('Error', 'Unable to initiate chat: Booking ID not found');
      return;
    }

    // Ensure we have valid IDs before navigating
    if (_currentUserId == null || _currentUserId!.isEmpty) {
      print('Error: Current user ID not available');
      Get.snackbar('Error', 'Unable to initiate chat: User ID not found');
      return;
    }

    if (_otherUserId == null ||
        _otherUserId!.isEmpty ||
        _otherUserId == _currentUserId) {
      print('Error: Other user ID invalid or matches current user');
      Get.snackbar('Error', 'Unable to initiate chat: Invalid receiver ID');
      return;
    }

    print('MessagePerson Debug:');
    print('  Current User ID: $_currentUserId');
    print('  Other User ID: $_otherUserId');
    print('  User Role: ${userRole.value}');
    print('  Booking ID: $rawBookingId');

    // Determine which ID is the provider and which is the client
    String providerId = userRole.value == 'user'
        ? _otherUserId ?? ''
        : _currentUserId ?? '';
    String clientId = userRole.value == 'user'
        ? _currentUserId ?? ''
        : _otherUserId ?? '';

    Get.to(
      () => SingleChatScreen(),
      arguments: {
        'bookingId': rawBookingId,
        'userId': _currentUserId,
        'providerId': providerId,
        'clientId': clientId,
        'providerName': personName.value,
        'userRole': userRole.value,
      },
    );
  }

  // Provider-specific actions
  void startService() {
    print("Starting service for booking ${bookingId.value}...");
  }

  void completeService() {
    print("Completing service for booking ${bookingId.value}...");
  }

  void navigateToCustomer() {
    print("Opening navigation to customer location...");
  }

  String _resolveBookingId(Map<String, dynamic> arguments) {
    final candidates = [
      arguments['bookingId'],
      arguments['id'],
      arguments['bookingNumber'],
      arguments['reference'],
    ];

    for (final candidate in candidates) {
      final value = candidate?.toString().trim() ?? '';
      if (value.isNotEmpty) {
        return value;
      }
    }

    return '';
  }

  String _resolveUserLocationDetails(Map<String, dynamic> arguments) {
    final candidates = [
      arguments['userLocationDetails'],
      arguments['locationDetails'],
      arguments['location'],
    ];

    for (final candidate in candidates) {
      final value = candidate?.toString().trim() ?? '';
      if (value.isNotEmpty) {
        return value;
      }
    }

    return location.value;
  }

  double? _resolveCoordinate(
    Map<String, dynamic> arguments, {
    required String primaryKey,
    String? fallbackKey,
  }) {
    final candidates = [
      arguments[primaryKey],
      if (fallbackKey != null) arguments[fallbackKey],
    ];

    for (final candidate in candidates) {
      if (candidate == null) {
        continue;
      }

      if (candidate is num) {
        return candidate.toDouble();
      }

      final parsed = double.tryParse(candidate.toString().trim());
      if (parsed != null) {
        return parsed;
      }
    }

    return null;
  }

  @override
  void onClose() {
    _providerLocationSubscription?.cancel();
    socketService.disconnect();
    super.onClose();
  }
}
