import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/payment_system/screen/provider_pricing_screen.dart';

class ProviderLogoBioController extends GetxController {
  static const int maxBioLength = 300;

  final bioController = TextEditingController();

  /// Selected logo file path (null = not selected, show placeholder).
  final logoPath = Rx<String?>(null);

  /// Reactive character count for bio (for 0/300 display).
  final bioCharCount = 0.obs;

  void updateBioCount(int count) => bioCharCount.value = count;

  void pickLogo() {
    // TODO: Implement image_picker for logo
    // For now just trigger so UI can show dialog or picker
  }

  void handleSkip() {
    // Skip this step, go to next or home
    Get.back();
  }

  void handleNext() {
    Get.to(() => const ProviderPricingScreen());
  }

  @override
  void onClose() {
    bioController.dispose();
    super.onClose();
  }
}
