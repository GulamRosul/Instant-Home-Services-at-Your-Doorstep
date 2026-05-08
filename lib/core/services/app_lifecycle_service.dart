import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:protiva502/core/utils/logging/logger.dart';

class AppLifecycleService {
  AppLifecycleService._();
  static final AppLifecycleService instance = AppLifecycleService._();

  Future<void> setupBackgroundMessageHandler() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AppLoggerHelper.info(
        'Received foreground message: ${message.notification?.title}',
      );
      _handleCallNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppLoggerHelper.info(
        'Message opened app: ${message.notification?.title}',
      );
      _handleCallNotification(message);
    });
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    AppLoggerHelper.info(
      'Handling background message: ${message.notification?.title}',
    );
    _handleCallNotification(message);
  }

  void _handleCallNotification(RemoteMessage message) {
    try {
      final data = message.data;
      final notification = message.notification;

      AppLoggerHelper.info(
        'Processing notification - Title: ${notification?.title}, Body: ${notification?.body}',
      );

      if (notification?.title?.contains('call') == true ||
          notification?.body?.contains('calling') == true ||
          data.containsKey('type') && data['type'] == 'call') {
        AppLoggerHelper.info('Detected incoming call notification');
      }
    } catch (e) {
      AppLoggerHelper.error('Error handling notification: $e');
    }
  }

  Future<String?> getFCMToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      AppLoggerHelper.info('FCM Token: $token');
      return token;
    } catch (e) {
      AppLoggerHelper.error('Error getting FCM token: $e');
      return null;
    }
  }

  Future<void> requestNotificationPermission() async {
    try {
      final messaging = FirebaseMessaging.instance;

      final settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        // criticalSound: false,
        provisional: false,
        sound: true,
      );

      AppLoggerHelper.info(
        'Notification permission status: ${settings.authorizationStatus}',
      );
    } catch (e) {
      AppLoggerHelper.error('Error requesting notification permission: $e');
    }
  }
}
