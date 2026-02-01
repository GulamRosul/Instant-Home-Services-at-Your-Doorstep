import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/service_provider/wallet/screen/confirm_withdrawal_screen.dart';

class WalletController extends GetxController {
  var totalEarnings = "12,450.50".obs;
  var pendingAmount = "850.00".obs;

  var withdrawalHistory = [
    {"amount": "5,000.00", "date": "Jan 10, 2026", "status": "Completed"},
    {"amount": "3,000.00", "date": "Jan 5, 2026", "status": "Completed"},
  ].obs;

  var withdrawalAmount = "0.00".obs;
  var accountNumber = "".obs;
  var selectedPercentage = 0.obs; // 25, 50, 75, 100

  void setPercentage(int percentage) {
    selectedPercentage.value = percentage;
    double balance = double.parse(totalEarnings.value.replaceAll(',', ''));
    withdrawalAmount.value = (balance * (percentage / 100)).toStringAsFixed(2);
  }

  void handleWithdrawFunds() {
    // Logic for withdrawing funds
    Get.snackbar("Success", "Withdrawal request submitted");
  }

  void goToConfirmation() {
    if (accountNumber.value.isEmpty) {
      Get.snackbar("Error", "Please enter bank account number");
      return;
    }
    Get.find<ProviderNavbarController>().showHomeSubPage(
      const ConfirmWithdrawalScreen(),
    );
  }

  void handleContinueWithdrawal() {
    goToConfirmation();
  }
}
