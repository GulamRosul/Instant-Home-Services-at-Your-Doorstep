import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
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
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16.h),
        Obx(
          () => Column(
            children: controller.includedServices.asMap().entries.map((entry) {
              int idx = entry.key;
              String val = entry.value;
              // Use local controller for each field if we want live editing,
              // but for simplicity here we show as static or editable via dialog.
              // Following image, it looks like text fields with buttons.
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
                          border: Border.all(color: Colors.grey.shade200),
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
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: idx == 0
                              ? const Color(0xFF7079F0)
                              : const Color(0xFFFFF1F1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          idx == 0 ? Icons.add : Icons.delete_outline_rounded,
                          color: idx == 0 ? Colors.white : Colors.red,
                          size: 24.sp,
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
        const Divider(),
        SizedBox(height: 24.h),
        Text(
          'Upload an image',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
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
                          padding: EdgeInsets.all(20.w),
                          child: Icon(
                            Icons.image_outlined,
                            size: 60.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                        ),
                      )
                    : Container(
                        width: 140.w,
                        height: 140.w,
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
                  fontSize: 13.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
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
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: const Color(0xFF475569)),
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
                          fontSize: 14.sp,
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
        title: Text(
          'Add Service',
          style: getTextStyle(fontWeight: FontWeight.w700),
        ),
        content: TextField(
          controller: controller.serviceInputController,
          decoration: const InputDecoration(hintText: 'Enter service name'),
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
