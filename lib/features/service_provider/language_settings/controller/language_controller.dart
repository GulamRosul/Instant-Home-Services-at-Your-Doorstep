import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'English'.obs;
  final List<String> languages = ['English', 'Bengali'];

  void updateLanguage(String language) {
    selectedLanguage.value = language;
  }
}
