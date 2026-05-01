import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/booking/controller/booking_controller.dart';
import 'package:protiva502/features/service_provider/booking/widget/booking_card.dart';
import 'package:protiva502/features/service_provider/booking/widget/stats_grid.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: Color(0xFFCBD5E1), height: 1),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'bookings'.tr,
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3F3F3F),
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              StatsGrid(controller: controller),
              SizedBox(height: 24.h),
              Text(
                'booking_service'.tr,
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'view_all_bookings'.tr,
                style: getTextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF334155),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              _buildTabs(controller),
              SizedBox(height: 20.h),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.errorMessage.value,
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        ElevatedButton(
                          onPressed: controller.fetchBookings,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.filteredBookings.isEmpty) {
                  return Center(
                    child: Text(
                      'no_bookings_found'.tr,
                      textAlign: TextAlign.center,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredBookings.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final booking = controller.filteredBookings[index];
                    return BookingCard(
                      controller: controller,
                      booking: booking,
                      index: index,
                    );
                  },
                );
              }),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(BookingController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Row(
          children: controller.dynamicTabs.asMap().entries.map((entry) {
            int idx = entry.key;
            String label = entry.value;
            bool isSelected = controller.selectedTabIndex.value == idx;
            return GestureDetector(
              onTap: () => controller.changeTab(idx),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border(
                          bottom: BorderSide(
                            color: const Color(0xFF7079F0),
                            width: 2.h,
                          ),
                        )
                      : null,
                ),
                child: Text(
                  label,
                  style: getTextStyle(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFF7079F0)
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
