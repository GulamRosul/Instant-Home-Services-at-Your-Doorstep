import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/common/widgets/shimmer_effect.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/profile/controller/profile_controller.dart';
import 'package:protiva502/features/profile/widget/edit_field_dialogue_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  ImageProvider<Object> _buildProfileImage(String imagePath) {
    if (imagePath.trim().isEmpty) {
      return const AssetImage(ImagePath.profile);
    }

    if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    }

    return FileImage(File(imagePath));
  }

  String _displayValue(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? 'Not provided' : trimmed;
  }

  void _showImageSourceDialog(
    BuildContext context,
    ProfileController controller,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                controller.pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                controller.pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(title: 'profile'.tr, showBackButton: true),
      body: Obx(() {
        if (controller.isLoading.value && !controller.hasLoadedProfile.value) {
          return _buildLoadingShimmer();
        }

        if (controller.errorMessage.value.isNotEmpty &&
            !controller.hasLoadedProfile.value) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 44.sp,
                    color: const Color(0xFFEF4444),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: getTextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: controller.fetchProfile,
                    style:
                        ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ).copyWith(
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                          side: WidgetStateProperty.all(BorderSide.none),
                        ),
                    child:  Text('retry'.tr),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchProfile(isRefresh: true),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.errorMessage.value.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0xFFFECACA)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 18.sp,
                            color: const Color(0xFFDC2626),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              controller.errorMessage.value,
                              style: getTextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF991B1B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Stack(
                    children: [
                      Container(
                        width: 120.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          image: DecorationImage(
                            image: _buildProfileImage(
                              controller.imagePath.value,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: controller.isUpdatingProfile.value
                              ? null
                              : () =>
                                    _showImageSourceDialog(context, controller),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: controller.isUpdatingProfile.value
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primary,
                                      ),
                                    ),
                                  )
                                : Icon(
                                    Icons.camera_alt_outlined,
                                    size: 20.sp,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'profile_information'.tr,
                    style: getTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoSection([
                    _buildInfoItem(
                      context: context,
                      label: 'first_name'.tr,
                      value: controller.firstName.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'firstName',
                        value: value,
                      ),
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'last_name'.tr,
                      value: controller.lastName.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'lastName',
                        value: value,
                      ),
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'email'.tr,
                      value: controller.email.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'email',
                        value: value,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      isEditable: false,
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'phone'.tr,
                      value: controller.phone.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'phone',
                        value: value,
                      ),
                      keyboardType: TextInputType.phone,
                      isEditable: false,
                    ),
                    // _buildInfoItem(
                    //   context: context,
                    //   label: 'Profession',
                    //   value: controller.profession.value,
                    //   onSave: (value) => controller.updateProfileField(
                    //     fieldName: 'profession',
                    //     value: value,
                    //   ),
                    // ),
                    _buildInfoItem(
                      context: context,
                      label: 'bio'.tr,
                      value: controller.bio.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'bio',
                        value: value,
                      ),
                      maxLines: 3,
                      isLast: true,
                    ),
                  ]),
                  SizedBox(height: 32.h),
                  Text(
                    'address_information'.tr,
                    style: getTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoSection([
                    _buildInfoItem(
                      context: context,
                      label: 'street_address'.tr,
                      value: controller.streetAddress.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'streetAddress',
                        value: value,
                      ),
                      maxLines: 2,
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'city'.tr,
                      value: controller.city.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'city',
                        value: value,
                      ),
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'state'.tr,
                      value: controller.state.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'state',
                        value: value,
                      ),
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'zip_code'.tr,
                      value: controller.zipCode.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'zipCode',
                        value: value,
                      ),
                      keyboardType: TextInputType.number,
                      isLast: true,
                    ),
                  ]),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.05)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildLoadingShimmer() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image Shimmer
            ShimmerEffect(width: 120.w, height: 120.h, borderRadius: 60.r),
            SizedBox(height: 32.h),
            // Profile Information Title
            ShimmerEffect(width: 150.w, height: 20.h, borderRadius: 8.r),
            SizedBox(height: 16.h),
            // Profile Information Items Shimmer
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: List.generate(
                  5,
                  (index) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerEffect(
                              width: 80.w,
                              height: 14.h,
                              borderRadius: 6.r,
                            ),
                            SizedBox(height: 8.h),
                            ShimmerEffect(
                              width: 200.w,
                              height: 14.h,
                              borderRadius: 6.r,
                            ),
                          ],
                        ),
                      ),
                      if (index < 4)
                        Divider(height: 1, color: Colors.grey.shade100),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            // Address Information Title
            ShimmerEffect(width: 160.w, height: 20.h, borderRadius: 8.r),
            SizedBox(height: 16.h),
            // Address Information Items Shimmer
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: List.generate(
                  4,
                  (index) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerEffect(
                              width: 70.w,
                              height: 14.h,
                              borderRadius: 6.r,
                            ),
                            SizedBox(height: 8.h),
                            ShimmerEffect(
                              width: 180.w,
                              height: 14.h,
                              borderRadius: 6.r,
                            ),
                          ],
                        ),
                      ),
                      if (index < 3)
                        Divider(height: 1, color: Colors.grey.shade100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required BuildContext context,
    required String label,
    required String value,
    required Future<bool> Function(String value) onSave,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isEditable = true,
    bool isLast = false,
  }) {
    final displayValue = _displayValue(value);

    return InkWell(
      onTap: isEditable
          ? () => showEditFieldBottomSheet(
              context: context,
              label: label,
              currentValue: value,
              onSave: onSave,
              keyboardType: keyboardType,
              maxLines: maxLines,
            )
          : null,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isEditable ? Colors.transparent : const Color(0xFFF8FAFC),
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(color: Colors.grey.shade100, width: 1),
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      displayValue,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isEditable
                            ? const Color(0xFF334155)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    isEditable ? Icons.arrow_forward_ios : Icons.lock_outline,
                    size: 14.sp,
                    color: isEditable
                        ? const Color(0xFF64748B)
                        : const Color(0xFF94A3B8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
