import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart'; // Ensure correct path
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/user/authentication/controller/user_reg_controller.dart';
import 'package:protiva502/features/user/authentication/screen/user_login_screen.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';

class UserRegScreen extends StatelessWidget {
  const UserRegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserRegController());
    final socialMediaController = Get.put(SocialMediaController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Client Registration'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get Started as a Client',
              style: getTextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 24.h),

            _buildFieldLabel("First name"),
            CustomTextField(
              controller: controller.firstNameController,
              hintText: 'Sarah',
              backgroundColor: const Color(0xFFF1F5F9), // Very light grey input
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),

            SizedBox(height: 16.h),
            _buildFieldLabel("Last name"),
            CustomTextField(
              controller: controller.lastNameController,
              hintText: 'Sarah',
              backgroundColor: const Color(0xFFF1F5F9), // Very light grey input
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),

            SizedBox(height: 16.h),
            _buildFieldLabel("E-mail address"),
            CustomTextField(
              controller: controller.emailController,
              hintText: 'sarah.johnson@email.com',
              keyboardType: TextInputType.emailAddress,
              backgroundColor: const Color(0xFFF1F5F9), // Very light grey input
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),

            SizedBox(height: 16.h),
            _buildFieldLabel("Phone"),
            CustomTextField(
              controller: controller.phoneController,
              hintText: '1XXXXXXXXX',
              keyboardType: TextInputType.phone,
              backgroundColor: const Color(0xFFF1F5F9), // Very light grey input
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
              prefixIcon: CountryCodePicker(
                onChanged: (country) => controller.updateCountryCode(
                  country.dialCode ?? controller.selectedCountryCode.value,
                ),
                initialSelection: controller.selectedCountryCode.value,
                favorite: const ["+880", "BD"],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                padding: EdgeInsets.zero,
                textStyle: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 16.h),
            _buildFieldLabel("City"),
            CustomTextField(
              controller: controller.cityController,
              hintText: 'Canada',
              backgroundColor: const Color(0xFFF1F5F9),
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),

            SizedBox(height: 16.h),
            _buildPasswordFieldLabel("Password", controller.isPasswordVisible),
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
              ),
            ),

            SizedBox(height: 16.h),
            _buildPasswordFieldLabel(
              "Confirm password",
              controller.isConfirmPasswordVisible,
            ),
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
              ),
            ),

            SizedBox(height: 30.h),
            Obx(
              () => CustomButton(
                text: controller.isLoading.value ? 'Registering...' : 'Next',
                onPressed: controller.isLoading.value
                    ? null
                    : controller.handleRegistration,
                backgroundColor: controller.isLoading.value
                    ? AppColors.primary.withValues(alpha: 0.7)
                    : AppColors.primary,
                textColor: Colors.white,
              ),
            ),

            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => UserLoginScreen()),
                  child: Text(
                    'Sign In',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF6366F1), // Purple color
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
          socialMediaController.launchSocialUrl(socialMediaController.whatsappUrl);
        },
        backgroundColor: Colors.white,
        mini: false,
        child: SvgPicture.asset(IconPath.whatsapp),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
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

  Widget _buildPasswordFieldLabel(String label, RxBool visibility) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
