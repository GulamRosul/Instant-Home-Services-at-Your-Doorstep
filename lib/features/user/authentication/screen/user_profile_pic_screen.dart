import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/user/authentication/controller/user_profile_pic_controller.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';

class UserProfilePicScreen extends StatelessWidget {
  const UserProfilePicScreen({super.key, this.registeredEmail});

  final String? registeredEmail;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserProfilePicController());
    final socialMediaController = Get.put(SocialMediaController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background from image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () =>
                controller.handleNext(registeredEmail: registeredEmail),
            child: Text(
              'Skip',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black, // Matching the underlined "Skip" in image
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // Profile Image Upload Area
            GestureDetector(
              onTap: () => controller.pickImage(context),
              child: Stack(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.grey.shade400,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                          : null,
                      child: controller.selectedImage.value == null
                          ? Icon(Icons.person, size: 60.r, color: Colors.white)
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.grey,
                        size: 24.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Upload Your Logo',
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30.h),

            // Bio Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bio',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: controller.bioController,
              hintText: 'Enter your bio',
              maxLines: 5,
              minLines: 5,
              backgroundColor: Colors.white,
              borderColor: AppColors.textSecondary.withValues(alpha: 0.2),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
              // Manual character count implementation as seen in image
              suffixIcon: Padding(
                padding: EdgeInsets.only(top: 80.h, right: 10.w),
                child: Text(
                  "13/300",
                  style: getTextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
              ),
            ),

            SizedBox(height: 100.h), // Spacing to match "Next" button position

            CustomButton(
              text: 'Next',
              onPressed: () =>
                  controller.handleNext(registeredEmail: registeredEmail),
              backgroundColor: AppColors.textPurple, // Match dark button color
              textColor: Colors.white,
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          socialMediaController.launchSocialUrl(socialMediaController.whatsappUrl);
        },
        backgroundColor: Colors.white,
        mini: false,
        child: SvgPicture.asset(IconPath.whatsapp),
      ),


    );
  }
}
