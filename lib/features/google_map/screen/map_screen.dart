import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:protiva502/features/google_map/controller/map_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.isPickerMode = false});

  final bool isPickerMode;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController controller;
  late final bool ownsController;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = _resolveController();
  }

  MapController _resolveController() {
    if (Get.isRegistered<MapController>()) {
      ownsController = false;
      return Get.find<MapController>();
    }

    ownsController = true;
    return Get.put(MapController());
  }

  @override
  void dispose() {
    searchController.dispose();
    if (ownsController && Get.isRegistered<MapController>()) {
      Get.delete<MapController>();
    }
    super.dispose();
  }

  Future<void> _submitSearch() async {
    FocusScope.of(context).unfocus();
    final didSelectLocation = await controller.searchPlace(
      searchController.text,
      buildRoute: !widget.isPickerMode,
    );

    if (!mounted || !widget.isPickerMode || !didSelectLocation) {
      return;
    }

    Get.back<String>(result: controller.selectedLocationLabel);
  }

  Future<void> _handleMapTap(LatLng position) async {
    await controller.setDestination(position, buildRoute: !widget.isPickerMode);

    if (!mounted || !widget.isPickerMode) {
      return;
    }

    Get.back<String>(result: controller.selectedLocationLabel);
  }

  Future<void> _handleCurrentLocationTap() async {
    if (!widget.isPickerMode) {
      await controller.centerOnCurrentLocation();
      return;
    }

    final didPickCurrentLocation = await controller
        .useCurrentLocationForSelection(buildRoute: false);

    if (!mounted || !didPickCurrentLocation) {
      return;
    }

    Get.back<String>(result: controller.selectedLocationLabel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPickerMode ? 'Pick Location' : 'Google Map'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            if (controller.isMapAvailable.value)
              GoogleMap(
                initialCameraPosition: controller.initialCameraPosition,
                onMapCreated: controller.onMapCreated,
                onTap: _handleMapTap,
                myLocationEnabled: controller.hasLocation,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                markers: controller.markers.toSet(),
                polylines: controller.polylines.toSet(),
              )
            else
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.map_outlined,
                          size: 48,
                          color: Colors.black54,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          controller.mapAvailabilityMessage.value.isNotEmpty
                              ? controller.mapAvailabilityMessage.value
                              : 'Google Maps is unavailable right now.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.isPickerMode
                              ? 'You can still search for a location above and it will be used for the booking.'
                              : 'You can still search for a location above.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(16),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => _submitSearch(),
                      decoration: InputDecoration(
                        hintText: 'Search destination',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: controller.isSearching.value
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed: _submitSearch,
                                icon: const Icon(Icons.arrow_forward),
                              ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  if (controller.searchError.value.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildMessageCard(context, controller.searchError.value),
                  ],
                  if (controller.errorMessage.value.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildMessageCard(
                      context,
                      controller.errorMessage.value,
                      trailing: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          OutlinedButton(
                            onPressed: controller.initializeMap,
                            child: const Text('Retry'),
                          ),
                          OutlinedButton(
                            onPressed: controller.openLocationSettings,
                            child: const Text('Location Settings'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          widget.isPickerMode
                              ? 'Tap on the map or search for a place to use that location in your booking.'
                              : controller.hasDestination
                              ? 'Route ready. Tap another point on the map or search again to change the destination.'
                              : 'Tap anywhere on the map or search for a place to create a route.',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (controller.isMapAvailable.value)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (controller.hasDestination) ...[
                          FloatingActionButton.small(
                            heroTag: 'clear_destination',
                            onPressed: controller.clearDestination,
                            child: const Icon(Icons.close),
                          ),
                          const SizedBox(height: 12),
                        ],
                        FloatingActionButton(
                          heroTag: 'current_location',
                          onPressed: _handleCurrentLocationTap,
                          child: const Icon(Icons.my_location),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMessageCard(
    BuildContext context,
    String message, {
    Widget? trailing,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
          if (trailing != null) ...[const SizedBox(height: 12), trailing],
        ],
      ),
    );
  }
}
