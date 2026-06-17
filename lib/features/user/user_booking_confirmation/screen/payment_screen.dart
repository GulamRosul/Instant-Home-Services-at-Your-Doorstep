import 'package:flutter/gestures.dart';
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
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final bookingIdService = BookingIdService();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'book_service'.tr),
      // ✅ Use Column to separate scrollable content from sticky bottom
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 20.h),
                  const BookingStepProgress(currentStep: 3),
                  SizedBox(height: 24.h),
                  _buildPaymentSummary(controller),
                  SizedBox(height: 30.h),
                  _buildCouponInput(controller),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),

          // ✅ Sticky bottom area
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Terms checkbox
                _buildTermsCheckbox(controller),
                SizedBox(height: 16.h),

                // Payment button
                Obx(
                  () => CustomButton(
                    text: controller.isPaymentProcessing.value
                        ? 'processing'.tr
                        : 'proceed_to_payment'.tr,
                    onPressed:
                        (controller.isPaymentProcessing.value ||
                            !controller.isTermsAccepted.value)
                        ? null
                        : controller.makePayment,
                    backgroundColor: controller.isTermsAccepted.value
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade400,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking ID row
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

            // Original price
            _buildPriceRow(
              label: 'Original Price',
              value: '৳${controller.originalAmount.value.toStringAsFixed(2)}',
              labelColor: Colors.grey.shade700,
              valueColor: Colors.black,
            ),

            // Discount row — only show if coupon applied
            if (controller.selectedCoupon.value != null) ...[
              SizedBox(height: 8.h),
              _buildPriceRow(
                label:
                    'Discount (${controller.selectedCoupon.value!.couponCode} · ${controller.selectedCoupon.value!.discountPercentage}%)',
                value:
                    '- ৳${((controller.originalAmount.value * controller.selectedCoupon.value!.discountPercentage) / 100).toStringAsFixed(2)}',
                labelColor: Colors.green.shade700,
                valueColor: Colors.green.shade700,
                labelFontSize: 12.sp,
              ),
              SizedBox(height: 12.h),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 8.h),
            ] else ...[
              SizedBox(height: 12.h),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 8.h),
            ],

            // Total payable
            // _buildPriceRow(
            //   label: 'Total Payable',
            //   value: '৳${controller.amountController.text}',
            //   labelColor: Colors.black,
            //   valueColor: AppColors.primary,
            //   fontWeight: FontWeight.w700,
            //   fontSize: 16.sp,
            // ),
            // Replace the static Total Payable row with this:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total Payable',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '৳',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 120.w, // ✅ fixed width so it doesn't overflow
                      child: CustomTextField(
                        controller: controller.amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        hintText: '0.00',
                        backgroundColor: Colors.white,
                        borderColor: Colors.grey.shade300,
                        borderRadius: 8,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 8.h,
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

  // Helper widget
  Widget _buildPriceRow({
    required String label,
    required String value,
    required Color labelColor,
    required Color valueColor,
    FontWeight fontWeight = FontWeight.w500,
    double? fontSize,
    double? labelFontSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: labelFontSize ?? fontSize ?? 14.sp,
            fontWeight: fontWeight,
            color: labelColor,
          ),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: fontSize ?? 14.sp,
            fontWeight: fontWeight,
            color: valueColor,
          ),
        ),
      ],
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
        // Obx(() {
        //   if (controller.selectedCoupon.value != null) {
        //     final coupon = controller.selectedCoupon.value!;
        //     final discount =
        //         (controller.originalAmount.value * coupon.discountPercentage) /
        //         100;
        //     return Padding(
        //       padding: EdgeInsets.only(top: 12.h),
        //       child: Container(
        //         padding: EdgeInsets.all(12.r),
        //         decoration: BoxDecoration(
        //           color: Colors.green.shade50,
        //           borderRadius: BorderRadius.circular(8.r),
        //           border: Border.all(color: Colors.green.shade300),
        //         ),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   '✓ ${coupon.couponCode} Applied',
        //                   style: getTextStyle(
        //                     fontSize: 12.sp,
        //                     fontWeight: FontWeight.w600,
        //                     color: Colors.green.shade700,
        //                   ),
        //                 ),
        //                 SizedBox(height: 4.h),
        //                 Text(
        //                   'Discount: ${coupon.discountPercentage}% (৳${discount.toStringAsFixed(2)})',
        //                   style: getTextStyle(
        //                     fontSize: 11.sp,
        //                     color: Colors.green.shade600,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             GestureDetector(
        //               onTap: controller.removeCoupon,
        //               child: Icon(Icons.close, size: 18.sp, color: Colors.red),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   }
        //   return const SizedBox.shrink();
        // }),
      ],
    );
  }

  Widget _buildTermsCheckbox(PaymentController controller) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.isTermsAccepted.value =
            !controller.isTermsAccepted.value,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: Checkbox(
                value: controller.isTermsAccepted.value,
                onChanged: (val) =>
                    controller.isTermsAccepted.value = val ?? false,
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                  children: [
                     TextSpan(text: 'agree_to'.tr),
                    _linkSpan(
                      'terms_conditions'.tr,
                      'https://kaajbd.com.bd/about-us-2/terms-of-service/',
                    ),
                     TextSpan(text: ', '),
                    _linkSpan(
                      'privacy_policy'.tr,
                      'https://kaajbd.com.bd/about-us-2/privacy-policy/',
                    ),
                     TextSpan(text: ', ${'and'.tr} '),
                    _linkSpan(
                      'refund_policy'.tr,
                      'https://kaajbd.com.bd/refund-policy/',
                    ),
                     TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan _linkSpan(String text, String url) {
    return TextSpan(
      text: text,
      style: getTextStyle(
        fontSize: 12.sp,
        color: AppColors.primary,
        fontWeight: FontWeight.w500,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () =>
            launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
    );
  }
}
