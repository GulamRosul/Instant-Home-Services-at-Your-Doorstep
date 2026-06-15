import 'package:flutter/material.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/call_const.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CallService {
  CallService._();
  static final CallService instance = CallService._();

  String? _initializedUserId;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
      },
    );

    try {
      // Request permission for iOS 10+
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      // Request permission for Android 13+
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    } catch (e) {
      AppLoggerHelper.warning('Notification permission request: $e');
    }
  }

  Future<void> initialize({
    required String userID,
    required String userName,
  }) async {
    final normalizedUserId = userID.trim();
    if (normalizedUserId.isEmpty) return;

    await _initializeLocalNotifications();

    final invitationService = ZegoUIKitPrebuiltCallInvitationService();

    if (invitationService.isInit && _initializedUserId == normalizedUserId) {
      return;
    }

    if (invitationService.isInit) {
      await invitationService.uninit();
    }

    await invitationService.init(
      appID: call_Constants.appID,
      appSign: call_Constants.appSign,
      userID: normalizedUserId,
      userName: userName.trim().isEmpty ? 'User' : userName,
      plugins: [ZegoUIKitSignalingPlugin()],
      // resourceID: 'Zego_Call',

      notificationConfig: ZegoCallInvitationNotificationConfig(
        androidNotificationConfig: ZegoCallAndroidNotificationConfig(
          showOnLockedScreen: true,
          showOnFullScreen: true,
          callChannel: ZegoCallAndroidNotificationChannelConfig(
            channelID: "zego_call",
            channelName: "Call Notifications",
            vibrate: true,
          ),
        ),
        iOSNotificationConfig: ZegoCallIOSNotificationConfig(
          systemCallingIconName: "CallKitDefaultIcon",
          isSandboxEnvironment: true,
        ),
      ),

      requireConfig: (invitationData) {
        final config = invitationData.type == ZegoCallInvitationType.videoCall
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

        config.audioVideoView.backgroundBuilder =
            (context, size, user, extraInfo) {
              return Container(color: const Color(0xFF1A1A1A));
            };

        config.avatarBuilder = (context, size, user, extraInfo) {
          final initial = (user?.name.isNotEmpty == true)
              ? user!.name[0].toUpperCase()
              : '?';
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white10,
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: const TextStyle(color: Colors.white, fontSize: 32),
            ),
          );
        };

        config.topMenuBar.isVisible = false;
        return config;
      },

      events: ZegoUIKitPrebuiltCallEvents(
        user: ZegoCallUserEvents(
          onEnter: (user) {
            AppLoggerHelper.info('User entered call - enabling wake lock');
            _enableWakeLock();
          },
          onLeave: (user) {
            AppLoggerHelper.info(
              'User left call - checking if disabling wake lock',
            );
          },
        ),
        onCallEnd: (event, defaultAction) {
          AppLoggerHelper.info('Call ended - disabling wake lock');
          _disableWakeLock();
          defaultAction.call();
        },
      ),
    );

    _initializedUserId = normalizedUserId;
  }

  Future<void> initializeFromStorage() async {
    await StorageService.ensureInitialized();
    final userId = StorageService.getUserId()?.trim();
    final userName = StorageService.getDisplayName();
    if (userId != null && userId.isNotEmpty) {
      await initialize(userID: userId, userName: userName ?? 'User');
    }
  }

  Future<bool> startAudioCall({
    required String targetUserId,
    required String targetUserName,
    String? callID,
  }) async {
    try {
      final callerName = StorageService.getDisplayName();

      AppLoggerHelper.info(
        'Initiating audio call to $targetUserId ($targetUserName) from $callerName',
      );

      return await ZegoUIKitPrebuiltCallInvitationService().send(
        invitees: [ZegoCallUser(targetUserId, targetUserName)],
        isVideoCall: false,
        callID: callID,
        notificationTitle: 'Incoming call',
        notificationMessage: '$callerName is calling you',
        resourceID: 'Zego_Call',
      );
    } catch (e) {
      AppLoggerHelper.error('Error starting audio call: $e');
      return false;
    }
  }

  Future<void> _enableWakeLock() async {
    try {
      await WakelockPlus.enable();
      AppLoggerHelper.info('Wake lock enabled');
    } catch (e) {
      AppLoggerHelper.error('Error enabling wake lock: $e');
    }
  }

  Future<void> _disableWakeLock() async {
    try {
      await WakelockPlus.disable();
      AppLoggerHelper.info('Wake lock disabled');
    } catch (e) {
      AppLoggerHelper.error('Error disabling wake lock: $e');
    }
  }
}
