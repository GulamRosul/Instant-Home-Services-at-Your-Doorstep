import 'dart:async';

import 'package:get/get.dart';
import 'package:protiva502/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(AppRoute.onboardingScreen);
    });
  }
}
