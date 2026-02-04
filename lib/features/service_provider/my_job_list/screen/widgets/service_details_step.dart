import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
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
            children: controller.includedServices.asMap().entries.map((entry) {
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
                      onTap: () => idx == 0
                          ? _showAddServiceDialog(context, controller)
                          : controller.removeService(idx),
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: idx == 0
                              ? const Color(0xFF7079F0)
                              : const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: SvgPicture.asset(
                          idx == 0 ? IconPath.add : IconPath.delete,
                          color: idx == 0 ? Colors.white : Color(0xFFB91C1C),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
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
              Obx(
                () => controller.uploadedImagePath.value.isEmpty
                    ? CustomDashedBorder(
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
                      )
                    : Container(
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                          border: Border.all(color: const Color(0xFF1E293B)),
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
                    SizedBox(width: 16.w),
                    Obx(
                      () => Text(
                        controller.uploadedImagePath.value.isEmpty
                            ? 'No File Chosen'
                            : 'File Selected',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
