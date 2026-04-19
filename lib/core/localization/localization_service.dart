// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'en_us.dart';
// import 'bn_bd.dart';


// class LocalizationService extends Translations {
//   // Default locale
//   static const locale = Locale('en', 'US');

//   // Fallback locale
//   static const fallbackLocale = Locale('en', 'US');

//   // Supported locales
//   static final locales = [const Locale('en', 'US'), const Locale('fr', 'FR')];

//   // Current locale holder (will be set from SharedPreferences)
//   static Locale _currentLocale = locale;

//   // Get the current locale (from SharedPreferences or default)
//   static Locale get currentLocale => _currentLocale;

//   // Language names for display
//   static const Map<String, String> languageNames = {
//     'en_US': 'English',
//     'fr_FR': 'French',
//   };

//   // Keys for SharedPreferences
//   static const String _languageKey = 'selected_language';
//   static const String _countryKey = 'selected_country';

//   // Translations map
//   @override
//   Map<String, Map<String, String>> get keys => {'en_US': enUS, 'fr_FR': frFR};

//   // Get current language name
//   static String get currentLanguageName {
//     final locale = Get.locale;
//     if (locale == null) return 'English';
//     final key = '${locale.languageCode}_${locale.countryCode}';
//     return languageNames[key] ?? 'English';
//   }

//   // Get current language code
//   static String get currentLanguageCode {
//     final locale = Get.locale;
//     if (locale == null) return 'en';
//     return locale.languageCode;
//   }

//   // Get available languages
//   static List<String> get availableLanguages {
//     return languageNames.values.toList();
//   }

//   // Initialize localization
//   static Future<void> initialize() async {
//     final prefs = await SharedPreferences.getInstance();
//     final languageCode = prefs.getString(_languageKey);
//     final countryCode = prefs.getString(_countryKey);

//     if (languageCode != null && countryCode != null) {
//       final savedLocale = Locale(languageCode, countryCode);
//       if (locales.contains(savedLocale)) {
//         _currentLocale = savedLocale;
//         await Get.updateLocale(savedLocale);
//         debugPrint(
//           '✅ Language loaded from SharedPreferences: ${languageCode}_$countryCode',
//         );
//       }
//     } else {
//       debugPrint('ℹ️ No saved language found, using default: English');
//     }
//   }

//   // Change language by name (e.g., "English", "French")
//   static Future<void> changeLanguage(String languageName) async {
//     String? languageCode;
//     String? countryCode;

//     // Find the locale key for the language name
//     for (var entry in languageNames.entries) {
//       if (entry.value == languageName) {
//         final parts = entry.key.split('_');
//         languageCode = parts[0];
//         countryCode = parts[1];
//         break;
//       }
//     }

//     if (languageCode != null && countryCode != null) {
//       await changeLocale(languageCode, countryCode);
//       debugPrint(
//         '✅ Language changed to: $languageName (saved to SharedPreferences)',
//       );
//     }
//   }

//   // Change language by locale code
//   static Future<void> changeLocale(
//     String languageCode,
//     String countryCode,
//   ) async {
//     final locale = Locale(languageCode, countryCode);

//     if (locales.contains(locale)) {
//       _currentLocale = locale;
//       await Get.updateLocale(locale);

//       // Save to SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(_languageKey, languageCode);
//       await prefs.setString(_countryKey, countryCode);
//       debugPrint(
//         '💾 Language saved to SharedPreferences: ${languageCode}_$countryCode',
//       );
//     }
//   }

//   // Get saved language
//   static Future<Locale?> getSavedLanguage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final languageCode = prefs.getString(_languageKey);
//     final countryCode = prefs.getString(_countryKey);

//     if (languageCode != null && countryCode != null) {
//       return Locale(languageCode, countryCode);
//     }
//     return null;
//   }

//   // Clear saved language
//   static Future<void> clearSavedLanguage() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_languageKey);
//     await prefs.remove(_countryKey);
//     debugPrint('🗑️ Saved language cleared from SharedPreferences');
//   }

//   // Convert language name to code for display purposes
//   static String getLanguageCodeForServer() {
//     final locale = Get.locale;
//     if (locale == null) return 'en';
//     return locale.languageCode; // Returns 'en' or 'fr'
//   }

//   // Convert language name to display name
//   static String getLanguageNameForServer() {
//     return currentLanguageName; // Returns 'English' or 'French'
//   }

//   // Get speech-to-text locale ID based on current app language
//   // Maps app locale (en_US, fr_FR) to speech recognition locale (en-US, fr-FR)
//   static String getSpeechLocaleId() {
//     final locale = Get.locale;
//     if (locale == null) return 'en-US';

//     // Convert locale to speech recognition format
//     // e.g., en_US -> en-US, fr_FR -> fr-FR
//     return '${locale.languageCode}-${locale.countryCode}';
//   }

//   // Get full speech locale string for speech recognition
//   // Returns locale in format: "en-US", "fr-FR", etc.
//   static String getSpeechLocale() {
//     return getSpeechLocaleId();
//   }
// }
