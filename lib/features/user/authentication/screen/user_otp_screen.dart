import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart'; // Using your reusable AppBar
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/user/authentication/controller/user_otp_controller.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';

class UserOtpScreen extends StatelessWidget {
  const UserOtpScreen({
    super.key,
    this.email,
    this.isForgotPassword = false,
    this.fromProvider = false,
  });

  final String? email;
  final bool isForgotPassword;
  final bool fromProvider;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserOtpController());

    // Set email from constructor parameter
    if (email != null) {
      controller.setEmail(email!);
    }

    // Set forgot password flow flags
    controller.setForgotPasswordFlow(isForgotPassword);
    controller.setFromProvider(fromProvider);

    final socialMediaController = Get.put(SocialMediaController());

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
              'send_otp_code'.tr,
              style: getTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '${'enter_6_digit_code'.tr} ${email ?? 'cheers@design.com'}',
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
              child: Obx(
                () => TextButton(
                  onPressed:
                      controller.secondsRemaining.value == 0 &&
                          !controller.isLoading.value
                      ? controller.resendOtp
                      : null,
                  child: Text(
                    'resend_code'.tr,
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3F51B5),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            // Continue Button
            Obx(
              () => CustomButton(
                text: controller.isLoading.value
                    ? 'verifying'.tr
                    : 'continue'.tr,
                onPressed: controller.isLoading.value
                    ? null
                    : controller.verifyOtp,
                backgroundColor: const Color(0xFF7079F0),
                textColor: Colors.white,
              ),
            ),

            SizedBox(height: 20.h),

            // Footer Links
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '${'by_signing_up'.tr}\n',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade700,
                  ),
                  children: [
                    TextSpan(
                      text: 'terms_of_service'.tr,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF3F51B5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' ${'and'.tr} ',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    TextSpan(
                      text: 'privacy_policy'.tr,
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
            SizedBox(height: 60.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          socialMediaController.launchSocialUrl(
            socialMediaController.whatsappUrl,
          );
        },
        backgroundColor: Colors.white,
        mini: false,
        child: SvgPicture.asset(IconPath.whatsapp),
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
