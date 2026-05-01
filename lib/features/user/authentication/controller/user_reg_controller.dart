import 'dart:developer';

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
      _showSnackBar('error'.tr, validationMessage);
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
      _showSnackBar('error'.tr, 'registration_error'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  String? _validateInputs() {
    if (firstNameController.text.trim().isEmpty) {
      return 'first_name_required'.tr;
    }

    if (lastNameController.text.trim().isEmpty) {
      return 'last_name_required'.tr;
    }

    if (emailController.text.trim().isEmpty) {
      return 'email_required'.tr;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      return 'email_invalid'.tr;
    }

    if (phoneController.text.trim().isEmpty) {
      return 'phone_required'.tr;
    }

    if (cityController.text.trim().isEmpty) {
      return 'city_required'.tr;
    }

    if (passwordController.text.isEmpty) {
      return 'password_required'.tr;
    }

    if (passwordController.text.length < 8) {
      return 'password_min_length'.tr;
    }

    if (confirmPasswordController.text.isEmpty) {
      return 'confirm_password_required'.tr;
    }

    if (passwordController.text != confirmPasswordController.text) {
      return 'password_mismatch'.tr;
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
