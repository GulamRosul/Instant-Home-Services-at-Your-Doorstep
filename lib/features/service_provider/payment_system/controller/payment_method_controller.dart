import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PaymentType { cardPayment, mobileBanking }

enum PaymentGateway { mastercard, visa }

enum MobileBankingService { bKash, nagad, rocket, upay }

class PaymentMethodController extends GetxController {
  final selectedPaymentType = PaymentType.cardPayment.obs;
  final selectedGateway = PaymentGateway.mastercard.obs;
  final selectedMobileService = MobileBankingService.bKash.obs;

  // Card Payment Controllers
  final cardNumberController = TextEditingController();
  final countryController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();
  final zipController = TextEditingController();

  // Mobile Banking Controllers
  final mobileNumberController = TextEditingController();
  final accountHolderNameController = TextEditingController();
  final amountController = TextEditingController();
  final pinNumberController = TextEditingController();

  /// Show green check on card number when valid (e.g. length >= 16).
  final isCardNumberValid = false.obs;

  final List<String> countries = ['Bangladesh', 'Canada', 'USA', 'UK', 'India'];
  final selectedCountry = Rx<String?>(null);

  void selectCardPayment() =>
      selectedPaymentType.value = PaymentType.cardPayment;
  void selectMobileBanking() =>
      selectedPaymentType.value = PaymentType.mobileBanking;

  void selectMastercard() => selectedGateway.value = PaymentGateway.mastercard;
  void selectVisa() => selectedGateway.value = PaymentGateway.visa;

  void selectMobileService(MobileBankingService service) =>
      selectedMobileService.value = service;

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
    mobileNumberController.dispose();
    accountHolderNameController.dispose();
    amountController.dispose();
    pinNumberController.dispose();
    super.onClose();
  }
}
