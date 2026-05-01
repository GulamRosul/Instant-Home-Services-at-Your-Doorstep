import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/service_provider/auhecntication/controller/provider_reg_controller.dart';
import 'package:protiva502/features/service_provider/auhecntication/widget/build_field_label.dart';
import 'package:protiva502/features/social_media/controller/social_media_controller.dart';

class ProviderRegistration extends StatelessWidget {
  const ProviderRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ProviderRegController>()
        ? Get.find<ProviderRegController>()
        : Get.put(ProviderRegController());

    final socialMediaController = Get.put(SocialMediaController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: const Color(0xFFF1F5F9),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'provider_registration'.tr,
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3F3F3F),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'get_started_as_provider'.tr,
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                SvgPicture.asset(IconPath.business, width: 20.w, height: 20.h),
                SizedBox(width: 8.w),
                Text(
                  'business_information'.tr,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            // FieldLabel(label: 'Service Category'),
            // Obx(
            //   () => CustomPopupMenu(
            //     value: controller.selectedServiceCategory.value,
            //     items: controller.serviceCategories,
            //     onSelected: controller.onServiceCategoryChanged,
            //   ),
            // ),
            // SizedBox(height: 16.h),

            // // Sub-Category (dropdown)
            // FieldLabel(label: 'Sub-Category'),
            // Obx(
            //   () => CustomPopupMenu(
            //     value: controller.selectedSubCategory.value,
            //     items: controller.subCategories,
            //     onSelected: controller.onSubCategoryChanged,
            //   ),
            // ),
            // SizedBox(height: 16.h),

            // Service location
            FieldLabel(label: 'service_location'.tr),
            CustomTextField(
              borderRadius: 4.r,
              controller: controller.serviceLocationController,
              hintText: 'dhaka_city_hint'.tr,
              backgroundColor: const Color(0xFFF1F5F9),
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.3),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),

            FieldLabel(label: 'city'.tr),
            CustomTextField(
              borderRadius: 4.r,
              controller: controller.cityController,
              hintText: 'dhaka_hint'.tr,
              backgroundColor: const Color(0xFFF1F5F9),
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.3),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),

            // Year of Experience
            FieldLabel(label: 'year_of_experience'.tr),
            CustomTextField(
              borderRadius: 4.r,
              controller: controller.yearOfExperienceController,
              hintText: 'experience_hint'.tr,
              keyboardType: TextInputType.text,
              backgroundColor: const Color(0xFFF1F5F9),
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.3),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 24.h),

            // Next button
            Obx(
              () => CustomButton(
                borderRadius: 6.r,
                text: controller.isRegistering.value
                    ? 'registering'.tr
                    : 'next'.tr,
                onPressed: controller.isRegistering.value
                    ? null
                    : controller.handleNext2,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),

            // Sign In link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'already_have_account'.tr,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: controller.goToLogin,
                  child: Text(
                    'sign_in'.tr,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF787BEB),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF787BEB),
                    ),
                  ),
                ),
              ],
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
