import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';

class NotificationController extends GetxController {
  // Mock data for notifications
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Booking Accepted',
      'message': 'Mike Handyman has accepted your Carpentry request.',
      'time': '10:30 AM',
      'isRead': false,
      'type': 'booking',
      'dateGroup': 'Today',
    },
    {
      'title': 'Payment Successful',
      'message': 'Your payment of ৳ 450.00 was successful.',
      'time': '09:15 AM',
      'isRead': true,
      'type': 'payment',
      'dateGroup': 'Today',
    },
    {
      'title': 'New Service Available',
      'message': 'New plumbing services are now available in your area.',
      'time': 'Yesterday',
      'isRead': true,
      'type': 'system',
      'dateGroup': 'Yesterday',
    },
  ].obs;

  late FirebaseMessaging _firebaseMessaging;
  String? _fcmToken;

  @override
  void onInit() {
    super.onInit();
    _initializeFirebaseMessaging();
  }

  /// Initialize Firebase Messaging
  Future<void> _initializeFirebaseMessaging() async {
    try {
      _firebaseMessaging = FirebaseMessaging.instance;

      // Request permissions (required for iOS)
      if (Platform.isIOS) {
        final NotificationSettings settings = await _firebaseMessaging
            .requestPermission(
              alert: true,
              announcement: false,
              badge: true,
              carPlay: false,
              criticalAlert: false,
              provisional: false,
              sound: true,
            );

        debugPrint(
          '🔔 [NOTIFICATION] iOS permission status: ${settings.authorizationStatus}',
        );
      }

      // Get FCM token
      await _getFcmToken();

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _handleTokenRefresh(newToken);
      });

      // Handle foreground notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleForegroundNotification(message);
      });

      // Handle notification when app is opened from a notification
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationTap(message);
      });

      debugPrint('✅ [NOTIFICATION] Firebase Messaging initialized');
    } catch (e, stackTrace) {
      debugPrint('❌ [NOTIFICATION] Failed to initialize Firebase: $e');
      debugPrint('❌ [NOTIFICATION] Stack trace: $stackTrace');
    }
  }

  /// Get FCM token from Firebase with retry mechanism for iOS
  Future<void> _getFcmToken() async {
    int retries = 0;
    const maxRetries = 5;
    const delayMs = 1000;

    while (retries < maxRetries) {
      try {
        final token = await _firebaseMessaging.getToken();

        if (token != null && token.isNotEmpty) {
          _fcmToken = token;

          // Print token for debugging
          debugPrint('🔑 [FCM TOKEN] FCM Token: $token');
          log('FCM Token retrieved: $token');

          // Save token to secure storage
          await SecureStorageService.saveFcmToken(token);
          debugPrint('💾 [FCM TOKEN] Token saved to secure storage');
          return; // Success, exit retry loop
        }
      } catch (e) {
        // On iOS, APNS token may not be ready immediately
        debugPrint(
          '⏳ [FCM TOKEN] Retry $retries/$maxRetries - Token not available yet',
        );
      }

      // Wait before retrying
      await Future.delayed(const Duration(milliseconds: delayMs));
      retries++;
    }

    debugPrint('❌ [FCM TOKEN] Failed to get token after $maxRetries retries');
  }

  /// Handle token refresh
  void _handleTokenRefresh(String newToken) {
    debugPrint('🔄 [FCM TOKEN] Token refreshed: $newToken');
    _fcmToken = newToken;
    SecureStorageService.saveFcmToken(newToken);
  }

  /// Handle foreground notifications
  void _handleForegroundNotification(RemoteMessage message) {
    debugPrint('📬 [NOTIFICATION] Foreground message received');
    debugPrint('📬 [NOTIFICATION] Title: ${message.notification?.title}');
    debugPrint('📬 [NOTIFICATION] Body: ${message.notification?.body}');
    debugPrint('📬 [NOTIFICATION] Data: ${message.data}');

    // Add to notifications list
    notifications.insert(0, {
      'title': message.notification?.title ?? 'Notification',
      'message': message.notification?.body ?? '',
      'time': DateTime.now().toString(),
      'isRead': false,
      'type': message.data['type'] ?? 'general',
      'dateGroup': 'Today',
    });

    // Show a dialog or toast if needed
    Get.snackbar(
      message.notification?.title ?? 'Notification',
      message.notification?.body ?? '',
      duration: const Duration(seconds: 4),
    );
  }

  /// Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('👆 [NOTIFICATION] Notification tapped');
    debugPrint('👆 [NOTIFICATION] Title: ${message.notification?.title}');
    debugPrint('👆 [NOTIFICATION] Body: ${message.notification?.body}');
    debugPrint('👆 [NOTIFICATION] Data: ${message.data}');

    // Navigate based on notification type
    _navigateBasedOnNotification(message);
  }

  /// Navigate based on notification data
  void _navigateBasedOnNotification(RemoteMessage message) {
    final type = message.data['type'];
    debugPrint('🗺️ [NAVIGATION] Navigating based on type: $type');

    switch (type) {
      case 'booking':
        // Navigate to booking details
        break;
      case 'payment':
        // Navigate to payment details
        break;
      case 'message':
        // Navigate to chat
        break;
      default:
        // Navigate to notification screen
        break;
    }
  }

  /// Get the current FCM token
  String? getFcmToken() => _fcmToken;

  /// Get FCM token from secure storage
  Future<String?> getStoredFcmToken() async {
    return await SecureStorageService.getFcmToken();
  }

  void markAsRead(int index) {
    notifications[index]['isRead'] = true;
  }

  void clearAll() {
    notifications.clear();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
