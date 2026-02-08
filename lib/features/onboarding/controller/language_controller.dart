import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  // Observable variable: true for English, false for Bangla
  var isEnglish = true.obs;

  // The toggle logic
  void toggleLanguage() {
    isEnglish.value = !isEnglish.value;

    // Update the actual App Locale for localization
    if (isEnglish.value) {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('bn', 'BD'));
    }
  }

  // Getter for the label shown in the UI
  String get currentLanguageLabel => isEnglish.value ? 'EN' : 'BN';
}