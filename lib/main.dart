import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:protiva502/app.dart';
import 'package:protiva502/core/localization/localization_service.dart';
import 'package:protiva502/core/services/call_service.dart';
import 'package:protiva502/core/services/app_lifecycle_service.dart';
import 'package:protiva502/core/services/firebase_notification_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/firebase_options.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await LocalizationService.initialize();

  // ✅ Must be FIRST before any Zego init
  ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
    ZegoUIKitSignalingPlugin(),
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Ensure local notifications and FCM token are initialized before CallService
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await initializeLocalNotifications();
  await initializeAndroidNotificationChannel();

  // Setup app lifecycle and background message handling for calls
  await AppLifecycleService.instance.setupBackgroundMessageHandler();
  await AppLifecycleService.instance.requestNotificationPermission();

  // Put the NotificationController early so it can fetch and save the FCM token
  Get.put<NotificationController>(NotificationController(), permanent: true);

  // Initialize navigator key and Zego call service in the background
  // after the UI is rendered. This avoids blocking startup on network calls.
  CallService.instance.setNavigatorKey(appNavigatorKey);
  CallService.instance.initializeFromStorage().catchError((e) {
    debugPrint('⚠️ [MAIN] CallService init error: $e');
  });

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFF8FAFC),
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const Protiva502());
}
