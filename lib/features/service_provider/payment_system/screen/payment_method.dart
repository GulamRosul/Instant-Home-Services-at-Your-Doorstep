import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/payment_system/controller/payment_method_controller.dart';
import 'package:protiva502/features/service_provider/payment_system/widget/build_segment.dart';
import 'package:protiva502/features/service_provider/payment_system/widget/card_payment_system.dart';
import 'package:protiva502/features/service_provider/payment_system/widget/mobile_banking_section.dart';
import 'package:protiva502/features/service_provider/provider_navber/screen/provider_navbar_screen.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  static const Color _primaryDark = Color(0xFF334155);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.sp),
          onPressed: () => Get.back(),
        ),
        centerTitle: false,
        title: Text(
          'Payment Method',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2D2D2D),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'On platform destination charge to provider apply 10%',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF334155),
              ),
            ),
            SizedBox(height: 24.h),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: SegmentItem(
                      icon: Icons.credit_card,
                      label: 'Card Payment',
                      isSelected:
                          controller.selectedPaymentType.value ==
                          PaymentType.cardPayment,
                      onTap: controller.selectCardPayment,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: SegmentItem(
                      icon: Icons.phone_android,
                      label: 'Mobile Banking',
                      isSelected:
                          controller.selectedPaymentType.value ==
                          PaymentType.mobileBanking,
                      onTap: controller.selectMobileBanking,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Obx(() {
              if (controller.selectedPaymentType.value ==
                  PaymentType.cardPayment) {
                return CardPaymentSection(controller: controller);
              } else {
                return MobileBankingSection(controller: controller);
              }
            }),

            SizedBox(height: 40.h),

            CustomButton(
              text: 'Go To Checkout',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SuccessDialog(),
                );
              },
              backgroundColor: _primaryDark,
              textColor: Colors.white,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      backgroundColor: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF787BEB),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('🎉', style: TextStyle(fontSize: 30.sp)),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Congratulations ! Account Setup Complete!',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your payment for the Service Provider subscription has been successfully processed. You now have full access to the marketplace , Log in to your Dashboard now.',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  borderRadius: 6.r,
                  text: 'Go to Dashboard',
                  onPressed: () {
                    Get.offAll(() => const ProviderNavbarScreen());
                  },
                  backgroundColor: const Color(0xFF787BEB),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          Positioned(
            right: 12.w,
            top: 12.h,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.black, size: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
