import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/services/booking_id_service.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/user/user_booking_confirmation/controller/payment_controller.dart';
import 'package:protiva502/features/user/user_booking_confirmation/widget/booking_step_progress.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final bookingIdService = BookingIdService();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'book_service'.tr),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20.h),

            // Custom Stepper
            const BookingStepProgress(currentStep: 3),
            SizedBox(height: 24.h),

            // Payment Summary
            _buildPaymentSummary(controller),
            SizedBox(height: 30.h),

            // Coupon Input
            _buildCouponInput(controller),
            SizedBox(height: 30.h),

            // Checkout Button
            Obx(
              () => CustomButton(
                text: controller.isPaymentProcessing.value
                    ? 'processing'.tr
                    : 'proceed_to_payment'.tr,
                onPressed: controller.isPaymentProcessing.value
                    ? null
                    : controller.makePayment,
                backgroundColor: const Color(0xFF1E293B),
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'book_service'.tr,
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            lineHeight: 15.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'complete_payment_to_confirm'.tr,
          style: getTextStyle(
            fontSize: 12.sp,
            color: AppColors.textSecondary,
            lineHeight: 15.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSummary(PaymentController controller) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'booking_id'.tr,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        bookingIdService.getTrimmedBookingId(
                          controller.bookingId.value,
                        ),
                        textAlign: TextAlign.end,
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(width: 6.w),

                    ValueListenableBuilder<bool>(
                      valueListenable: bookingIdService.isCopied,
                      builder: (context, copied, _) {
                        return GestureDetector(
                          onTap: () => bookingIdService.copyBookingId(
                            controller.bookingId.value,
                          ),
                          child: Icon(
                            copied ? Icons.check_circle : Icons.copy,
                            size: 16.sp,
                            color: copied ? Colors.green : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 12.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Amount:",
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      "৳",
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        hintText: "Enter amount",
                        backgroundColor: Colors.white,
                        borderColor: Colors.grey.shade300,
                        borderRadius: 8,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponInput(PaymentController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'have_coupon'.tr,
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Flexible(
              child: CustomTextField(
                controller: controller.couponController,
                hintText: 'enter_coupon_code'.tr,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderRadius: 8,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Obx(
              () => SizedBox(
                width: 100.w,
                height: 45.h,
                child: CustomButton(
                  text: controller.isApplyingCoupon.value ? '...' : 'apply'.tr,
                  onPressed: controller.isApplyingCoupon.value
                      ? null
                      : controller.applyCoupon,
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // Show selected coupon info
        Obx(() {
          if (controller.selectedCoupon.value != null) {
            final coupon = controller.selectedCoupon.value!;
            final discount =
                (controller.originalAmount.value * coupon.discountPercentage) /
                100;
            return Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '✓ ${coupon.couponCode} Applied',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade700,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Discount: ${coupon.discountPercentage}% (৳${discount.toStringAsFixed(2)})',
                          style: getTextStyle(
                            fontSize: 11.sp,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: controller.removeCoupon,
                      child: Icon(Icons.close, size: 18.sp, color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
