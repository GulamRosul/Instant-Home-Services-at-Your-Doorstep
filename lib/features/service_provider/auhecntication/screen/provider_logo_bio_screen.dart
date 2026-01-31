import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/auhecntication/controller/provider_login_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/controller/provider_logo_bio_controller.dart';

class ProviderLogoBioScreen extends StatelessWidget {
  const ProviderLogoBioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderLogoBioController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F7),
        elevation: 0,
        surfaceTintColor: const Color(0xFFF5F5F7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Faded Skip (top)
                Text(
                  'Skip',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 2.h),
                // Main Skip (underlined, darker)
                GestureDetector(
                  onTap: controller.handleSkip,
                  child: Text(
                    'Skip',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo upload section (centered)
            Center(
              child: GestureDetector(
                onTap: controller.pickLogo,
                child: Obx(() {
                  final path = controller.logoPath.value;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E7EB),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.defaultBorder.withValues(
                              alpha: 0.3,
                            ),
                            width: 1,
                          ),
                        ),
                        child: path != null
                            ? ClipOval(
                                child: Image.file(
                                  File(path),
                                  fit: BoxFit.cover,
                                  width: 120.w,
                                  height: 120.w,
                                ),
                              )
                            : Icon(
                                Icons.person_outline,
                                size: 56.sp,
                                color: AppColors.textGrey,
                              ),
                      ),
                      // Small plus circle at bottom right
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF9CA3AF),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: Text(
                'Upload Your Logo',
                style: getTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 28.h),

            // About Service
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                'About Service',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGrey,
                ),
              ),
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.defaultBorder.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    controller: controller.bioController,
                    maxLength: ProviderLogoBioController.maxBioLength,
                    maxLines: 5,
                    minLines: 4,
                    onChanged: (v) => controller.updateBioCount(v.length),
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your bio',
                      hintStyle: getTextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(
                        14.w,
                        14.h,
                        14.w,
                        32.h,
                      ),
                      counterText: '',
                    ),
                  ),
                ),
                Positioned(
                  right: 12.w,
                  bottom: 10.h,
                  child: Obx(
                    () => Text(
                      '${controller.bioCharCount.value}/${ProviderLogoBioController.maxBioLength}',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            CustomButton(
              text: 'Next',
              onPressed: controller.handleNext,
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
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
                  onTap: () => Get.off(() => const ProviderLoginScreen()),
                  child: Text(
                    'Sign In',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF6366F1),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
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
