import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/features/service_provider/wallet/controller/wallet_controller.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/service_provider/wallet/screen/withdraw_funds_screen.dart';
import 'package:protiva502/features/service_provider/wallet/screen/pending_approval_screen.dart';

class ConfirmWithdrawalScreen extends StatelessWidget {
  const ConfirmWithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();
    final navIndexController = Get.find<ProviderNavbarController>();

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
                  SizedBox(height: 48.h),

                  Text(
                    'Confirm Withdrawal',
                    style: getTextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Please review your withdrawal details',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Withdrawal Amount Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF787BEB), Color(0xFF5B5FC7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Withdrawal Amount',
                          style: getTextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          '৳ ${controller.withdrawalAmount.value}',
                          style: getTextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Details Table
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Text(
                            'Withdrawal Details',
                            style: getTextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        _buildDetailRow(
                          'Account Number',
                          controller.accountNumber.value,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Divider(color: Color(0xFFE2E8F0)),
                        ),
                        _buildDetailRow('Processing Time', '1-3 business days'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Divider(color: Color(0xFFE2E8F0)),
                        ),
                        _buildDetailRow(
                          'Transaction Fee',
                          'Free',
                          isGreen: true,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Divider(color: Color(0xFFE2E8F0)),
                        ),
                        _buildDetailRow(
                          'You\'ll Receive',
                          '৳ ${controller.withdrawalAmount.value}',
                          isBold: true,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Admin Note Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: const Color(0xFF3B82F6),
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Admin Review Required',
                                style: getTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E40AF),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'This request will be sent to the admin for approval. You\'ll be notified once it\'s been reviewed.',
                                style: getTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1E40AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    onPressed: () {
                      navIndexController.showHomeSubPage(
                        const PendingApprovalScreen(),
                      );
                    },
                    textColor: Colors.white,
                    text: 'Submit Request',
                    backgroundColor: Color(0xFF787BEB),
                    height: 50.h,
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    onPressed: () {
                      navIndexController.showHomeSubPage(
                        const WithdrawFundsScreen(),
                      );
                    },
                    textColor: Colors.black,
                    text: 'Edit Details',
                    backgroundColor: Colors.white,
                    height: 50.h,
                    borderColor: Color(0xFFE2E8F0),
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
                        navIndexController.showHomeSubPage(
                          const WithdrawFundsScreen(),
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

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isGreen = false,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: getTextStyle(fontSize: 14.sp, color: Color(0xFF64748B)),
              ),
              Text(
                value,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w600,
                  color: isGreen ? Color(0xFF16A34A) : Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
