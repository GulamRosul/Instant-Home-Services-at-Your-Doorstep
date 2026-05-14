import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/shimmer_effect.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/user/home/controller/available_category_controller.dart';
import 'package:protiva502/features/user/home/screen/subcategory_service_list_screen.dart';

class AvailableCategoryScreen extends StatelessWidget {
  final int? initialCategoryIndex;
  final String? categoryId;

  const AvailableCategoryScreen({
    super.key,
    this.initialCategoryIndex,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvailableCategoryController());

    // Get categoryId from arguments if passed from search screen
    final args = Get.arguments;
    String? passedCategoryId;
    if (args is Map && args.containsKey('categoryId')) {
      passedCategoryId = args['categoryId'] as String?;
    }

    // Set initial category if provided
    if (initialCategoryIndex != null) {
      // Delay to ensure ListView is built before scrolling
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.selectCategoryAfterLoad(initialCategoryIndex!);
      });
    } else if (categoryId != null && categoryId!.isNotEmpty) {
      // Find the index of the category by ID
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.selectCategoryAfterLoadById(categoryId!);
      });
    } else if (passedCategoryId != null && passedCategoryId.isNotEmpty) {
      // Find the index of the category by ID from arguments
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.selectCategoryAfterLoadById(passedCategoryId!);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(title: 'available_service'.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // Horizontally Scrollable Categories
          Obx(() {
            if (controller.isCategoriesLoading.value &&
                controller.categories.isEmpty) {
              return _buildCategoriesShimmerLoader();
            }

            if (controller.categoriesErrorMessage.value.isNotEmpty) {
              return SizedBox(
                height: 90.h,
                child: Center(
                  child: Text(
                    controller.categoriesErrorMessage.value,
                    style: getTextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }

            if (controller.categories.isEmpty) {
              return SizedBox(
                height: 90.h,
                child: Center(
                  child: Text(
                    'no_categories_available'.tr,
                    style: getTextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }

            return SizedBox(
              height: 90.h,
              child: ListView.builder(
                controller: controller.categoriesScrollController,
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
                            // Load icons as network images since they're URLs from API
                            category.icon.isNotEmpty
                                ? Image.network(
                                    category.icon,
                                    width: 24.w,
                                    height: 24.h,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.category,
                                        size: 24.sp,
                                        color: Colors.grey,
                                      );
                                    },
                                  )
                                : Icon(
                                    Icons.category,
                                    size: 24.sp,
                                    color: Colors.grey,
                                  ),
                            SizedBox(height: 8.h),
                            Text(
                              controller.categories[index].name,
                              style: getTextStyle(
                                fontSize: 11.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            );
          }),

          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
            child: Text(
              'sub_categories'.tr,
              style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
          ),

          // Sub Categories List
          Expanded(
            child: Obx(() {
              if (controller.isSubCategoriesLoading.value) {
                return _buildSubCategoriesShimmerLoader();
              }

              if (controller.subCategoriesErrorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.subCategoriesErrorMessage.value,
                    style: getTextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

              if (controller.subCategories.isEmpty) {
                return Center(
                  child: Text(
                    'no_sub_categories_found'.tr,
                    style: getTextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

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
                                item.name,
                                style: getTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  lineHeight: 15.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                item.description,
                                style: getTextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.textSecondary,
                                  lineHeight: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const SubcategoryServiceListScreen(),
                                    arguments: {
                                      'title': item.name,
                                      'count': item.jobCount,
                                      'subCategoryId': item.id,
                                    },
                                  );
                                },
                                child: Text(
                                  '${item.jobCount} ${'services'.tr}',
                                  style: getTextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.textPurple,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
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

  Widget _buildCategoriesShimmerLoader() {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 80.w,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const ShimmerCategoryItem(),
          );
        },
      ),
    );
  }

  Widget _buildSubCategoriesShimmerLoader() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0085B1),
                    shape: BoxShape.circle,
                  ),
                  width: 40.w,
                  height: 40.w,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 11.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        height: 12.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
