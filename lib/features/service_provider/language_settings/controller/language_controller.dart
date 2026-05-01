import 'package:get/get.dart';
import 'package:protiva502/core/localization/localization_service.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'English'.obs;

  // Getter so translations update reactively
  List<String> get languages => ['english'.tr, 'bengali'.tr];

  String get currentLanguageLabel => isEnglish ? 'EN' : 'BN';
  bool get isEnglish => selectedLanguage.value == 'English';

  @override
  void onInit() {
    super.onInit();
    selectedLanguage.value = LocalizationService.currentLanguageName;
  }

  void updateLanguage(String language) {
    selectedLanguage.value = language;
    if (language == 'English') {
      LocalizationService.changeLocale('en', 'US');
    } else {
      LocalizationService.changeLocale('bn', 'BD');
    }
  }

  void toggleLanguage() {
    updateLanguage(isEnglish ? 'Bengali' : 'English');
  }
}