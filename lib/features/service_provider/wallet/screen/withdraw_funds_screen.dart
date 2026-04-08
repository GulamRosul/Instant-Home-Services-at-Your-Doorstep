import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/features/service_provider/wallet/controller/wallet_controller.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/service_provider/wallet/screen/wallet_screen.dart';

class WithdrawFundsScreen extends StatelessWidget {
  const WithdrawFundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () {
            Get.find<ProviderNavbarController>().showHomeSubPage(
              const WalletScreen(),
            );
          },
        ),
        title: Text(
          'Back',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Center(
              child: Text(
                'Skip',
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[300]!,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(
              'Withdraw Funds',
              style: getTextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Request a withdrawal from your wallet',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 32.h),

            // Available Balance Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Balance',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => Text(
                      '৳${controller.totalEarnings.value}',
                      style: getTextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Admin Approval Required Info
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7D6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: const Color(0xFFD97706),
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin Approval Required',
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF92400E),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Your withdrawal request will be reviewed by the admin. Processing typically takes 1-3 business days.',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFFB45309),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            Text(
              'Withdrawal Amount',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: controller.withdrawalAmountController,
              hintText: '৳ 0.00',
              keyboardType: TextInputType.number,
              backgroundColor: Colors.white,
              borderColor: const Color(0xFFE2E8F0),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                child: Text(
                  '৳',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Percentage Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [25, 50, 75, 100].map((p) {
                return Obx(() {
                  bool isSelected = controller.selectedPercentage.value == p;
                  return GestureDetector(
                    onTap: () => controller.setPercentage(p),
                    child: Container(
                      width: 78.w,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF7079F0)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$p%',
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? const Color(0xFF7079F0)
                                : const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
            SizedBox(height: 24.h),

            // Payment Method Tabs
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: _buildTab(
                        title: 'Card Payment',
                        icon: Icons.credit_card_outlined,
                        isSelected:
                            controller.selectedPaymentMethod.value ==
                            'Card Payment',
                        onTap: () =>
                            controller.selectPaymentMethod('Card Payment'),
                      ),
                    ),
                    Expanded(
                      child: _buildTab(
                        title: 'Mobile Banking',
                        icon: Icons.smartphone_outlined,
                        isSelected:
                            controller.selectedPaymentMethod.value ==
                            'Mobile Banking',
                        onTap: () =>
                            controller.selectPaymentMethod('Mobile Banking'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Obx(() {
              if (controller.selectedPaymentMethod.value == 'Mobile Banking') {
                return _buildMobileBankingSection(controller);
              } else {
                return _buildCardPaymentSection(controller);
              }
            }),

            SizedBox(height: 32.h),

            // Footer info
            _buildInfoRow('Minimum withdrawal', '৳ 100.00'),
            SizedBox(height: 8.h),
            _buildInfoRow('Processing time', '1-3 business days'),
            SizedBox(height: 8.h),
            Obx(
              () => _buildInfoRow(
                'Transaction fee',
                '৳ ${controller.feeAmount.toStringAsFixed(2)}',
                isGreen: true,
              ),
            ),

            SizedBox(height: 40.h),

            // Continue Button
            ElevatedButton(
              onPressed: controller.handleContinueWithdrawal,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7079F0),
                minimumSize: Size(double.infinity, 56.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Continue',
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 120.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF334155) : Colors.white,
          borderRadius: BorderRadius.circular(isSelected ? 6.r : 0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileBankingSection(WalletController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Mobile Banking Service:',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 16.h),
        _buildMobileServiceProvider(
          name: 'bKash',
          color: const Color(0xFFE2136E),
          logoText: 'b',
          controller: controller,
        ),
        _buildMobileServiceProvider(
          name: 'Nagad',
          color: const Color(0xFFF44336),
          logoText: 'N',
          controller: controller,
        ),
        _buildMobileServiceProvider(
          name: 'Rocket',
          color: const Color(0xFF8C3494),
          logoText: 'R',
          controller: controller,
        ),
        _buildMobileServiceProvider(
          name: 'Upay',
          color: const Color(0xFFF58220),
          logoText: 'U',
          controller: controller,
        ),
        SizedBox(height: 24.h),
        Text(
          '${controller.selectedMobileService.value} Number',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          controller: controller.phoneNumberController,
          hintText: '1XXXXXXXXXX',
          keyboardType: TextInputType.phone,
          backgroundColor: Colors.white,
          borderColor: const Color(0xFFE2E8F0),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
            child: Text(
              '+880',
              style: getTextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Payment Take Number',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          controller: controller.pinController,
          hintText: 'Enter payment take number',
          backgroundColor: Colors.white,
          borderColor: const Color(0xFFE2E8F0),
        ),
      ],
    );
  }

  Widget _buildCardPaymentSection(WalletController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank Account Number',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          controller: controller.accountNumberController,
          hintText: 'Enter your account number',
          keyboardType: TextInputType.number,
          backgroundColor: Colors.white,
          borderColor: const Color(0xFFE2E8F0),
        ),
        SizedBox(height: 12.h),
        Text(
          'Bank Name',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          controller: controller.bankNameController,
          hintText: 'Enter your bank name',
          backgroundColor: Colors.white,
          borderColor: const Color(0xFFE2E8F0),
        ),

        SizedBox(height: 12.h),
        Text(
          'Branch Name',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          controller: controller.branchNameController,
          hintText: 'Enter your branch name',
          backgroundColor: Colors.white,
          borderColor: const Color(0xFFE2E8F0),
        ),
        SizedBox(height: 12.h),
        Text(
          'Account Holder Name',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          controller: controller.accountHolderNameController,
          hintText: 'Enter your account holder name',
          backgroundColor: Colors.white,
          borderColor: const Color(0xFFE2E8F0),
        ),
        SizedBox(height: 12.h),
        Text(
          'Phone Number',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          controller: controller.phoneNumberController,
          hintText: '1XXXXXXXXXX',
          keyboardType: TextInputType.phone,
          backgroundColor: Colors.white,
          borderColor: const Color(0xFFE2E8F0),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
            child: Text(
              '+880',
              style: getTextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileServiceProvider({
    required String name,
    required Color color,
    required String logoText,
    required WalletController controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Obx(() {
        bool isSelected = controller.selectedMobileService.value == name;
        return GestureDetector(
          onTap: () => controller.selectMobileService(name),
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
                        ? const Color(0xFF334155)
                        : const Color(0xFFCBD5E1),
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 14.sp,
                        color: const Color(0xFF334155),
                      )
                    : null,
              ),
              SizedBox(width: 12.w),
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Center(
                  child: Text(
                    logoText,
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                name,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w300,
            color: isGreen ? const Color(0xFF16A34A) : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
