import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/google_map/model/picked_location_data.dart';
import 'package:protiva502/features/google_map/screen/map_screen.dart';
import 'package:protiva502/features/user/home/model/home_job_model.dart';
import 'package:protiva502/features/user/user_booking_confirmation/controller/booking_details_controller.dart';
import 'package:protiva502/features/user/user_booking_confirmation/widget/booking_step_progress.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key, this.service});

  final HomeJobModel? service;

  Future<void> _openMapPicker(BookingDetailsController controller) async {
    final selectedLocation = await Get.to<PickedLocationData>(
      () => MapScreen(isPickerMode: true),
    );

    if (selectedLocation != null &&
        selectedLocation.address.trim().isNotEmpty) {
      controller.updateSelectedLocation(
        address: selectedLocation.address,
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingDetailsController());

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      appBar: const CustomAppBar(title: 'Book Service'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.r),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
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

              _buildServiceBriefCard(service),
              SizedBox(height: 24.h),

              _buildLabel("Service name"),
              CustomTextField(
                hintText: service?.title ?? "Selected Service",
                readOnly: true,
                backgroundColor: Colors.white,
                // textStyle: getTextStyle(fontSize: 14.sp, color: Colors.black),
                hintTextColor: Colors.black,
              ),

              SizedBox(height: 16.h),
              _buildLabel("Preferable Date & Time"),
              CustomTextField(
                controller: controller.preferredDateTimeController,
                hintText: "Select date & time",
                readOnly: true,
                onTap: () => controller.pickPreferredDateTime(context),
                suffixIcon: IconButton(
                  onPressed: () => controller.pickPreferredDateTime(context),
                  icon: Icon(
                    Icons.access_time,
                    size: 20.sp,
                    color: Colors.blueGrey,
                  ),
                ),
                backgroundColor: Colors.white,
              ),

              SizedBox(height: 16.h),
              _buildLabel("Phone"),
              CustomTextField(
                controller: controller.phoneController,
                hintText: "2505550199",
                keyboardType: TextInputType.phone,
                backgroundColor: Colors.white,
                prefixIcon: CountryCodePicker(
                  onChanged: (country) => controller.updateCountryCode(
                    country.dialCode ?? controller.selectedCountryCode.value,
                  ),
                  initialSelection: controller.selectedCountryCode.value,
                  favorite: const ["+1", "US", "+880", "BD"],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  padding: EdgeInsets.zero,
                  textStyle: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
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
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: () => _openMapPicker(controller),
                  icon: Icon(
                    Icons.edit_note,
                    size: 24.sp,
                    color: Colors.black87,
                  ),
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
                onPressed: () => controller.goToNextStep(service),
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

  Widget _buildServiceBriefCard(HomeJobModel? service) {
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
            child: service != null && service.thumbnail.isNotEmpty
                ? Image.network(
                    service.thumbnail,
                    width: 70.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset(
                      ImagePath.homeServ,
                      width: 70.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
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
                  children: [
                    Expanded(
                      child: Text(
                        service?.title ?? "Selected Service",
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "${service?.basePrice.toStringAsFixed(0) ?? '0'} ৳",
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  service?.description.isNotEmpty == true
                      ? service!.description
                      : "Service details",
                  style: getTextStyle(fontSize: 12.sp, color: Colors.blueGrey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 12.sp, color: Colors.blue),
                    Text(
                      " Remote Service",
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
