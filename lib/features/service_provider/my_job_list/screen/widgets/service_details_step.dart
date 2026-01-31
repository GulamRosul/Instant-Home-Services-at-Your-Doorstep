import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/create_job_controller.dart';

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
        GestureDetector(
          onTap: () => controller.pickImage(),
          child: Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle
                    .solid, // Should be dashed, but hard to do in vanilla BoxDecoration
              ),
            ),
            child: Obx(
              () => controller.uploadedImagePath.value.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              style: BorderStyle.none,
                            ),
                          ),
                          child: Icon(
                            Icons.image_outlined,
                            size: 40.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Please upload square image, size less than 100KB',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Choose File',
                                style: getTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'No File Chosen',
                                style: getTextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child:
                          controller.uploadedImagePath.value.startsWith(
                            'assets',
                          )
                          ? Image.asset(
                              controller.uploadedImagePath.value,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              controller.uploadedImagePath.value,
                              fit: BoxFit.cover,
                            ),
                    ),
            ),
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
