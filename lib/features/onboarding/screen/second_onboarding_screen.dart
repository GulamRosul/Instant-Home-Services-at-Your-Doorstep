import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_login_screen.dart';
import 'package:protiva502/features/onboarding/controller/language_controller.dart';
import 'package:protiva502/features/user/authentication/screen/user_login_screen.dart';

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
              children: [
                // Left Text (Flexible)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'select_role'.tr,
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
            SizedBox(height: 10.h),
            // Subtitle
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'select_role_subtitle'.tr,
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
                text: 'sign_in_client'.tr,
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                textColor: Colors.black,
                onPressed: () {
                  Get.to(() => UserLoginScreen());
                },
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: CustomButton(
                onPressed: () {
                  Get.to(() => ProviderLoginScreen());
                },
                text: 'sign_in_provider'.tr,
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
                  'continue_as'.tr,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    lineHeight: 15.sp,
                    color: AppColors.textSecondary,
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
            // SizedBox(height: 5.h),

            // Already have an account
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'Already have an account? ',
            //       style: getTextStyle(
            //         fontSize: 14.sp,
            //         fontWeight: FontWeight.w600,
            //         lineHeight: 15.sp,
            //         color: AppColors.textSecondary,
            //       ),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         // Navigate to sign in
            //       },
            //       style: TextButton.styleFrom(
            //         padding: EdgeInsets.zero,
            //         minimumSize: Size.zero,
            //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //       ),
            //       child: Text(
            //         'Sign In',
            //         style: getTextStyle(
            //           fontSize: 14.sp,
            //           fontWeight: FontWeight.w600,
            //           lineHeight: 15.sp,
            //           color: AppColors.textPurple,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
