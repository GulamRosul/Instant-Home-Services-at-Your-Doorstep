import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

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
      debugPrint('📲 [LOCAL NOTIFICATION] Tapped: ${response.payload}');
    },
  );

  debugPrint('✅ [LOCAL NOTIFICATIONS] Initialized');
}

/// Background handler — runs in separate isolate
/// Must reinitialize plugin since late variable isn't available
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('🔔 [BACKGROUND] Received: ${message.messageId}');

  // ✅ Skip Zego call notifications — Zego handles those itself
  final data = message.data;
  if (data.containsKey('zego') ||
      data.containsKey('call_id') ||
      data.containsKey('inviter_id') ||
      (message.notification?.title == 'Incoming call')) {
    debugPrint('🔔 [BACKGROUND] Zego call notification — skipping local display');
    return;
  }

  // ✅ Reinitialize plugin in background isolate
  final plugin = FlutterLocalNotificationsPlugin();
  await plugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
  );

  await _showNotification(plugin, message);
}

Future<void> displayLocalNotification(RemoteMessage message) async {
  // ✅ Skip Zego call notifications
  final data = message.data;
  if (data.containsKey('zego') ||
      data.containsKey('call_id') ||
      data.containsKey('inviter_id') ||
      (message.notification?.title == 'Incoming call')) {
    debugPrint('📲 Zego call notification — skipping local display');
    return;
  }

  await _showNotification(flutterLocalNotificationsPlugin, message);
}

Future<void> _showNotification(
  FlutterLocalNotificationsPlugin plugin,
  RemoteMessage message,
) async {
  try {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'protiva_high_importance_channel',
          'High Importance Notifications',
          channelDescription: 'Used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          enableVibration: true,
          enableLights: true,
          // ✅ No custom sound — avoids missing asset crash
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await plugin.show(
      message.hashCode,
      message.notification?.title ?? 'Notification',
      message.notification?.body ?? '',
      details,
      payload: message.data.toString(),
    );
  } catch (e) {
    debugPrint('❌ [LOCAL NOTIFICATION] Error: $e');
  }
}

Future<void> initializeAndroidNotificationChannel() async {
  if (!Platform.isAndroid) return;

  try {
    // ✅ No custom sound reference
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'protiva_high_importance_channel',
      'High Importance Notifications',
      description: 'Used for important notifications.',
      importance: Importance.max,
      enableVibration: true,
      enableLights: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    debugPrint('✅ [ANDROID] Notification channel created');
  } catch (e) {
    debugPrint('❌ [ANDROID] Channel error: $e');
  }
}