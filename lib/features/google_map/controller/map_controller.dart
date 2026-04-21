import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:protiva502/features/google_map/service/map_service.dart';

class MapController extends GetxController {
  MapController({
    MapService? mapService,
    GoogleMapsFlutterAndroid? androidMapsPlugin,
  }) : mapService =
           mapService ??
           MapService(apiKey: 'AIzaSyDByTL-51tHLFMJgUTyHe0nT3-qhD2i9Mc'),
       _androidMapsPlugin = androidMapsPlugin ?? GoogleMapsFlutterAndroid();

  final MapService mapService;
  final GoogleMapsFlutterAndroid _androidMapsPlugin;

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
  final _hasLocation = false.obs;

  GoogleMapController? mapController;
  StreamSubscription<Position>? positionStream;

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
  LatLng? _lastTrackingUserPosition;

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
          : 'Google Maps could not be initialized on this device.';
    } catch (_) {
      isMapAvailable.value = false;
      mapAvailabilityMessage.value =
          'Google Maps could not be initialized on this device.';
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
          'Location services are turned off. Please enable them and try again.';
      return null;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      errorMessage.value =
          'Location permission is required to choose a service address.';
      return null;
    }

    if (permission == LocationPermission.deniedForever) {
      errorMessage.value =
          'Location permission is permanently denied. Open settings to continue.';
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

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
      final polylinePoints = PolylinePoints(apiKey: mapService.apiKey);
      final result = await polylinePoints.getRouteBetweenCoordinatesV2(
        request: RoutesApiRequest(
          origin: PointLatLng(
            currentLatLng.value.latitude,
            currentLatLng.value.longitude,
          ),
          destination: PointLatLng(destination.latitude, destination.longitude),
        ),
      );

      final routePoints = result.primaryRoute?.polylinePoints;
      polylines.removeWhere(
        (polyline) => polyline.polylineId.value == _routePolylineId,
      );

      if (routePoints != null && routePoints.isNotEmpty) {
        polylines.add(
          Polyline(
            polylineId: const PolylineId(_routePolylineId),
            points: routePoints
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
            width: 5,
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
      title?.trim().isNotEmpty == true ? title!.trim() : 'User location',
      BitmapDescriptor.hueOrange,
    );
  }

  void setTrackedProviderLocation(LatLng position, {String? title}) {
    _updateMarker(
      position,
      _trackedProviderMarkerId,
      title?.trim().isNotEmpty == true ? title!.trim() : 'Provider location',
      BitmapDescriptor.hueGreen,
    );
  }

  Future<void> updateTrackingRoute({
    required LatLng providerPosition,
    required LatLng userPosition,
    bool force = false,
  }) async {
    if (!_shouldRefreshTrackingRoute(
      providerPosition: providerPosition,
      userPosition: userPosition,
      force: force,
    )) {
      return;
    }

    try {
      final polylinePoints = PolylinePoints(apiKey: mapService.apiKey);
      final result = await polylinePoints.getRouteBetweenCoordinatesV2(
        request: RoutesApiRequest(
          origin: PointLatLng(
            providerPosition.latitude,
            providerPosition.longitude,
          ),
          destination: PointLatLng(
            userPosition.latitude,
            userPosition.longitude,
          ),
        ),
      );

      final routePoints = result.primaryRoute?.polylinePoints;
      polylines.removeWhere(
        (polyline) => polyline.polylineId.value == _trackingRoutePolylineId,
      );

      if (routePoints != null && routePoints.isNotEmpty) {
        polylines.add(
          Polyline(
            polylineId: const PolylineId(_trackingRoutePolylineId),
            points: routePoints
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
            geodesic: true,
            width: 6,
          ),
        );
      } else {
        _drawDirectTrackingRoute(providerPosition, userPosition);
      }

      polylines.refresh();
      _lastTrackingRouteAt = DateTime.now();
      _lastTrackingProviderPosition = providerPosition;
      _lastTrackingUserPosition = userPosition;
    } catch (_) {
      // Fallback so the user still sees provider-to-user direction.
      _drawDirectTrackingRoute(providerPosition, userPosition);
      polylines.refresh();

      _lastTrackingRouteAt = DateTime.now();
      _lastTrackingProviderPosition = providerPosition;
      _lastTrackingUserPosition = userPosition;
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

  void clearTrackingRoute() {
    polylines.removeWhere(
      (polyline) => polyline.polylineId.value == _trackingRoutePolylineId,
    );
    polylines.refresh();
  }

  bool _shouldRefreshTrackingRoute({
    required LatLng providerPosition,
    required LatLng userPosition,
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
    final previousUser = _lastTrackingUserPosition;
    if (previousProvider == null || previousUser == null) {
      return true;
    }

    final providerMoved = Geolocator.distanceBetween(
      previousProvider.latitude,
      previousProvider.longitude,
      providerPosition.latitude,
      providerPosition.longitude,
    );
    final userMoved = Geolocator.distanceBetween(
      previousUser.latitude,
      previousUser.longitude,
      userPosition.latitude,
      userPosition.longitude,
    );

    return providerMoved >= _trackingMinMovementMeters ||
        userMoved >= _trackingMinMovementMeters;
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
