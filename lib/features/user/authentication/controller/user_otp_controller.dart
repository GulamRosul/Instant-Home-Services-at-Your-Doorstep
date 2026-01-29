import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/user/authentication/screen/user_login_screen.dart';

class UserOtpController extends GetxController {
  // Timer variables
  RxInt secondsRemaining = 59.obs;
  Timer? _timer;

  // OTP Input
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    secondsRemaining.value = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  String get timerText {
    final minutes = (secondsRemaining.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining.value % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void verifyOtp() {
    String otp = otpControllers.map((e) => e.text).join();
    if (otp.length == 6) {
      print("Verifying OTP: $otp");
      // Add your verification logic here
    } else {
      Get.snackbar(
        "Error",
        "Please enter a valid 6-digit OTP",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    Get.to(() => UserLoginScreen());
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
