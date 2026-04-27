import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';

class UserOtpController extends GetxController {
  // Timer variables
  RxInt secondsRemaining = 59.obs;
  Timer? _timer;

  // Loading state
  RxBool isLoading = false.obs;

  // OTP Input
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  // Email (passed from previous screen)
  late String email;

  // Forgot password flow flag
  RxBool isForgotPassword = false.obs;
  RxBool fromProvider = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void setEmail(String userEmail) {
    email = userEmail;
  }

  void setForgotPasswordFlow(bool isForgot) {
    isForgotPassword.value = isForgot;
  }

  void setFromProvider(bool isFromProvider) {
    fromProvider.value = isFromProvider;
  }

  void startTimer() {
    secondsRemaining.value = 600;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  String get timerText {
    final minutes = (secondsRemaining.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining.value % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  Future<void> verifyOtp() async {
    String otp = otpControllers.map((e) => e.text).join();

    if (otp.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter a valid 6-digit OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // If this is a forgot password flow, skip API verification and go to reset password
      if (isForgotPassword.value) {
        developer.log(
          '✅ OTP verified for password reset',
          name: 'UserOtpController',
        );

        Get.offNamed(
          '/userResetPasswordScreen',
          arguments: {
            'email': email,
            'otp': otp,
            'fromProvider': fromProvider.value,
          },
        );
        return;
      }

      // Normal signup/login OTP verification
      final response = await ApiClient().post(
        ApiEndpoints.verifyOTP,
        data: {'email': email, 'otp': otp},
      );

      developer.log(
        '🔐 OTP Verification Response: ${response.statusCode}',
        name: 'UserOtpController',
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data.containsKey('data')) {
          final userData = data['data'];

          // Extract tokens
          final accessToken = userData['accessToken'] ?? '';
          final refreshToken = userData['refreshToken'] ?? '';

          // Save tokens to secure storage
          if (accessToken.isNotEmpty) {
            await SecureStorageService.saveToken(accessToken);
          }
          if (refreshToken.isNotEmpty) {
            await SecureStorageService.saveRefreshToken(refreshToken);
          }

          // Save user data to storage
          final user = userData['user'];
          if (user is Map<String, dynamic>) {
            await StorageService.saveUser(
              userId: user['id'] ?? '',
              email: user['email'] ?? '',
              firstName: user['firstName'] ?? '',
              lastName: user['lastName'] ?? '',
              role: user['role'] ?? '',
            );

            // Mark user as logged in
            await StorageService.makeLoggedIn();

            developer.log(
              '✅ OTP Verified Successfully',
              name: 'UserOtpController',
            );

            Get.offAll(() => const MainNavigationScreen());
          }
        }
      } else {
        Get.snackbar(
          'Error',
          'OTP verification failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      developer.log('❌ OTP Verification Error: $e', name: 'UserOtpController');
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email not found. Please go back and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiClient().post(
        ApiEndpoints.resendOTP,
        data: {'email': email},
      );

      developer.log(
        '📧 Resend OTP Response: ${response.statusCode}',
        name: 'UserOtpController',
      );

      if (response.statusCode == 200) {
        // Reset timer and clear OTP fields
        for (var controller in otpControllers) {
          controller.clear();
        }
        startTimer();

        Get.snackbar(
          'Success',
          'OTP sent successfully',
          snackPosition: SnackPosition.BOTTOM,
        );

        developer.log('✅ OTP Resent Successfully', name: 'UserOtpController');
      } else {
        Get.snackbar(
          'Error',
          'Failed to resend OTP. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      developer.log('❌ Resend OTP Error: $e', name: 'UserOtpController');
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
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
