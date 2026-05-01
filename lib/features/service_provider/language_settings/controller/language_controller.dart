import 'package:get/get.dart';
import 'package:protiva502/core/localization/localization_service.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'English'.obs;
  final List<String> languages = ['English', 'Bengali'];

  void updateLanguage(String language) {
    selectedLanguage.value = language;
    LocalizationService.changeLanguage(language);
  }

  @override
  void onInit() {
    super.onInit();
    final currentLang = LocalizationService.currentLanguageName;
    selectedLanguage.value = currentLang;
  }
}
