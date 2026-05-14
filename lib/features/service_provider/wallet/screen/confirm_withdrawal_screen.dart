import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/features/service_provider/wallet/controller/wallet_controller.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/service_provider/wallet/screen/withdraw_funds_screen.dart';

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
                    'confirm_withdrawal'.tr,
                    style: getTextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'please_review_withdrawal_details'.tr,
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
                          'withdrawable_amount'.tr,
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
                            'withdrawal_details'.tr,
                            style: getTextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        _buildDetailRow(
                          'account_number'.tr,
                          controller.accountNumber.value,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Divider(color: Color(0xFFE2E8F0)),
                        ),
                        _buildDetailRow('processing_time'.tr, 'processing_time_details'.tr),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Divider(color: Color(0xFFE2E8F0)),
                        ),
                        // _buildDetailRow(
                        //   'Transaction Fee',
                        //   '৳ ${controller.feeAmount.toStringAsFixed(2)}',
                        //   isGreen: true,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Divider(color: Color(0xFFE2E8F0)),
                        ),
                        _buildDetailRow(
                          'you_will_receive'.tr,
                          '৳ ${controller.netAmount.toStringAsFixed(2)}',
                          isBold: true,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Obx(() {
                    if (controller.submitErrorMessage.value.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFFECACA)),
                      ),
                      child: Text(
                        controller.submitErrorMessage.value,
                        style: getTextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFB91C1C),
                        ),
                      ),
                    );
                  }),

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
                                'admin_approval_required'.tr,
                                style: getTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E40AF),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'withdrawal_review'.tr,
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
                  Obx(
                    () => CustomButton(
                      onPressed: controller.isSubmittingWithdrawal.value
                          ? null
                          : controller.submitWithdrawalRequest,
                      textColor: Colors.white,
                      text: controller.isSubmittingWithdrawal.value
                          ? 'submitting'.tr
                          : 'submit_request'.tr,
                      backgroundColor: Color(0xFF787BEB),
                      height: 50.h,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    onPressed: () {
                      navIndexController.showHomeSubPage(
                        const WithdrawFundsScreen(),
                      );
                    },
                    textColor: Colors.black,
                    text: 'edit_details'.tr,
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
                          const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                          SizedBox(width: 8.w),
                          Text(
                            'back'.tr,
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
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: isBold ? FontWeight.w600 : FontWeight.w600,
                    color: isGreen ? Color(0xFF16A34A) : Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
