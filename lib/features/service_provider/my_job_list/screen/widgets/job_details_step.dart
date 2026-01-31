import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/create_job_controller.dart';

class JobDetailsStep extends StatelessWidget {
  const JobDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateJobController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Job Title', isRequired: true),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: controller.jobTitleController,
          hint: 'e.g. Kitchen cabinet installation',
        ),
        SizedBox(height: 20.h),
        _buildLabel('Category'),
        SizedBox(height: 8.h),
        _buildDropdown(
          value: controller.selectedCategory,
          items: controller.categories,
          hint: 'Select Category',
        ),
        SizedBox(height: 20.h),
        _buildLabel('Specific Service'),
        SizedBox(height: 8.h),
        _buildDropdown(
          value: controller.selectedSpecificService,
          items: controller.specificServices,
          hint: 'Select',
        ),
        SizedBox(height: 20.h),
        _buildLabel('Job Description'),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: controller.jobDescriptionController,
          hint: 'Kitchen cabinet installation',
          maxLines: 4,
        ),
        SizedBox(height: 20.h),
        _buildLabel('Base Price'),
        SizedBox(height: 8.h),
        _buildTextField(
          controller: controller.basePriceController,
          hint: '\$200 |',
          prefixIcon: Icons.attach_money_rounded,
          suffixIcon: Icons.unfold_more_rounded, // Matches image arrows
        ),
        SizedBox(height: 20.h),
        _buildLabel('Price Type'),
        SizedBox(height: 8.h),
        _buildDropdown(
          value: controller.priceType,
          items: ["Fixed", "Hourly", "Negotiable"],
          hint: 'Fixed',
        ),
      ],
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: getTextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: getTextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20.sp) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20.sp) : null,
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF7079F0)),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required RxString value,
    required List<String> items,
    required String hint,
  }) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value.value.isEmpty ? null : value.value,
            hint: Text(
              hint,
              style: getTextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
            ),
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 24.sp,
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: getTextStyle(fontSize: 14.sp)),
              );
            }).toList(),
            onChanged: (newValue) {
              value.value = newValue!;
            },
          ),
        ),
      ),
    );
  }
}
