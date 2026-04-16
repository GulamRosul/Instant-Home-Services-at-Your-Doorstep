import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/colors.dart';

import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/settings/controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Settings', showBackButton: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            // Tab Selection Section
            // Obx(
            //   () => Row(
            //     children: [
            //       _buildTabItem(
            //         label: 'Preferences',
            //         isSelected: controller.isPreferencesSelected.value,
            //         onTap: () => controller.toggleTab(true),
            //       ),
            //       SizedBox(width: 20.w),
            //       _buildTabItem(
            //         label: 'Notification',
            //         isSelected: !controller.isPreferencesSelected.value,
            //         onTap: () => controller.toggleTab(false),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 32.h),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notification',
                    style: getTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  Switch(
                    value: controller.notificationsEnabled.value,
                    onChanged: controller.toggleNotificationsEnabled,
                    activeThumbColor: Colors.white,
                    activeTrackColor: Colors.black,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade300,
                  ),
                ],
              ),
            ),

            // Main Content Card
            // Obx(
            //   () => Container(
            //     width: double.infinity,
            //     padding: EdgeInsets.all(20.w),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(12.r),
            //       border: Border.all(color: Colors.blue.withValues(alpha: 0.1)),
            //     ),
            //     child: controller.isPreferencesSelected.value
            //         ? Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'Preferences',
            //                 style: getTextStyle(
            //                   fontSize: 18.sp,
            //                   fontWeight: FontWeight.w600,
            //                   color: const Color(0xFF334155),
            //                 ),
            //               ),
            //               SizedBox(height: 4.h),
            //               Text(
            //                 'Customize your experience',
            //                 style: getTextStyle(
            //                   fontSize: 14.sp,
            //                   fontWeight: FontWeight.w400,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //               SizedBox(height: 32.h),
            //               _buildSwitchTile(
            //                 title: 'Show contact info to users',
            //                 subtitle: 'Allow users to see your contact details',
            //                 value: controller.showContactInfo.value,
            //                 onChanged: controller.toggleShowContactInfo,
            //               ),
            //               SizedBox(height: 24.h),
            //               _buildSwitchTile(
            //                 title: 'Public profile',
            //                 subtitle: 'Make your profile visible to users',
            //                 value: controller.publicProfile.value,
            //                 onChanged: controller.togglePublicProfile,
            //               ),
            //             ],
            //           )
            //         : Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(
            //                     'Notification',
            //                     style: getTextStyle(
            //                       fontSize: 18.sp,
            //                       fontWeight: FontWeight.w600,
            //                       color: const Color(0xFF334155),
            //                     ),
            //                   ),
            //                   Switch(
            //                     value: controller.notificationsEnabled.value,
            //                     onChanged:
            //                         controller.toggleNotificationsEnabled,
            //                     activeThumbColor: Colors.white,
            //                     activeTrackColor: Colors.black,
            //                     inactiveThumbColor: Colors.white,
            //                     inactiveTrackColor: Colors.grey.shade300,
            //                   ),
            //                 ],
            //               ),
            //               // SizedBox(height: 32.h),
            //               // _buildSwitchTile(
            //               //   title: 'New Booking Alerts',
            //               //   subtitle:
            //               //       'Get notified when you receive new bookings',
            //               //   value: controller.newBookingAlerts.value,
            //               //   onChanged: controller.toggleNewBookingAlerts,
            //               // ),
            //               // SizedBox(height: 24.h),
            //               // _buildSwitchTile(
            //               //   title: 'Email Notifications',
            //               //   subtitle: 'Receive notifications via email',
            //               //   value: controller.emailNotifications.value,
            //               //   onChanged: controller.toggleEmailNotifications,
            //               // ),
            //               // SizedBox(height: 24.h),
            //               // _buildSwitchTile(
            //               //   title: 'SMS Notifications',
            //               //   subtitle: 'Receive notifications via text message',
            //               //   value: controller.smsNotifications.value,
            //               //   onChanged: controller.toggleSmsNotifications,
            //               // ),
            //             ],
            //           ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF334155) : Colors.white,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey.shade400,
              ),
            ),
            child: isSelected
                ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                : null,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: Colors.black,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}
