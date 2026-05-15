import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/service_provider/wallet/model/withdraw_request_model.dart';
import 'package:protiva502/features/service_provider/wallet/screen/confirm_withdrawal_screen.dart';
import 'package:protiva502/features/service_provider/wallet/screen/pending_approval_screen.dart';

class WalletController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  TextEditingController withdrawalAmountController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();

  // New Controllers
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  var isWalletLoading = false.obs;
  var walletErrorMessage = ''.obs;
  var totalEarnings = "0.00".obs;
  var pendingAmount = "0.00".obs;
  var bookingsServed = "0/0".obs;
  var isSubmittingWithdrawal = false.obs;
  var submitErrorMessage = ''.obs;
  var requestStatus = 'Pending'.obs;
  var requestDateLabel = ''.obs;

  var withdrawalHistory = <WithdrawRequestModel>[].obs;

  var withdrawalAmount = "0.00".obs;
  var accountNumber = "".obs;
  var selectedPercentage = 0.obs; // 25, 50, 75, 100

  // New Reactive Variables
  var selectedPaymentMethod =
      "Mobile Banking".obs; // 'Card Payment' or 'Mobile Banking'
  var selectedMobileService = "bKash".obs; // 'bKash', 'Nagad', 'Rocket', 'Upay'

  double get enteredAmountValue =>
      double.tryParse(withdrawalAmountController.text.trim()) ?? 0;

  double get feeAmount => selectedPaymentMethod.value == 'Card Payment' ? 0 : 0;

  double get netAmount {
    final value = enteredAmountValue;
    return value < 0 ? 0 : value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchWalletOverview();
  }

  Future<void> fetchWalletOverview() async {
    try {
      isWalletLoading.value = true;
      walletErrorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        walletErrorMessage.value = 'Provider token not found';
        return;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.providerWallet,
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Wallet screen request => ${ApiEndpoints.baseUrl}${ApiEndpoints.providerWallet}',
      );
      debugPrint('Wallet screen status => ${response.statusCode}');
      debugPrint('Wallet screen response => ${response.data}');

      if (response.statusCode != 200) {
        walletErrorMessage.value = 'Failed to load wallet data';
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final data = _asMap(responseMap['data']) ?? <String, dynamic>{};
      final walletData = _asMap(data['data']) ?? <String, dynamic>{};
      final withdraw = _asMap(walletData['withdraw']) ?? <String, dynamic>{};
      final withdrawAble =
          _asMap(withdraw['totalWithdraeAbleAmount']) ??
          _asMap(withdraw['totalWithdrawaAbleAmount']) ??
          _asMap(withdraw['totalWithdrawAbleAmount']) ??
          _asMap(withdraw['totalWithdrawalAbleAmount']) ??
          <String, dynamic>{};
      final booking = _asMap(walletData['booking']) ?? <String, dynamic>{};

      totalEarnings.value = _formatAmount(withdrawAble['amount']);
      pendingAmount.value = _formatAmount(withdraw['totalPendingAmount']);
      bookingsServed.value =
          '${booking['totalBookingServed'] ?? 0}/${booking['totalBooking'] ?? 0}';

      withdrawalHistory.assignAll([
        WithdrawRequestModel(
          amount: _formatAmount(withdraw['totalWithdrawAmount']),
          dateLabel: 'total_withdraw_request'.tr,
          status: 'processed'.tr,
        ),
        WithdrawRequestModel(
          amount: _formatAmount(withdraw['totalPendingAmount']),
          dateLabel: 'pending_withdraw'.tr,
          status: 'pending'.tr,
        ),
      ]);
    } on DioException catch (_) {
      walletErrorMessage.value = 'Failed to load wallet data';
    } catch (_) {
      walletErrorMessage.value = 'Failed to load wallet data';
    } finally {
      isWalletLoading.value = false;
    }
  }

  String _formatAmount(dynamic value) {
    final parsed = double.tryParse(value?.toString() ?? '') ?? 0;
    return parsed.toStringAsFixed(2);
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return value.map((key, item) => MapEntry(key.toString(), item));
    }

    return null;
  }

  void setPercentage(int percentage) {
    selectedPercentage.value = percentage;
    double balance = double.parse(totalEarnings.value.replaceAll(',', ''));
    withdrawalAmount.value = (balance * (percentage / 100)).toStringAsFixed(2);
    withdrawalAmountController.text = withdrawalAmount.value;
    submitErrorMessage.value = '';
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
    submitErrorMessage.value = '';
  }

  void selectMobileService(String service) {
    selectedMobileService.value = service;
    submitErrorMessage.value = '';
  }

  void handleWithdrawFunds() {
    // Logic for withdrawing funds
    Get.snackbar("success".tr, "withdrawal_request_submitted".tr);
  }

  void goToConfirmation() {
    final amount = enteredAmountValue;
    if (amount <= 0) {
      Get.snackbar("Error".tr, "please_enter_valid_withdrawal_amount".tr);
      return;
    }

    if (selectedPaymentMethod.value == "Mobile Banking") {
      if (phoneNumberController.text.isEmpty) {
        Get.snackbar(
          "Error".tr,
          "Please enter your ${selectedMobileService.value} number".tr,
        );
        return;
      }
      if (pinController.text.isEmpty) {
        Get.snackbar("error".tr, "please_enter_your_payment_take_number".tr);
        return;
      }
    } else {
      if (accountNumberController.text.isEmpty) {
        Get.snackbar("error".tr, "please_enter_bank_account_number".tr);
        return;
      }
      if (bankNameController.text.isEmpty) {
        Get.snackbar("error".tr, "please_enter_bank_name".tr);
        return;
      }
      if (branchNameController.text.isEmpty) {
        Get.snackbar("error".tr, "please_enter_branch_name".tr);
        return;
      }
      if (accountHolderNameController.text.isEmpty) {
        Get.snackbar("error".tr, "please_enter_account_holder_name".tr);
        return;
      }
      if (phoneNumberController.text.isEmpty) {
        Get.snackbar("error".tr, "please_enter_phone_number".tr);
        return;
      }
    }

    // Update observable variables for the next screen
    accountNumber.value = selectedPaymentMethod.value == "Mobile Banking"
        ? phoneNumberController.text
        : accountNumberController.text;
    withdrawalAmount.value = withdrawalAmountController.text;
    submitErrorMessage.value = '';

    Get.find<ProviderNavbarController>().showHomeSubPage(
      const ConfirmWithdrawalScreen(),
    );
  }

  void handleContinueWithdrawal() {
    goToConfirmation();
  }

  Future<void> submitWithdrawalRequest() async {
    try {
      isSubmittingWithdrawal.value = true;
      submitErrorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        submitErrorMessage.value = 'Provider token not found';
        Get.snackbar('Error', submitErrorMessage.value);
        return;
      }

      final isCard = selectedPaymentMethod.value == 'Card Payment';
      final path = isCard
          ? ApiEndpoints.withdrawCard
          : ApiEndpoints.withdrawMobileBanking;

      final body = isCard
          ? <String, dynamic>{
              'amount': enteredAmountValue.toInt(),
              'fee': feeAmount.toInt(),
              'netAmount': netAmount.toInt(),
              'bankName': bankNameController.text.trim(),
              'accountNumber': accountNumberController.text.trim(),
              'accountHolderName': accountHolderNameController.text.trim(),
              'branchName': branchNameController.text.trim(),
              'phoneNumber': phoneNumberController.text.trim(),
            }
          : <String, dynamic>{
              'amount': enteredAmountValue.toInt(),
              'fee': feeAmount.toInt(),
              'netAmount': netAmount.toInt(),
              'mobileBankingPaymentTakeNumber': pinController.text.trim(),
              'mobileBankingType': selectedMobileService.value.toUpperCase(),
              'phoneNumber': phoneNumberController.text.trim(),
            };

      debugPrint('Withdraw request path => ${ApiEndpoints.baseUrl}$path');
      debugPrint('Withdraw request body => $body');

      final response = await _apiClient.post<dynamic>(
        path,
        data: body,
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint('Withdraw request status => ${response.statusCode}');
      debugPrint('Withdraw request response => ${response.data}');

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final message =
          responseMap['message']?.toString() ?? 'Withdraw request failed';

      if (response.statusCode != 200 && response.statusCode != 201) {
        submitErrorMessage.value = message;
        Get.snackbar('reminder'.tr, message);
        return;
      }

      requestStatus.value = 'Pending';
      requestDateLabel.value = _formatToday();
      // Get.snackbar('success'.tr, message);
      await fetchWalletOverview();
      Get.find<ProviderNavbarController>().showHomeSubPage(
        const PendingApprovalScreen(),
      );
    } on DioException catch (error) {
      final message =
          _asMap(error.response?.data)?['message']?.toString() ??
          'Withdraw request failed';
      submitErrorMessage.value = message;
      Get.snackbar('error'.tr, message);
    } catch (_) {
      submitErrorMessage.value = 'Withdraw request failed';
      Get.snackbar('error'.tr, submitErrorMessage.value);
    } finally {
      isSubmittingWithdrawal.value = false;
    }
  }

  String _formatToday() {
    final now = DateTime.now();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }
}
