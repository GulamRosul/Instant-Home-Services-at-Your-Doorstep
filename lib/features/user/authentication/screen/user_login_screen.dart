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
import 'package:protiva502/features/user/authentication/controller/user_login_controller.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserLoginController());
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
          children: [
            SizedBox(
              height: 120.h,
              child: Image.asset(ImagePath.signin, fit: BoxFit.contain),
            ),
            SizedBox(height: 24.h),
            Text(
              "welcome_back".tr,
              style: getTextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "please_sign_in".tr,
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 32.h),
            _buildLabel("email".tr),
            Obx(
              () => CustomTextField(
                controller: controller.emailController,
                hintText: 'sarah@example.com',
                backgroundColor: const Color(0xFFF1F5F9),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
                errorText: controller.emailError.value,
              ),
            ),
            SizedBox(height: 20.h),
            _buildPasswordFieldLabel("password".tr, controller),
            Obx(
              () => CustomTextField(
                controller: controller.passwordController,
                hintText: '***********',
                isPasswordField: true,
                isPasswordVisible: controller.isPasswordVisible.value,
                onIconPressed: controller.togglePasswordVisibility,
                backgroundColor: const Color(0xFFF1F5F9),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
                errorText: controller.passwordError.value,
              ),
            ),
            10.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/userForgotPasswordScreen');
                  },
                  child: Text(
                    "forgot_password".tr,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF7079F0),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.textPurple,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.h),
            Obx(
              () => CustomButton(
                text: controller.isLoading.value ? "signing_in".tr : "sign_in".tr,
                onPressed: controller.isLoading.value
                    ? null
                    : controller.handleSignIn,
                backgroundColor: controller.isLoading.value
                    ? const Color(0xFF7079F0).withValues(alpha: 0.7)
                    : const Color(0xFF7079F0),
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "dont_have_account".tr,
                  style: getTextStyle(fontSize: 14.sp, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/userRegScreen'),
                  child: Text(
                    "sign_up".tr,
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
        shape: const CircleBorder(),
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

  Widget _buildPasswordFieldLabel(String text, UserLoginController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
