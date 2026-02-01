import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/provider_navber/screen/provider_navbar_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';

class ProviderLoginController extends GetxController {
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
      // Perform your API call logic here...

      // Navigate to the Provider Navbar and clear the navigation stack
      Get.offAll(() => const ProviderNavbarScreen());
    } else {
      Get.snackbar("Error", "Please fill in all fields");
    }
  }

  void navigateToSignUp() {
    // Navigate to Provider Registration
    Get.to(() => const ProviderRegistration());
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
