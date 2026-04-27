import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/user/authentication/screen/user_otp_screen.dart';

class ProviderForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  RxString emailError = ''.obs;
  RxBool isLoading = false.obs;

  bool _validateEmail() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      emailError.value = 'Please enter a valid email';
      return false;
    }

    emailError.value = '';
    return true;
  }

  Future<void> handleForgotPassword() async {
    if (!_validateEmail()) {
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiClient().post(
        ApiEndpoints.forgotPassword,
        data: {'email': emailController.text.trim()},
      );

      developer.log(
        '📧 Forgot Password Response: ${response.statusCode}',
        name: 'ProviderForgotPasswordController',
      );

      if (response.statusCode == 200) {
        developer.log(
          '✅ OTP sent successfully to email',
          name: 'ProviderForgotPasswordController',
        );

        Get.snackbar(
          'Success',
          'OTP sent to your email',
          snackPosition: SnackPosition.BOTTOM,
        );

        // Store the email in storage for OTP verification later
        await StorageService.saveForgotPasswordEmail(
          emailController.text.trim(),
        );

        // Navigate to OTP screen
        Get.to(
          () => UserOtpScreen(
            email: emailController.text.trim(),
            isForgotPassword: true,
            fromProvider: true,
          ),
          transition: Transition.rightToLeft,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to send OTP. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      developer.log(
        '❌ Forgot Password Error: $e',
        name: 'ProviderForgotPasswordController',
      );
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
