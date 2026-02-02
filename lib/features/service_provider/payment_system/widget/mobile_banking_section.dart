import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/features/service_provider/auhecntication/widget/build_field_label.dart';
import 'package:protiva502/features/service_provider/payment_system/controller/payment_method_controller.dart';
import 'package:protiva502/features/service_provider/payment_system/widget/mobile_service_option.dart';

class MobileBankingSection extends StatelessWidget {
  final PaymentMethodController controller;

  const MobileBankingSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Mobile Banking Service:',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 14.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: Color(0xFFCBD5E1)),
          ),
          child: Obx(
            () => Column(
              children: [
                MobileServiceOption(
                  label: 'bKash',
                  service: MobileBankingService.bKash,
                  color: const Color(0xFFD82061),
                  isSelected:
                      controller.selectedMobileService.value ==
                      MobileBankingService.bKash,
                  onTap: () => controller.selectMobileService(
                    MobileBankingService.bKash,
                  ),
                ),
                SizedBox(height: 15.h),
                MobileServiceOption(
                  label: 'Nagad',
                  service: MobileBankingService.nagad,
                  color: const Color(0xFFF42A24),
                  isSelected:
                      controller.selectedMobileService.value ==
                      MobileBankingService.nagad,
                  onTap: () => controller.selectMobileService(
                    MobileBankingService.nagad,
                  ),
                ),
                SizedBox(height: 15.h),
                MobileServiceOption(
                  label: 'Rocket',
                  service: MobileBankingService.rocket,
                  color: const Color(0xFF863390),
                  isSelected:
                      controller.selectedMobileService.value ==
                      MobileBankingService.rocket,
                  onTap: () => controller.selectMobileService(
                    MobileBankingService.rocket,
                  ),
                ),
                SizedBox(height: 15.h),
                MobileServiceOption(
                  label: 'Upay',
                  service: MobileBankingService.upay,
                  color: const Color(0xFFFF911A),
                  isSelected:
                      controller.selectedMobileService.value ==
                      MobileBankingService.upay,
                  onTap: () =>
                      controller.selectMobileService(MobileBankingService.upay),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),

        // Selected Service Form
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: Color(0xFFCBD5E1)),
          ),
          child: Obx(
            () => Column(
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: _getServiceColor(
                      controller.selectedMobileService.value,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone_android,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  '${_getServiceName(controller.selectedMobileService.value)} Payment',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: _getServiceColor(
                      controller.selectedMobileService.value,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: FieldLabel(label: "Mobile Number:"),
                ),
                CustomTextField(
                  borderRadius: 6.r,
                  controller: controller.mobileNumberController,
                  hintText: '1XXXXXXXXX',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Container(
                    width: 60.w,
                    alignment: Alignment.center,
                    child: Text(
                      '+880',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  borderColor: Color(0xFFCBD5E1),
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: FieldLabel(label: "Account Holder Name:"),
                ),
                CustomTextField(
                  borderRadius: 6.r,
                  controller: controller.accountHolderNameController,
                  hintText: 'Enter your name',
                  backgroundColor: Colors.white,
                  borderColor: Color(0xFFCBD5E1),
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: FieldLabel(label: "Amount:"),
                ),
                CustomTextField(
                  borderRadius: 6.r,
                  controller: controller.amountController,
                  hintText: '0.00',
                  keyboardType: TextInputType.number,
                  prefixIcon: Container(
                    width: 40.w,
                    alignment: Alignment.center,
                    child: Text(
                      '৳',
                      style: getTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  borderColor: Color(0xFFCBD5E1),
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: FieldLabel(label: "Pin Number:"),
                ),
                CustomTextField(
                  borderRadius: 6.r,
                  controller: controller.pinNumberController,
                  hintText: '****',
                  isPasswordField: true,
                  keyboardType: TextInputType.number,
                  backgroundColor: Colors.white,
                  borderColor: Color(0xFFCBD5E1),
                ),
                SizedBox(height: 20.h),

                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Text(
                    'You will receive a payment request notification. Please complete the payment within 5 minutes.',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF334155),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getServiceName(MobileBankingService service) {
    switch (service) {
      case MobileBankingService.bKash:
        return 'bKash';
      case MobileBankingService.nagad:
        return 'Nagad';
      case MobileBankingService.rocket:
        return 'Rocket';
      case MobileBankingService.upay:
        return 'Upay';
    }
  }

  Color _getServiceColor(MobileBankingService service) {
    switch (service) {
      case MobileBankingService.bKash:
        return const Color(0xFFD82061);
      case MobileBankingService.nagad:
        return const Color(0xFFF42A24);
      case MobileBankingService.rocket:
        return const Color(0xFF863390);
      case MobileBankingService.upay:
        return const Color(0xFFFF911A);
    }
  }
}
