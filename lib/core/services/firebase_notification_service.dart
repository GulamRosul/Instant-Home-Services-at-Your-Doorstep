import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// Initialize local notifications
Future<void> initializeLocalNotifications() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings iOSInitializationSettings =
      DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iOSInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      debugPrint(
        '📲 [LOCAL NOTIFICATION] Notification tapped: ${response.payload}',
      );
    },
  );

  debugPrint('✅ [LOCAL NOTIFICATIONS] Initialized');
}

/// Background message handler for Firebase notifications
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('🔔 [BACKGROUND] Received message: ${message.messageId}');
  debugPrint('🔔 [BACKGROUND] Title: ${message.notification?.title}');
  debugPrint('🔔 [BACKGROUND] Body: ${message.notification?.body}');

  // Display local notification for background message
  await displayLocalNotification(message);
}

/// Display local notification
Future<void> displayLocalNotification(RemoteMessage message) async {
  try {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'protiva_high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          enableVibration: true,
          enableLights: true,
          sound: RawResourceAndroidNotificationSound('notification_sound'),
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'Notification',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: message.data.toString(),
    );

    debugPrint(
      '✅ [LOCAL NOTIFICATION] Displayed: ${message.notification?.title}',
    );
  } catch (e) {
    debugPrint('❌ [LOCAL NOTIFICATION] Error displaying notification: $e');
  }
}

/// Initialize Android notification channel
Future<void> initializeAndroidNotificationChannel() async {
  if (!Platform.isAndroid) return;

  try {
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
