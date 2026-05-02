import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/create_job_controller.dart';
import 'package:protiva502/core/common/widgets/custom_dashed_border.dart';

class ServiceDetailsStep extends StatelessWidget {
  const ServiceDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateJobController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Section
        Text(
          'Category',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D2D2D),
          ),
        ),
        SizedBox(height: 12.h),
        Obx(() {
          if (controller.isCategoriesLoading.value) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Color(0xFFCBD5E1)),
              ),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.categoriesErrorMessage.value.isNotEmpty) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Color(0xFFCBD5E1)),
              ),
              child: Text(
                controller.categoriesErrorMessage.value,
                style: getTextStyle(fontSize: 14.sp, color: Colors.red),
              ),
            );
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Color(0xFFCBD5E1)),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: SizedBox(),
              hint: Text(
                'Select a category',
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              value: controller.selectedCategoryId.value.isEmpty
                  ? null
                  : controller.selectedCategoryId.value,
              items: controller.categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category.id,
                  child: Text(
                    category.name,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade800,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  final selectedCat = controller.categories.firstWhere(
                    (cat) => cat.id == newValue,
                  );
                  controller.selectCategory(newValue, selectedCat.name);
                }
              },
            ),
          );
        }),
        SizedBox(height: 24.h),

        // Sub-Category Section
        Text(
          'Sub Category',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D2D2D),
          ),
        ),
        SizedBox(height: 12.h),
        Obx(() {
          if (controller.selectedCategoryId.value.isEmpty) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Color(0xFFCBD5E1)),
              ),
              child: Text(
                'Please select a category first',
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            );
          }

          if (controller.isSubCategoriesLoading.value) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Color(0xFFCBD5E1)),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.textPurple),
              ),
            );
          }

          if (controller.subCategoriesErrorMessage.value.isNotEmpty) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Color(0xFFCBD5E1)),
              ),
              child: Text(
                controller.subCategoriesErrorMessage.value,
                style: getTextStyle(fontSize: 14.sp, color: Colors.red),
              ),
            );
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Color(0xFFCBD5E1)),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: SizedBox(),
              hint: Text(
                'Select a sub category',
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              value: controller.selectedSubCategoryId.value.isEmpty
                  ? null
                  : controller.selectedSubCategoryId.value,
              items: controller.subCategories.map((subCategory) {
                return DropdownMenuItem<String>(
                  value: subCategory.id,
                  child: Text(
                    subCategory.name,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade800,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  final selectedSubCat = controller.subCategories.firstWhere(
                    (subCat) => subCat.id == newValue,
                  );
                  controller.selectSubCategory(newValue, selectedSubCat.name);
                }
              },
            ),
          );
        }),
        SizedBox(height: 24.h),
        Divider(color: Color(0xFFCBD5E1)),
        SizedBox(height: 24.h),

        Text(
          'What include in your service',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D2D2D),
          ),
        ),
        SizedBox(height: 16.h),
        Obx(
          () => Column(
            children: [
              ...controller.includedServices.asMap().entries.map((entry) {
                int idx = entry.key;
                String val = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFCBD5E1)),
                          ),
                          child: Text(
                            val,
                            style: getTextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () => controller.removeService(idx),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: SvgPicture.asset(
                            IconPath.delete,
                            color: Color(0xFFB91C1C),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () => _showAddServiceDialog(context, controller),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7079F0),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: SvgPicture.asset(
                          IconPath.add,
                          color: Colors.white,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Add Service',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7079F0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Divider(color: Color(0xFFCBD5E1)),
        SizedBox(height: 24.h),
        Text(
          'Upload an image',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D2D2D),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: Color(0xFFCBD5E1)),
          ),
          child: Column(
            children: [
              Obx(() {
                // Show new uploaded image if selected
                if (controller.uploadedImagePath.value.isNotEmpty) {
                  return Column(
                    children: [
                      Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: DecorationImage(
                            image: FileImage(
                              File(controller.uploadedImagePath.value),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      GestureDetector(
                        onTap: () {
                          controller.uploadedImagePath.value = '';
                        },
                        child: Text(
                          'Change Image',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF7079F0),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                // Show existing thumbnail URL in edit mode
                if (controller.isEditMode.value &&
                    controller.thumbnailUrl.value.isNotEmpty) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          controller.thumbnailUrl.value,
                          width: 120.w,
                          height: 120.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 120.w,
                              height: 120.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.grey[300],
                              ),
                              child: const Icon(Icons.image_not_supported),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 12.h),
                      GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: Text(
                          'Change Image',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF7079F0),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                // Show empty state with upload option
                return Column(
                  children: [
                    CustomDashedBorder(
                      color: const Color(0xFFCBD5E1),
                      strokeWidth: 1.5,
                      dashWidth: 4,
                      dashSpace: 4,
                      borderRadius: 8.r,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF475569).withValues(alpha: 0.1),
                        ),
                        padding: EdgeInsets.all(20.w),
                        child: SvgPicture.asset(
                          IconPath.galary,
                          height: 50.h,
                          width: 50.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Please upload square image, size less than 100KB',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => controller.pickImage(),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              child: Text(
                                'Choose File',
                                style: getTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 16.w),
                          // Text(
                          //   'No File Chosen',
                          //   style: getTextStyle(
                          //     fontSize: 12.sp,
                          //     fontWeight: FontWeight.w400,
                          //     color: const Color(0xFF64748B),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddServiceDialog(
    BuildContext context,
    CreateJobController controller,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Add Service',
          style: getTextStyle(fontWeight: FontWeight.w700),
        ),
        content: CustomTextField(
          controller: controller.serviceInputController,
          hintText: 'Enter service name',
          backgroundColor: Colors.white,
          borderColor: Color(0xFF666659).withValues(alpha: 0.3),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              controller.addService();
              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
