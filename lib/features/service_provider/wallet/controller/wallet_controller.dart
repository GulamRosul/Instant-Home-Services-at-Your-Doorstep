import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/service_provider/wallet/screen/confirm_withdrawal_screen.dart';

class WalletController extends GetxController {
  TextEditingController withdrawalAmountController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();

  // New Controllers
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  var totalEarnings = "11,500.50".obs; // Updated to match screenshot
  var pendingAmount = "850.00".obs;

  var withdrawalHistory = [
    {"amount": "5,000.00", "date": "Jan 10, 2026", "status": "Completed"},
    {"amount": "3,000.00", "date": "Jan 5, 2026", "status": "Completed"},
  ].obs;

  var withdrawalAmount = "0.00".obs;
  var accountNumber = "".obs;
  var selectedPercentage = 0.obs; // 25, 50, 75, 100

  // New Reactive Variables
  var selectedPaymentMethod =
      "Mobile Banking".obs; // 'Card Payment' or 'Mobile Banking'
  var selectedMobileService = "bKash".obs; // 'bKash', 'Nagad', 'Rocket', 'Upay'

  void setPercentage(int percentage) {
    selectedPercentage.value = percentage;
    double balance = double.parse(totalEarnings.value.replaceAll(',', ''));
    withdrawalAmount.value = (balance * (percentage / 100)).toStringAsFixed(2);
    withdrawalAmountController.text = withdrawalAmount.value;
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void selectMobileService(String service) {
    selectedMobileService.value = service;
  }

  void handleWithdrawFunds() {
    // Logic for withdrawing funds
    Get.snackbar("Success", "Withdrawal request submitted");
  }

  void goToConfirmation() {
    if (selectedPaymentMethod.value == "Mobile Banking") {
      if (phoneNumberController.text.isEmpty) {
        Get.snackbar(
          "Error",
          "Please enter your ${selectedMobileService.value} number",
        );
        return;
      }
      if (pinController.text.isEmpty) {
        Get.snackbar("Error", "Please enter your PIN");
        return;
      }
    } else {
      if (accountNumberController.text.isEmpty) {
        Get.snackbar("Error", "Please enter bank account number");
        return;
      }
    }

    // Update observable variables for the next screen
    accountNumber.value = selectedPaymentMethod.value == "Mobile Banking"
        ? phoneNumberController.text
        : accountNumberController.text;
    withdrawalAmount.value = withdrawalAmountController.text;

    Get.find<ProviderNavbarController>().showHomeSubPage(
      const ConfirmWithdrawalScreen(),
    );
  }

  void handleContinueWithdrawal() {
    goToConfirmation();
  }
}
