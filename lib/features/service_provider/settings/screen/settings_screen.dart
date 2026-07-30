import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/colors.dart';

import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/settings/controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    final userRole = StorageService.getRole();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(title: 'settings'.tr, showBackButton: true),
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
                    'notification'.tr,
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
            _buildActionTile(
              title: 'change_password'.tr,
              subtitle: 'update_password_reminder'.tr,
              icon: Icons.lock_outline,
              iconColor: AppColors.textPurple,
              onTap: () => _showChangePasswordSheet(context, controller),
            ),
            12.h.verticalSpace,
            if (userRole == 'CLIENT')
             _buildActionTile(
              title: 'delete_account'.tr,
              subtitle: 'delete_account_reminder'.tr,
              icon: Icons.delete_forever_outlined,
              iconColor: const Color(0xFFDC2626),
              onTap: () => _showDeleteAccountSheet(context, controller),
            ),
           
          ],
        ),
      ),
    );
  }

  void _showChangePasswordSheet(
    BuildContext context,
    SettingsController controller,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(99.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'change_password'.tr,
                      style: getTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Enter your current password and choose a new one.',
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      hintText: 'current_password'.tr,
                      isPasswordField: true,
                      controller: controller.currentPasswordController,
                      backgroundColor: Colors.white,
                    ),
                    12.h.verticalSpace,
                    CustomTextField(
                      hintText: 'new_password'.tr,
                      isPasswordField: true,
                      controller: controller.newPasswordController,
                      backgroundColor: Colors.white,
                    ),
                    12.h.verticalSpace,
                    CustomTextField(
                      hintText: 'confirm_new_password'.tr,
                      isPasswordField: true,
                      controller: controller.confirmPasswordController,
                      backgroundColor: Colors.white,
                    ),
                    16.h.verticalSpace,
                    Obx(
                      () => CustomButton(
                        text: controller.isLoading.value
                            ? 'updating_password'.tr
                            : 'update_password'.tr,
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                                final success = await controller
                                    .changePassword();
                                if (success && Get.isBottomSheetOpen == true) {
                                  Get.back();
                                }
                              },
                        backgroundColor: AppColors.textPurple,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteAccountSheet(
    BuildContext context,
    SettingsController controller,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: const Icon(
                        Icons.delete_forever_outlined,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'delete_account_confirmation'.tr,
                        style: getTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  'delete_account_description'.tr,
                  style: getTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF475569),
                    lineHeight: 16.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controller.isDeleteLoading.value
                              ? null
                              : () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 52.h),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                          child: Text(
                            'cancel'.tr,
                            style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomButton(
                          text: controller.isDeleteLoading.value
                              ? 'deleting'.tr
                              : 'delete'.tr,
                          onPressed: controller.isDeleteLoading.value
                              ? null
                              : () async {
                                  await controller.deleteAccount();
                                },
                          backgroundColor: const Color(0xFFDC2626),
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(icon, color: iconColor, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
                size: 22.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
