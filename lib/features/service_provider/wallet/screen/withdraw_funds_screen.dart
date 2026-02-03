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
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.h),
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
                      color: Colors.black.withValues(alpha: 0.8),
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
                      border: Border.all(color: Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available Balance',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '৳ ${controller.totalEarnings.value}',
                          style: getTextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.orange,
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
                                  color: Color(0xFF92400E),
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
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomTextField(
                    controller: controller.withdrawalAmountController,
                    hintText: '৳ 0.00',
                    keyboardType: TextInputType.number,
                    backgroundColor: Colors.white,
                    borderColor: Color(0xFFE2E8F0),
                  ),
                  SizedBox(height: 16.h),

                  // Percentage Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [25, 50, 75, 100].map((p) {
                      return Obx(() {
                        bool isSelected =
                            controller.selectedPercentage.value == p;
                        return GestureDetector(
                          onTap: () => controller.setPercentage(p),
                          child: Container(
                            width: 75.w,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFE2E8F0)
                                    : Colors.grey.shade200,
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
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                  SizedBox(height: 24.h),

                  // Bank Account
                  Text(
                    'Bank Account Number',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomTextField(
                    controller: controller.accountNumberController,
                    hintText: 'Enter your account number',
                    keyboardType: TextInputType.number,
                    backgroundColor: Colors.white,
                    borderColor: Color(0xFFE2E8F0),
                  ),
                  SizedBox(height: 32.h),

                  // Footer info
                  _buildInfoRow('Minimum withdrawal', '৳ 100.00'),
                  SizedBox(height: 8.h),
                  _buildInfoRow('Processing time', '1-3 business days'),
                  SizedBox(height: 8.h),
                  _buildInfoRow('Transaction fee', 'Free', isGreen: true),

                  SizedBox(height: 40.h),

                  // Continue Button
                  ElevatedButton(
                    onPressed: controller.handleContinueWithdrawal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7079F0),
                      minimumSize: Size(double.infinity, 56.h),
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
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 20.w,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                color: const Color(0xFFF8F9FA),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.find<ProviderNavbarController>().showHomeSubPage(
                          const WalletScreen(),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, color: Colors.black),
                          SizedBox(width: 8.w),
                          Text(
                            'Back',
                            style: getTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
            color: Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w300,
            color: isGreen ? Color(0xFF16A34A) : Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
