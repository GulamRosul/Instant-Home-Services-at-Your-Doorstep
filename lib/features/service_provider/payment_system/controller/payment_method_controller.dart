import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PaymentType { cardPayment, mobileBanking }

enum PaymentGateway { mastercard, visa }

class PaymentMethodController extends GetxController {
  final selectedPaymentType = PaymentType.cardPayment.obs;
  final selectedGateway = PaymentGateway.mastercard.obs;

  final cardNumberController = TextEditingController();
  final countryController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();
  final zipController = TextEditingController();

  /// Show green check on card number when valid (e.g. length >= 16).
  final isCardNumberValid = false.obs;

  final List<String> countries = [
    'Bangladesh',
    'Canada',
    'USA',
    'UK',
    'India',
  ];
  final selectedCountry = Rx<String?>(null);

  void selectCardPayment() => selectedPaymentType.value = PaymentType.cardPayment;
  void selectMobileBanking() =>
      selectedPaymentType.value = PaymentType.mobileBanking;

  void selectMastercard() => selectedGateway.value = PaymentGateway.mastercard;
  void selectVisa() => selectedGateway.value = PaymentGateway.visa;

  void onCardNumberChanged(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    isCardNumberValid.value = digits.length >= 16;
  }

  void selectCountry(String? value) => selectedCountry.value = value;

  void handleCheckout() {
    // TODO: Validate and submit payment
    Get.back();
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    countryController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    zipController.dispose();
    super.onClose();
  }
}
