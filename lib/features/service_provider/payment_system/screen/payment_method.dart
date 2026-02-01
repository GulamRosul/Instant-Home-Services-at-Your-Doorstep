import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/auhecntication/widget/build_field_label.dart';
import 'package:protiva502/features/service_provider/payment_system/controller/payment_method_controller.dart';
import 'package:protiva502/features/service_provider/payment_system/widget/build_segment.dart';
import 'package:protiva502/features/service_provider/payment_system/widget/card_payment_system.dart';
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
                return _buildMobileBankingSection(controller);
              }
            }),

            SizedBox(height: 24.h),

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

  Widget _buildMobileBankingSection(PaymentMethodController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Mobile Banking Service:',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 14.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.defaultBorder.withValues(alpha: 0.2),
            ),
          ),
          child: Obx(
            () => Column(
              children: [
                _buildMobileServiceOption(
                  label: 'bKash',
                  service: MobileBankingService.bKash,
                  color: const Color(0xFFD82061),
                  isSelected:
                      controller.selectedMobileService.value ==
                      MobileBankingService.bKash,
                  onTap: () => controller.selectMobileService(
                    MobileBankingService.bKash,
                  ),
                ),
                Divider(
                  height: 24.h,
                  thickness: 1,
                  color: const Color(0xFFF1F5F9),
                ),
                _buildMobileServiceOption(
                  label: 'Nagad',
                  service: MobileBankingService.nagad,
                  color: const Color(0xFFF42A24),
                  isSelected:
                      controller.selectedMobileService.value ==
                      MobileBankingService.nagad,
                  onTap: () => controller.selectMobileService(
                    MobileBankingService.nagad,
                  ),
                ),
                Divider(
                  height: 24.h,
                  thickness: 1,
                  color: const Color(0xFFF1F5F9),
                ),
                _buildMobileServiceOption(
                  label: 'Rocket',
                  service: MobileBankingService.rocket,
                  color: const Color(0xFF863390),
                  isSelected:
                      controller.selectedMobileService.value ==
                      MobileBankingService.rocket,
                  onTap: () => controller.selectMobileService(
                    MobileBankingService.rocket,
                  ),
                ),
                Divider(
                  height: 24.h,
                  thickness: 1,
                  color: const Color(0xFFF1F5F9),
                ),
                _buildMobileServiceOption(
                  label: 'Upay',
                  service: MobileBankingService.upay,
                  color: const Color(0xFFFF911A),
                  isSelected:
                      controller.selectedMobileService.value ==
                      MobileBankingService.upay,
                  onTap: () =>
                      controller.selectMobileService(MobileBankingService.upay),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),

        // Selected Service Form
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.defaultBorder.withValues(alpha: 0.2),
            ),
          ),
          child: Obx(
            () => Column(
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: _getServiceColor(
                      controller.selectedMobileService.value,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone_android,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  '${_getServiceName(controller.selectedMobileService.value)} Payment',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: _getServiceColor(
                      controller.selectedMobileService.value,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                FieldLabel(label: "Mobile Number:"),
                CustomTextField(
                  controller: controller.mobileNumberController,
                  hintText: '1XXXXXXXXX',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Container(
                    width: 60.w,
                    alignment: Alignment.center,
                    child: Text(
                      '+880',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  backgroundColor: const Color(0xFFF8FAFC),
                  borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                ),
                SizedBox(height: 16.h),

                FieldLabel(label: "Account Holder Name:"),
                CustomTextField(
                  controller: controller.accountHolderNameController,
                  hintText: 'Enter your name',
                  backgroundColor: const Color(0xFFF8FAFC),
                  borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                ),
                SizedBox(height: 16.h),

                FieldLabel(label: "Amount:"),
                CustomTextField(
                  controller: controller.amountController,
                  hintText: '0.00',
                  keyboardType: TextInputType.number,
                  prefixIcon: Container(
                    width: 40.w,
                    alignment: Alignment.center,
                    child: Text(
                      '৳',
                      style: getTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  backgroundColor: const Color(0xFFF8FAFC),
                  borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                ),
                SizedBox(height: 16.h),

                FieldLabel(label: "Pin Number:"),
                CustomTextField(
                  controller: controller.pinNumberController,
                  hintText: '****',
                  isPasswordField: true,
                  keyboardType: TextInputType.number,
                  backgroundColor: const Color(0xFFF8FAFC),
                  borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                ),
                SizedBox(height: 20.h),

                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F9FF),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFFBAE6FD)),
                  ),
                  child: Text(
                    'You will receive a payment request notification. Please complete the payment within 5 minutes.',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0369A1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileServiceOption({
    required String label,
    required MobileBankingService service,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: isSelected
                    ? _primaryDark
                    : AppColors.textGrey.withValues(alpha: 0.5),
                width: 1.5,
              ),
              color: isSelected ? _primaryDark : Colors.transparent,
            ),
            child: isSelected
                ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                : null,
          ),
          SizedBox(width: 12.w),
          Container(
            width: 36.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Center(
              child: Text(
                label[0].toUpperCase(),
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  String _getServiceName(MobileBankingService service) {
    switch (service) {
      case MobileBankingService.bKash:
        return 'bKash';
      case MobileBankingService.nagad:
        return 'Nagad';
      case MobileBankingService.rocket:
        return 'Rocket';
      case MobileBankingService.upay:
        return 'Upay';
    }
  }

  Color _getServiceColor(MobileBankingService service) {
    switch (service) {
      case MobileBankingService.bKash:
        return const Color(0xFFD82061);
      case MobileBankingService.nagad:
        return const Color(0xFFF42A24);
      case MobileBankingService.rocket:
        return const Color(0xFF863390);
      case MobileBankingService.upay:
        return const Color(0xFFFF911A);
    }
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
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
                  width: 80.w,
                  height: 80.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF787BEB),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('🎉', style: TextStyle(fontSize: 40.sp)),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Congratulations ! Account Setup Complete!',
                  style: getTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Your payment for the Service Provider subscription has been successfully processed. You now have full access to the marketplace , Log in to your Dashboard now.',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                CustomButton(
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
                child: Icon(Icons.close, color: Colors.black54, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
