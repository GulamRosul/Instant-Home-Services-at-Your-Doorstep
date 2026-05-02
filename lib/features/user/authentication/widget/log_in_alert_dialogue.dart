import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/onboarding/screen/second_onboarding_screen.dart';

// ignore: unused_element

void showLoginAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const LoginAlertDialog(), // ✅ public class name
  );
}

class LoginAlertDialog extends StatelessWidget {
  // ✅ public, no underscore
  const LoginAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEDFE),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: const Color(0xFF534AB7),
                size: 28.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Login required',
              style: getTextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please log in or create an account to continue.',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
                lineHeight: 20.sp,
              ),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              text: 'Log in',
              backgroundColor: const Color(0xFF534AB7),
              textColor: Colors.white,
              borderRadius: 8.r,
              height: 44.h,
              onPressed: () {
                Get.back();
                Get.to(() => SecondOnboardingScreen());
              },
            ),
            SizedBox(height: 10.h),
            // CustomButton(
            //   text: 'Create an account',
            //   backgroundColor: Colors.transparent,
            //   textColor: Colors.black,
            //   borderRadius: 8.r,
            //   height: 44.h,
            //   borderColor: AppColors.textSecondary.withValues(alpha: 0.3),
            //   onPressed: () {
            //     Get.back();
            //     Get.to(() => const RegisterScreen());
            //   },
            // ),
            // SizedBox(height: 4.h),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Continue browsing',
                style: getTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
