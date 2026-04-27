import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/features/user/authentication/screen/user_profile_pic_screen.dart';

class UserRegController extends GetxController {
  UserRegController({ApiClient? apiClient});


  // Text Editing Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Country Code State
  final selectedCountryCode = '+880'.obs;

  // Password Visibility State
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  void updateCountryCode(String dialCode) {
    selectedCountryCode.value = dialCode;
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  Future<void> handleRegistration() async {
    final validationMessage = _validateInputs();

    if (validationMessage != null) {
      _showSnackBar('Error', validationMessage);
      return;
    }

    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      Get.to(
        () =>
            UserProfilePicScreen(registeredEmail: emailController.text.trim()),
      );
    } catch (error, stackTrace) {
      log('Navigation error', error: error, stackTrace: stackTrace);
      _showSnackBar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  String? _validateInputs() {
    if (firstNameController.text.trim().isEmpty) {
      return 'Please enter your first name';
    }

    if (lastNameController.text.trim().isEmpty) {
      return 'Please enter your last name';
    }

    if (emailController.text.trim().isEmpty) {
      return 'Please enter your email address';
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      return 'Please enter a valid email address';
    }

    if (phoneController.text.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    if (passwordController.text.isEmpty) {
      return 'Please enter your password';
    }

    if (passwordController.text.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (confirmPasswordController.text.isEmpty) {
      return 'Please confirm your password';
    }

    if (passwordController.text != confirmPasswordController.text) {
      return 'Password and confirm password do not match';
    }

    return null;
  }

  String? _extractMessage(dynamic responseData) {
    final responseMap = _asMap(responseData);
    if (responseMap == null) {
      return null;
    }

    final data = _asMap(responseMap['data']);
    final nestedMessage = data?['message'];
    if (nestedMessage is String && nestedMessage.trim().isNotEmpty) {
      return nestedMessage;
    }

    final message = responseMap['message'];
    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    final error = responseMap['error'];
    if (error is String && error.trim().isNotEmpty) {
      return error;
    }

    return null;
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

  void _showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
