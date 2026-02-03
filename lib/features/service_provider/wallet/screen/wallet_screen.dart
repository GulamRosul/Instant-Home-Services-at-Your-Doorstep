import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/service_provider/wallet/controller/wallet_controller.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';

import 'package:protiva502/features/service_provider/wallet/screen/withdraw_funds_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 435.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF787BEB),
                            const Color(0xFF5B5FC7),
                          ],
                        ),
                      ),
                    ),
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                'My Wallet',
                                style: getTextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // card
                    Positioned(
                      bottom: 26.h,
                      left: 20.w,
                      right: 20.w,
                      child: Column(
                        children: [
                          _buildWalletInfoCard(controller),
                          SizedBox(height: 24.h),
                          _buildWithdrawButton(controller),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Withdrawal History',
                        style: getTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => Column(
                          children: controller.withdrawalHistory.map((item) {
                            return _buildHistoryItem(item);
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 90.h),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.find<ProviderNavbarController>().resetHomeSubPage();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Text(
                      'Back',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletInfoCard(WalletController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.2,
        ), // Glassy effect on purple BG
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Earnings',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '৳ ${controller.totalEarnings.value}',
            style: getTextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'From completed services',
            style: getTextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15.h),
          Divider(color: Colors.white.withValues(alpha: 0.2)),
          SizedBox(height: 15.h),
          Text(
            'Pending Amount',
            style: getTextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Text(
            '৳ ${controller.pendingAmount.value}',
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawButton(WalletController controller) {
    return InkWell(
      onTap: () {
        Get.find<ProviderNavbarController>().showHomeSubPage(
          const WithdrawFundsScreen(),
        );
      },
      child: Container(
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_download_outlined,
              color: const Color(0xFF7079F0),
              size: 24.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Withdraw Funds',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF7079F0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, String> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '৳ ${item['amount']}',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(IconPath.ok, width: 16.sp, height: 16.sp),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                item['date']!,
                style: getTextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              item['status']!,
              style: getTextStyle(
                fontSize: 12.sp,
                color: Color(0xFF16A34A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
