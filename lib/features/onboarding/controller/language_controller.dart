import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/localization/localization_service.dart';

class LanguageController extends GetxController {
  var isEnglish = true.obs;

  void toggleLanguage() {
    isEnglish.value = !isEnglish.value;

    if (isEnglish.value) {
      LocalizationService.changeLocale('en', 'US');
    } else {
      LocalizationService.changeLocale('bn', 'BD');
    }
  }

  String get currentLanguageLabel => isEnglish.value ? 'EN' : 'BN';
}
