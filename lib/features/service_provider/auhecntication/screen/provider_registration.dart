import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/auhecntication/controller/provider_reg_controller.dart';
import 'package:protiva502/features/user/authentication/screen/user_login_screen.dart';

class ProviderRegistration extends StatelessWidget {
  const ProviderRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderRegController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F5F9),
        elevation: 0,
        surfaceTintColor: const Color(0xFFF1F5F9),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Provider Registration',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title: Get Started as a Provider (underlined)
            Text(
              'Get Started as a Provider',
              style: getTextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 24.h),

            // Section: Business Information (briefcase icon)
            Row(
              children: [
                Icon(
                  Icons.business_center_outlined,
                  size: 20.sp,
                  color: AppColors.textGrey,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Business Information',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Service Category (dropdown)
            _buildFieldLabel('Service Category'),
            Obx(
              () => _buildDropdown(
                value: controller.selectedServiceCategory.value,
                items: controller.serviceCategories,
                onChanged: controller.onServiceCategoryChanged,
              ),
            ),
            SizedBox(height: 16.h),

            // Sub-Category (dropdown)
            _buildFieldLabel('Sub-Category'),
            Obx(
              () => _buildDropdown(
                value: controller.selectedSubCategory.value,
                items: controller.subCategories,
                onChanged: controller.onSubCategoryChanged,
              ),
            ),
            SizedBox(height: 16.h),

            // Service location
            _buildFieldLabel('Service location'),
            CustomTextField(
              controller: controller.serviceLocationController,
              hintText: 'Canada',
              backgroundColor: const Color(0xFFF1F5F9),
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),

            // Year of Experience
            _buildFieldLabel('Year of Experience'),
            CustomTextField(
              controller: controller.yearOfExperienceController,
              hintText: 'e.g. 5',
              keyboardType: TextInputType.number,
              backgroundColor: const Color(0xFFF1F5F9),
              borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
              textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 30.h),

            // Next button
            CustomButton(
              text: 'Next',
              onPressed: controller.handleNext,
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
            ),
            SizedBox(height: 20.h),

            // Sign In link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.off(() => const UserLoginScreen()),
                  child: Text(
                    'Sign In',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF6366F1),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: getTextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textGrey,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.defaultBorder.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textGrey,
            size: 24.sp,
          ),
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
