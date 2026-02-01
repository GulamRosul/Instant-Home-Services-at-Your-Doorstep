import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/profile/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      appBar: const CustomAppBar(title: 'Profile', showBackButton: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Section
              Stack(
                children: [
                  Obx(
                    () => Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        image: controller.imagePath.value.isEmpty
                            ? const DecorationImage(
                                image: NetworkImage(
                                  'https://as1.ftcdn.net/v2/jpg/02/43/12/34/1000_F_243123463_zTo9Qg099Lz7fL7Y8HsSZJ1PVGu9fL7x.jpg',
                                ),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: FileImage(
                                  File(controller.imagePath.value),
                                ),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => _showImageSourceDialog(context, controller),
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

              // Profile Information Section
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
                _buildInfoItem('Name', controller.name.value),
                _buildInfoItem('Email', controller.email.value),
                _buildInfoItem('Phone', controller.phone.value),
                _buildInfoItem('Profession', controller.profession.value),
                _buildInfoItem('Bio', controller.bio.value, isLast: true),
              ]),

              SizedBox(height: 32.h),

              // Address Information Section
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
                  'Street Address',
                  controller.streetAddress.value,
                ),
                _buildInfoItem('City', controller.city.value),
                _buildInfoItem('State', controller.state.value),
                _buildInfoItem(
                  'zip code',
                  controller.zipCode.value,
                  isLast: true,
                ),
              ]),
            ],
          ),
        ),
      ),
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

  Widget _buildInfoItem(String label, String value, {bool isLast = false}) {
    return InkWell(
      onTap: () {
        // Handle edit logic
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(color: Colors.grey.shade100, width: 1),
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF334155),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: const Color(0xFF64748B),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
