import 'dart:async';

import 'package:get/get.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      if (StorageService.hasActiveSession()) {
        final role = StorageService.getRole()?.toLowerCase() ?? '';

        if (role.contains('provider') || role.contains('service_provider')) {
          Get.offAllNamed(AppRoute.getProviderNavbar());
          return;
        }

        Get.offAllNamed(AppRoute.getMainNavigationScreen());
        return;
      }

      Get.offNamed(AppRoute.secondOnboardingScreen);
    });
  }
}
