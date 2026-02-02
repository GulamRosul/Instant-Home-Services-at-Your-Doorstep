import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/service_provider/home/controller/provider_home_controller.dart';

class StatsGrid extends StatelessWidget {
  final ProviderHomeController controller;

  const StatsGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = (constraints.maxWidth - 12.w) / 2;
        double cardHeight = 120.h;
        double aspectRatio = cardWidth / cardHeight;

        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: aspectRatio > 0 ? aspectRatio : 1.2,
          children: [
            Obx(
              () => _buildStatCard(
                "Applications This Month",
                "${controller.applicationsCount.value}/${controller.maxApplications}",
                icon: SvgPicture.asset(IconPath.one),
                iconBG: Color(0xFFFFF7ED),
                progress:
                    controller.applicationsCount.value /
                    controller.maxApplications,
              ),
            ),
            Obx(
              () => _buildStatCard(
                "Total bookings Served",
                controller.bookingsServed.value,
                icon: SvgPicture.asset(IconPath.two),
                iconBG: Color(0xFFDCFCE7),
              ),
            ),
            Obx(
              () => _buildStatCard(
                "Average Rating's",
                "${controller.averageRating.value} (${controller.reviewCount.value} reviews)",
                icon: SvgPicture.asset(IconPath.star),
                iconBG: Color(0xFFFEFCE8),
              ),
            ),

            Obx(
              () => _buildStatCard(
                "Submitted Proposal",
                controller.submittedProposals.value.toString(),
                icon: SvgPicture.asset(IconPath.three),
                iconBG: Color(0xFFCFFAFE),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    String title,
    String value, {
    required dynamic icon,
    required Color iconBG,
    double? progress,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: iconBG,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: icon is IconData
                    ? Icon(icon, color: Colors.grey.shade700, size: 18.sp)
                    : SizedBox(width: 18.sp, height: 18.sp, child: icon),
              ),
            ],
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          if (progress != null) ...[
            SizedBox(height: 6.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade100,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF22C55E),
                ),
                minHeight: 4.h,
              ),
            ),
          ],
          SizedBox(height: 4.h),
          Text(
            title,
            style: getTextStyle(
              fontSize: 11.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
