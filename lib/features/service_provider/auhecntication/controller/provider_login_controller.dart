import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:protiva502/core/services/call_service.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration_screen_01.dart';
import 'package:protiva502/features/service_provider/provider_navber/screen/provider_navbar_screen.dart';

class ProviderLoginController extends GetxController {
  static const String _baseUrl = ApiEndpoints.baseUrl;
      // 'https://x3081msx-3000.asse.devtunnels.ms/api/v1';
      // 'https://1z13k3v3-3000.inc1.devtunnels.ms/api/v1';
  static const String _loginEndpoint = '$_baseUrl/auth/login';
  static const String _defaultDeviceId = '21';

  // Text Editing Controllers
  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();

  // Password Visibility State
  var isPasswordVisible = false.obs;
  var isSigningIn = false.obs;

  var emailError = RxnString();
  var passwordError = RxnString();

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  Future<void> handleSignIn() async {
    final email = userEmailController.text.trim();
    final password = passwordController.text;

    // Reset errors
    emailError.value = null;
    passwordError.value = null;

    if (email.isEmpty) {
      emailError.value = "email_empty".tr;
      return;
    }

    if (!GetUtils.isEmail(email)) {
      emailError.value = "email_invalid".tr;
      return;
    }

    if (password.isEmpty) {
      passwordError.value = "password_empty".tr;
      return;
    }

    if (email.isNotEmpty && password.isNotEmpty) {
      if (isSigningIn.value) return;

      isSigningIn.value = true;
      final uri = Uri.parse(_loginEndpoint);
      final payload = jsonEncode({'email': email, 'password': password});

      // Get FCM token - initialize notification controller if not already done
      String deviceId = _defaultDeviceId;
      try {
        final notificationController =
            Get.isRegistered<NotificationController>()
            ? Get.find<NotificationController>()
            : Get.put(NotificationController());

        // Wait for FCM token to be available
        await Future.delayed(const Duration(milliseconds: 300));
        final fcmToken = notificationController.getFcmToken();
        if (fcmToken != null && fcmToken.isNotEmpty) {
          deviceId = fcmToken;
          debugPrint('Provider login using FCM token as device-id');
        }
      } catch (e) {
        debugPrint('Failed to get FCM token, using default device-id: $e');
      }

      debugPrint('Provider login URL => $uri');
      debugPrint('Provider login device-id => $deviceId');
      debugPrint('Provider login body => $payload');
      log('Provider login URL => $uri', name: 'ProviderLogin');
      log('Provider login device-id => $deviceId', name: 'ProviderLogin');
      log('Provider login body => $payload', name: 'ProviderLogin');

      try {
        final response = await http.post(
          uri,
          headers: {
            'accept': '*/*',
            'device-id': deviceId,
            'Content-Type': 'application/json',
          },
          body: payload,
        );

        debugPrint('Provider login status => ${response.statusCode}');
        debugPrint('Provider login response => ${response.body}');
        log(
          'Provider login status => ${response.statusCode}',
          name: 'ProviderLogin',
        );
        log(
          'Provider login response => ${response.body}',
          name: 'ProviderLogin',
        );

        final responseData = _tryDecode(response.body);
        if (response.statusCode == 200) {
          // ... (existing success logic)
          final data = responseData?['data'] as Map<String, dynamic>?;
          final user = data?['user'] as Map<String, dynamic>?;

          await StorageService.makeLoggedIn();
          await SecureStorageService.saveToken(
            data?['accessToken']?.toString() ?? '',
          );
          await SecureStorageService.saveRefreshToken(
            data?['refreshToken']?.toString() ?? '',
          );
          await StorageService.saveUser(
            userId: user?['id']?.toString(),
            email: user?['email']?.toString(),
            firstName: user?['firstName']?.toString(),
            lastName: user?['lastName']?.toString(),
            role: user?['role']?.toString(),
            username:
                user?['username']?.toString() ?? user?['email']?.toString(),
            avatar: user?['avatar']?.toString(),
          );

          await CallService.instance.initialize(
            userID: user?['id']?.toString() ?? '',
            userName: StorageService.getDisplayName(),
          );

          // Get FCM token for logging (controller should already be initialized)
          String? fcmToken;
          try {
            if (Get.isRegistered<NotificationController>()) {
              final notificationController = Get.find<NotificationController>();
              fcmToken = notificationController.getFcmToken();
            }
          } catch (_) {}
          if (fcmToken != null) {
            debugPrint('📱 [PROVIDER LOGIN] FCM Token confirmed: $fcmToken');
          }

          Get.offAll(() => const ProviderNavbarScreen());
        } else {
          if (response.statusCode == 401) {
            passwordError.value = "password_wrong".tr;
          } else if (response.statusCode == 404) {
            emailError.value = "email_wrong".tr;
          } else if (response.statusCode == 400) {
            emailError.value = "email_wrong".tr;
            passwordError.value = "password_wrong".tr;
          } else {
            debugPrint('Login failed: ${response.statusCode}');
          }
        }
      } catch (error, stackTrace) {
        debugPrint('Provider login error => $error');
        log(
          'Provider login error => $error',
          name: 'ProviderLogin',
          stackTrace: stackTrace,
        );
        debugPrint('Login failed: Could not connect to the server');
      } finally {
        isSigningIn.value = false;
      }
    } else {
      Get.snackbar("error".tr, "fill_all_fields".tr);
    }
  }

  void navigateToSignUp() {
    // Navigate to Provider Registration
    Get.to(() => const ProviderRegistrationScreen01());
  }

  Map<String, dynamic>? _tryDecode(String source) {
    try {
      final decoded = jsonDecode(source);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  String _extractMessage(Map<String, dynamic>? responseData) {
    return responseData?['message']?.toString() ??
        responseData?['data']?['message']?.toString() ??
        responseData?['error']?.toString() ??
        'Something went wrong';
  }

  @override
  void onClose() {
    userEmailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
