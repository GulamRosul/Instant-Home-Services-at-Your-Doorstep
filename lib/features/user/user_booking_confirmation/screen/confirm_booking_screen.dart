import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/provoder_details/screen/provoder_details_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/controller/confirm_booking_controller.dart';
import 'package:protiva502/features/user/user_booking_confirmation/widget/booking_step_progress.dart';

class ConfirmBookingScreen extends StatelessWidget {
  const ConfirmBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmBookingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
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

              // Using the Step Progress widget with Step 2 active
              const BookingStepProgress(currentStep: 2),
              SizedBox(height: 24.h),

              // Confirmation Summary Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      IconPath.checkcircle,
                      width: 60.w,
                      height: 60.h,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Confirm Your Booking",
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        lineHeight: 15.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Review your booking details before confirming",
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                        lineHeight: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    Divider(
                      height: 32.h,
                      color: AppColors.textSecondary.withValues(alpha: 0.3),
                    ),

                    // Service Preview
                    _buildServiceSmallCard(),
                    SizedBox(height: 20.h),

                    // Detail Rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildDetailItem(
                          "Service Name",
                          "Carpentry & Woodwork",
                        ),
                      ],
                    ),
                    _buildDetailItem(
                      "Date & Time",
                      "Wednesday, September 3, 2025 at 9:00 AM",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildDetailItem(
                          "Location",
                          "123 Main Street, Ontario",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [_buildDetailItem("Phone", "+12505550199")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [_buildDetailItem("Service At", "My Location")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildDetailItem("Payment method", "Mastercard"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildDetailItem("Total", "450.0\$", isBold: true),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              CustomButton(
                text: 'Confirm Your Booking',
                onPressed: controller.confirmBooking,
                textColor: Colors.white,
                backgroundColor: AppColors.textPurple,
              ),
              100.h.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              lineHeight: 15.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: getTextStyle(
              fontSize: 13.sp,
              color: isBold ? Colors.black : AppColors.textSecondary,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
              lineHeight: 15.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSmallCard() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(
            ImagePath.servicecard,
            width: 60.w,
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
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      lineHeight: 15.sp,
                    ),
                  ),
                  Text(
                    "450.0\$",
                    style: getTextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      lineHeight: 15.sp,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ProviderDetailsScreen());
                    },
                    child: Text(
                      "Mike Handyman service",
                      style: getTextStyle(
                        fontSize: 11.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        lineHeight: 15.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.check_circle,
                    size: 12.sp,
                    color: const Color.fromARGB(255, 237, 154, 66),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 10.sp,
                    color: AppColors.textBlue,
                  ),
                  Text(
                    " Toronto, Canada",
                    style: getTextStyle(
                      fontSize: 10.sp,
                      color: AppColors.textSecondary,
                      lineHeight: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
