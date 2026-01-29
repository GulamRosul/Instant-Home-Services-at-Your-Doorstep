import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginController extends GetxController {
  // Text Editing Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Password Visibility State
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;

  void handleSignIn() {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      debugPrint("Signing in with: $username");
      // Add your authentication logic or API call here
    } else {
      Get.snackbar(
        "Required", 
        "Please enter both username and password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void navigateToSignUp() {
    // Navigate back to role selection or registration
    Get.back(); 
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}