import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/shimmer_effect.dart';
import 'package:protiva502/features/service_provider/home/controller/provider_home_controller.dart';
import 'package:protiva502/features/service_provider/home/widget/active_job.dart';
import 'package:protiva502/features/service_provider/home/widget/home_header_appber.dart';
import 'package:protiva502/features/service_provider/home/widget/recent_booking_card.dart';
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
            // SearchBarWidget(),
            SizedBox(height: 24.h),

            // Wallet Card
            Obx(
              () => controller.isWalletLoading.value
                  ? _buildWalletShimmer()
                  : WalletCard(controller: controller),
            ),
            SizedBox(height: 24.h),
            // Application Limit Warning (Obx)
            // Obx(
            //   () => controller.isLimitReached.value
            //       ? LimitWarningCard(controller: controller)
            //       : const SizedBox.shrink(),
            // ),
            // if (controller.isLimitReached.value) SizedBox(height: 20.h),

            // Stats Grid
            Obx(
              () => controller.isStatsLoading.value
                  ? _buildStatsShimmer()
                  : StatsGrid(controller: controller),
            ),
            SizedBox(height: 24.h),
            // Active Jobs Section
            _buildSectionHeader(
              "Active Jobs",
              controller.handleViewAllActiveJobs,
            ),
            SizedBox(height: 12.h),
            Obx(
              () => controller.isActiveJobsLoading.value
                  ? _buildActiveJobsShimmer()
                  : ActiveJobsSection(controller: controller),
            ),
            SizedBox(height: 24.h),

            // Recent Bookings Section
            _buildSectionHeader(
              "recent_bookings".tr,
              controller.handleViewAllRecentBookings,
            ),
            SizedBox(height: 12.h),
            Obx(
              () => controller.isRecentBookingsLoading.value
                  ? _buildRecentBookingsShimmer()
                  : RecentBookingsSection(controller: controller),
            ),
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
            'view_all'.tr,
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

  Widget _buildWalletShimmer() {
    return ShimmerEffect(
      height: 140.h,
      width: double.infinity,
      borderRadius: 16,
      margin: EdgeInsets.zero,
    );
  }

  Widget _buildStatsShimmer() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      children: List.generate(
        4,
        (index) => ShimmerEffect(
          height: 100.h,
          width: double.infinity,
          borderRadius: 12,
        ),
      ),
    );
  }

  Widget _buildActiveJobsShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          2,
          (index) => Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: ShimmerServiceCard(width: 160, height: 220),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentBookingsShimmer() {
    return Column(
      children: List.generate(
        2,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: ShimmerEffect(
            height: 110.h,
            width: double.infinity,
            borderRadius: 12,
          ),
        ),
      ),
    );
  }
}
