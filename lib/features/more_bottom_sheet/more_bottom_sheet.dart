import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/routes/app_routes.dart';

class MoreBottomSheet extends StatelessWidget {
  const MoreBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Grid of menu items
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMenuItem(
                      iconPath: IconPath.profilePic,
                      label: 'Profile',
                      onTap: () {
                        Get.back();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Get.toNamed(AppRoute.getProfile());
                        });
                      },
                    ),
                    _buildMenuItem(
                      iconPath: IconPath.language,
                      label: 'Language',
                      onTap: () {
                        Get.back();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Get.toNamed(AppRoute.getLanguageSettings());
                        });
                      },
                    ),
                    _buildMenuItem(
                      iconPath: IconPath.settings,
                      label: 'Settings',
                      onTap: () {
                        Get.back();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Get.toNamed(AppRoute.getSettings());
                        });
                      },
                    ),
                    _buildMenuItem(
                      iconPath: IconPath.help,
                      label: 'Help & Support',
                      onTap: () {
                        Get.back();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Get.toNamed(AppRoute.getSocialMedia());
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 15.w),
                    _buildMenuItem(
                      iconPath: IconPath.privacy,
                      label: 'Privacy & Policy',
                      onTap: () {
                        Get.back();
                        // Navigate to privacy policy
                      },
                    ),
                    SizedBox(width: 20.w),
                    _buildMenuItem(
                      iconPath: IconPath.logout,
                      label: 'Logout',
                      isLogout: true,
                      onTap: () {
                        Get.back();
                        // Handle logout
                        Get.offAllNamed(AppRoute.getOnboardingScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: isLogout
                    ? const Color(0xFFFEE2E2)
                    : const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isLogout
                      ? const Color(0xFFEF4444).withValues(alpha: 0.3)
                      : AppColors.textPurple.withValues(alpha: 0.3),
                  width: 1.w,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 32.w,
                  height: 32.h,
                  // colorFilter: ColorFilter.mode(
                  //   isLogout ? const Color(0xFFEF4444) : AppColors.textPurple,
                  //   BlendMode.srcIn,
                  // ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
