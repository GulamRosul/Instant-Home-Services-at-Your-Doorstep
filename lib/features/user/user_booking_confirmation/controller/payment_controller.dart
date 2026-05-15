import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/widget/confirm_dialogue.dart';
import 'package:protiva502/features/user/user_booking_confirmation/model/payment_models.dart';

class PaymentController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Observable Variables
  var bookingId = ''.obs;
  var originalAmount = 0.0.obs;
  var isPaymentProcessing = false.obs;
  var isApplyingCoupon = false.obs;
  var selectedCoupon = Rxn<CouponResponse>();
  var discountedAmount = 0.0.obs;

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
      discountedAmount.value = amt;
      amountController.text = amt.toStringAsFixed(2);
    }
  }

  // --- Coupon Logic ---
  Future<void> applyCoupon() async {
    if (couponController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a coupon code",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isApplyingCoupon.value = true;
    try {
      final couponCode = couponController.text.trim();
      final response = await _apiClient.post(
        ApiEndpoints.useCoupon(couponCode),
        data: {},
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data?['data']?['success'] == true) {
        final couponData = response.data['data']['data'];
        final coupon = CouponResponse.fromJson(
          couponData as Map<String, dynamic>,
        );

        // Calculate discount
        double discountAmount =
            (originalAmount.value * coupon.discountPercentage) / 100;
        double newTotal = originalAmount.value - discountAmount;

        selectedCoupon.value = coupon;
        discountedAmount.value = newTotal;
        amountController.text = newTotal.toStringAsFixed(2);

        debugPrint('✅ [COUPON] Applied: ${coupon.couponCode}');
        debugPrint('   Discount: ${coupon.discountPercentage}%');
        debugPrint('   Original: ৳${originalAmount.value}');
        debugPrint('   Discount Amount: ৳$discountAmount');
        debugPrint('   New Total: ৳$newTotal');

        // Get.snackbar(
        //   "Success",
        //   response.data['data']['message'] ?? "Coupon applied successfully!",
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
      } else {
        Get.snackbar(
          "Error",
          response.data?['data']?['message'] ?? "Invalid or expired coupon",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('❌ [COUPON] Error applying coupon: $e');
      Get.snackbar(
        "Error",
        "Failed to apply coupon",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isApplyingCoupon.value = false;
    }
  }

  void removeCoupon() {
    selectedCoupon.value = null;
    couponController.clear();
    discountedAmount.value = originalAmount.value;
    amountController.text = originalAmount.value.toStringAsFixed(2);
    debugPrint('🗑️ [COUPON] Coupon removed');
    Get.snackbar(
      "Info",
      "Coupon removed",
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  // --- Payment SDK Logic ---
  Future<void> makePayment() async {
    final amountValue = double.tryParse(amountController.text) ?? 0;

    if (bookingId.isEmpty || amountValue <= 0) {
      Get.snackbar(
        'Error',
        'Invalid booking or amount',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isPaymentProcessing.value = true;

    try {
      // Step 1: Initiate SDK payment
      final initResponse = await _initiateSDKPayment(
        bookingId.value,
        amountValue.toInt(),
      );

      if (initResponse != null) {
        // Step 2: Open SSL Commerz SDK with payment credentials
        await _openSSLCommerzSDK(initResponse);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isPaymentProcessing.value = false;
    }
  }

  Future<PaymentInitiateResponse?> _initiateSDKPayment(
    String bookingId,
    int amount,
  ) async {
    try {
      final request = PaymentInitiateRequest(
        bookingId: bookingId,
        amount: amount,
      );

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.initialSDK,
        data: request.toJson(),
      );

      if ((response.statusCode == 201 || response.statusCode == 200) &&
          response.data['data'] != null) {
        return PaymentInitiateResponse.fromJson(response.data['data']);
      } else {
        throw Exception(
          response.data?['message'] ?? 'Failed to initiate payment',
        );
      }
    } catch (e) {
      debugPrint('Error initiating SDK payment: $e');
      rethrow;
    }
  }

  Future<void> _openSSLCommerzSDK(PaymentInitiateResponse paymentData) async {
    try {
      var sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
          store_id: paymentData.storeId,
          store_passwd: paymentData.storePassword,
          total_amount: paymentData.amount.toDouble(),
          currency: SSLCurrencyType.BDT,
          tran_id: paymentData.transactionId,
          product_category: 'service',
          sdkType: paymentData.isSandbox
              ? SSLCSdkType.TESTBOX
              : SSLCSdkType.LIVE,
        ),
      );

      sslcommerz.addCustomerInfoInitializer(
        customerInfoInitializer: SSLCCustomerInfoInitializer(
          customerName: paymentData.customerName,
          customerEmail: paymentData.customerEmail,
          customerAddress1: paymentData.customerAddress,
          customerPhone: paymentData.customerPhone,
          customerCity: 'Dhaka',
          customerPostCode: '1000',
          customerCountry: 'Bangladesh',
          customerState: 'Dhaka',
        ),
      );

      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      debugPrint('💳 Payment Result:');
      debugPrint('   Status: ${result.status}');
      debugPrint('   Amount: ${result.amount}');
      debugPrint('   TranID: ${result.tranId}');
      debugPrint('   ValID: ${result.valId}');
      debugPrint('   Risk: ${result.riskTitle}');
      debugPrint('   Card Brand: ${result.cardBrand}');
      debugPrint('   Card Issuer: ${result.cardIssuer}');
      debugPrint('   Card Type: ${result.cardType}');

      final status = result.status?.toLowerCase() ?? '';
      if (status == 'success' || status == 'valid') {
        _handlePaymentSuccess(result, paymentData.transactionId);
      } else if (status == 'failed') {
        _handlePaymentFailed(result, paymentData.transactionId);
      } else if (status == 'closed') {
        _handlePaymentCancelled(result, paymentData.transactionId);
      } else {
        debugPrint('⚠️ Unknown payment status: $status');
        _handlePaymentFailed(result, paymentData.transactionId);
      }
    } catch (e) {
      debugPrint('Error opening SSL Commerz SDK: $e');
      Get.snackbar(
        'Error',
        'Failed to open payment gateway',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _handlePaymentSuccess(
    SSLCTransactionInfoModel result,
    String transactionId,
  ) async {
    try {
      debugPrint('Payment Success: ${result.status}');

      final valId = result.valId ?? transactionId;
      final confirmedAmount =
          num.tryParse(result.amount ?? '') ??
          (double.tryParse(amountController.text) ?? 0);

      final confirmRequest = PaymentConfirmRequest(
        valId: valId,
        tranId: transactionId,
        amount: confirmedAmount,
      );

      final confirmResponse = await _apiClient.post(
        ApiEndpoints.paymentConfirm,
        data: confirmRequest.toJson(),
      );

      if (confirmResponse.statusCode == 200 ||
          confirmResponse.statusCode == 201) {
        _showSuccessDialog();
        Get.offAll(() => const MainNavigationScreen());
        // Switch to bookings tab (index 1) after navigation
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final navController = Get.find<BottomNavController>();
          navController.changeTab(1);
        });
      } else {
        throw Exception(
          confirmResponse.data?['message'] ?? 'Failed to confirm payment',
        );
      }
    } catch (e) {
      debugPrint('Error confirming payment: $e');
      Get.snackbar(
        'Error',
        'Payment confirmation failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _handlePaymentFailed(
    SSLCTransactionInfoModel result,
    String transactionId,
  ) async {
    try {
      debugPrint('❌ Payment Failed: ${result.status}');
      debugPrint('   Risk Title: ${result.riskTitle}');
      debugPrint('   Amount: ${result.amount}');
      debugPrint('   Card Brand: ${result.cardBrand}');
      debugPrint('   Card Type: ${result.cardType}');

      // Use tranId from result if available, otherwise use transactionId from backend
      final actualTranId = result.tranId ?? transactionId;

      // Build meaningful error reason
      String errorReason = 'Payment declined';
      if (result.riskTitle != null && result.riskTitle!.isNotEmpty) {
        errorReason = result.riskTitle!;
      }

      final failRequest = PaymentFailRequest(
        transactionId: actualTranId,
        status: 'FAILED',
        reason: errorReason,
      );

      await _apiClient.post(
        ApiEndpoints.paymentFail,
        data: failRequest.toJson(),
      );

      Get.snackbar(
        'Payment Failed',
        'Your payment could not be processed: $errorReason',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Error handling payment failure: $e');
      Get.snackbar(
        'Error',
        'Payment failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _handlePaymentCancelled(
    SSLCTransactionInfoModel result,
    String transactionId,
  ) async {
    try {
      debugPrint('Payment Cancelled: ${result.status}');
      debugPrint('   TranID from SDK: ${result.tranId}');

      // Use tranId from result if available, otherwise use transactionId from backend
      final actualTranId = result.tranId ?? transactionId;

      final failRequest = PaymentFailRequest(
        transactionId: actualTranId,
        status: 'CANCELLED',
        reason: 'User cancelled the payment',
      );

      await _apiClient.post(
        ApiEndpoints.paymentFail,
        data: failRequest.toJson(),
      );

      Get.snackbar(
        'Payment Cancelled',
        'You cancelled the payment',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Error handling payment cancellation: $e');
    }
  }

  void _showSuccessDialog() {
    Get.dialog(
      BookingSuccessDialog(message: 'Payment confirmed!'),
      barrierDismissible: false,
    );
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
