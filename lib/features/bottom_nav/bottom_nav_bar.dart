import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(BottomNavController());
    final controller = Get.find<BottomNavController>();
    final notificationController = Get.find<NotificationController>();

    final List<Map<String, dynamic>> navItems = [
  {'icon': IconPath.home, 'label': 'home'.tr},
  {'icon': IconPath.booking, 'label': 'bookings'.tr},
  {'icon': IconPath.notification, 'label': 'notification'.tr},
  {'icon': IconPath.more, 'label': 'more'.tr},
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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
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
                          fontSize: 14.sp,
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
        if (index == 2)
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

  // Helper to map index to icons (replace with your actual icon assets)
  IconData _getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.home_filled;
      case 1:
        return Icons.description_outlined; // Booking icon
      case 2:
        return Icons.notifications_none_rounded;
      case 3:
        return Icons.grid_view_rounded; // More icon
      default:
        return Icons.home;
    }
  }
}
