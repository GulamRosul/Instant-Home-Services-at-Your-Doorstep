import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_reg_screen.dart';

class UserLoginController extends GetxController {
  UserLoginController({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;
  static const String _deviceId = '20';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  Future<void> handleSignIn() async {
    if (isLoading.value) {
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (emailController.text.trim().isEmpty) {
      _showSnackBar('Error', 'Enter email');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      _showSnackBar('Error', 'Invalid email');
      return;
    }

    if (password.isEmpty) {
      _showSnackBar('Error', 'Enter password');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {'device-id': _deviceId},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final httpStatusCode = response.statusCode;
      final apiStatusCode = responseMap['statusCode'];

      AppLoggerHelper.debug('Login HTTP status code: $httpStatusCode');
      AppLoggerHelper.debug('Login API status code: $apiStatusCode');

      if (httpStatusCode != 200 || apiStatusCode != 200) {
        final errorMessage =
            _extractMessage(response.data) ??
            (httpStatusCode == 401
                ? 'Invalid credentials'
                : 'Login failed. Please try again.');

        _showSnackBar('Login Failed', errorMessage);
        return;
      }

      AppLoggerHelper.info('Login successful response: ${response.data}');

      final data = _asMap(responseMap['data']);
      if (data == null) {
        _showSnackBar('Error', 'Invalid login response');
        return;
      }

      final user = _asMap(data['user']);
      final token = data['accessToken']?.toString();
      final refreshToken = data['refreshToken']?.toString();

      if (user == null || token == null || token.isEmpty) {
        _showSnackBar('Error', 'Login failed');
        return;
      }

      await SecureStorageService.saveToken(token);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await SecureStorageService.saveRefreshToken(refreshToken);
      }

      await StorageService.ensureInitialized();

      await StorageService.saveUser(
        userId: user['id']?.toString(),
        username: user['email']?.toString(),
        email: user['email']?.toString(),
        firstName: user['firstName']?.toString(),
        lastName: user['lastName']?.toString(),
        role: user['role']?.toString(),
        avatar: user['avatar']?.toString(),
      );

      await StorageService.makeLoggedIn();

      _showSnackBar('Success', 'Login successful');

      Get.offAll(() => const MainNavigationScreen());
    } on DioException catch (error) {
      AppLoggerHelper.error('Login failed', error);

      final errorMessage =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Login failed. Please try again.';

      _showSnackBar('Login Failed', errorMessage);
    } catch (error) {
      AppLoggerHelper.error('Unexpected login error', error);
      _showSnackBar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
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
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  void navigateToSignUp() {
    Get.to(() => const UserRegScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
