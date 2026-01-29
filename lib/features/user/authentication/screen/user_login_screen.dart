import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/image_path.dart'; // Ensure illustration path is here
import 'package:protiva502/features/user/authentication/controller/user_login_controller.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserLoginController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Subtle grey background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Skip',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade300, // Matching the light "Skip" color
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            // Top Illustration
            SizedBox(
              height: 200.h,
              child: Image.asset(
                ImagePath.signin, // Update with your actual asset path
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 24.h),

            // Header Text
            Text(
              'Welcome back!',
              style: getTextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please Sign in to continue.',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 32.h),

            // Username Field
            _buildLabel("Username"),
            CustomTextField(
              controller: controller.usernameController,
              hintText: 'Sarah',
              backgroundColor: const Color(0xFFF1F5F9), // Very light grey input
              borderColor: Colors.transparent,
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),

            // Password Field
            _buildPasswordFieldLabel("Password", controller),
            Obx(
              () => CustomTextField(
                controller: controller.passwordController,
                hintText: '***********',
                isPasswordField: true,
                isPasswordVisible: controller.isPasswordVisible.value,
                onIconPressed: controller.togglePasswordVisibility,
                backgroundColor: const Color(0xFFF1F5F9),
                borderColor: Colors.transparent,
                textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
              ),
            ),

            SizedBox(height: 48.h),

            // Sign In Button
            CustomButton(
              text: 'Sign In',
              onPressed: controller.handleSignIn,
              backgroundColor: const Color(
                0xFF7079F0,
              ), // Matching purple from screenshot
              textColor: Colors.white,
            ),

            SizedBox(height: 24.h),

            // Footer Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account? ",
                  style: getTextStyle(fontSize: 14.sp, color: Colors.black),
                ),
                GestureDetector(
                  onTap: controller.navigateToSignUp,
                  child: Text(
                    'Sign Up',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF7079F0),
                      fontWeight: FontWeight.w600,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
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
          // Obx(
          //   () => Row(
          //     children: [
          //       Icon(
          //         controller.isPasswordVisible.value
          //             ? Icons.visibility
          //             : Icons.visibility_off,
          //         size: 16.sp,
          //         color: Colors.grey,
          //       ),
          //       SizedBox(width: 4.w),
          //       Text(
          //         controller.isPasswordVisible.value ? 'Hide' : 'Show',
          //         style: getTextStyle(fontSize: 12.sp, color: Colors.grey),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
