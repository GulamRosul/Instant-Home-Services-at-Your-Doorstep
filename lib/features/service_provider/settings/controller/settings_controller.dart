import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';

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

  late NotificationController _notificationController;

  @override
  void onInit() {
    super.onInit();
    _notificationController = Get.find<NotificationController>();
    _loadNotificationPreference();
  }

  void _loadNotificationPreference() {
    notificationsEnabled.value = StorageService.getNotificationsEnabled();
  }

  void toggleTab(bool isPreferences) {
    isPreferencesSelected.value = isPreferences;
  }

  void toggleShowContactInfo(bool val) => showContactInfo.value = val;
  void togglePublicProfile(bool val) => publicProfile.value = val;

  Future<void> toggleNotificationsEnabled(bool val) async {
    notificationsEnabled.value = val;
    final success = await _notificationController.toggleNotification(val);

    if (!success) {
      notificationsEnabled.value = !val;
      Get.snackbar(
        'error'.tr,
        'failed_to_update_notification'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    }
  }

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
          'success'.tr,
          'password_changed_successfully'.tr,
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
          'error'.tr,
          'password_update_failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log('❌ Change Password Error: $e', name: 'SettingsController');
      Get.snackbar(
        'error'.tr,
        'password_update_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String? _validatePasswords() {
    if (currentPasswordController.text.isEmpty) {
      return 'current_password_required'.tr;
    }

    if (newPasswordController.text.isEmpty) {
      return 'new_password_required'.tr;
    }

    if (newPasswordController.text.length < 8) {
      return 'new_password_length'.tr;
    }

    if (confirmPasswordController.text.isEmpty) {
      return 'confirm_new_password_required'.tr;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      return 'passwords_do_not_match'.tr;
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
