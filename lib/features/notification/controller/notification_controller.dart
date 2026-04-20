import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/notification/model/notification_model.dart';

class NotificationController extends GetxController {
  final RxList<Map<String, dynamic>> notifications =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  final ApiClient _apiClient = ApiClient();

  late FirebaseMessaging _firebaseMessaging;
  String? _fcmToken;

  @override
  void onInit() {
    super.onInit();
    _initializeFirebaseMessaging();
    fetchNotifications();
  }

  /// Fetch notifications from API
  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      error.value = '';

      debugPrint('📡 [NOTIFICATION] Fetching notifications from API...');
      final response = await _apiClient.get(ApiEndpoints.getNotifications);

      debugPrint('📡 [NOTIFICATION] Response status: ${response.statusCode}');
      debugPrint(
        '📡 [NOTIFICATION] Response data type: ${response.data.runtimeType}',
      );
      debugPrint('📡 [NOTIFICATION] Response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        debugPrint('📡 [NOTIFICATION] Data keys: ${data.keys}');
        debugPrint(
          '📡 [NOTIFICATION] Data[data] type: ${data['data'].runtimeType}',
        );

        if (data['data'] is List) {
          final List<dynamic> notificationList = data['data'];
          debugPrint(
            '📡 [NOTIFICATION] Found ${notificationList.length} notifications in list',
          );

          final List<Map<String, dynamic>> formattedNotifications = [];

          for (final item in notificationList) {
            try {
              final notification = NotificationModel.fromJson(item);
              formattedNotifications.add(
                _formatNotificationForDisplay(notification),
              );
            } catch (e) {
              debugPrint('❌ [NOTIFICATION] Error parsing item: $e');
            }
          }

          notifications.value = formattedNotifications;
          debugPrint(
            '✅ [NOTIFICATION] Successfully formatted ${formattedNotifications.length} notifications',
          );
        } else {
          debugPrint(
            '❌ [NOTIFICATION] data[data] is not a List: ${data['data'].runtimeType}',
          );
        }
      } else {
        error.value = 'Failed to fetch notifications: ${response.statusCode}';
        debugPrint(
          '❌ [NOTIFICATION] Failed to fetch notifications: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      error.value = 'Error fetching notifications: $e';
      debugPrint('❌ [NOTIFICATION] Error fetching notifications: $e');
      debugPrint('❌ [NOTIFICATION] Stack trace: $stackTrace');
    } finally {
      isLoading.value = false;
    }
  }

  /// Format notification for display
  Map<String, dynamic> _formatNotificationForDisplay(
    NotificationModel notification,
  ) {
    return {
      'id': notification.id,
      'title': notification.title,
      'message': notification.message,
      'time': _formatTime(notification.createdAt),
      'isRead': notification.isRead,
      'type': _mapNotificationType(notification.type),
      'dateGroup': _getDateGroup(notification.createdAt),
      'fullNotification': notification,
    };
  }

  /// Format time to display format
  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final notificationDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );

    if (notificationDate == today) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (notificationDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }

  /// Get date group for notifications
  String _getDateGroup(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final notificationDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );

    if (notificationDate == today) {
      return 'Today';
    } else if (notificationDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d, yyyy').format(dateTime);
    }
  }

  /// Map API notification type to display type
  String _mapNotificationType(String type) {
    switch (type) {
      case 'BOOKING_NEW':
      case 'BOOKING_ACCEPTED':
      case 'BOOKING_REJECTED':
      case 'BOOKING_CANCELLED':
        return 'booking';
      case 'PAYMENT_SUCCESSFUL':
      case 'PAYMENT_FAILED':
      case 'WITHDRAW_REQUEST':
        return 'payment';
      case 'MESSAGE':
        return 'message';
      default:
        return 'system';
    }
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
      } else if (Platform.isAndroid) {
        // For Android, we need to set up notification channel
        debugPrint('🔔 [NOTIFICATION] Setting up Android notifications...');
        // Note: AndroidNotificationChannel setup should be in main.dart
        // This is just a log to indicate Android handling
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

      // Handle notification when app is terminated and opened by tapping notification
      final RemoteMessage? initialMessage = await _firebaseMessaging
          .getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationTap(initialMessage);
      }

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
    // Token refresh will be sent to backend on next login
    debugPrint('💾 [FCM TOKEN] Token refreshed and saved to secure storage');
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

  /// Refresh notifications from API
  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
