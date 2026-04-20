import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:protiva502/app.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/firebase_options.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set up background message handler for Android
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize Android notification channel for Android 8.0+
  if (Platform.isAndroid) {
    await _initializeAndroidNotificationChannel();
  }

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

/// Background message handler for Firebase notifications
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('🔔 [BACKGROUND] Received message: ${message.messageId}');
  debugPrint('🔔 [BACKGROUND] Title: ${message.notification?.title}');
  debugPrint('🔔 [BACKGROUND] Body: ${message.notification?.body}');

  // Handle background notification
  // You can show a local notification or store the notification
}

/// Initialize Android notification channel
Future<void> _initializeAndroidNotificationChannel() async {
  try {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'protiva_high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      enableVibration: true,
      enableLights: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    debugPrint('✅ [ANDROID] Notification channel created');
  } catch (e) {
    debugPrint('❌ [ANDROID] Error initializing notification channel: $e');
  }
}
