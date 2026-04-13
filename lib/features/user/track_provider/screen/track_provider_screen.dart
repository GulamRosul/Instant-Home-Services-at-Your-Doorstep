import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/track_provider/controller/track_provider_controller.dart';

class TrackProviderScreen extends StatelessWidget {
  const TrackProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrackProviderController());

    return Scaffold(
      appBar: const CustomAppBar(title: 'Track'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Map View
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: _buildMapView(controller),
            ),

            // 2. Estimated Arrival Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: _buildEstimatedArrivalCard(controller),
            ),

            // 3. Provider Tracking Card
            _buildTrackingCard(controller),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMapView(TrackProviderController controller) {
    return Container(
      height: 400.h,
      width: double.infinity,
      color: AppColors.textSecondary.withValues(
        alpha: 0.2,
      ), // Placeholder background
      // borderRadius: BorderRadius.circular(16.r),
      child: Image.asset(
        ImagePath.mapview,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.broken_image, color: Colors.grey),
          );
        },
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Status',
                  style: getTextStyle(fontSize: 11.sp, color: Colors.white70),
                ),
                SizedBox(height: 4.h),
                Text(
                  controller.trackingStatus.value,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
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
