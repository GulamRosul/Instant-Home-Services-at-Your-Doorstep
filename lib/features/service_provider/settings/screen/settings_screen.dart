import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            20.h.verticalSpace,
            Text(
              'Change Password',
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
            ),
            12.h.verticalSpace,

            CustomTextField(
              hintText: 'Current Password',
              isPasswordField: true,
              controller: controller.currentPasswordController,
              backgroundColor: Colors.white,
            ),
            12.h.verticalSpace,

            CustomTextField(
              hintText: 'New Password',
              isPasswordField: true,
              controller: controller.newPasswordController,
              backgroundColor: Colors.white,
            ),
            12.h.verticalSpace,

            CustomTextField(
              hintText: 'Confirm New Password',
              isPasswordField: true,
              controller: controller.confirmPasswordController,
              backgroundColor: Colors.white,
            ),

            14.h.verticalSpace,
            Obx(
              () => CustomButton(
                text: controller.isLoading.value
                    ? 'Updating...'
                    : 'Update Password',
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.changePassword(),
                backgroundColor: AppColors.textPurple,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
