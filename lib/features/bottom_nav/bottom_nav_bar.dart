import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/bottom_nav/controller/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavController());

    return Container(
      height: 60.h,
      margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 35.h),
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
        children: List.generate(controller.navItems.length, (index) {
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
                    Icon(
                      _getIconData(index),
                      color: isSelected
                          ? AppColors.textPurple
                          : Colors.black.withValues(alpha: 0.7),
                      size: 24.sp,
                    ),
                    if (isSelected) ...[
                      SizedBox(width: 8.w),
                      Text(
                        controller.navItems[index]['label'],
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
