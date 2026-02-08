import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration_screen_01.dart';
import 'package:protiva502/features/onboarding/controller/language_controller.dart';
import 'package:protiva502/features/user/authentication/screen/user_reg_screen.dart';

class SecondOnboardingScreen extends StatelessWidget {
  SecondOnboardingScreen({super.key});

  final langController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 40.h),
            // Image Container
            // Image Container
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black, // Fully visible image
                      Colors
                          .transparent, // Fades to nothing (glow/blend effect)
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
            // Language Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Text(
                    'Select Role',
                    style: getTextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      lineHeight: 10.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => langController.toggleLanguage(),
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w),
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
                              // Using the getter from the controller for cleaner code
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
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Padding(
                //     padding: EdgeInsets.only(right: 20.w),
                //     child: Container(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 12.w,
                //         vertical: 6.h,
                //       ),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: AppColors.textSecondary.withValues(alpha: 0.5),
                //         ),
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Icon(
                //             Icons.language,
                //             size: 16.sp,
                //             color: AppColors.textSecondary,
                //           ),
                //           SizedBox(width: 4.w),
                //           Text(
                //             'EN',
                //             style: getTextStyle(
                //               fontSize: 12.sp,
                //               fontWeight: FontWeight.w500,
                //               color: AppColors.textSecondary,
                //             ),
                //           ),
                //           Icon(
                //             Icons.keyboard_arrow_down,
                //             size: 16.sp,
                //             color: AppColors.textSecondary,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10.h),
            // Subtitle
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select your role to continue and unlock relevant features',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    lineHeight: 20.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // Title
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: CustomButton(
                text: 'Sign Up to continue as a client',
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                textColor: Colors.black,
                onPressed: () {
                  Get.to(() => UserRegScreen());
                },
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: CustomButton(
                onPressed: () {
                  Get.to(() => ProviderRegistrationScreen01());
                },
                text: 'Sign Up to continue as Service Provider',
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                textColor: Colors.black,
              ),
            ),

            // Sign Up as Service Provider Button
            SizedBox(height: 10.h),
            // Continue as Guest
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue as',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    lineHeight: 15.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate as guest
                  },
                  child: Text(
                    'Guest',
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
            // SizedBox(height: 5.h),

            // Already have an account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    lineHeight: 15.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to sign in
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Sign In',
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
        ),
      ),
    );
  }
}
