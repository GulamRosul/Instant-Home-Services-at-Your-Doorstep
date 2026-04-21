import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/auhecntication/controller/provider_reg_controller.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_login_screen.dart';

class ProviderRegistrationScreen01 extends StatelessWidget {
  const ProviderRegistrationScreen01({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ProviderRegController>()
        ? Get.find<ProviderRegController>()
        : Get.put(ProviderRegController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Provider Registration',
          style: getTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3F3F3F),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person_outline, size: 24.sp, color: Colors.black),
                SizedBox(width: 8.w),
                Text(
                  'Personal Information',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            _buildLabel('E-mail address'),
            CustomTextField(
              controller: controller.emailController,
              hintText: 'sarah.johnson@email.com',
              backgroundColor: const Color(0xFFF8F9FA),
              borderColor: const Color(0xFFE2E8F0),
            ),
            SizedBox(height: 16.h),

            _buildLabel('Phone'),
            CustomTextField(
              controller: controller.phoneController,
              hintText: '1XXXXXXXXX',
              backgroundColor: const Color(0xFFF8F9FA),
              borderColor: const Color(0xFFE2E8F0),
              keyboardType: TextInputType.phone,
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

            _buildLabel('First Name'),
            CustomTextField(
              controller: controller.firstNameController,
              hintText: 'Enter your first name',
              backgroundColor: const Color(0xFFF8F9FA),
              borderColor: const Color(0xFFE2E8F0),
            ),
            SizedBox(height: 16.h),

            _buildLabel('Last Name'),
            CustomTextField(
              controller: controller.lastNameController,
              hintText: 'Enter your last name',
              backgroundColor: const Color(0xFFF8F9FA),
              borderColor: const Color(0xFFE2E8F0),
            ),
            SizedBox(height: 16.h),

            _buildLabel('NID Number'),
            CustomTextField(
              controller: controller.nidNumberController,
              hintText: 'Enter your NID number',
              backgroundColor: const Color(0xFFF8F9FA),
              borderColor: const Color(0xFFE2E8F0),
            ),
            SizedBox(height: 16.h),

            _buildLabel('NID Image'),
            Obx(
              () => _buildImageUploadContainer(
                onTap: controller.pickNidImage,
                imagePath: controller.nidImage.value?.path,
                title: 'Upload your NID image',
                subtitle: 'Front and back of your NID card',
              ),
            ),
            SizedBox(height: 16.h),

            _buildLabel('Password'),
            Obx(
              () => CustomTextField(
                controller: controller.passwordController,
                hintText: '**********',
                backgroundColor: const Color(0xFFF8F9FA),
                borderColor: const Color(0xFFE2E8F0),
                isPasswordField: true,
                isPasswordVisible: controller.isPasswordVisible.value,
                onIconPressed: controller.togglePasswordVisibility,
                showPasswordToggleText: true,
              ),
            ),
            SizedBox(height: 16.h),

            _buildLabel('Confirm password'),
            Obx(
              () => CustomTextField(
                controller: controller.confirmPasswordController,
                hintText: '**********',
                backgroundColor: const Color(0xFFF8F9FA),
                borderColor: const Color(0xFFE2E8F0),
                isPasswordField: true,
                isPasswordVisible: controller.isConfirmPasswordVisible.value,
                onIconPressed: controller.toggleConfirmPasswordVisibility,
                showPasswordToggleText: true,
              ),
            ),
            // SizedBox(height: 16.h),

            // _buildLabel('Face Verification'),
            // Obx(
            //   () => _buildImageUploadContainer(
            //     onTap: controller.pickFaceVerificationImage,
            //     imagePath: controller.faceVerificationImage.value?.path,
            //     title: 'Upload or capture your photo',
            //     subtitle: 'For identity verification',
            //   ),
            // ),
            SizedBox(height: 30.h),

            CustomButton(
              text: 'Next',
              onPressed: controller.handleNext,
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
            ),
            SizedBox(height: 20.h),

            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGrey,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPurple,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.off(() => const ProviderLoginScreen());
                        },
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

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: getTextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }

  Widget _buildImageUploadContainer({
    required VoidCallback onTap,
    String? imagePath,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: imagePath != null
            ? Image.file(
                File(imagePath),
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 24.sp,
                      color: Colors.grey[600],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      title,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]!,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
