import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart'; // Using your reusable AppBar
import 'package:protiva502/features/user/authentication/controller/user_otp_controller.dart';

class UserOtpScreen extends StatelessWidget {
  const UserOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserOtpController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(
        title: '', // Empty title as per screenshot
        actions: [
          // TextButton(
          //   onPressed: () => Get.back(),
          //   child: Text(
          //     'Skip',
          //     style: getTextStyle(
          //       fontSize: 16.sp,
          //       fontWeight: FontWeight.w400,
          //       color: Colors.grey.shade400,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Send OTP Code',
              style: getTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Enter the 6-digit that we have sent via the email to cheers@design.com',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 30.h),

            // OTP Input Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => _buildOtpBox(context, index, controller),
              ),
            ),

            SizedBox(height: 20.h),

            // Timer Row
            Obx(
              () => Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: const Color(0xFF3F51B5),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    controller.timerText,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Resend Button
            Center(
              child: TextButton(
                onPressed: controller.secondsRemaining.value == 0
                    ? controller.startTimer
                    : null,
                child: Text(
                  'Resend Code',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3F51B5),
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            // Continue Button
            CustomButton(
              text: 'Continue',
              onPressed: controller.verifyOtp,
              backgroundColor: const Color(
                0xFF7079F0,
              ), // Lighter purple/blue from image
              textColor: Colors.white,
            ),

            SizedBox(height: 20.h),

            // Footer Links
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By signing up or logging in, i accept the apps\n',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade700,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF3F51B5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF3F51B5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(
    BuildContext context,
    int index,
    UserOtpController controller,
  ) {
    return Container(
      width: 48.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        // border: Border.all(color: Color(0xFFF8F9FA), width: 1.5),
      ),
      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: getTextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            controller.focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            controller.focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
