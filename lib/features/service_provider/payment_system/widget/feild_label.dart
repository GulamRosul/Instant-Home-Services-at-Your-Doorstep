import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/colors.dart';

class FieldLabel extends StatelessWidget {
  final String label;

  const FieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: getTextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textGrey,
        ),
      ),
    );
  }
}
