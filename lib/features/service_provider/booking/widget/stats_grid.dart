import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/service_provider/booking/controller/booking_controller.dart';

class StatsGrid extends StatelessWidget {
  final BookingController controller;

  const StatsGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.w,
          mainAxisSpacing: 15.h,
          childAspectRatio: 1.2,
        ),
        itemCount: controller.dynamicStats.length,
        itemBuilder: (context, index) {
          final stat = controller.dynamicStats[index];

          return Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Color(0xFFCBD5E1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatIcon(stat['icon']!),
                SizedBox(height: 8.h),
                Text(
                  stat['value']!,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  stat['label']!,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: Color(0xFF4B5563),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatIcon(String type) {
    String iconPath;
    Color bgColor;

    switch (type) {
      case 'flag':
        iconPath = IconPath.x1;
        bgColor = const Color(0xFFFFF7ED);
        break;
      case 'confirmed':
        iconPath = IconPath.x2;
        bgColor = const Color(0xFFDCFCE7);
        break;
      case 'star':
        iconPath = IconPath.star;
        bgColor = const Color(0xFFFEFCE8);
        break;
      default:
        iconPath = IconPath.x3;
        bgColor = const Color(0xFFCFFAFE);
    }

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: SvgPicture.asset(iconPath, width: 16.sp, height: 16.sp),
    );
  }
}
