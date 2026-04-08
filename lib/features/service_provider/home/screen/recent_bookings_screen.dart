import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/home/controller/provider_home_controller.dart';
import 'package:protiva502/features/service_provider/home/widget/recent_booking_card.dart';

class RecentBookingsScreen extends StatelessWidget {
  const RecentBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderHomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Recent Bookings',
          style: getTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isRecentBookingsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.recentBookingsErrorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Text(
                controller.recentBookingsErrorMessage.value,
                textAlign: TextAlign.center,
                style: getTextStyle(fontSize: 13.sp, color: Colors.black54),
              ),
            ),
          );
        }

        if (controller.recentBookings.isEmpty) {
          return Center(
            child: Text(
              'No recent bookings found',
              textAlign: TextAlign.center,
              style: getTextStyle(fontSize: 13.sp, color: Colors.black54),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(20.w),
          itemCount: controller.recentBookings.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return RecentBookingCard(booking: controller.recentBookings[index]);
          },
        );
      }),
    );
  }
}
