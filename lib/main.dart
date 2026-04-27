import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:protiva502/app.dart';
import 'package:protiva502/core/services/call_service.dart';
import 'package:protiva502/core/services/firebase_notification_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/firebase_options.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  CallService.instance.setNavigatorKey(Get.key);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CallService.instance.initializeFromStorage();

  // Set up background message handler for Firebase notifications
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
    ZegoUIKitSignalingPlugin(),
  ]);

  // Initialize notifications
  await initializeLocalNotifications();
  await initializeAndroidNotificationChannel();

  Get.put<NotificationController>(NotificationController(), permanent: true);

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
