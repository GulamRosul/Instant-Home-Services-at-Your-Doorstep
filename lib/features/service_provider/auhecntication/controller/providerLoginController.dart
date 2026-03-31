import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/features/service_provider/provider_navber/screen/provider_navbar_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';

class ProviderLoginController extends GetxController {
  static const String _baseUrl = 'https://protiva-backend.onrender.com/api/v1';
  static const String _loginEndpoint = '$_baseUrl/auth/login';
  static const String _deviceId = '21';

  // Text Editing Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Password Visibility State
  var isPasswordVisible = false.obs;
  var isSigningIn = false.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  Future<void> handleSignIn() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      if (isSigningIn.value) return;

      isSigningIn.value = true;
      final uri = Uri.parse(_loginEndpoint);
      final payload = jsonEncode({'email': username, 'password': password});

      debugPrint('Provider login URL => $uri');
      debugPrint('Provider login device-id => $_deviceId');
      debugPrint('Provider login body => $payload');
      log('Provider login URL => $uri', name: 'ProviderLogin');
      log('Provider login device-id => $_deviceId', name: 'ProviderLogin');
      log('Provider login body => $payload', name: 'ProviderLogin');

      try {
        final response = await http.post(
          uri,
          headers: const {
            'accept': '*/*',
            'device-id': _deviceId,
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
          final data = responseData?['data'] as Map<String, dynamic>?;
          final user = data?['user'] as Map<String, dynamic>?;

          await StorageService.makeLoggedIn();
          await StorageService.saveToken(
            data?['accessToken']?.toString() ?? '',
          );
          await StorageService.saveRefreshToken(
            data?['refreshToken']?.toString() ?? '',
          );
          await StorageService.saveUserId(user?['id']?.toString() ?? '');
          await StorageService.saveEmail(user?['email']?.toString());
          await StorageService.saveFirstName(user?['firstName']?.toString());
          await StorageService.saveLastName(user?['lastName']?.toString());
          await StorageService.saveUserRole(user?['role']?.toString());
          await StorageService.savePassword(password);
          await StorageService.saveProvider('service_provider');

          final message = data?['message']?.toString() ?? 'Login successful';
          Get.snackbar('Success', message);
          Get.offAll(() => const ProviderNavbarScreen());
        } else {
          Get.snackbar('Login failed', _extractMessage(responseData));
        }
      } catch (error, stackTrace) {
        debugPrint('Provider login error => $error');
        log(
          'Provider login error => $error',
          name: 'ProviderLogin',
          stackTrace: stackTrace,
        );
        Get.snackbar('Login failed', 'Could not connect to the server');
      } finally {
        isSigningIn.value = false;
      }
    } else {
      Get.snackbar("Error", "Please fill in all fields");
    }
  }

  void navigateToSignUp() {
    // Navigate to Provider Registration
    Get.to(() => const ProviderRegistration());
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
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
