import 'dart:async';

import 'package:get/get.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/features/version_check/controller/version_check_controller.dart';
import 'package:protiva502/routes/app_routes.dart';

class SplashController extends GetxController {
  late VersionCheckController _versionCheckController;

  @override
  void onInit() {
    super.onInit();
    _versionCheckController = Get.put(VersionCheckController());
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () async {
      await _versionCheckController.checkForUpdate();

      if (_versionCheckController.isBlockedByForceUpdate) {
        return; // ❌ STOP navigation
      }

      _navigateToNextScreen(); // ✅ only if safe
    });
  }

  void _navigateToNextScreen() {
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
  }
}
