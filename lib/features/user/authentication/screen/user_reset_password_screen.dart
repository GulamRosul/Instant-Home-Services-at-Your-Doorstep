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
import 'package:protiva502/features/user/authentication/controller/user_reset_password_controller.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';

class UserResetPasswordScreen extends StatelessWidget {
  const UserResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserResetPasswordController());
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
            // Top Illustration
            SizedBox(
              height: 120.h,
              child: Image.asset(ImagePath.signin, fit: BoxFit.contain),
            ),
            SizedBox(height: 24.h),

            // Header Text
            Text(
              'create_new_password'.tr,
              style: getTextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                lineHeight: 25.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'enter_new_password'.tr,
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 32.h),

            // New Password Field
            _buildLabel("new_password".tr),
            Obx(
              () => CustomTextField(
                controller: controller.newPasswordController,
                hintText: '***********',
                isPasswordField: true,
                isPasswordVisible: controller.isNewPasswordVisible.value,
                onIconPressed: controller.toggleNewPasswordVisibility,
                backgroundColor: const Color(0xFFF1F5F9),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
                errorText: controller.newPasswordError.value,
              ),
            ),
            SizedBox(height: 20.h),

            // Confirm Password Field
            _buildLabel("confirm_password".tr),
            Obx(
              () => CustomTextField(
                controller: controller.confirmPasswordController,
                hintText: '***********',
                isPasswordField: true,
                isPasswordVisible: controller.isConfirmPasswordVisible.value,
                onIconPressed: controller.toggleConfirmPasswordVisibility,
                backgroundColor: const Color(0xFFF1F5F9),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
                errorText: controller.confirmPasswordError.value,
              ),
            ),
            SizedBox(height: 48.h),

            // Reset Password Button
            Obx(
              () => CustomButton(
                text: controller.isLoading.value
                    ? 'resetting'.tr
                    : 'reset_password'.tr,
                onPressed: controller.isLoading.value
                    ? null
                    : controller.handleResetPassword,
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
                  'remember_password'.tr,
                  style: getTextStyle(fontSize: 14.sp, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    'sign_in'.tr,
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
