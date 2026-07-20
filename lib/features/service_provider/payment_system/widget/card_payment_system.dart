import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_popupmenu_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/service_provider/auhecntication/widget/build_field_label.dart';
import 'package:protiva502/features/service_provider/payment_system/controller/payment_method_controller.dart';

class CardPaymentSection extends StatelessWidget {
  final PaymentMethodController controller;

  const CardPaymentSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Payment Gateway:',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 14.h),

        // Gateway selection container
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: Color(0xFFCBD5E1), width: 1.5),
          ),
          child: Column(
            children: [
              // Mastercard option
              GestureDetector(
                onTap: controller.selectMastercard,
                behavior: HitTestBehavior.opaque,
                child: Obx(
                  () => Row(
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                controller.selectedGateway.value ==
                                    PaymentGateway.mastercard
                                ? const Color(0xFF334155)
                                : AppColors.defaultBorder,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                          color:
                              controller.selectedGateway.value ==
                                  PaymentGateway.mastercard
                              ? const Color(0xFF334155)
                              : Colors.white,
                        ),
                        child:
                            controller.selectedGateway.value ==
                                PaymentGateway.mastercard
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16.sp,
                              )
                            : null,
                      ),
                      SizedBox(width: 12.w),
                      SvgPicture.asset(
                        IconPath.mastercard,
                        width: 40.w,
                        height: 28.h,
                        placeholderBuilder: (context) => Container(
                          width: 40.w,
                          height: 28.h,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Pay With Mastercard',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Visa option
              GestureDetector(
                onTap: controller.selectVisa,
                behavior: HitTestBehavior.opaque,
                child: Obx(
                  () => Row(
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                controller.selectedGateway.value ==
                                    PaymentGateway.visa
                                ? const Color(0xFF334155)
                                : AppColors.defaultBorder,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                          color:
                              controller.selectedGateway.value ==
                                  PaymentGateway.visa
                              ? const Color(0xFF334155)
                              : Colors.white,
                        ),
                        child:
                            controller.selectedGateway.value ==
                                PaymentGateway.visa
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16.sp,
                              )
                            : null,
                      ),
                      SizedBox(width: 12.w),
                      SvgPicture.asset(
                        IconPath.visa,
                        width: 40.w,
                        height: 28.h,
                        placeholderBuilder: (context) => Container(
                          width: 40.w,
                          height: 28.h,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Pay With Visa card',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Large card logo placeholder
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: Color(0xFFCBD5E1), width: 1.5),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                Center(
                  child: Obx(
                    () => Container(
                      width: 120.w,
                      height: 75.h,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          color: AppColors.defaultBorder.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          controller.selectedGateway.value ==
                                  PaymentGateway.mastercard
                              ? IconPath.mastercard
                              : IconPath.visa,
                          width: 80.w,
                          height: 50.h,
                          fit: BoxFit.contain,
                          placeholderBuilder: (context) => Container(
                            width: 80.w,
                            height: 50.h,
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Icon(
                                Icons.credit_card,
                                size: 30.sp,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: FieldLabel(label: "Card Number:"),
                ),

                Obx(
                  () => CustomTextField(
                    controller: controller.cardNumberController,
                    hintText: '01234 5678 9100',
                    keyboardType: TextInputType.number,
                    backgroundColor: Colors.white,
                    borderRadius: 6.r,
                    borderColor: Color(0xFFCBD5E1),
                    textStyle: getTextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                    onChanged: controller.onCardNumberChanged,
                    suffixIcon: controller.isCardNumberValid.value
                        ? Padding(
                            padding: EdgeInsets.all(14.r),
                            child: SvgPicture.asset(
                              IconPath.chack,
                              width: 16.w,
                              height: 16.h,
                            ),
                          )
                        : null,
                  ),
                ),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FieldLabel(label: "Country:"),
                          Obx(
                            () => CustomPopupMenu(
                              backgroundcolor: Colors.white.toARGB32().toString(),
                              value:
                                  controller.selectedCountry.value ??
                                  'Select Country',
                              items: controller.countries,
                              onSelected: (value) {
                                controller.selectCountry(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FieldLabel(label: "Expiry Date:"),
                          CustomTextField(
                            controller: controller.expiryController,
                            hintText: 'MM/YY',
                            borderRadius: 6.r,
                            keyboardType: TextInputType.streetAddress,
                            backgroundColor: Colors.white,
                            borderColor: const Color(0xFFCBD5E1),
                            textStyle: getTextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FieldLabel(label: "CVC:"),
                          CustomTextField(
                            controller: controller.cvcController,
                            hintText: '123',
                            keyboardType: TextInputType.number,
                            backgroundColor: Colors.white,
                            borderRadius: 6.r,
                            borderColor: const Color(0xFFCBD5E1),
                            textStyle: getTextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FieldLabel(label: "ZIP:"),
                          CustomTextField(
                            borderRadius: 6.r,
                            controller: controller.zipController,
                            hintText: '12345',
                            keyboardType: TextInputType.number,
                            backgroundColor: Colors.white,
                            borderColor: const Color(0xFFCBD5E1),
                            textStyle: getTextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
