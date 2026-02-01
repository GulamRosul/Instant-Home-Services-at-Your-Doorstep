import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/payment_system/controller/provider_pricing_controller.dart';

class PlanCard extends StatelessWidget {
  final String planName;
  final String price;
  final String perMonth;
  final String description;
  final bool showDottedDivider;
  final List<String> features;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.planName,
    required this.price,
    required this.perMonth,
    required this.description,
    required this.showDottedDivider,
    required this.features,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<ProviderPricingController>();

      final isThisSelected =
          (planName == 'Basic' &&
              controller.selectedPlan.value == PricingPlan.basic) ||
          (planName == 'Unlimited' &&
              controller.selectedPlan.value == PricingPlan.unlimited);

      return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isThisSelected
                  ? Colors.black
                  : const Color(0xFFE0E7FF).withValues(alpha: 0.8),
              width: isThisSelected ? 2 : 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                planName,
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    price,
                    style: getTextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    perMonth,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              if (showDottedDivider) ...[
                CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: _DottedLinePainter(),
                ),
                SizedBox(height: 16.h),
              ],
              ...features.map(
                (f) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check, size: 20.sp, color: Colors.black),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          f,
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
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
    });
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.defaultBorder.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    const dashWidth = 4.0;
    const gap = 4.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashWidth, 0), paint);
      x += dashWidth + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
