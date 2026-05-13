import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SocialMediaController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'social_media'.tr, showBackButton: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'connect_with_us'.tr,
              style: getTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'follow_us_on_social_media'.tr,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 32.h),

            _buildSocialCard(
              title: 'facebook'.tr,
              handle: 'kaajbd',
              icon: IconPath.facebook,
              iconColor: Color(0xFF0C63D4),
              onTap: () => controller.launchSocialUrl(controller.facebookUrl),
            ),
            SizedBox(height: 16.h),

            _buildSocialCard(
              title: 'whatsapp'.tr,
              handle: '+880 1798-036636',
              icon: IconPath.whatsapp2,
              iconColor: Color(0xFF25D366),
              // iconColor: Colors.black,
              onTap: () => controller.launchSocialUrl(controller.whatsappUrl),
            ),
            SizedBox(height: 16.h),

            _buildSocialCard(
              title: 'youtube'.tr,
              handle: '@kaajbdofficial',
              icon: IconPath.youtube,
              iconColor: Color(0xFFFF0000),
              onTap: () => controller.launchSocialUrl(controller.youtubeUrl),
            ),
            SizedBox(height: 16.h),

            _buildSocialCard(
              title: 'instagram'.tr,
              handle: 'kaajbdofficial',
              icon: IconPath.instragram,
              iconColor: const Color(0xFFE4405F),
              onTap: () => controller.launchSocialUrl(controller.instagramUrl),
            ),
            SizedBox(height: 32.h),

            // Stay Updated Box
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F9FF),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text('💬', style: TextStyle(fontSize: 16.sp)),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'stay_updated'.tr,
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'join_our_community'.tr,
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialCard({
    required String title,
    required String handle,
    required String icon,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(
                icon,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    handle,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              color: const Color(0xFF94A3B8),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
