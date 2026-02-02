import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/service_provider/home/controller/provider_home_controller.dart';

class WalletCard extends StatelessWidget {
  final ProviderHomeController controller;

  const WalletCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: controller.handleViewWallet,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF7079F0),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: SvgPicture.asset(IconPath.wallet),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'My Wallet',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.show_chart,
                        color: Color(0xFF4ADE80),
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Active',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Total Earnings',
              style: getTextStyle(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 8.h),
            Obx(
              () => FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  '৳ ${controller.totalEarnings.value}',
                  style: getTextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'From completed services',
              style: getTextStyle(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 12.h),
            Divider(color: Colors.white.withValues(alpha: 0.2)),
            SizedBox(height: 12.h),
            Text(
              'Pending Amount',
              style: getTextStyle(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 8.h),
            Obx(
              () => Text(
                '৳ ${controller.pendingAmount.value}',
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
