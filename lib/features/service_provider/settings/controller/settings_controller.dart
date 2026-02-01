import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Tab state
  var isPreferencesSelected = true.obs;

  // Preferences state
  var showContactInfo = false.obs;
  var publicProfile = true.obs;

  // Notification state
  var notificationsEnabled = false.obs;
  var newBookingAlerts = false.obs;
  var emailNotifications = false.obs;
  var smsNotifications = false.obs;

  void toggleTab(bool isPreferences) {
    isPreferencesSelected.value = isPreferences;
  }

  void toggleShowContactInfo(bool val) => showContactInfo.value = val;
  void togglePublicProfile(bool val) => publicProfile.value = val;
  void toggleNotificationsEnabled(bool val) => notificationsEnabled.value = val;
  void toggleNewBookingAlerts(bool val) => newBookingAlerts.value = val;
  void toggleEmailNotifications(bool val) => emailNotifications.value = val;
  void toggleSmsNotifications(bool val) => smsNotifications.value = val;
}
