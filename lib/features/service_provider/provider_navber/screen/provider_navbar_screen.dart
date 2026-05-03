import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/home/screen/provider_home_screen.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/my_job_list_screen.dart';
import 'package:protiva502/features/service_provider/booking/screen/booking_screen.dart';
import 'package:protiva502/features/notification/screen/notification_screen.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';

class ProviderNavbarScreen extends StatelessWidget {
  const ProviderNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderNavbarController());

    final List<Widget> pages = [
      Obx(() => controller.homeSubPage.value ?? const ProviderHomeScreen()),
      const MyJobListScreen(),
      const BookingScreen(),
      const NotificationScreen(),
      const Center(child: Text("Provider Settings")),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: const ProviderBottomNavBar(),
      extendBody: true,
    );
  }
}

class ProviderBottomNavBar extends StatelessWidget {
  const ProviderBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderNavbarController>();
    final notificationController = Get.find<NotificationController>();

    final List<Map<String, dynamic>> navItems = [
      {'label': 'home'.tr},
      {'label': 'my_job'.tr},
      {'label': 'bookings'.tr},
      {'label': 'notification'.tr},
      {'label': 'more'.tr},
    ];

    return Container(
      height: 60.h,
      margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 40.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(navItems.length, (index) {
          return Obx(() {
            bool isSelected = controller.selectedIndex.value == index;
            return GestureDetector(
              onTap: () => controller.changeTab(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.textPurple.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    _buildIconWithBadge(
                      iconData: _getIconData(index),
                      isSelected: isSelected,
                      index: index,
                      notificationController: notificationController,
                    ),
                    if (isSelected) ...[
                      SizedBox(width: 8.w),
                      Text(
                        navItems[index]['label'],
                        style: getTextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPurple,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          });
        }),
      ),
    );
  }

  Widget _buildIconWithBadge({
    required IconData iconData,
    required bool isSelected,
    required int index,
    required NotificationController notificationController,
  }) {
    return Stack(
      children: [
        Icon(
          iconData,
          color: isSelected
              ? AppColors.textPurple
              : Colors.black.withValues(alpha: 0.7),
          size: 24.sp,
        ),
        if (index == 3)
          Obx(() {
            final unreadCount = notificationController.unreadCount;
            if (unreadCount == 0) return const SizedBox.shrink();

            return Positioned(
              top: -3.r,
              right: 0.r,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  notificationController.unreadCountDisplay,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }

  IconData _getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.home_rounded;
      case 1:
        return Icons.business_center_rounded;
      case 2:
        return Icons.account_balance_wallet_rounded;
      case 3:
        return Icons.notifications_rounded;
      case 4:
        return Icons.grid_view_rounded;
      default:
        return Icons.home;
    }
  }
}
