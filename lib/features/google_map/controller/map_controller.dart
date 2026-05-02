import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:protiva502/features/google_map/service/map_service.dart';
import 'package:http/http.dart' as http;
import 'package:protiva502/features/tracking/controller/tracking_controller.dart';

class MapController extends GetxController {
  // Google Maps API Key - shared for all map operations
  static const String _googleMapsApiKey =
      'AIzaSyDByTL-51tHLFMJgUTyHe0nT3-qhD2i9Mc';

  MapController({
    MapService? mapService,
    GoogleMapsFlutterAndroid? androidMapsPlugin,
  }) : mapService = mapService ?? MapService(apiKey: _googleMapsApiKey),
       _androidMapsPlugin = androidMapsPlugin ?? GoogleMapsFlutterAndroid();

  final MapService mapService;
  final GoogleMapsFlutterAndroid _androidMapsPlugin;

  final travelDistance = ''.obs;
  final travelDuration = ''.obs;

  final polylinePoints = PolylinePoints(apiKey: _googleMapsApiKey);

  final currentLatLng = const LatLng(23.8103, 90.4125).obs;
  final destinationLatLng = Rxn<LatLng>();
  final markers = <Marker>{}.obs;
  final polylines = <Polyline>{}.obs;
  final isLoading = true.obs;
  final isSearching = false.obs;
  final errorMessage = ''.obs;
  final searchError = ''.obs;
  final selectedAddress = ''.obs;
  final currentLocationLabel = ''.obs;
  final isMapAvailable = true.obs;
  final mapAvailabilityMessage = ''.obs;
  final placeSuggestions = <MapPlaceSuggestion>[].obs;
  final isSuggestionLoading = false.obs;
  final _hasLocation = false.obs;

  GoogleMapController? mapController;
  StreamSubscription<Position>? positionStream;
  Timer? _suggestionDebounce;

  static const String _currentMarkerId = 'current_location';
  static const String _destinationMarkerId = 'selected_destination';
  static const String _trackedUserMarkerId = 'tracked_user_location';
  static const String _trackedProviderMarkerId = 'tracked_provider_location';
  static const String _routePolylineId = 'route';
  static const String _trackingRoutePolylineId = 'tracking_route';
  static const double _defaultZoom = 15;
  static const Duration _trackingRouteThrottle = Duration(seconds: 4);
  static const double _trackingMinMovementMeters = 8;

  DateTime? _lastTrackingRouteAt;
  LatLng? _lastTrackingProviderPosition;

  CameraPosition get initialCameraPosition => CameraPosition(
    target: destinationLatLng.value ?? currentLatLng.value,
    zoom: _defaultZoom,
  );

  bool get hasLocation => _hasLocation.value;
  bool get hasDestination => destinationLatLng.value != null;

  String get selectedLocationLabel {
    if (selectedAddress.value.trim().isNotEmpty) {
      return selectedAddress.value.trim();
    }

    final selectedPoint = destinationLatLng.value;
    if (selectedPoint == null) {
      return '';
    }

    return _formatLatLng(selectedPoint);
  }

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    await _checkMapAvailability();

    if (!isMapAvailable.value) {
      isLoading.value = false;
      return;
    }

    await initializeMap();
  }

  Future<void> _checkMapAvailability() async {
    isMapAvailable.value = true;
    mapAvailabilityMessage.value = '';

    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return;
    }

    try {
      await _androidMapsPlugin.warmup();
    } on MissingPluginException {
      isMapAvailable.value = false;
      mapAvailabilityMessage.value =
          'Google Maps native plugins are not loaded in this running app yet. '
          'Fully stop the app and run it again.';
    } on PlatformException catch (error) {
      isMapAvailable.value = false;
      mapAvailabilityMessage.value = error.message?.trim().isNotEmpty == true
          ? error.message!.trim()
          : 'map_initialization_error'.tr;
    } catch (_) {
      isMapAvailable.value = false;
      mapAvailabilityMessage.value =
          'map_initialization_error'.tr;
    }
  }

  Future<void> initializeMap() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final currentPosition = await _refreshCurrentLocation();
      if (currentPosition != null) {
        await _moveCamera(currentPosition);
        _startLiveTracking();
      }
    } catch (_) {
      errorMessage.value = 'Unable to load your current location.';
      _hasLocation.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<LatLng?> _determineCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      errorMessage.value =
          'location_services_off'.tr;;
      return null;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      errorMessage.value =
          'location_permission_required'.tr;
      return null;
    }

    if (permission == LocationPermission.deniedForever) {
      errorMessage.value =
          'location_permission_permanently_denied'.tr;
      return null;
    }

    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  Future<LatLng?> _refreshCurrentLocation() async {
    final gpsLocation = await _determineCurrentLocation();
    if (gpsLocation == null) {
      _hasLocation.value = false;
      return null;
    }

    currentLocationLabel.value = '';

    LatLng resolvedLocation = gpsLocation;
    if (_shouldUseApproximateLocationFallback(gpsLocation)) {
      final approximateLocation = await mapService
          .lookupApproximateLocationFromIp();
      if (approximateLocation != null) {
        resolvedLocation = approximateLocation.location;
        currentLocationLabel.value = approximateLocation.displayLabel ?? '';
        debugPrint(
          'Using approximate current location => latitude: ${resolvedLocation.latitude}, '
          'longitude: ${resolvedLocation.longitude}',
        );
      }
    }

    currentLatLng.value = resolvedLocation;
    _hasLocation.value = true;
    _updateMarker(
      resolvedLocation,
      _currentMarkerId,
      'You',
      BitmapDescriptor.hueBlue,
    );
    return resolvedLocation;
  }

  double _calculateBearing(LatLng start, LatLng end) {
    double lat1 = start.latitude * pi / 180;
    double lon1 = start.longitude * pi / 180;
    double lat2 = end.latitude * pi / 180;
    double lon2 = end.longitude * pi / 180;

    double dLon = lon2 - lon1;
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    return (atan2(y, x) * 180 / pi + 360) % 360;
  }

  // In setTrackedProviderLocation:
  void setTrackedProviderLocation(LatLng position, {String? title}) {
    double rotation = 0;
    if (_lastTrackingProviderPosition != null) {
      rotation = _calculateBearing(_lastTrackingProviderPosition!, position);
    }

    markers.add(
      Marker(
        markerId: MarkerId(_trackedProviderMarkerId),
        position: position,
        rotation: rotation, // This makes the icon face the movement direction
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // Apply padding so markers aren't hidden by the bottom sheet
    // 300 is a rough estimate of your sheet's initial height
    // controller.setMapPadding(0, 0, 0, 300);
    _moveCamera(destinationLatLng.value ?? currentLatLng.value);
  }

  Future<void> setDestination(
    LatLng position, {
    bool buildRoute = true,
    String? fallbackLabel,
  }) async {
    searchError.value = '';
    destinationLatLng.value = position;
    _debugPrintSelectedLocation(position);
    _updateMarker(
      position,
      _destinationMarkerId,
      'Selected location',
      BitmapDescriptor.hueRed,
    );
    selectedAddress.value = await _resolveAddress(
      position,
      fallback: fallbackLabel,
    );
    await _moveCamera(position);
    clearPlaceSuggestions();

    if (buildRoute) {
      await createRoute();
    } else {
      polylines.removeWhere(
        (polyline) => polyline.polylineId.value == _routePolylineId,
      );
      polylines.refresh();
    }
  }

  Future<bool> searchPlace(String query, {bool buildRoute = true}) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      searchError.value = 'Please enter a location to search.';
      return false;
    }

    isSearching.value = true;
    searchError.value = '';
    clearPlaceSuggestions();

    try {
      final place = await mapService.searchPlace(trimmedQuery);
      if (place == null) {
        searchError.value = 'No matching location found.';
        return false;
      }

      destinationLatLng.value = place.location;
      _debugPrintSelectedLocation(place.location);
      _updateMarker(
        place.location,
        _destinationMarkerId,
        'Selected location',
        BitmapDescriptor.hueRed,
      );
      selectedAddress.value = place.displayLabel ?? trimmedQuery;
      await _moveCamera(place.location);

      if (buildRoute) {
        await createRoute();
      } else {
        polylines.removeWhere(
          (polyline) => polyline.polylineId.value == _routePolylineId,
        );
        polylines.refresh();
      }

      return true;
    } catch (_) {
      searchError.value = 'Unable to search that location right now.';
      return false;
    } finally {
      isSearching.value = false;
    }
  }

  void onSearchQueryChanged(String query) {
    _suggestionDebounce?.cancel();

    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      clearPlaceSuggestions();
      return;
    }

    _suggestionDebounce = Timer(const Duration(milliseconds: 300), () {
      _loadPlaceSuggestions(trimmedQuery);
    });
  }

  Future<void> _loadPlaceSuggestions(String query) async {
    isSuggestionLoading.value = true;
    try {
      final suggestions = await mapService.getPlaceSuggestions(query);
      placeSuggestions.assignAll(suggestions);
    } catch (_) {
      placeSuggestions.clear();
    } finally {
      isSuggestionLoading.value = false;
    }
  }

  Future<bool> selectPlaceSuggestion(
    MapPlaceSuggestion suggestion, {
    bool buildRoute = true,
  }) async {
    searchError.value = '';
    isSearching.value = true;
    clearPlaceSuggestions();

    try {
      final details = await mapService.getPlaceDetails(suggestion.placeId);
      if (details == null) {
        searchError.value = 'Unable to load that location.';
        return false;
      }

      destinationLatLng.value = details.location;
      _debugPrintSelectedLocation(details.location);
      _updateMarker(
        details.location,
        _destinationMarkerId,
        'selected_location'.tr,
        BitmapDescriptor.hueRed,
      );
      selectedAddress.value = details.displayLabel ?? suggestion.description;
      await _moveCamera(details.location);

      if (buildRoute) {
        await createRoute();
      } else {
        polylines.removeWhere(
          (polyline) => polyline.polylineId.value == _routePolylineId,
        );
        polylines.refresh();
      }

      return true;
    } catch (_) {
      searchError.value = 'Unable to load that location.';
      return false;
    } finally {
      isSearching.value = false;
    }
  }

  void clearPlaceSuggestions() {
    _suggestionDebounce?.cancel();
    placeSuggestions.clear();
    isSuggestionLoading.value = false;
  }

  Future<void> createRoute() async {
    final destination = destinationLatLng.value;
    if (destination == null || !_hasLocation.value) {
      polylines.removeWhere(
        (polyline) => polyline.polylineId.value == _routePolylineId,
      );
      polylines.refresh();
      return;
    }

    try {
      final polylinePoints = PolylinePoints(apiKey: _googleMapsApiKey);
      final result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(
            currentLatLng.value.latitude,
            currentLatLng.value.longitude,
          ),
          destination: PointLatLng(destination.latitude, destination.longitude),
          mode: TravelMode.driving,
        ),
      );

      final routePoints = result.points;
      polylines.removeWhere(
        (polyline) => polyline.polylineId.value == _routePolylineId,
      );

      if (routePoints.isNotEmpty) {
        polylines.add(
          Polyline(
            polylineId: const PolylineId(_routePolylineId),
            points: routePoints
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
            color: const Color(0xFF4285F4),
            width: 5,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            jointType: JointType.round,
            geodesic: true,
          ),
        );
      }

      polylines.refresh();
    } catch (_) {
      polylines.removeWhere(
        (polyline) => polyline.polylineId.value == _routePolylineId,
      );
      polylines.refresh();
    }
  }

  void clearDestination() {
    destinationLatLng.value = null;
    selectedAddress.value = '';
    clearPlaceSuggestions();
    polylines.removeWhere(
      (polyline) => polyline.polylineId.value == _routePolylineId,
    );
    markers.removeWhere(
      (marker) => marker.markerId.value == _destinationMarkerId,
    );
    markers.refresh();
    polylines.refresh();
  }

  Future<void> centerOnCurrentLocation() async {
    final currentPosition = _hasLocation.value
        ? currentLatLng.value
        : await _refreshCurrentLocation();
    if (currentPosition == null) {
      return;
    }

    await _moveCamera(currentPosition);
  }

  Future<bool> useCurrentLocationForSelection({bool buildRoute = true}) async {
    errorMessage.value = '';
    clearPlaceSuggestions();

    final currentPosition = await _refreshCurrentLocation();
    if (currentPosition == null) {
      return false;
    }

    final fallbackLabel = currentLocationLabel.value.trim();
    await setDestination(
      currentPosition,
      buildRoute: buildRoute,
      fallbackLabel: fallbackLabel.isEmpty ? null : fallbackLabel,
    );
    return true;
  }

  Future<void> openLocationSettings() async {
    try {
      await Geolocator.openLocationSettings();
    } catch (_) {}
  }

  Future<void> openAppSettings() async {
    try {
      await Geolocator.openAppSettings();
    } catch (_) {}
  }

  void setTrackedUserLocation(LatLng position, {String? title}) {
    _updateMarker(
      position,
      _trackedUserMarkerId,
      title?.trim().isNotEmpty == true ? title!.trim() : 'user_location'.tr,
      BitmapDescriptor.hueOrange,
    );
  }

  // void setTrackedProviderLocation(LatLng position, {String? title}) {
  //   _updateMarker(
  //     position,
  //     _trackedProviderMarkerId,
  //     title?.trim().isNotEmpty == true ? title!.trim() : 'Provider location',
  //     BitmapDescriptor.hueGreen,
  //   );
  // }

  Future<Map<String, dynamic>?> getDirectionData(
    LatLng origin,
    LatLng dest,
  ) async {
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?"
        "origin=${origin.latitude},${origin.longitude}&"
        "destination=${dest.latitude},${dest.longitude}&"
        "mode=driving&" // Essential for road-based routing
        "key=$_googleMapsApiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if ((data['routes'] as List).isNotEmpty) {
          return data['routes'][0];
        }
      }
    } catch (e) {
      debugPrint("Directions API Error: $e");
    }
    return null;
  }

  // Inside MapController
  // Future<void> updateTrackingRoute({
  //   required LatLng providerPosition,
  //   required LatLng userPosition,
  // }) async {
  //   // Throttle: skip if provider hasn't moved enough and interval hasn't elapsed
  //   if (!_shouldRefreshTrackingRoute(
  //     providerPosition: providerPosition,
  //     force: false,
  //   )) {
  //     return;
  //   }

  //   final routeData = await getDirectionData(providerPosition, userPosition);

  //   if (routeData != null) {
  //     // 1. Get the Encoded Polyline
  //     final String encodedPoints = routeData['overview_polyline']['points'];
  //     final List<PointLatLng> result = PolylinePoints.decodePolyline(
  //       encodedPoints,
  //     );

  //     // 2. Convert to LatLng for GoogleMap widget
  //     final List<LatLng> polylineCoordinates = result
  //         .map((point) => LatLng(point.latitude, point.longitude))
  //         .toList();

  //     // 3. Update the Polyline on the Map
  //     polylines.clear();
  //     if (polylineCoordinates.isNotEmpty) {
  //       polylines.add(
  //         Polyline(
  //           polylineId: const PolylineId(_trackingRoutePolylineId),
  //           points: polylineCoordinates,
  //           color: AppColors.textPurple,
  //           width: 5,
  //           jointType: JointType.round,
  //           startCap: Cap.roundCap,
  //           endCap: Cap.roundCap,
  //           geodesic: true,
  //         ),
  //       );
  //     } else {
  //       _drawDirectTrackingRoute(providerPosition, userPosition);
  //     }

  //     // 4. Extract ETA and Distance from Directions API leg
  //     final leg = routeData['legs'][0];
  //     final String distanceText =
  //         (leg['distance']?['text'] ?? '') as String; // e.g., "5.4 km"
  //     final String durationText =
  //         (leg['duration']?['text'] ?? '') as String; // e.g., "18 mins"

  //     // Write to MapController observables so the UI card reacts
  //     travelDistance.value = distanceText;
  //     travelDuration.value = durationText;

  //     _lastTrackingRouteAt = DateTime.now();
  //     _lastTrackingProviderPosition = providerPosition;

  //     // 5. Adjust camera to show both markers
  //     await _fitCameraToBothMarkers(
  //       providerPosition: providerPosition,
  //       userPosition: userPosition,
  //     );
  //   } else {
  //     // Fallback: draw straight line so user still sees direction
  //     _drawDirectTrackingRoute(providerPosition, userPosition);
  //     polylines.refresh();

  //     _lastTrackingRouteAt = DateTime.now();
  //     _lastTrackingProviderPosition = providerPosition;
  //   }
  // }

  Future<void> updateTrackingRoute({
    required LatLng providerPosition,
    required LatLng userPosition,
  }) async {
    const String url =
        "https://routes.googleapis.com/directions/v2:computeRoutes";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": _googleMapsApiKey,
        // CRITICAL: Tells Google exactly what data to return
        "X-Goog-FieldMask":
            "routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline",
      },
      body: jsonEncode({
        "origin": {
          "location": {
            "latLng": {
              "latitude": providerPosition.latitude,
              "longitude": providerPosition.longitude,
            },
          },
        },
        "destination": {
          "location": {
            "latLng": {
              "latitude": userPosition.latitude,
              "longitude": userPosition.longitude,
            },
          },
        },
        "travelMode": "DRIVE",
        "routingPreference":
            "TRAFFIC_AWARE", // Gets real-time Dhaka traffic data
        "computeAlternativeRoutes": false,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final route = data['routes'][0];

      // 1. Decode the Polyline
      String encodedPolyline = route['polyline']['encodedPolyline'];
      List<PointLatLng> result = PolylinePoints.decodePolyline(encodedPolyline);

      List<LatLng> coords = result
          .map((p) => LatLng(p.latitude, p.longitude))
          .toList();

      // 2. Update Map Polylines
      polylines
        ..clear()
        ..add(
          Polyline(
            polylineId: const PolylineId("route"),
            points: coords,
            color: const Color(0xFF7C3AED), // Your Purple theme
            width: 5,
            jointType: JointType.round,
          ),
        );

      // 3. Update ETA & Distance
      // Routes API returns distance in meters and duration in seconds (e.g., "1200s")
      double meters = (route['distanceMeters'] as num).toDouble();
      String durationString = route['duration']; // e.g., "950s"
      int seconds = int.parse(durationString.replaceAll('s', ''));

      final distanceKm = "${(meters / 1000).toStringAsFixed(1)} km";
      final durationMins = "${(seconds / 60).round()} mins";

      // Update MapController properties for the UI card
      travelDistance.value = distanceKm;
      travelDuration.value = durationMins;

      // Also update TrackProviderController if available
      try {
        final trackingController = Get.find<TrackProviderController>();
        trackingController.distance.value = distanceKm;
        trackingController.estimatedTime.value = durationMins;
      } catch (_) {
        // TrackProviderController may not be registered
      }
    } else {
      debugPrint("Routes API Error: ${response.body}");
    }
  }

  void _drawDirectTrackingRoute(LatLng providerPosition, LatLng userPosition) {
    polylines.removeWhere(
      (polyline) => polyline.polylineId.value == _trackingRoutePolylineId,
    );
    polylines.add(
      Polyline(
        polylineId: const PolylineId(_trackingRoutePolylineId),
        points: [providerPosition, userPosition],
        geodesic: true,
        width: 6,
      ),
    );
  }

  void _drawRoute(List<PointLatLng> routePoints) {
    polylines.removeWhere(
      (polyline) => polyline.polylineId.value == _trackingRoutePolylineId,
    );

    polylines.add(
      Polyline(
        polylineId: const PolylineId(_trackingRoutePolylineId),
        points: routePoints
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList(),
        color: const Color(0xFF4285F4),
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        jointType: JointType.round,
        geodesic: true,
      ),
    );

    polylines.refresh();
  }

  void clearTrackingRoute() {
    polylines.removeWhere(
      (polyline) => polyline.polylineId.value == _trackingRoutePolylineId,
    );
    travelDistance.value = '';
    travelDuration.value = '';
    polylines.refresh();
  }

  bool _shouldRefreshTrackingRoute({
    required LatLng providerPosition,
    required bool force,
  }) {
    if (force || _lastTrackingRouteAt == null) {
      return true;
    }

    final elapsed = DateTime.now().difference(_lastTrackingRouteAt!);
    if (elapsed >= _trackingRouteThrottle) {
      return true;
    }

    final previousProvider = _lastTrackingProviderPosition;
    if (previousProvider == null) {
      return true;
    }

    // Only check provider movement - refresh only when provider moves significantly
    final providerMoved = Geolocator.distanceBetween(
      previousProvider.latitude,
      previousProvider.longitude,
      providerPosition.latitude,
      providerPosition.longitude,
    );

    return providerMoved >= _trackingMinMovementMeters;
  }

  void _startLiveTracking() {
    positionStream?.cancel();
    if (!_hasLocation.value) {
      return;
    }

    positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          ),
        ).listen((Position position) {
          final updatedLocation = LatLng(position.latitude, position.longitude);
          currentLatLng.value = updatedLocation;
          _updateMarker(
            updatedLocation,
            _currentMarkerId,
            'You',
            BitmapDescriptor.hueBlue,
          );

          if (hasDestination) {
            createRoute();
          }
        });
  }

  void _updateMarker(LatLng position, String id, String title, double hue) {
    markers.removeWhere((marker) => marker.markerId.value == id);
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(hue),
        infoWindow: InfoWindow(title: title),
      ),
    );
    markers.refresh();
  }

  Future<String> _resolveAddress(LatLng position, {String? fallback}) async {
    final address = await mapService.reverseGeocode(position);
    if (address != null && address.trim().isNotEmpty) {
      return address.trim();
    }

    if (fallback != null && fallback.trim().isNotEmpty) {
      return fallback.trim();
    }

    return _formatLatLng(position);
  }

  Future<void> _fitCameraToBothMarkers({
    required LatLng providerPosition,
    required LatLng userPosition,
  }) async {
    final controller = mapController;
    if (controller == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        providerPosition.latitude < userPosition.latitude
            ? providerPosition.latitude
            : userPosition.latitude,
        providerPosition.longitude < userPosition.longitude
            ? providerPosition.longitude
            : userPosition.longitude,
      ),
      northeast: LatLng(
        providerPosition.latitude > userPosition.latitude
            ? providerPosition.latitude
            : userPosition.latitude,
        providerPosition.longitude > userPosition.longitude
            ? providerPosition.longitude
            : userPosition.longitude,
      ),
    );

    await controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
  }

  Future<void> _moveCamera(LatLng target) async {
    final controller = mapController;
    if (controller == null) {
      return;
    }

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: _defaultZoom),
      ),
    );
  }

  String _formatLatLng(LatLng position) {
    return 'Lat: ${position.latitude.toStringAsFixed(5)}, '
        'Lng: ${position.longitude.toStringAsFixed(5)}';
  }

  String _formatDurationFromSeconds(int seconds) {
    if (seconds <= 0) {
      return '0 mins';
    }

    final totalMinutes = (seconds / 60).ceil();
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours == 0) {
      return '$totalMinutes mins';
    }

    if (minutes == 0) {
      return '$hours hr';
    }

    return '$hours hr $minutes mins';
  }

  void _debugPrintSelectedLocation(LatLng position) {
    debugPrint(
      'Picked location => latitude: ${position.latitude}, '
      'longitude: ${position.longitude}',
    );
  }

  bool _shouldUseApproximateLocationFallback(LatLng location) {
    if (!kDebugMode || defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }

    const googleplexLatitude = 37.4219983;
    const googleplexLongitude = -122.084;

    final latitudeDifference = (location.latitude - googleplexLatitude).abs();
    final longitudeDifference = (location.longitude - googleplexLongitude)
        .abs();

    return latitudeDifference < 0.02 && longitudeDifference < 0.02;
  }

  @override
  void onClose() {
    positionStream?.cancel();
    mapService.dispose();
    super.onClose();
  }
}
