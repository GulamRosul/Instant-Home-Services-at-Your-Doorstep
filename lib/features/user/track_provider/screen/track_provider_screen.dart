import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/user/track_provider/controller/track_provider_controller.dart';

class TrackProviderScreen extends StatelessWidget {
  const TrackProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrackProviderController());

    return Scaffold(
      appBar: const CustomAppBar(title: 'Track Provider'),
      body: Stack(
        children: [
          // 1. Map View Placeholder
          _buildMapView(controller),

          // 2. Back Button (If not using CustomAppBar leading)
          Positioned(
            top: 20.h,
            left: 20.w,
            child: _buildRoundIconButton(Icons.arrow_back, () => Get.back()),
          ),

          // 3. Provider Tracking Card
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildTrackingCard(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView(TrackProviderController controller) {
    return Container(
      color: Colors.grey.shade200, // Placeholder for Google Maps
      child: const Center(
        child: Icon(Icons.map, size: 100, color: Colors.grey),
      ),
      // Integrate GoogleMap widget here:
      // child: GoogleMap(initialCameraPosition: ...),
    );
  }

  Widget _buildTrackingCard(TrackProviderController controller) {
    return Container(
      margin: EdgeInsets.all(20.r),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: const NetworkImage('https://placeholder.com/mike'),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.providerName,
                        style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    Text("Handyman Service",
                        style: getTextStyle(fontSize: 12.sp, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              _buildActionIcon(Icons.phone, Colors.green, controller.callProvider),
              SizedBox(width: 10.w),
              _buildActionIcon(Icons.message, AppColors.textPurple, controller.messageProvider),
            ],
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatInfo(Icons.access_time, controller.estimatedTime, "Arrival"),
              _buildStatInfo(Icons.directions_car, controller.distance, "Distance"),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPurple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
              child: Text("Service In-Progress",
                  style: getTextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatInfo(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16.sp, color: AppColors.textPurple),
            SizedBox(width: 4.w),
            Text(value, style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
          ],
        ),
        Text(label, style: getTextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildActionIcon(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20.sp),
      ),
    );
  }

  Widget _buildRoundIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.black, size: 20.sp),
      ),
    );
  }
}