import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_popupmenu_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/create_job_controller.dart';

class JobDetailsStep extends StatelessWidget {
  const JobDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateJobController>();

    // Map enum values to display labels
    final Map<String, String> priceTypeLabels = {
      'FIXED': 'Fixed',
      'HOURLY': 'Hourly',
      'NEGOTIABLE': 'Negotiable',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('job_title'.tr, isRequired: true),
        SizedBox(height: 8.h),
        CustomTextField(
          backgroundColor: Colors.white,
          borderColor: Color(0xFF666659).withValues(alpha: 0.3),
          controller: controller.jobTitleController,
          hintText: 'enter_job_title'.tr,
        ),
        SizedBox(height: 20.h),
        // _buildLabel('Category', isRequired: true),
        // SizedBox(height: 8.h),
        // Obx(
        //   () => CustomPopupMenu(
        //     value: controller.selectedCategory.value.isEmpty
        //         ? 'Select Category'
        //         : controller.selectedCategory.value,
        //     items: controller.categories,
        //     onSelected: (value) {
        //       controller.selectedCategory.value = value;
        //     },
        //   ),
        // ),
        // SizedBox(height: 20.h),
        // _buildLabel('Specific Service', isRequired: true),
        // SizedBox(height: 8.h),
        // Obx(
        //   () => CustomPopupMenu(
        //     value: controller.selectedSpecificService.value.isEmpty
        //         ? 'Select'
        //         : controller.selectedSpecificService.value,
        //     items: controller.specificServices,
        //     onSelected: (value) {
        //       controller.selectedSpecificService.value = value;
        //     },
        //   ),
        // ),
        // SizedBox(height: 20.h),
        _buildLabel('job_description'.tr, isRequired: true),
        SizedBox(height: 8.h),
        CustomTextField(
          backgroundColor: Colors.white,
          borderColor: Color(0xFF666659).withValues(alpha: 0.3),
          controller: controller.jobDescriptionController,
          // hintText: 'Kitchen cabinet installation',
          maxLines: 7,
        ),
        SizedBox(height: 20.h),
        _buildLabel('base_price'.tr, isRequired: true),
        SizedBox(height: 8.h),
        CustomTextField(
          backgroundColor: Colors.white,
          borderColor: Color(0xFF666659).withValues(alpha: 0.3),
          controller: controller.basePriceController,
          hintText: ' ৳200',
        ),
        SizedBox(height: 20.h),
        _buildLabel('price_type'.tr, isRequired: true),
        SizedBox(height: 8.h),
        Obx(
          () => CustomPopupMenu(
            value: priceTypeLabels[controller.priceType.value] ?? 'Fixed',
            items: priceTypeLabels.values.toList(),
            onSelected: (value) {
              // Map display label back to enum value
              controller.priceType.value = priceTypeLabels.entries
                  .firstWhere((entry) => entry.value == value)
                  .key;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: getTextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2D2D2D),
        ),
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: getTextStyle(color: Colors.red, fontSize: 16.sp),
                ),
              ]
            : [],
      ),
    );
  }
}
