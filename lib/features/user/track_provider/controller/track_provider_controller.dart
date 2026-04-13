import 'package:get/get.dart';
import 'package:protiva502/core/services/socket_io_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/features/chat/screen/single_chat_screen.dart';

class TrackProviderController extends GetxController {
  // Socket.IO Service
  late SocketIOService socketService;

  // Role - determined on init
  late Rx<String> userRole = "user".obs; // "user" or "provider"

  // Person Info - Observable rxn fields for dynamic updates
  late Rx<String> personName = "Mike Handyman".obs;
  late Rx<String> serviceName = "Handyman service".obs;
  late Rx<String> location = "Toronto, Canada".obs;
  late Rx<String> rating = "4.8 (170 Reviews)".obs;
  late Rx<String> personCost = "৳ 20.00".obs; // Cost for user view, Earnings for provider view
  late Rx<String> bookingId = "#BK12345".obs;

  // Tracking Data - Observable for real-time updates
  late Rx<double> providerLatitude = 23.8103.obs;
  late Rx<double> providerLongitude = 90.4125.obs;
  late Rx<double> userLatitude = 23.8110.obs;
  late Rx<double> userLongitude = 90.4140.obs;
  late Rx<String> estimatedTime = "12 mins".obs;
  late Rx<String> distance = "2.4 km".obs;
  late Rx<bool> isPersonOnline = true.obs;
  late Rx<String> trackingStatus = "Connected".obs;

  String? _currentUserId;
  String? _otherUserId;

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
        personName.value = arguments['personName'] ??
            arguments['providerName'] ??
            personName.value;
        serviceName.value = arguments['serviceName'] ?? serviceName.value;
        location.value = arguments['location'] ?? location.value;
        rating.value = arguments['rating'] ?? rating.value;
        personCost.value = arguments['personCost'] ??
            arguments['cost'] ??
            personCost.value;
        bookingId.value = arguments['bookingId'] ?? bookingId.value;
        _currentUserId = arguments['userId'];
        _otherUserId = arguments['personId'] ?? arguments['providerId'];
      }
    }

    // Get current user ID from storage if not set
    _currentUserId ??= StorageService.getUserId();

    // Get other user ID from storage as fallback
    _otherUserId ??= StorageService.getUserId();
  }

  /// Initialize Socket.IO connection for tracking
  void _initializeSocket() {
    socketService = SocketIOService();

    // Setup callbacks
    socketService.onLocationBroadcast = _handleLocationBroadcast;
    socketService.onTrackingState = _handleTrackingState;
    socketService.onTrackingError = _handleTrackingError;

    // Connect to socket
    socketService.connect(userId: _currentUserId ?? 'user_123');

    // Join tracking room - extract booking ID
    String rawBookingId = bookingId.value.replaceAll('#', '');
    socketService.joinTrackingRoom(rawBookingId);

    trackingStatus.value = "Connecting...";
  }

  /// Handle location broadcast from provider
  void _handleLocationBroadcast(Map<String, dynamic> data) {
    try {
      final point = data['point'] ?? {};
      final state = data['state'] ?? {};

      // Update provider's location
      if (point.containsKey('latitude')) {
        providerLatitude.value = (point['latitude'] as num).toDouble();
      }
      if (point.containsKey('longitude')) {
        providerLongitude.value = (point['longitude'] as num).toDouble();
      }

      // Update distance and ETA from state
      if (state.containsKey('distanceMeters')) {
        double distanceM = (state['distanceMeters'] as num).toDouble();
        distance.value = (distanceM / 1000).toStringAsFixed(1) + ' km';
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
      // Update both users' locations from state
      final clientState = data['client'] ?? {};
      final providerState = data['provider'] ?? {};

      if (clientState.containsKey('latitude')) {
        userLatitude.value = (clientState['latitude'] as num).toDouble();
      }
      if (clientState.containsKey('longitude')) {
        userLongitude.value = (clientState['longitude'] as num).toDouble();
      }

      if (providerState.containsKey('latitude')) {
        providerLatitude.value = (providerState['latitude'] as num).toDouble();
      }
      if (providerState.containsKey('longitude')) {
        providerLongitude.value = (providerState['longitude'] as num).toDouble();
      }

      print(
          'Tracking State: User(${userLatitude.value}, ${userLongitude.value}) Provider(${providerLatitude.value}, ${providerLongitude.value})');
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

  void callPerson() {
    print("Initiating call to ${personName.value}...");
  }

  void messagePerson() {
    // Extract raw booking ID without # symbol
    String rawBookingId = bookingId.value.replaceAll('#', '');

    Get.to(() => SingleChatScreen(), arguments: {
      'bookingId': rawBookingId,
      'userId': _currentUserId,
      'otherUserId': _otherUserId,
      'personName': personName.value,
      'userRole': userRole.value,
    });
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

  @override
  void onClose() {
    socketService.leaveRoom();
    socketService.disconnect();
    super.onClose();
  }
}
