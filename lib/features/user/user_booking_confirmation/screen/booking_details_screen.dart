import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/user_booking_confirmation/controller/booking_details_controller.dart';
import 'package:protiva502/features/user/user_booking_confirmation/widget/booking_step_progress.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingDetailsController());

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      appBar: const CustomAppBar(title: 'Book Service'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Book Service",
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                lineHeight: 15.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Book Your Service in Just a Few Clicks",
              style: getTextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
                lineHeight: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24.h),

            const BookingStepProgress(currentStep: 1), // Step 1 Active
            SizedBox(height: 24.h),

            _buildServiceBriefCard(),
            SizedBox(height: 24.h),

            _buildLabel("Service name"),
            CustomTextField(
              hintText: "Carpentry & Woodwork",
              readOnly: true,
              backgroundColor: Colors.white,
              // textStyle: getTextStyle(fontSize: 14.sp, color: Colors.black),
              hintTextColor: Colors.black,
            ),

            SizedBox(height: 16.h),
            _buildLabel("Preferable Date & Time"),
            CustomTextField(
              hintText: "09 Dec 2022 || 10.00 Am",
              suffixIcon: Icon(
                Icons.access_time,
                size: 20.sp,
                color: Colors.blueGrey,
              ),
              // readOnly: true,
              backgroundColor: Colors.white,
              // hintTextColor: Colors.black,
            ),

            SizedBox(height: 16.h),
            _buildLabel("Phone"),
            CustomTextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              backgroundColor: Colors.white,
              // hintTextColor: Colors.black,
            ),

            SizedBox(height: 16.h),
            _buildLabel("Getting Service at"),
            Obx(
              () => Row(
                children: [
                  _buildRadioButton("My Location", controller),
                  SizedBox(width: 20.w),
                  _buildRadioButton("Provider Location", controller),
                ],
              ),
            ),

            SizedBox(height: 16.h),
            _buildLabel("Location details"),
            CustomTextField(
              controller: controller.locationController,
              suffixIcon: Icon(
                Icons.edit_note,
                size: 24.sp,
                color: Colors.black87,
              ),
              backgroundColor: Colors.white,
              // prefixIcon: Icon(Icons.location_on_outlined, color: Colors.blue, size: 20.sp),
            ),

            SizedBox(height: 16.h),
            _buildLabel("Message"),
            CustomTextField(
              controller: controller.messageController,
              hintText: "Add short description..",
              maxLines: 4,
              backgroundColor: Colors.white,
            ),

            SizedBox(height: 20.h),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.isAgreed.value,
                    onChanged: (val) => controller.isAgreed.value = val!,
                    activeColor: const Color(0xFF334155),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Colors.black87,
                      ),
                      children: [
                        const TextSpan(
                          text:
                              "By clicking \"Go to checkout\", you agree to our ",
                        ),
                        TextSpan(
                          text: "Terms of Service",
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),
            CustomButton(
              text: 'Next',
              onPressed: controller.goToNextStep,
              textColor: Colors.white,
            ),
            100.h.verticalSpace,
            // SizedBox(
            //   width: double.infinity,
            //   height: 50.h,
            //   child: ElevatedButton(
            //     onPressed: controller.goToNextStep,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(
            //         0xFF1E293B,
            //       ), // Dark navy as per screenshot
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8.r),
            //       ),
            //     ),
            //     child: Text(
            //       "Next",
            //       style: getTextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildRadioButton(String label, BookingDetailsController controller) {
    bool isSelected = controller.selectedLocationType.value == label;
    return GestureDetector(
      onTap: () => controller.selectLocation(label),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected ? const Color(0xFF334155) : Colors.grey,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Text(label, style: getTextStyle(fontSize: 13.sp)),
        ],
      ),
    );
  }

  Widget _buildServiceBriefCard() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              ImagePath.homeServ,
              width: 70.w,
              height: 60.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Home Renovation",
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "450.0\$",
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Mike Handyman service",
                  style: getTextStyle(fontSize: 12.sp, color: Colors.blueGrey),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 12.sp, color: Colors.blue),
                    Text(
                      " Toronto, Canada",
                      style: getTextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Column(
                  children: [
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (i) => Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  " 4.8 (170 Reviews)",
                  style: getTextStyle(
                    fontSize: 11.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
