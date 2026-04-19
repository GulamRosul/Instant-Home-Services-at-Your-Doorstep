import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:protiva502/app.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/firebase_options.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       systemNavigationBarColor: Colors.transparent,
//       systemNavigationBarDividerColor: Colors.transparent,
//       // This line makes the icons visible (dark) on a light background
//       systemNavigationBarIconBrightness: Brightness.dark,
//       systemNavigationBarContrastEnforced: false,

//       // Do the same for the status bar at the top
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//   );

//   SystemChrome.setEnabledSystemUIMode(
//     SystemUiMode.manual,
//     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
//   );

//   runApp(const Protiva502());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize NotificationController as a persistent controller
  Get.put<NotificationController>(NotificationController(), permanent: true);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // A very light grey/off-white background
      systemNavigationBarColor: Color(0xFFF8FAFC),
      systemNavigationBarDividerColor: Colors.transparent,

      // Use dark icons (black).
      // Against the F8FAFC background, they appear greyish.
      systemNavigationBarIconBrightness: Brightness.dark,

      // MUST be false to avoid the system's "protection" (black bar)
      systemNavigationBarContrastEnforced: false,

      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const Protiva502());
}
