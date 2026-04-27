import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/auhecntication/controller/provider_forgot_password_controller.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';

class ProviderForgotPasswordScreen extends StatelessWidget {
  const ProviderForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderForgotPasswordController());
    final socialMediaController = Get.put(SocialMediaController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Illustration
            SizedBox(
              height: 120.h,
              child: Image.asset(ImagePath.signin, fit: BoxFit.contain),
            ),
            SizedBox(height: 24.h),

            // Header Text
            Text(
              'Reset your password',
              style: getTextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                lineHeight: 25.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Enter your email address to receive an OTP code.',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                lineHeight: 22.sp,
              ),
            ),
            SizedBox(height: 32.h),

            // Email Field
            _buildLabel("Email"),
            Obx(
              () => CustomTextField(
                controller: controller.emailController,
                hintText: 'example@gmail.com',
                keyboardType: TextInputType.emailAddress,
                backgroundColor: const Color(0xFFF1F5F9),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
                errorText: controller.emailError.value,
              ),
            ),
            SizedBox(height: 48.h),

            // Send OTP Button
            Obx(
              () => CustomButton(
                text: controller.isLoading.value
                    ? 'Sending OTP...'
                    : 'Send OTP',
                onPressed: controller.isLoading.value
                    ? null
                    : controller.handleForgotPassword,
                backgroundColor: controller.isLoading.value
                    ? const Color(0xFF7079F0).withValues(alpha: 0.7)
                    : const Color(0xFF7079F0),
                textColor: Colors.white,
              ),
            ),

            SizedBox(height: 24.h),

            // Back to Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Remember your password? ",
                  style: getTextStyle(fontSize: 14.sp, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    'Sign In',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF7079F0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
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

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(
          text,
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
