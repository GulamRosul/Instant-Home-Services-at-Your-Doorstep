import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/features/service_provider/provider_navber/screen/provider_navbar_screen.dart';

class ProviderLogoBioController extends GetxController {
  static const int maxBioLength = 300;

  final bioController = TextEditingController();

  /// Selected logo file path (null = not selected, show placeholder).
  final logoPath = Rx<String?>(null);

  /// Reactive character count for bio (for 0/300 display).
  final bioCharCount = 0.obs;

  void updateBioCount(int count) => bioCharCount.value = count;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickLogo(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (image != null) {
        logoPath.value = image.path;
      }
    } catch (e) {
      Get.snackbar(
        "error".tr,
        "${'failed_pick_image'.tr}: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    }
  }

  void handleNext() {
    // Get.to(() => const ProviderNavbarScreen());
    Get.offAll(() => const ProviderNavbarScreen());
  }

  @override
  void onClose() {
    bioController.dispose();
    super.onClose();
  }
}
