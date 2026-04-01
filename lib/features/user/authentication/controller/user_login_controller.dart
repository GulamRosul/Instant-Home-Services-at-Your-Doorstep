import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';

class UserLoginController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  Future<void> handleSignIn() async {
    if (isLoading.value) return;

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar("Error", "Enter valid email");
      return;
    }

    if (password.isEmpty) {
      Get.snackbar("Error", "Enter password");
      return;
    }

    try {
      isLoading.value = true;

      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );

      if (response.statusCode != 200) {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
        return;
      }

      final data = response.data["data"];
      final token = data?["accessToken"];

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Invalid login response");
        return;
      }

      AppLoggerHelper.info('Login success response: ${response.data}');

      await StorageService.makeLoggedIn();
      await StorageService.saveUser(
        userId: data?["user"]?["id"]?.toString(),
        email: data?["user"]?["email"]?.toString() ?? email,
        firstName: data?["user"]?["firstName"]?.toString(),
        lastName: data?["user"]?["lastName"]?.toString(),
        username: data?["user"]?["username"]?.toString() ?? email,
        role: data?["user"]?["role"]?.toString() ?? 'user',
        avatar: data?["user"]?["avatar"]?.toString(),
      );
      await SecureStorageService.saveToken(token);
      final refreshToken = data?["refreshToken"]?.toString();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await SecureStorageService.saveRefreshToken(refreshToken);
      }

      Get.offAll(() => const MainNavigationScreen());
    } catch (e) {
      Get.snackbar("Error", "Login failed");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
