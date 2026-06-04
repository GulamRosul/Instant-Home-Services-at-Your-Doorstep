import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';

class VersionCheckDialogue extends StatelessWidget {
  final String currentVersion;
  final String latestVersion;
  final bool isForceUpdate;
  final VoidCallback onUpdate;
  final VoidCallback onCancel;

  const VersionCheckDialogue({
    super.key,
    required this.currentVersion,
    required this.latestVersion,
    required this.isForceUpdate,
    required this.onUpdate,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isForceUpdate
                    ? const Color(0xFFFFE8E8)
                    : const Color(0xFFE8F5E9),
              ),
              child: Icon(
                isForceUpdate ? Icons.warning_rounded : Icons.system_update,
                color: isForceUpdate
                    ? AppColors.error
                    : const Color(0xFF4CAF50),
                size: 32.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              isForceUpdate ? 'Update Required' : 'Update Available',
              style: getTextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Current: v$currentVersion | Latest: v$latestVersion',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              isForceUpdate
                  ? 'A critical update is available. Please update to continue using the app.'
                  : 'A new version is available with improvements and bug fixes.',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
                lineHeight: 18.sp,
              ),
            ),
            SizedBox(height: 32.h),
            CustomButton(
              text: 'Update Now',
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
              borderRadius: 8.r,
              height: 44.h,
              onPressed: onUpdate,
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: onCancel,
              child: Container(
                height: 44.h,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isForceUpdate ? 'Close App' : 'Later',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isForceUpdate ? AppColors.error : Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
