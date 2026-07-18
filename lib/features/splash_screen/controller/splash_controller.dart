import 'dart:async';

import 'package:get/get.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
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

  // void startTimer() {
  //   Timer(const Duration(seconds: 3), () async {
  //     await _versionCheckController.checkForUpdate();

  //     if (_versionCheckController.isBlockedByForceUpdate) {
  //       return; // ❌ STOP navigation
  //     }

  //     _navigateToNextScreen(); // ✅ only if safe
  //   });
  // }

  void startTimer() async {
    await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      _versionCheckController.checkForUpdate(),
    ]);

    if (_versionCheckController.isBlockedByForceUpdate) return;
    await _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final hasValidToken = await StorageService.hasValidAccessToken();
    final refreshToken = await SecureStorageService.getRefreshToken();
    final hasRefreshToken = refreshToken != null && refreshToken.isNotEmpty;

    if (StorageService.hasActiveSession() &&
        (hasValidToken || hasRefreshToken)) {
      final role = StorageService.getRole()?.toLowerCase() ?? '';

      if (role.contains('provider') || role.contains('service_provider')) {
        Get.offAllNamed(AppRoute.getProviderNavbar());
        return;
      }

      Get.offAllNamed(AppRoute.getMainNavigationScreen());
      return;
    }

    await StorageService.makeLoggedOut();
    Get.offNamed(AppRoute.userLoginScreen);
  }
}
