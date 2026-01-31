import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/payment_system/controller/payment_method_controller.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  static const Color _primaryDark = Color(0xFF334155);
  static const Color _successGreen = Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        surfaceTintColor: const Color(0xFFF8F9FA),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'On platform destination charge to provider apply 10%',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textGrey,
              ),
            ),
            SizedBox(height: 24.h),

            // Segmented: Card Payment | Mobile Banking
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: _buildSegment(
                      icon: Icons.credit_card,
                      label: 'Card Payment',
                      isSelected:
                          controller.selectedPaymentType.value ==
                              PaymentType.cardPayment,
                      onTap: controller.selectCardPayment,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildSegment(
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
            SizedBox(height: 28.h),

            // Choose Your Payment Gateway
            Obx(() {
              if (controller.selectedPaymentType.value !=
                  PaymentType.cardPayment) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Your Payment Gateway:',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildGatewayOption(
                          label: 'Pay With Mastercard',
                          isSelected: controller.selectedGateway.value ==
                              PaymentGateway.mastercard,
                          onTap: controller.selectMastercard,
                          isMastercard: true,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildGatewayOption(
                          label: 'Pay With Visa card',
                          isSelected: controller.selectedGateway.value ==
                              PaymentGateway.visa,
                          onTap: controller.selectVisa,
                          isMastercard: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Large Mastercard/Visa logo placeholder
                  Center(
                    child: Obx(
                      () => Container(
                        width: 80.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          color: controller.selectedGateway.value ==
                                  PaymentGateway.mastercard
                              ? const Color(0xFFEB001B)
                              : const Color(0xFF1A1F71),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            controller.selectedGateway.value ==
                                    PaymentGateway.mastercard
                                ? 'MC'
                                : 'Visa',
                            style: getTextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  _buildFieldLabel('Card Number:'),
                  Obx(
                    () => CustomTextField(
                      controller: controller.cardNumberController,
                      hintText: '01234 5678 9100',
                      keyboardType: TextInputType.number,
                      backgroundColor: const Color(0xFFE8ECF1),
                      borderColor: AppColors.defaultBorder.withValues(alpha: 0.2),
                      textStyle: getTextStyle(color: Colors.black, fontSize: 14.sp),
                      onChanged: controller.onCardNumberChanged,
                      suffixIcon: controller.isCardNumberValid.value
                          ? Icon(Icons.check_circle, color: _successGreen, size: 22.sp)
                          : null,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Country:'),
                            Obx(
                              () => _buildDropdown(
                                value: controller.selectedCountry.value,
                                hint: 'Select Country',
                                items: controller.countries,
                                onChanged: controller.selectCountry,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Expiry Date:'),
                            CustomTextField(
                              controller: controller.expiryController,
                              hintText: 'MM/YY',
                              keyboardType: TextInputType.streetAddress,
                              backgroundColor: const Color(0xFFE8ECF1),
                              borderColor:
                                  AppColors.defaultBorder.withValues(alpha: 0.2),
                              textStyle:
                                  getTextStyle(color: Colors.black, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('CVC:'),
                            CustomTextField(
                              controller: controller.cvcController,
                              hintText: '123',
                              keyboardType: TextInputType.number,
                              backgroundColor: const Color(0xFFE8ECF1),
                              borderColor:
                                  AppColors.defaultBorder.withValues(alpha: 0.2),
                              textStyle:
                                  getTextStyle(color: Colors.black, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('ZIP:'),
                            CustomTextField(
                              controller: controller.zipController,
                              hintText: '12345',
                              keyboardType: TextInputType.number,
                              backgroundColor: const Color(0xFFE8ECF1),
                              borderColor:
                                  AppColors.defaultBorder.withValues(alpha: 0.2),
                              textStyle:
                                  getTextStyle(color: Colors.black, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              );
            }),
            SizedBox(height: 24.h),

            CustomButton(
              text: 'Go To Checkout',
              onPressed: controller.handleCheckout,
              backgroundColor: _primaryDark,
              textColor: Colors.white,
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSegment({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? _primaryDark : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? _primaryDark : AppColors.defaultBorder.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isSelected ? Colors.white : AppColors.textGrey,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: getTextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGatewayOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isMastercard,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? _primaryDark
                : AppColors.defaultBorder.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: isMastercard
                    ? const Color(0xFFEB001B)
                    : const Color(0xFF1A1F71),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: Text(
                  isMastercard ? 'MC' : 'V',
                  style: getTextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                label,
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check, size: 18.sp, color: _primaryDark),
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
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF1),
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
          hint: Text(
            hint,
            style: getTextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey, size: 24.sp),
          style: getTextStyle(fontSize: 14.sp, color: Colors.black),
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

  Widget _buildBottomNav() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, 'Home', false),
            _buildNavItem(Icons.description_outlined, 'Booking', true),
            _buildNavItem(Icons.notifications_none_rounded, null, false),
            _buildNavItem(Icons.grid_view_rounded, null, false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String? label, bool isActive) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.textPurple.withValues(alpha: 0.15) : null,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: isActive ? AppColors.textPurple : AppColors.textGrey,
            ),
            if (label != null) ...[
              SizedBox(width: 8.w),
              Text(
                label,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.textPurple : AppColors.textGrey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
