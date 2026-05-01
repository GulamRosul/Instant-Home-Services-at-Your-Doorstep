import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/service_provider/auhecntication/controller/provider_reg_controller.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';

class ProviderLogoBioScreen extends StatelessWidget {
  const ProviderLogoBioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ProviderRegController>()
        ? Get.find<ProviderRegController>()
        : Get.put(ProviderRegController());

    final socialMediaController = Get.put(SocialMediaController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F7),
        elevation: 0,
        surfaceTintColor: const Color(0xFFF5F5F7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: Get.back,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: controller.pickAvatarImage,
                child: Obx(() {
                  final path = controller.avatarImage.value?.path;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 100.w,
                        child: path != null
                            ? ClipOval(
                                child: Image.file(
                                  File(path),
                                  fit: BoxFit.cover,
                                  width: 120.w,
                                  height: 120.w,
                                ),
                              )
                            : SvgPicture.asset(
                                IconPath.person,
                                width: 120.w,
                                height: 120.w,
                              ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: Text(
                'upload_your_logo'.tr,
                style: getTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                'about_service'.tr,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF18181B),
                ),
              ),
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.defaultBorder.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    controller: controller.bioController,
                    maxLength: ProviderRegController.maxBioLength,
                    maxLines: 5,
                    minLines: 4,
                    onChanged: (v) => controller.updateBioCount(v.length),
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'bio_hint'.tr,
                      hintStyle: getTextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF3F3F3F),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 221, 223, 226),
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(
                        10.w,
                        10.h,
                        10.w,
                        30.h,
                      ),
                      counterText: '',
                    ),
                  ),
                ),
                Positioned(
                  right: 12.w,
                  bottom: 10.h,
                  child: Obx(
                    () => Text(
                      '${controller.bioCharCount.value}/${ProviderRegController.maxBioLength}',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Color.fromARGB(255, 135, 133, 133),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 61.h),

            Obx(
              () => CustomButton(
                borderRadius: 6.r,
                text: controller.isRegistering.value
                    ? 'submitting'.tr
                    : 'complete_registration'.tr,
                onPressed: controller.isRegistering.value
                    ? null
                    : controller.submitProviderRegistration,
                backgroundColor: Color(0xFF334155),
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          socialMediaController.launchSocialUrl(
            socialMediaController.whatsappUrl,
          );
        },
        backgroundColor: Colors.white,
        mini: false,
        child: SvgPicture.asset(IconPath.whatsapp),
      ),
    );
  }
}
