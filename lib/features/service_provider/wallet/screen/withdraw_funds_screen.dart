import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/wallet/controller/wallet_controller.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/service_provider/wallet/screen/wallet_screen.dart';

class WithdrawFundsScreen extends StatelessWidget {
  const WithdrawFundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();
    final navIndexController = Get.find<ProviderNavbarController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      navIndexController.showHomeSubPage(const WalletScreen());
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
                  Text(
                    'Skip',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              Text(
                'Withdraw Funds',
                style: getTextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Request a withdrawal from your wallet',
                style: getTextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              SizedBox(height: 32.h),

              // Available Balance Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Balance',
                      style: getTextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '৳ ${controller.totalEarnings.value}',
                      style: getTextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Admin Approval Note
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7D6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange, size: 20.sp),
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
                              color: const Color(
                                0xFF92400E,
                              ).withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Withdrawal Amount
              Text(
                'Withdrawal Amount',
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: controller.withdrawalAmount.value,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Text(
                        '৳',
                        style: getTextStyle(
                          fontSize: 20.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    border: InputBorder.none,
                  ),
                  style: getTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
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
                        width: 75.w,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF7079F0)
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
              SizedBox(height: 32.h),

              // Bank Account
              Text(
                'Bank Account Number',
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  onChanged: (value) => controller.accountNumber.value = value,
                  decoration: InputDecoration(
                    hintText: 'Enter your account number',
                    hintStyle: getTextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14.sp,
                    ),
                    border: InputBorder.none,
                  ),
                ),
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

              SizedBox(height: 100.h), // Space for Navbar
            ],
          ),
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
          style: getTextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isGreen ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}
