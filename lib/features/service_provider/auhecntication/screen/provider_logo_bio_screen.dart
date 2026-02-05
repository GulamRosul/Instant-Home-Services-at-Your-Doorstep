import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/service_provider/auhecntication/controller/provider_logo_bio_controller.dart';
import 'package:protiva502/features/service_provider/payment_system/screen/provider_pricing_screen.dart';

class ProviderLogoBioScreen extends StatelessWidget {
  const ProviderLogoBioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderLogoBioController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F7),
        elevation: 0,
        surfaceTintColor: const Color(0xFFF5F5F7),
        leading: SizedBox(),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10.h),
                // Main Skip (underlined, darker)
                GestureDetector(
                  onTap: () async {
                    await Get.to(() => const ProviderPricingScreen());
                  },
                  child: Text(
                    'Skip',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Select Image Source',
                            style: getTextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: Text(
                              'Camera',
                              style: getTextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              controller.pickLogo(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: Text(
                              'Gallery',
                              style: getTextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              controller.pickLogo(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Obx(() {
                  final path = controller.logoPath.value;
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
                'Upload Your Logo',
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
                'About Service',
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
                    maxLength: ProviderLogoBioController.maxBioLength,
                    maxLines: 5,
                    minLines: 4,
                    onChanged: (v) => controller.updateBioCount(v.length),
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your bio',
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
                      '${controller.bioCharCount.value}/${ProviderLogoBioController.maxBioLength}',
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

            CustomButton(
              borderRadius: 6.r,
              text: 'Next',
              onPressed: controller.handleNext,
              backgroundColor: Color(0xFF334155),
              textColor: Colors.white,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
