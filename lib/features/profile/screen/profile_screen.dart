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
import 'package:protiva502/features/profile/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  ImageProvider<Object> _buildProfileImage(String imagePath) {
    if (imagePath.trim().isEmpty) {
      return const NetworkImage(
        'https://as1.ftcdn.net/v2/jpg/02/43/12/34/1000_F_243123463_zTo9Qg099Lz7fL7Y8HsSZJ1PVGu9fL7x.jpg',
      );
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

  void _showEditFieldDialog({
    required BuildContext context,
    required String label,
    required String currentValue,
    required Future<bool> Function(String value) onSave,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    final textController = TextEditingController(text: currentValue);
    var isSaving = false;

    showDialog(
      context: context,
      barrierColor: const Color(0xFF0F172A).withValues(alpha: 0.45),
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
          backgroundColor: Colors.transparent,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(dialogContext).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.14),
                      blurRadius: 32,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E293B), Color(0xFF475569)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      'Edit $label',
                      style: getTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Update your $label details below and save when you are ready.',
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            size: 18.sp,
                            color: const Color(0xFF475569),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            label,
                            style: getTextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    CustomTextField(
                      controller: textController,
                      hintText: 'Enter $label',
                      keyboardType: keyboardType,
                      maxLines: maxLines,
                      minLines: maxLines > 1 ? maxLines : null,
                      backgroundColor: const Color(0xFFF8FAFC),
                      borderColor: const Color(0xFFCBD5E1),
                      borderRadius: 16.r,
                      autofocus: true,
                      enabled: !isSaving,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: maxLines > 1 ? 16.h : 14.h,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isSaving
                                ? null
                                : () => Navigator.of(dialogContext).pop(),
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size.fromHeight(48.h),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isSaving
                                ? null
                                : () async {
                                    final updatedValue = textController.text
                                        .trim();
                                    if (updatedValue.isEmpty) {
                                      Get.snackbar(
                                        'Required field',
                                        '$label cannot be empty.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: const Color(
                                          0xFF0F172A,
                                        ),
                                        colorText: Colors.white,
                                        margin: EdgeInsets.all(16.w),
                                      );
                                      return;
                                    }

                                    if (updatedValue == currentValue.trim()) {
                                      Navigator.of(dialogContext).pop();
                                      return;
                                    }

                                    setState(() => isSaving = true);
                                    final didSave = await onSave(updatedValue);

                                    if (!dialogContext.mounted) {
                                      return;
                                    }

                                    if (didSave) {
                                      Navigator.of(dialogContext).pop();
                                      return;
                                    }

                                    setState(() => isSaving = false);
                                  },
                            style:
                                ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  minimumSize: Size.fromHeight(48.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                ).copyWith(
                                  overlayColor: WidgetStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  side: WidgetStateProperty.all(
                                    BorderSide.none,
                                  ),
                                ),
                            child: isSaving
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2.2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Save Changes',
                                    style: getTextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
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
          ),
        ),
      ),
    ).then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        textController.dispose();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Profile', showBackButton: true),
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
                    child: const Text('  Retry  '),
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
                          onTap: () =>
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
                            child: Icon(
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
                    'Profile Information',
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
                      label: 'Name',
                      value: controller.name.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'name',
                        value: value,
                      ),
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'Email',
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
                      label: 'Phone',
                      value: controller.phone.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'phone',
                        value: value,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'Profession',
                      value: controller.profession.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'profession',
                        value: value,
                      ),
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'Bio',
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
                    'Address Information',
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
                      label: 'Street Address',
                      value: controller.streetAddress.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'streetAddress',
                        value: value,
                      ),
                      maxLines: 2,
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'City',
                      value: controller.city.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'city',
                        value: value,
                      ),
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'State',
                      value: controller.state.value,
                      onSave: (value) => controller.updateProfileField(
                        fieldName: 'state',
                        value: value,
                      ),
                    ),
                    _buildInfoItem(
                      context: context,
                      label: 'Zip Code',
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
          ? () => _showEditFieldDialog(
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
