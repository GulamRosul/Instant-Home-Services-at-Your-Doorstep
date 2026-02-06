import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/payment_system/controller/provider_pricing_controller.dart';
import 'package:protiva502/features/service_provider/payment_system/widget/basic_checkbox.dart';
import 'package:protiva502/features/service_provider/payment_system/widget/plan_card.dart';

class ProviderPricingScreen extends StatelessWidget {
  const ProviderPricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderPricingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          'Simple and affordable pricing',
          textAlign: TextAlign.left,
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                children: [
                  GestureDetector(
                    onTap: controller.selectBasic,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BasicCheckbox(
                          checked:
                              controller.selectedPlan.value ==
                              PricingPlan.basic,
                          onTap: controller.selectBasic,
                        ),
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
                        BasicCheckbox(
                          checked:
                              controller.selectedPlan.value ==
                              PricingPlan.unlimited,
                          onTap: controller.selectUnlimited,
                        ),
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
            PlanCard(
              planName: 'Basic',
              price: '৳ 29',
              perMonth: '/per month',
              description: 'Best for professional freelancers and small teams.',
              showDottedDivider: true,
              features: const ['cap 2 applications/mo', '1 active listing'],
              onTap: () {
                controller.selectedPlan.value = PricingPlan.basic;
              },
            ),

            SizedBox(height: 16.h),

            // Unlimited plan card
            PlanCard(
              planName: 'Unlimited',
              price: '৳ 99',
              perMonth: '/per month',
              description: 'Perfect for starters',
              showDottedDivider: false,
              features: const [
                'Unlimited applications & listings',
                'priority placement',
              ],
              onTap: () {
                controller.selectedPlan.value = PricingPlan.unlimited;
              },
            ),

            SizedBox(height: 30.h),
            CustomButton(
              borderRadius: 6.r,
              text: 'Next',
              onPressed: controller.handleNext,
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
