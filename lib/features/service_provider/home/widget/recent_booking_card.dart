import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/home/controller/provider_home_controller.dart';
import 'package:protiva502/features/service_provider/home/model/recent_booking_model.dart';
import 'package:protiva502/features/user/provoder_details/screen/provoder_details_screen.dart';

class RecentBookingCard extends StatelessWidget {
  const RecentBookingCard({super.key, required this.booking});

  final RecentBookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Image
          ClipRRect(
            borderRadius: BorderRadius.circular(3.r),
            child: Image.asset(
              ImagePath.servicecard,
              width: 50.w,
              height: 50.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              booking.serviceName,
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0F172A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.check_circle,
                            color: Colors.amber,
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      booking.status,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFFFFC100),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                /// Location
                Text(
                  '— ${booking.locationDetails}',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                /// Price + View Details
                Text(
                  'Starting : ৳ ${booking.serviceAmount.toStringAsFixed(0)}',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D2D2D),
                  ),
                ),

                /// Rating Row
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFF8113),
                        size: 12.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        booking.preferredTime.isNotEmpty
                            ? booking.preferredTime
                            : 'Preferred schedule',
                        style: getTextStyle(
                          fontSize: 10.sp,
                          color: Color(0xFF475569),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ProviderDetailsScreen());
                      },
                      child: Text(
                        'View Details',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1D4ED8),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF1D4ED8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecentBookingsSection extends StatelessWidget {
  const RecentBookingsSection({super.key, required this.controller});

  final ProviderHomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isRecentBookingsLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.recentBookingsErrorMessage.value.isNotEmpty) {
        return Text(
          controller.recentBookingsErrorMessage.value,
          style: getTextStyle(fontSize: 12.sp, color: Colors.black54),
        );
      }

      if (controller.recentBookings.isEmpty) {
        return Center(
          child: Text(
            'No recent bookings found',
            textAlign: TextAlign.center,
            style: getTextStyle(fontSize: 12.sp, color: Colors.black54),
          ),
        );
      }

      return RecentBookingCard(booking: controller.recentBookings.first);
    });
  }
}
