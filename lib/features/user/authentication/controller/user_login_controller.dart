import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_reg_screen.dart';

class UserLoginController extends GetxController {
  // Text Editing Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Password Visibility State
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void handleSignIn() {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      // 1. Perform your API call logic here...

      // 2. Navigate to the Main Screen and clear the navigation stack
      Get.offAll(() => const MainNavigationScreen());
    } else {
      Get.snackbar("Error", "Please fill in all fields");
    }
  }

  void navigateToSignUp() {
    // Navigate back to role selection or registration
    Get.to(() => UserRegScreen());
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
