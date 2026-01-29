import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/user/home/controller/available_category_controller.dart';

class AvailableCategoryScreen extends StatelessWidget {
  const AvailableCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvailableCategoryController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CustomAppBar(title: 'Available Service'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // Horizontally Scrollable Categories
          SizedBox(
            height: 90.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                return Obx(() {
                  bool isSelected = controller.selectedIndex.value == index;
                  return GestureDetector(
                    onTap: () => controller.selectCategory(index),
                    child: Container(
                      width: 80.w,
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.textPurple.withValues(alpha: 0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.textPurple
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Placeholder for actual IconPath asset
                          SvgPicture.asset(
                            category['icon']!,
                            width: 24.w,
                            height: 24.h,
                            // colorFilter: ColorFilter.mode(
                            //   Colors.blue.shade700,
                            //   BlendMode.srcIn,
                            // ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            controller.categories[index]['name']!,
                            style: getTextStyle(
                              fontSize: 11.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
            child: Text(
              'Sub Categories',
              style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
          ),

          // Sub Categories List
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: controller.subCategories.length,
                itemBuilder: (context, index) {
                  final item = controller.subCategories[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0085B1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.handyman,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: getTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  lineHeight: 15.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                item['desc']!,
                                style: getTextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.textSecondary,
                                  lineHeight: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                item['count']!,
                                style: getTextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.textPurple,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
