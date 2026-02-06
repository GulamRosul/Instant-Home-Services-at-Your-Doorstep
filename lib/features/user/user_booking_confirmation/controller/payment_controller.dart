import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
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

  void setMobileGateway(String gateway) {
    selectedMobileGateway.value = gateway;
  }

  // Text Controllers
  final promoController = TextEditingController();
  final cardNumberController = TextEditingController();
  final countryController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();
  final zipController = TextEditingController();

  // Update Payment Method Type (Card / Mobile)
  void setPaymentMethodType(int index) {
    selectedPaymentMethodType.value = index;
  }

  // Update Gateway (Mastercard / Visa)
  void setGateway(String gateway) {
    selectedGateway.value = gateway;
  }

  void applyPromoCode() {
    Get.snackbar("Success", "Promo code applied!", 
      snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
  }

  void proceedToCheckout() {
    // Navigate to Success Screen or Process Payment
    Get.snackbar("Processing", "Processing your payment...", 
      snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    promoController.dispose();
    cardNumberController.dispose();
    countryController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    zipController.dispose();
    super.onClose();
  }
}