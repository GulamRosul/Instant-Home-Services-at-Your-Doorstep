import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/create_job_controller.dart';

class TabItem extends StatelessWidget {
  final String label;
  final int index;
  final CreateJobController controller;

  const TabItem({
    super.key,
    required this.label,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = controller.currentStep.value == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: isActive ? const Color(0xFF787BEB) : const Color(0xFF334155),
          ),
        ),
        if (isActive)
          Container(
            height: 1.h,
            width: label.length * 7.w,
            decoration: BoxDecoration(
              color: const Color(0xFF7079F0),
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
      ],
    );
  }
}
