import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/localization/localization_service.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/user_booking_confirmation/controller/confirm_booking_controller.dart';
import 'package:protiva502/features/user/user_booking_confirmation/model/booking_confirmation_data.dart';
import 'package:protiva502/features/user/user_booking_confirmation/widget/booking_step_progress.dart';

class ConfirmBookingScreen extends StatelessWidget {
  const ConfirmBookingScreen({super.key, required this.bookingData});

  final BookingConfirmationData bookingData;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmBookingController());
    final service = bookingData.service;
    final formattedDateTime = DateFormat(
      'EEEE, MMMM d, y \'at\' h:mm a',
    ).format(bookingData.preferredDateTime);
    final totalPrice = '${service?.basePrice.toStringAsFixed(1) ?? '0.0'} ৳';
    final message = bookingData.message.isEmpty
        ? 'no_additional_message'.tr
        : bookingData.message;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: CustomAppBar(title: 'book_service'.tr),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.r),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                'book_service'.tr,
                style: getTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  lineHeight: 15.sp,
                ),
              ),

              SizedBox(height: 8.h),
              Text(
                'book_your_service_in_few_clicks'.tr,
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
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      IconPath.checkcircle,
                      width: 60.w,
                      height: 60.h,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'confirm_your_booking'.tr,
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        lineHeight: 15.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'review_booking_details'.tr,
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
                    _buildServiceSmallCard(
                      title: service?.title ?? 'selected_service'.tr,
                      price: totalPrice,
                      thumbnail: service?.thumbnail ?? '',
                      subtitle: service?.description ?? '',
                    ),
                    SizedBox(height: 20.h),

                    // Detail Rows
                    _buildDetailItem(
                      'service_name_label'.tr,
                      service?.title ?? 'selected_service'.tr,
                    ),
                    _buildDetailItem('date_time_label'.tr, formattedDateTime),
                    _buildDetailItem(
                      'location_label'.tr,
                      bookingData.locationDetails,
                    ),
                    _buildDetailItem('phone_label'.tr, bookingData.phoneNumber),
                    _buildDetailItem(
                      'service_at_label'.tr,
                      bookingData.locationType,
                    ),
                    _buildDetailItem('message_label'.tr, message),
                    _buildDetailItem(
                      'total_label'.tr,
                      totalPrice,
                      isBold: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              Obx(
                () => CustomButton(
                  text: controller.isSubmitting.value
                      ? 'confirming'.tr
                      : 'confirm_your_booking'.tr,
                  onPressed: controller.isSubmitting.value
                      ? null
                      : () => controller.confirmBooking(bookingData),
                  textColor: Colors.white,
                  backgroundColor: controller.isSubmitting.value
                      ? AppColors.textPurple.withValues(alpha: 0.7)
                      : AppColors.textPurple,
                ),
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
              lineHeight: 18.sp,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSmallCard({
    required String title,
    required String price,
    required String thumbnail,
    required String subtitle,
  }) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: thumbnail.isNotEmpty
              ? Image.network(
                  thumbnail,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    ImagePath.servicecard,
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
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
                    title,
                    style: getTextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      lineHeight: 15.sp,
                    ),
                  ),
                  Text(
                    price,
                    style: getTextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      lineHeight: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle.isEmpty
                    ? 'service_details_will_be_confirmed'.tr
                    : subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getTextStyle(
                  fontSize: 11.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  lineHeight: 15.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 10.sp,
                    color: AppColors.textBlue,
                  ),
                  Text(
                    ' ${'ready_for_confirmation'.tr}',
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
