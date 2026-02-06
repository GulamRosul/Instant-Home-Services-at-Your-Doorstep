import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart'; // Adjust path
import 'package:protiva502/core/common/widgets/custom_appbar.dart'; // Adjust path
import 'package:protiva502/core/common/widgets/custom_button.dart'; // Adjust path
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/user_booking_confirmation/controller/payment_controller.dart';
import 'package:protiva502/features/user/user_booking_confirmation/widget/booking_step_progress.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: Colors.white, // Matches background
      appBar: const CustomAppBar(title: 'Book Service'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20.h),

            // 1. Custom Stepper
            const BookingStepProgress(currentStep: 3),
            SizedBox(height: 24.h),

            // 2. Payment Method Toggle
            Text(
              "Payment Method",
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "On platform destination charge to provider apply 10%",
              style: getTextStyle(
                fontSize: 14.sp,
                color: Colors.black.withValues(alpha: 0.8),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.h),
            Obx(() => _buildPaymentMethodToggle(controller)),

            SizedBox(height: 24.h),

            // 3. Promo Code
            Text(
              "Have a Promo Code?",
              style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            _buildPromoCodeField(controller),

            SizedBox(height: 24.h),

            // 4. Gateway Selection

            // _buildGatewaySelector(controller),
            SizedBox(height: 5.h),

            // 5. Card Details Form
            // Inside the Column in build()
            Obx(
              () => controller.selectedPaymentMethodType.value == 0
                  ? _buildCardForm(controller)
                  : _buildMobileBankingForm(controller), // New Mobile View
            ),

            SizedBox(height: 30.h),

            // 6. Checkout Button
            CustomButton(
              text: "Go To Checkout",
              onPressed: controller.proceedToCheckout,
              backgroundColor: const Color(0xFF1E293B), // Dark Navy
              textColor: Colors.white,
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Book Service",
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            lineHeight: 15.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Book Your Service in Just a Few Clicks",
          style: getTextStyle(
            fontSize: 12.sp,
            color: AppColors.textSecondary,
            lineHeight: 15.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodToggle(PaymentController controller) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => controller.setPaymentMethodType(0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: controller.selectedPaymentMethodType.value == 0
                    ? const Color(0xFF2C3E50)
                    : Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.credit_card,
                    size: 18.sp,
                    color: controller.selectedPaymentMethodType.value == 0
                        ? Colors.white
                        : Colors.grey[700],
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Card Payment",
                    style: getTextStyle(
                      color: controller.selectedPaymentMethodType.value == 0
                          ? Colors.white
                          : (Colors.grey[700] ?? Colors.grey),
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GestureDetector(
            onTap: () => controller.setPaymentMethodType(1),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: controller.selectedPaymentMethodType.value == 1
                    ? const Color(0xFF2C3E50)
                    : Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_android,
                    size: 18.sp,
                    color: controller.selectedPaymentMethodType.value == 1
                        ? Colors.white
                        : const Color.fromARGB(255, 97, 97, 97),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Mobile Banking",
                    style: getTextStyle(
                      color: controller.selectedPaymentMethodType.value == 1
                          ? Colors.white
                          : (Colors.grey[700] ?? Colors.grey),
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCodeField(PaymentController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.defaultBorder),
      ),
      padding: EdgeInsets.only(left: 12.w, right: 6.w, top: 2.h, bottom: 2.h),
      child: Row(
        children: [
          Icon(
            Icons.local_offer_outlined,
            color: AppColors.primary,
            size: 20.sp,
          ),
          Expanded(
            child: CustomTextField(
              controller: controller.promoController,
              hintText: "Enter promo code",
              backgroundColor: Colors.transparent,
              borderColor: Colors.white,
            ),
          ),

          ElevatedButton(
            onPressed: controller.applyPromoCode,
            style:
                ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  minimumSize: Size(0, 32.h),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  side: WidgetStateProperty.all(BorderSide.none),
                ),
            child: Text(
              "Apply",
              style: getTextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGatewaySelector(PaymentController controller) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Obx(
        () => Column(
          children: [
            _buildGatewayOption(
              controller,
              value: 'mastercard',
              label: 'Pay With Mastercard',
              // Replace with actual asset if available
              // icon: Icon(Icons.credit_card, color: Colors.orange, size: 24.sp),
              // icon: AssetImage(ImagePath.master)
              imagePath: AssetImage(ImagePath.master),
            ),
            SizedBox(height: 12.h),
            _buildGatewayOption(
              controller,
              value: 'visa',
              label: 'Pay With Visa card',
              // icon: Icon(Icons.credit_card, color: Colors.blue, size: 24.sp),
              imagePath: AssetImage(ImagePath.visa),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGatewayOption(
    PaymentController controller, {
    required String value,
    required String label,
    required ImageProvider imagePath,
  }) {
    bool isSelected = controller.selectedGateway.value == value;
    return GestureDetector(
      onTap: () => controller.setGateway(value),
      child: Row(
        children: [
          Container(
            height: 20.w,
            width: 20.w,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
              border: Border.all(
                color: isSelected ? const Color(0xFF2C3E50) : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: isSelected
                ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                : null,
          ),
          SizedBox(width: 12.w),
          Image(image: imagePath, height: 24.sp, width: 24.sp),
          SizedBox(width: 12.w),
          Text(
            label,
            style: getTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardForm(PaymentController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Choose Your Payment Gateway:",
              style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _buildGatewaySelector(controller),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                // Use Image.asset if you have the Mastercard logo
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white, // Mastercard dark blue background
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Image.asset(
                    ImagePath.master,
                    height: 50.sp,
                    width: 110.sp,
                  ),
                ),
              ),

              // SizedBox(height: 20.h),
              _buildInputLabel("Card Number:"),

              // _buildTextField(
              //   controller.cardNumberController,
              //   "01234 5678 9100",
              //   suffixIcon: Icon(
              //     Icons.check_circle_outline,
              //     color: Colors.green,
              //     size: 18.sp,
              //   ),
              // ),
              CustomTextField(
                controller: controller.cardNumberController,
                hintText: "01234 5678 9100",
                backgroundColor: const Color(0xFFF1F5F9).withOpacity(0.5),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.3),
                suffixIcon: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 18.sp,
                ),
              ),
              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputLabel("Country:"),
                        // _buildTextField(
                        //   controller.countryController,
                        //   "Select Country",
                        // ),
                        CustomTextField(
                          controller: controller.countryController,
                          hintText: "Select Country",
                          backgroundColor: const Color(
                            0xFFF1F5F9,
                          ).withOpacity(0.5),
                          borderColor: AppColors.defaultBorder.withValues(
                            alpha: 0.3,
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
                        _buildInputLabel("Expiry Date:"),
                        CustomTextField(
                          controller: controller.expiryController,
                          hintText: "MM/YY",
                          backgroundColor: const Color(
                            0xFFF1F5F9,
                          ).withOpacity(0.5),
                          borderColor: AppColors.defaultBorder.withValues(
                            alpha: 0.3,
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
                        _buildInputLabel("CVC:"),
                        CustomTextField(
                          controller: controller.cvcController,
                          hintText: "123",
                          backgroundColor: const Color(
                            0xFFF1F5F9,
                          ).withOpacity(0.5),
                          borderColor: AppColors.defaultBorder.withValues(
                            alpha: 0.3,
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
                        _buildInputLabel("ZIP:"),
                        CustomTextField(
                          controller: controller.zipController,
                          hintText: "12345",
                          backgroundColor: const Color(
                            0xFFF1F5F9,
                          ).withOpacity(0.5),
                          borderColor: AppColors.defaultBorder.withValues(
                            alpha: 0.3,
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
      ],
    );
  }

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileBankingForm(PaymentController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Your Mobile Banking Service:",
          style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12.h),
        _buildMobileGatewaySelector(controller),
        SizedBox(height: 24.h),

        // Dynamic Form based on selection
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              // Dynamic Logo and Title
              Obx(
                () => Column(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: _getGatewayColor(
                        controller.selectedMobileGateway.value,
                      ),
                      child: Icon(
                        Icons.phone_android,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                      // Use Image.asset(ImagePath.bkashLogo) here for exact match
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "${controller.selectedMobileGateway.value.capitalizeFirst} Payment",
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: _getGatewayColor(
                          controller.selectedMobileGateway.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              _buildInputLabel("Mobile Number:"),
              CustomTextField(
                controller: controller.mobileNumberController,
                hintText: "+880 1XXXXXXXXX",
                backgroundColor: const Color(0xFFF1F5F9).withOpacity(0.5),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.3),
              ),

              SizedBox(height: 16.h),
              _buildInputLabel("Account Holder Name:"),
              CustomTextField(
                controller: controller.accountHolderController,
                hintText: "Enter your name",
                backgroundColor: const Color(0xFFF1F5F9).withOpacity(0.5),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.3),
              ),

              SizedBox(height: 16.h),
              _buildInputLabel("Amount:"),
              CustomTextField(
                controller: controller.amountController,
                hintText: "৳ 0.00",
                backgroundColor: const Color(0xFFF1F5F9).withOpacity(0.5),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.3),
              ),

              SizedBox(height: 16.h),
              _buildInputLabel("Pin Number:"),
              CustomTextField(
                controller: controller.pinController,
                hintText: "****",
                isPasswordField: true,
                backgroundColor: const Color(0xFFF1F5F9).withOpacity(0.5),
                borderColor: AppColors.defaultBorder.withValues(alpha: 0.3),
              ),

              SizedBox(height: 16.h),
              // Instruction Box
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "You will receive a payment request notification. Please complete the payment within 5 minutes.",
                  style: getTextStyle(fontSize: 12.sp, color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileGatewaySelector(PaymentController controller) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Obx(
        () => Column(
          children: [
            _buildMobileOption(
              controller,
              'bkash',
              'bKash',
              const Color(0xFFD12053),
            ),
            _buildMobileOption(
              controller,
              'nagad',
              'Nagad',
              const Color(0xFFED1C24),
            ),
            _buildMobileOption(
              controller,
              'rocket',
              'Rocket',
              const Color(0xFF8C3494),
            ),
            _buildMobileOption(
              controller,
              'upay',
              'Upay',
              const Color(0xFFF7941D),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileOption(
    PaymentController controller,
    String value,
    String label,
    Color color,
  ) {
    bool isSelected = controller.selectedMobileGateway.value == value;
    return GestureDetector(
      onTap: () => controller.setMobileGateway(value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Container(
              height: 18.w,
              width: 18.w,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
                border: Border.all(
                  color: isSelected ? const Color(0xFF2C3E50) : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 12.w),
            // Placeholder for Logo
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.r),
              ),
              alignment: Alignment.center,
              child: Text(
                label[0],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: getTextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Color _getGatewayColor(String gateway) {
    switch (gateway) {
      case 'bkash':
        return const Color(0xFFD12053);
      case 'nagad':
        return const Color(0xFFED1C24);
      case 'rocket':
        return const Color(0xFF8C3494);
      case 'upay':
        return const Color(0xFFF7941D);
      default:
        return Colors.blue;
    }
  }
}
