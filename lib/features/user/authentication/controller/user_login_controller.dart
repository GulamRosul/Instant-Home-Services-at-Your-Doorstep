import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:protiva502/core/services/api_client.dart';
// import 'package:protiva502/core/services/call_service.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';
import 'package:protiva502/features/service_provider/provider_navber/screen/provider_navbar_screen.dart';

class UserLoginController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var needsEmailVerification = false.obs;
  var isOtpLoading = false.obs;

  var emailError = RxnString();
  var passwordError = RxnString();

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  Future<void> handleSignIn() async {
    if (isLoading.value) return;

    final email = emailController.text.trim();
    final password = passwordController.text;

    debugPrint('🔐 [LOGIN] Email: $email');
    debugPrint('🔐 [LOGIN] Password length: ${password.length}');

    // Reset errors
    emailError.value = null;
    passwordError.value = null;

    if (email.isEmpty) {
      emailError.value = "email_empty".tr;
      debugPrint('❌ [LOGIN] Empty email');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      emailError.value = "email_invalid".tr;
      debugPrint('❌ [LOGIN] Invalid email format');
      return;
    }

    if (password.isEmpty) {
      passwordError.value = "password_empty".tr;
      debugPrint('❌ [LOGIN] Empty password');
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('🔄 [LOGIN] Sending login request...');

      // Get FCM token - initialize notification controller if not already done
      String deviceId = '21'; // Default device ID
      debugPrint('📱 [LOGIN] Default device-id set to: $deviceId');
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
          debugPrint('🔐 [LOGIN] Using FCM token as device-id : $deviceId');
        }
      } catch (e) {
        debugPrint('❌ [LOGIN] Failed to get FCM token, using default: $e');
      }

      // Create options with device-id header
      final options = Options(headers: {'device-id': deviceId});

      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
        options: options,
      );

      // Add these lines:
      debugPrint('🌐 [LOGIN] Request URL: ${response.requestOptions.uri}');
      debugPrint('📤 [LOGIN] Request Body: ${response.requestOptions.data}');
      debugPrint('📥 [LOGIN] Response: ${response.data}');

      debugPrint('📡 [LOGIN] Response status code: ${response.statusCode}');
      debugPrint('📡 [LOGIN] Full response data: ${response.data}');
      debugPrint('📡 [LOGIN] Response headers: ${response.headers}');

      if (response.statusCode != 200) {
        debugPrint('❌ [LOGIN] Server error: ${response.statusCode}');
        if (response.statusCode == 401) {
          final message = response.data?["message"];
          if (message == "Please verify your email first") {
            debugPrint('📧 [LOGIN] Email verification needed');
            needsEmailVerification.value = true;
            return;
          }
          passwordError.value = "password_wrong".tr;
        } else if (response.statusCode == 404 || response.statusCode == 400) {
          emailError.value = "email_wrong".tr;
          passwordError.value = "password_wrong".tr;
        }
        return;
      }

      final data = response.data["data"];
      debugPrint('📦 [LOGIN] Extracted data: $data');

      final token = data?["accessToken"];
      debugPrint('🔑 [LOGIN] Access token exists: ${token != null}');
      debugPrint('🔑 [LOGIN] Token length: ${token?.length ?? 0}');

      if (token == null || token.isEmpty) {
        debugPrint('❌ [LOGIN] Invalid or empty token in response');
        Get.snackbar("Error", "Invalid login response");
        return;
      }

      AppLoggerHelper.info('Login success response: ${response.data}');
      debugPrint('✅ [LOGIN] Token validated successfully');

      final userId = data?["user"]?["id"]?.toString();
      final userEmail = data?["user"]?["email"]?.toString() ?? email;
      final firstName = data?["user"]?["firstName"]?.toString();
      final lastName = data?["user"]?["lastName"]?.toString();
      final username = data?["user"]?["username"]?.toString() ?? email;
      final role = data?["user"]?["role"]?.toString() ?? 'user';
      final avatar = data?["user"]?["avatar"]?.toString();

      debugPrint('👤 [LOGIN] User ID: $userId');
      debugPrint('👤 [LOGIN] User Email: $userEmail');
      debugPrint('👤 [LOGIN] User Name: $firstName $lastName');
      debugPrint('👤 [LOGIN] Username: $username');
      debugPrint('👤 [LOGIN] Role: $role');
      debugPrint('👤 [LOGIN] Avatar: $avatar');

      await StorageService.makeLoggedIn();
      debugPrint('💾 [LOGIN] Marked as logged in');

      await StorageService.saveUser(
        userId: userId,
        email: userEmail,
        firstName: firstName,
        lastName: lastName,
        username: username,
        role: role,
        avatar: avatar,
      );
      debugPrint('💾 [LOGIN] User data saved');

      await SecureStorageService.saveToken(token);
      debugPrint('🔐 [LOGIN] Access token saved');

      // await CallService.instance.initialize(
      //   userID: userId ?? '',
      //   userName: StorageService.getDisplayName(),
      // );

      final refreshToken = data?["refreshToken"]?.toString();
      debugPrint('🔄 [LOGIN] Refresh token exists: ${refreshToken != null}');

      if (refreshToken != null && refreshToken.isNotEmpty) {
        await SecureStorageService.saveRefreshToken(refreshToken);
        debugPrint('🔐 [LOGIN] Refresh token saved');
      }

      debugPrint(
        '✅ [LOGIN] All data saved successfully, navigating to home...',
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
        debugPrint('📱 [LOGIN] FCM Token confirmed: $fcmToken');
      }

      await _navigateByRole(role);
    } catch (e, stackTrace) {
      debugPrint('❌ [LOGIN] Exception caught: $e');
      debugPrint('❌ [LOGIN] Stack trace: $stackTrace');
      AppLoggerHelper.error('Login failed with error: $e');

      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          passwordError.value = "password_wrong".tr;
        } else if (e.response?.statusCode == 404) {
          emailError.value = "email_wrong".tr;
        } else if (e.response?.statusCode == 400) {
          emailError.value = "email_wrong".tr;
          passwordError.value = "password_wrong".tr;
        } else {
          debugPrint('📡 [LOGIN] Other error: ${e.message}');
        }
      } else {
        debugPrint('❌ [LOGIN] Non-Dio error: $e');
      }
    } finally {
      isLoading.value = false;
      debugPrint('🏁 [LOGIN] Login process completed');
    }
  }

  Future<void> _navigateByRole(String? role) async {
    final normalizedRole = role?.trim().toLowerCase() ?? '';

    if (normalizedRole == 'provider') {
      Get.offAll(() => const ProviderNavbarScreen());
      return;
    }

    Get.offAll(() => const MainNavigationScreen());
  }

  Future<void> sendOtp() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return;
    }

    try {
      isOtpLoading.value = true;
      debugPrint('📧 [LOGIN] Sending OTP to: $email');

      final response = await _apiClient.post(
        ApiEndpoints.resendOTP,
        data: {"email": email},
      );

      debugPrint('📧 [LOGIN] Send OTP Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        debugPrint('✅ [LOGIN] OTP sent successfully');
        Get.snackbar('Success', 'OTP sent to your email');
        Get.toNamed('/userOtpScreen', arguments: {'email': email});
      } else {
        Get.snackbar('Error', 'Failed to send OTP');
      }
    } catch (e) {
      debugPrint('❌ [LOGIN] Send OTP Error: $e');
      Get.snackbar('Error', 'Failed to send OTP');
    } finally {
      isOtpLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
