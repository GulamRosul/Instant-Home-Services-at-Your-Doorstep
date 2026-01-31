import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/auhecntication/controller/provider_pricing_controller.dart';
import 'package:protiva502/features/user/authentication/screen/user_login_screen.dart';

/// Teal color for checkmarks (matches screenshot).
const Color _tealCheck = Color(0xFF14B8A6);

class ProviderPricingScreen extends StatelessWidget {
  const ProviderPricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderPricingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F7),
        elevation: 0,
        surfaceTintColor: const Color(0xFFF5F5F7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Simple and affordable pricing',
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: controller.handleSkip,
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Center(
                child: Text(
                  'Skip',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan selection: Basic (checkbox) | Unlimited (radio)
            Obx(
              () => Row(
                children: [
                  GestureDetector(
                    onTap: controller.selectBasic,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildBasicCheckbox(
                            controller.selectedPlan.value ==
                                PricingPlan.basic),
                        SizedBox(width: 8.w),
                        Text(
                          'Basic',
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 24.w),
                  GestureDetector(
                    onTap: controller.selectUnlimited,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildUnlimitedRadio(
                            controller.selectedPlan.value ==
                                PricingPlan.unlimited),
                        SizedBox(width: 8.w),
                        Text(
                          'Unlimited',
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Basic plan card
            _buildPlanCard(
              planName: 'Basic',
              price: '\$29',
              perMonth: '/per month',
              description:
                  'Best for professional freelancers and small teams.',
              showDottedDivider: true,
              features: [
                'cap 2 applications/mo',
                '1 active listing',
              ],
              onTap: controller.selectBasic,
            ),
            SizedBox(height: 16.h),

            // Unlimited plan card
            _buildPlanCard(
              planName: 'Unlimited',
              price: '\$99',
              perMonth: '/per month',
              description:
                  'Best for professional freelancers and small teams.',
              showDottedDivider: false,
              features: [
                'Unlimited applications & listings',
                'priority placement',
              ],
              onTap: controller.selectUnlimited,
            ),
            SizedBox(height: 30.h),

            CustomButton(
              text: 'Next',
              onPressed: controller.handleNext,
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
            ),
            SizedBox(height: 20.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.off(() => const UserLoginScreen()),
                  child: Text(
                    'Sign In',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF6366F1),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicCheckbox(bool checked) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        color: checked ? const Color(0xFF334155) : Colors.transparent,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: checked ? const Color(0xFF334155) : AppColors.defaultBorder,
          width: 1.5,
        ),
      ),
      child: checked
          ? Icon(Icons.check, size: 16.sp, color: _tealCheck)
          : null,
    );
  }

  Widget _buildUnlimitedRadio(bool selected) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? const Color(0xFF334155) : Colors.transparent,
        border: Border.all(
          color: selected ? const Color(0xFF334155) : AppColors.defaultBorder,
          width: 1.5,
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: _tealCheck,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildPlanCard({
    required String planName,
    required String price,
    required String perMonth,
    required String description,
    required bool showDottedDivider,
    required List<String> features,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      final controller = Get.find<ProviderPricingController>();
      final isThisSelected = (planName == 'Basic' &&
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
                  ? _tealCheck.withValues(alpha: 0.6)
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
              if (showDottedDivider) ...[
                SizedBox(height: 16.h),
                CustomPaint(
                  size: Size(double.infinity, 1),
                  painter: _DottedLinePainter(),
                ),
                SizedBox(height: 16.h),
              ] else
                SizedBox(height: 16.h),
              ...features.map(
                (f) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check,
                        size: 20.sp,
                        color: _tealCheck,
                      ),
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
