import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/widget/confirm_dialogue.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/payment_webview_screen.dart';

class PaymentController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Observable Variables
  var bookingId = ''.obs;
  var originalAmount = 0.0.obs; // Base price from arguments
  var isPaymentProcessing = false.obs;
  var isApplyingCoupon = false.obs;
  var gatewayUrl = ''.obs;
  
  // Controllers
  final amountController = TextEditingController();
  final couponController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializePayment();
  }

  void initializePayment() {
    final args = Get.arguments;
    if (args != null && args is Map) {
      bookingId.value = args['bookingId']?.toString() ?? '';
      double amt = double.tryParse(args['amount']?.toString() ?? '0') ?? 0.0;
      originalAmount.value = amt;
      amountController.text = amt.toStringAsFixed(2);
    }
  }

  // --- Coupon Logic ---
  Future<void> applyCoupon() async {
    if (couponController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter a coupon code", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isApplyingCoupon.value = true;
    try {
      // Replace with your actual coupon endpoint
      final response = await _apiClient.post(
        '${ApiEndpoints.makePayment}/apply-coupon', 
        data: {
          'bookingId': bookingId.value,
          'couponCode': couponController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        // Assuming API returns new total in data['discountedAmount']
        double newTotal = response.data['data']['discountedAmount'];
        amountController.text = newTotal.toStringAsFixed(2);
        Get.snackbar("Success", "Coupon applied successfully!", backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Invalid or expired coupon", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isApplyingCoupon.value = false;
    }
  }

  // --- Payment Logic ---
  Future<void> makePayment() async {
    final amountValue = double.tryParse(amountController.text) ?? 0;

    if (bookingId.isEmpty || amountValue <= 0) {
      Get.snackbar('Error', 'Invalid booking or amount', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isPaymentProcessing.value = true;

    try {
      final token = await SecureStorageService.getToken();
      final options = Options(headers: {'Authorization': 'Bearer $token'});

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.makePayment,
        data: {
          'bookingId': bookingId.value, 
          'amount': amountValue,
          'couponCode': couponController.text.trim(), // Send coupon if applied
        },
        options: options,
      );

      if ((response.statusCode == 201 || response.statusCode == 200) && response.data['data']?['gatewayUrl'] != null) {
        gatewayUrl.value = response.data['data']['gatewayUrl'];
        await Get.to(() => const PaymentWebViewScreen());
      } else {
        throw Exception(response.data?['message'] ?? 'Payment failed to initialize');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isPaymentProcessing.value = false;
    }
  }

  void handlePaymentSuccess() {
    Get.dialog(BookingSuccessDialog(message: 'Payment confirmed!'), barrierDismissible: false);
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const MainNavigationScreen());
    });
  }

  @override
  void onClose() {
    amountController.dispose();
    couponController.dispose();
    super.onClose();
  }
}