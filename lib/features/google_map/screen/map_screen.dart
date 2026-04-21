import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/google_map/controller/map_controller.dart';
import 'package:protiva502/features/google_map/model/picked_location_data.dart';
import 'package:protiva502/features/tracking/controller/tracking_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.isPickerMode = false,
    this.trackingController,
  });

  final bool isPickerMode;
  final TrackProviderController? trackingController;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController controller;
  late final bool ownsController;
  Worker? trackingWorker;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = _resolveController();
    _bindTrackingMarkers();
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
    trackingWorker?.dispose();
    searchController.dispose();
    if (ownsController && Get.isRegistered<MapController>()) {
      Get.delete<MapController>();
    }
    super.dispose();
  }

  void _bindTrackingMarkers() {
    final trackingController = widget.trackingController;
    if (trackingController == null) {
      return;
    }

    _syncTrackingMarkers(trackingController);
    trackingWorker = everAll([
      trackingController.userLatitude,
      trackingController.userLongitude,
      trackingController.providerLatitude,
      trackingController.providerLongitude,
      trackingController.hasUserLocation,
      trackingController.hasProviderLocation,
      trackingController.userLocationDetails,
    ], (_) => _syncTrackingMarkers(trackingController));
  }

  void _syncTrackingMarkers(TrackProviderController trackingController) {
    LatLng? userPosition;
    LatLng? providerPosition;

    if (trackingController.hasUserLocation.value) {
      userPosition = LatLng(
        trackingController.userLatitude.value,
        trackingController.userLongitude.value,
      );

      controller.setTrackedUserLocation(
        userPosition,
        title: trackingController.userLocationDetails.value,
      );

      controller.destinationLatLng.value ??= userPosition;
    }

    if (trackingController.hasProviderLocation.value) {
      providerPosition = LatLng(
        trackingController.providerLatitude.value,
        trackingController.providerLongitude.value,
      );
      controller.setTrackedProviderLocation(providerPosition);
    }

    if (userPosition != null && providerPosition != null) {
      controller.updateTrackingRoute(
        providerPosition: providerPosition,
        userPosition: userPosition,
      );
    } else {
      controller.clearTrackingRoute();
    }
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

    Get.back<PickedLocationData>(result: _buildPickedLocationData());
  }

  Future<void> _handleMapTap(LatLng position) async {
    await controller.setDestination(position, buildRoute: !widget.isPickerMode);

    if (!mounted || !widget.isPickerMode) {
      return;
    }

    Get.back<PickedLocationData>(result: _buildPickedLocationData());
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

    Get.back<PickedLocationData>(result: _buildPickedLocationData());
  }

  PickedLocationData _buildPickedLocationData() {
    final selectedPosition =
        controller.destinationLatLng.value ?? controller.currentLatLng.value;

    return PickedLocationData(
      address: controller.selectedLocationLabel,
      latitude: selectedPosition.latitude,
      longitude: selectedPosition.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTrackingMode = widget.trackingController != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPickerMode ? 'Pick Location' : 'Track'),
        centerTitle: false,
      ),

      body: isTrackingMode
          ? _buildTrackingModeBody()
          : Obx(() {
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
                                controller
                                        .mapAvailabilityMessage
                                        .value
                                        .isNotEmpty
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
                          // child: TextField(
                          //   controller: searchController,
                          //   textInputAction: TextInputAction.search,
                          //   onSubmitted: (_) => _submitSearch(),
                          //   decoration: InputDecoration(
                          //     hintText: 'Search destination',
                          //     prefixIcon: const Icon(Icons.search),
                          // suffixIcon: controller.isSearching.value
                          //     ? const Padding(
                          //         padding: EdgeInsets.all(12),
                          //         child: SizedBox(
                          //           width: 20,
                          //           height: 20,
                          //           child: CircularProgressIndicator(
                          //             strokeWidth: 2,
                          //           ),
                          //         ),
                          //       )
                          //     : IconButton(
                          //         onPressed: _submitSearch,
                          //         icon: const Icon(Icons.arrow_forward),
                          //       ),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(16),
                          //       borderSide: BorderSide.none,
                          //     ),
                          //     filled: true,
                          //   ),
                          // ),
                          child: CustomTextField(
                            backgroundColor: Colors.white,
                            controller: searchController,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (_) => _submitSearch(),
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
                          ),
                        ),
                        if (controller.searchError.value.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          _buildMessageCard(
                            context,
                            controller.searchError.value,
                          ),
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

  Widget _buildTrackingModeBody() {
    final trackingController = widget.trackingController!;

    return Stack(
      children: [
        // Map taking top 2/3 of screen
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 2 / 3,
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.isMapAvailable.value) {
              return GoogleMap(
                initialCameraPosition: controller.initialCameraPosition,
                onMapCreated: controller.onMapCreated,
                myLocationEnabled: controller.hasLocation,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                markers: controller.markers.toSet(),
                polylines: controller.polylines.toSet(),
              );
            } else {
              return Container(
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(Icons.map, size: 48, color: Colors.grey),
                ),
              );
            }
          }),
        ),
        // Draggable sheet - full height for proper constraints
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: DraggableScrollableSheet(
            initialChildSize: 0.33,
            minChildSize: 0.25,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    // Drag handle
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Container(
                        height: 4.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Estimated Arrival Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: _buildEstimatedArrivalCard(trackingController),
                    ),
                    SizedBox(height: 16.h),

                    // Tracking Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _buildTrackingCard(trackingController),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              );
            },
          ),
        ),
      ],
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

  Widget _buildEstimatedArrivalCard(TrackProviderController controller) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0891B2), Color(0xFF06B6D4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimated Arrival',
                  style: getTextStyle(fontSize: 11.sp, color: Colors.white70),
                ),
                SizedBox(height: 4.h),
                Text(
                  controller.estimatedTime.value,
                  style: getTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Distance',
                  style: getTextStyle(fontSize: 11.sp, color: Colors.white70),
                ),
                SizedBox(height: 4.h),
                Text(
                  controller.distance.value,
                  style: getTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text(
            //       'Status',
            //       style: getTextStyle(fontSize: 11.sp, color: Colors.white70),
            //     ),
            //     SizedBox(height: 4.h),
            //     Text(
            //       controller.trackingStatus.value,
            //       style: getTextStyle(
            //         fontSize: 12.sp,
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingCard(TrackProviderController controller) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28.r,
                      backgroundImage: AssetImage(ImagePath.profile),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2.r),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              controller.personName.value,
                              style: getTextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.verified,
                            color: Colors.orange,
                            size: 16.sp,
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: controller.isPersonOnline.value
                                  ? Colors.green.shade50
                                  : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              controller.isPersonOnline.value
                                  ? 'On the way'
                                  : 'Offline',
                              style: getTextStyle(
                                fontSize: 10.sp,
                                color: controller.isPersonOnline.value
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        controller.serviceName.value,
                        style: getTextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        controller.location.value,
                        style: getTextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            controller.rating.value,
                            style: getTextStyle(
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          controller.userRole.value == "user"
                              ? 'Service Cost'
                              : 'Estimated Earnings',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        controller.personCost.value,
                        style: getTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Booking ID',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        controller.bookingId.value,
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Obx(
              () => controller.userRole.value == "user"
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: AppColors.textPurple,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: controller.callPerson,
                                borderRadius: BorderRadius.circular(8.r),
                                child: Center(
                                  child: Text(
                                    'Call',
                                    style: getTextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: controller.messagePerson,
                            child: Container(
                              height: 48.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.textPurple),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: controller.messagePerson,
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Center(
                                    child: Text(
                                      'Message',
                                      style: getTextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPurple,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: AppColors.textPurple,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: controller.callPerson,
                                borderRadius: BorderRadius.circular(8.r),
                                child: Center(
                                  child: Text(
                                    'Call',
                                    style: getTextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: controller.messagePerson,
                            child: Container(
                              height: 48.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.textPurple),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: controller.messagePerson,
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Center(
                                    child: Text(
                                      'Message',
                                      style: getTextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPurple,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 12.h),
            CustomButton(
              text: 'Help & Support',
              backgroundColor: Colors.white,
              textColor: AppColors.textSecondary,
              borderColor: AppColors.textSecondary.withOpacity(0.5),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
