import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/home/controller/provider_home_controller.dart';
import 'package:protiva502/features/service_provider/home/widget/activeJob.dart';
import 'package:protiva502/features/service_provider/home/widget/home_header_appber.dart';
import 'package:protiva502/features/service_provider/home/widget/recentBookingCard.dart';
import 'package:protiva502/features/service_provider/home/widget/search_ber_widget.dart';
import 'package:protiva502/features/service_provider/home/widget/statesGride.dart';
import 'package:protiva502/features/service_provider/home/widget/wallet_card.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderHomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const HomeHeaderAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            SearchBarWidget(),
            SizedBox(height: 24.h),

            // Wallet Card
            WalletCard(controller: controller),
            SizedBox(height: 24.h),
            // Application Limit Warning (Obx)
            // Obx(
            //   () => controller.isLimitReached.value
            //       ? LimitWarningCard(controller: controller)
            //       : const SizedBox.shrink(),
            // ),
            // if (controller.isLimitReached.value) SizedBox(height: 20.h),

            // Stats Grid
            StatsGrid(controller: controller),
            SizedBox(height: 24.h),
            // Active Jobs Section
            _buildSectionHeader(
              "Active Jobs",
              controller.handleViewAllActiveJobs,
            ),
            SizedBox(height: 12.h),
            ActiveJobCard(),
            SizedBox(height: 24.h),

            // Recent Bookings Section
            _buildSectionHeader(
              "Recent Bookings",
              controller.handleViewAllRecentBookings,
            ),
            SizedBox(height: 12.h),
            RecentBookingCard(),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Text(
            'View All',
            style: getTextStyle(
              fontSize: 12.sp,
              color: Color(0xFF1D4ED8),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF1D4ED8),
            ),
          ),
        ),
      ],
    );
  }
}
