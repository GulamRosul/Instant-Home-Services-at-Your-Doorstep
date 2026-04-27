import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';

class UserResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxString newPasswordError = ''.obs;
  RxString confirmPasswordError = ''.obs;
  RxBool isLoading = false.obs;

  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  late String email;
  late String otp;
  late bool fromProvider;

  @override
  void onInit() {
    super.onInit();
    _extractArguments();
  }

  void _extractArguments() {
    final arguments = Get.arguments;
    if (arguments is Map) {
      email = arguments['email'] ?? '';
      otp = arguments['otp'] ?? '';
      fromProvider = arguments['fromProvider'] ?? false;
    }
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  bool _validatePasswords() {
    newPasswordError.value = '';
    confirmPasswordError.value = '';

    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword.isEmpty) {
      newPasswordError.value = 'Password is required';
      return false;
    }

    if (newPassword.length < 8) {
      newPasswordError.value = 'Password must be at least 8 characters';
      return false;
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      return false;
    }

    if (newPassword != confirmPassword) {
      confirmPasswordError.value = 'Passwords do not match';
      return false;
    }

    return true;
  }

  Future<void> handleResetPassword() async {
    if (!_validatePasswords()) {
      return;
    }

    if (email.isEmpty || otp.isEmpty) {
      Get.snackbar(
        'Error',
        'Invalid request. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiClient().post(
        ApiEndpoints.resetPassword,
        data: {
          'email': email,
          'otp': otp,
          'newPassword': newPasswordController.text.trim(),
        },
      );

      developer.log(
        '🔐 Reset Password Response: ${response.statusCode}',
        name: 'UserResetPasswordController',
      );

      if (response.statusCode == 200) {
        developer.log(
          '✅ Password reset successfully',
          name: 'UserResetPasswordController',
        );

        Get.snackbar(
          'Success',
          'Password reset successfully. Please login with your new password.',
          snackPosition: SnackPosition.BOTTOM,
        );

        // Clear forgot password email from storage
        await StorageService.clearForgotPasswordEmail();

        // Navigate to the appropriate login screen
        if (fromProvider) {
          Get.offNamedUntil('/providerLoginScreen', (route) => false);
        } else {
          Get.offNamedUntil('/userLoginScreen', (route) => false);
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to reset password. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      developer.log(
        '❌ Reset Password Error: $e',
        name: 'UserResetPasswordController',
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
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
