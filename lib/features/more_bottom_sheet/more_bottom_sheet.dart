import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/routes/app_routes.dart';
import 'package:protiva502/features/user/authentication/widget/log_in_alert_dialogue.dart';

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
                      label: 'profile'.tr,
                      onTap: () {
                        if (!StorageService.isLoggedIn) {
                          showLoginAlertDialog(context);
                          return;
                        }
                        Get.back();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Get.toNamed(AppRoute.getProfile());
                        });
                      },
                    ),
                    _buildMenuItem(
                      iconPath: IconPath.language,
                      label: 'language'.tr,
                      onTap: () {
                        Get.back();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Get.toNamed(AppRoute.getLanguageSettings());
                        });
                      },
                    ),
                    _buildMenuItem(
                      iconPath: IconPath.settings,
                      label: 'settings'.tr,
                      onTap: () {
                        if (!StorageService.isLoggedIn) {
                          showLoginAlertDialog(context);
                          return;
                        }
                        Get.back();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Get.toNamed(AppRoute.getSettings());
                        });
                      },
                    ),
                    _buildMenuItem(
                      iconPath: IconPath.help,
                      label: 'help_support'.tr,
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
                      label: 'privacy_policy'.tr,
                      onTap: () {
                        Get.back();
                        // Navigate to privacy policy
                        Get.toNamed(AppRoute.getPrivacyPolicyScreen());
                      },
                    ),
                    SizedBox(width: 10.w),
                    _buildMenuItem(
                      iconPath: IconPath.termsCondition,
                      label: 'terms_conditions'.tr,
                      onTap: () {
                        Get.back();
                        // Navigate to terms and conditions
                        Get.toNamed(AppRoute.getTermsCondition());
                      },
                    ),
                    SizedBox(width: 10.w),
                    _buildMenuItem(
                      iconPath: IconPath.logout,
                      label: 'logout'.tr,
                      isLogout: true,
                      onTap: () => _showLogoutDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }

  void showLoginAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => LoginAlertDialog(),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  IconPath.logout,
                  width: 32.w,
                  height: 32.h,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'logout'.tr,
                style: getTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'logout_confirmation'.tr,
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'no'.tr,
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.back(); // Close dialog
                        Get.back(); // Close bottom sheet
                        // await CallService.instance.uninitialize();
                        await StorageService.clearAll();
                        Get.offAllNamed(AppRoute.getSecondOnboardingScreen());
                      },
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEF4444),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ).copyWith(
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            side: WidgetStateProperty.all(BorderSide.none),
                          ),
                      child: Text(
                        'yes'.tr,
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
