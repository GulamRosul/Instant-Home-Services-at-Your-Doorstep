import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/wallet/controller/wallet_controller.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';

class PendingApprovalScreen extends StatelessWidget {
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();
    final navIndexController = Get.find<ProviderNavbarController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            children: [
              // Pending Icon
              Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.access_time,
                  size: 40.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 24.h),
              // Title & Subtitle
              Text(
                'Pending Approval',
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Your withdrawal request is being reviewed\nby the admin',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 40.h),

              // Amount Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF7079F0),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Text(
                      'Withdrawal Amount',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8.h),
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

              // Details Card
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
                        'Request Details',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _buildDetailRow('Status', 'Pending', isStatus: true),
                    _buildDetailRow('Request Date', 'Jan 19, 2026'),
                    _buildDetailRow('Expected Review', '1-3 business days'),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Info Note
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "💡 You'll receive a notification once the admin reviews your request. The funds will be transferred to your account within 1-2 business days after approval.",
                        style: getTextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFF1E40AF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35.h),

              // Back to Home Button
              ElevatedButton(
                onPressed: () {
                  navIndexController.resetHomeSubPage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 40.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home_outlined, color: Colors.black, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Back to Home',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              if (isStatus)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    value,
                    style: getTextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFD97706),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else
                Text(
                  value,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
          if (label != 'Expected Review')
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Divider(height: 1, color: Colors.grey.shade100),
            ),
        ],
      ),
    );
  }
}
