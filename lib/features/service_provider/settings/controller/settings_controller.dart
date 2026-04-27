import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';

class SettingsController extends GetxController {
  // Tab state
  var isPreferencesSelected = true.obs;

  // Preferences state
  var showContactInfo = false.obs;
  var publicProfile = true.obs;

  // Notification state
  var notificationsEnabled = false.obs;
  var newBookingAlerts = false.obs;
  var emailNotifications = false.obs;
  var smsNotifications = false.obs;

  // Password change controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Loading state
  final isLoading = false.obs;

  void toggleTab(bool isPreferences) {
    isPreferencesSelected.value = isPreferences;
  }

  void toggleShowContactInfo(bool val) => showContactInfo.value = val;
  void togglePublicProfile(bool val) => publicProfile.value = val;
  void toggleNotificationsEnabled(bool val) => notificationsEnabled.value = val;
  void toggleNewBookingAlerts(bool val) => newBookingAlerts.value = val;
  void toggleEmailNotifications(bool val) => emailNotifications.value = val;
  void toggleSmsNotifications(bool val) => smsNotifications.value = val;

  Future<void> changePassword() async {
    final validationMessage = _validatePasswords();

    if (validationMessage != null) {
      _showSnackBar('Error', validationMessage);
      return;
    }

    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiClient().post(
        ApiEndpoints.changePassword,
        data: {
          'currentPassword': currentPasswordController.text,
          'newPassword': newPasswordController.text,
        },
      );

      log(
        '🔐 Change Password Response: ${response.statusCode}',
        name: 'SettingsController',
      );

      if (response.statusCode == 200) {
        _clearPasswordFields();
        Get.snackbar(
          'Success',
          'Password changed successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.check_circle, color: Colors.white),
          shouldIconPulse: false,
          barBlur: 10,
          overlayBlur: 1,
          snackStyle: SnackStyle.FLOATING,
          animationDuration: const Duration(milliseconds: 400),
        );
        log('✅ Password Changed Successfully', name: 'SettingsController');
      } else {
        Get.snackbar(
          'Error',
          'Failed to change password. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log('❌ Change Password Error: $e', name: 'SettingsController');
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String? _validatePasswords() {
    if (currentPasswordController.text.isEmpty) {
      return 'Please enter your current password';
    }

    if (newPasswordController.text.isEmpty) {
      return 'Please enter a new password';
    }

    if (newPasswordController.text.length < 8) {
      return 'New password must be at least 8 characters long';
    }

    if (confirmPasswordController.text.isEmpty) {
      return 'Please confirm your new password';
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      return 'New password and confirm password do not match';
    }

    return null;
  }

  void _clearPasswordFields() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
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
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
