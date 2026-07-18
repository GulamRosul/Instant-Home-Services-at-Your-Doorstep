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
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/user/authentication/controller/user_login_controller.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';
import 'package:protiva502/features/onboarding/controller/language_controller.dart';

class UserLoginScreen extends StatelessWidget {
  UserLoginScreen({super.key});
  final langController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserLoginController());
    final socialMediaController = Get.put(SocialMediaController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios_new,
      //       color: Colors.black,
      //       size: 24.sp,
      //     ),
      //     onPressed: () => Get.back(),
      //   ),
      // ),
      body: Obx(
        () => SingleChildScrollView(
          // padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: controller.needsEmailVerification.value
              ? _buildEmailVerificationUI(controller)
              : _buildLoginForm(controller, context),
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

  Widget _buildLoginForm(UserLoginController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: 120.h,
        //   child: Image.asset(ImagePath.signin, fit: BoxFit.contain),
        // ),
        // SizedBox(height: 24.h),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black, // Fully visible image
                  Colors.transparent, // Fades to nothing (glow/blend effect)
                ],
                stops: [0.7, 1.0], // Image starts fading at 70% height
              ).createShader(rect);
            },
            blendMode:
                BlendMode.dstIn, // Important: applies the mask to the image
            child: Image.asset(
              ImagePath.onboardingtwo,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "welcome_back".tr,
        //       style: getTextStyle(
        //         fontSize: 28.sp,
        //         fontWeight: FontWeight.w700,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        // ),
        Row(
          children: [
            // Left Text (Flexible)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'welcome_back'.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    lineHeight: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Language Toggle Button
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: GestureDetector(
                onTap: () => langController.toggleLanguage(),
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.textPurple.withValues(alpha: 0.5),
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.language,
                          size: 16.sp,
                          color: AppColors.textPurple,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          langController.currentLanguageLabel,
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // SizedBox(height: 12.h),
        // Text(
        //   "please_sign_in".tr,
        //   style: getTextStyle(
        //     fontSize: 16.sp,
        //     fontWeight: FontWeight.w500,
        //     color: Colors.black87,
        //     lineHeight: 20.sp,
        //   ),
        //   textAlign: TextAlign.center,
        // ),
        SizedBox(height: 32.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: _buildLabel("email".tr),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Obx(
            () => CustomTextField(
              controller: controller.emailController,
              hintText: 'example@gmail.com',
              backgroundColor: const Color(0xFFF1F5F9),
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
              errorText: controller.emailError.value,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: _buildPasswordFieldLabel("password".tr),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Obx(
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
        ),
        10.h.verticalSpace,
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Row(
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
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Obx(
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
        ),
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "dont_have_account".tr,
                style: getTextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500),
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
        ),
        // SizedBox(height: 16.h),
        Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'continue_as'.tr,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    lineHeight: 15.sp,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.offAll(() => const MainNavigationScreen());
                  },
                  child: Text(
                    'guest'.tr,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      lineHeight: 15.sp,
                      color: AppColors.textPurple,
                    ),
                  ),
                ),
              ],
            ),
        SizedBox(height: 40.h),
      ],
    );
  }

  Widget _buildEmailVerificationUI(UserLoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100.h),
        Icon(Icons.mail_outline, size: 80.sp, color: const Color(0xFF7079F0)),
        SizedBox(height: 32.h),
        Text(
          "verify_email".tr,
          style: getTextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3CD),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFFFE69C), width: 1),
          ),
          child: Text(
            "please_verify_your_email_first".tr,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF856404),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          "verify_email_desc".tr,
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 48.h),
        Obx(
          () => CustomButton(
            text: controller.isOtpLoading.value
                ? "sending_otp".tr
                : "send_otp".tr,
            onPressed: controller.isOtpLoading.value
                ? null
                : controller.sendOtp,
            backgroundColor: controller.isOtpLoading.value
                ? const Color(0xFF7079F0).withValues(alpha: 0.7)
                : const Color(0xFF7079F0),
            textColor: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        TextButton(
          onPressed: () {
            controller.needsEmailVerification.value = false;
            controller.emailController.clear();
            controller.passwordController.clear();
          },
          child: Text(
            "back_to_login".tr,
            style: getTextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF7079F0),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(height: 40.h),
      ],
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

  Widget _buildPasswordFieldLabel(String text) {
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
