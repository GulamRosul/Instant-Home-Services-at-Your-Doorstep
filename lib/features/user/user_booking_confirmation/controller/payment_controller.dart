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

  // Payment Flow Variables
  var bookingId = ''.obs;
  var amount = 0.obs;
  var isPaymentProcessing = false.obs;
  var paymentError = ''.obs;
  var gatewayUrl = ''.obs;

  // Toggle: 0 for Card Payment, 1 for Mobile Banking
  var selectedPaymentMethodType = 0.obs;

  // Gateway: 'mastercard' or 'visa'
  var selectedGateway = 'mastercard'.obs;
  var selectedMobileGateway = 'bkash'.obs;

  // Mobile Banking Controllers
  final mobileNumberController = TextEditingController();
  final accountHolderController = TextEditingController();
  final amountController = TextEditingController();
  final pinController = TextEditingController();

  // Text Controllers
  final promoController = TextEditingController();
  final cardNumberController = TextEditingController();
  final countryController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();
  final zipController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializePayment();
  }

  void initializePayment() {
    try {
      final args = Get.arguments;
      if (args != null && args is Map) {
        bookingId.value = args['bookingId'] ?? '';
        amount.value = args['amount'] ?? 0;
        amountController.text = amount.value.toString();
      }
    } catch (e) {
      paymentError.value = 'Failed to load booking details';
    }
  }

  void setMobileGateway(String gateway) {
    selectedMobileGateway.value = gateway;
  }

  // Update Payment Method Type (Card / Mobile)
  void setPaymentMethodType(int index) {
    selectedPaymentMethodType.value = index;
  }

  // Update Gateway (Mastercard / Visa)
  void setGateway(String gateway) {
    selectedGateway.value = gateway;
  }

  void applyPromoCode() {
    Get.snackbar(
      "Success",
      "Promo code applied!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Future<void> makePayment() async {
    final amountValue = double.tryParse(amountController.text) ?? 0;

    if (bookingId.isEmpty || amountValue == 0) {
      Get.snackbar(
        'Error',
        'Booking information missing',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isPaymentProcessing.value = true;
    paymentError.value = '';

    try {
      final payload = {'bookingId': bookingId.value, 'amount': amountValue};

      // Get the auth token
      final token = await SecureStorageService.getToken();
      if (token == null) {
        paymentError.value = 'Authentication required. Please login again.';
        Get.snackbar(
          'Error',
          paymentError.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isPaymentProcessing.value = false;
        return;
      }

      // Add Authorization header
      final options = Options(headers: {'Authorization': 'Bearer $token'});

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.makePayment,
        data: payload,
        options: options,
      );

      // Debug: Log the payment response
      debugPrint('Payment Response Status: ${response.statusCode}');
      debugPrint('Payment Response Data: ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        debugPrint('Payment data structure: $data');
        if (data != null &&
            data['data'] != null &&
            data['data']['gatewayUrl'] != null) {
          gatewayUrl.value = data['data']['gatewayUrl'];
          debugPrint('Gateway URL: ${gatewayUrl.value}');
          // Navigate to WebView screen
          await Get.to(() => const PaymentWebViewScreen());
        } else {
          paymentError.value = 'Failed to get payment gateway URL';
          debugPrint('Error: Missing gateway URL in response');
          Get.snackbar(
            'Error',
            paymentError.value,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        paymentError.value =
            response.data?['message'] ?? 'Payment initialization failed';
        debugPrint(
          'Payment Error: $paymentError with status ${response.statusCode}',
        );
        Get.snackbar(
          'Error',
          paymentError.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      paymentError.value = e.message ?? 'Network error occurred';
      debugPrint('DioException: ${e.message}');
      debugPrint('DioException Type: ${e.type}');
      debugPrint('DioException Response: ${e.response?.data}');
      Get.snackbar(
        'Error',
        paymentError.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      paymentError.value = 'An unexpected error occurred';
      debugPrint('Unexpected Error: $e');
      debugPrint('Error Stack Trace: ${StackTrace.current}');
      Get.snackbar(
        'Error',
        paymentError.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isPaymentProcessing.value = false;
    }
  }

  void handlePaymentSuccess() {
    Get.dialog(
      BookingSuccessDialog(
        message: 'Payment successful! Your booking has been confirmed.',
      ),
      barrierDismissible: false,
    );

    Future<void>.delayed(const Duration(seconds: 3), () {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.offAll(() => const MainNavigationScreen());
    });
  }

  // Temporary method for proceedToCheckout - will call makePayment
  Future<void> proceedToCheckout() async {
    await makePayment();
  }

  @override
  void onClose() {
    promoController.dispose();
    cardNumberController.dispose();
    countryController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    zipController.dispose();
    mobileNumberController.dispose();
    accountHolderController.dispose();
    amountController.dispose();
    pinController.dispose();
    super.onClose();
  }
}
