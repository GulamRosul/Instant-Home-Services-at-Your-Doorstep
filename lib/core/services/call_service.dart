// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:protiva502/core/utils/logging/logger.dart';
// import 'package:protiva502/core/services/storage_service.dart';
// import 'package:protiva502/core/utils/constants/call_const.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class CallService {
//   CallService._();
//   static final CallService instance = CallService._();

//   String? _initializedUserId;
//   final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
//     ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
//   }

//   Future<void> _initializeLocalNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ic_notification');

//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//           requestAlertPermission: true,
//           requestBadgePermission: true,
//           requestSoundPermission: true,
//         );

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//           android: initializationSettingsAndroid,
//           iOS: initializationSettingsIOS,
//         );

//     await _localNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Handle notification tap
//       },
//     );

//     try {
//       // Request permission for iOS 10+
//       await _localNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin
//           >()
//           ?.requestPermissions(alert: true, badge: true, sound: true);

//       // Request permission for Android 13+
//       await _localNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin
//           >()
//           ?.requestNotificationsPermission();
//     } catch (e) {
//       AppLoggerHelper.warning('Notification permission request: $e');
//     }
//   }

//   Future<void> initialize({
//     required String userID,
//     required String userName,
//   }) async {
//     final normalizedUserId = userID.trim();
//     if (normalizedUserId.isEmpty) return;

//     await _initializeLocalNotifications();

//     final invitationService = ZegoUIKitPrebuiltCallInvitationService();

//     if (invitationService.isInit && _initializedUserId == normalizedUserId) {
//       return;
//     }

//     if (invitationService.isInit) {
//       await invitationService.uninit();
//     }

//     await invitationService.init(
//       appID: call_Constants.appID,
//       appSign: call_Constants.appSign,
//       userID: normalizedUserId,
//       userName: userName.trim().isEmpty ? 'User' : userName,
//       plugins: [ZegoUIKitSignalingPlugin()],
//       // resourceID: 'Zego_Call',

//       notificationConfig: ZegoCallInvitationNotificationConfig(
//         androidNotificationConfig: ZegoCallAndroidNotificationConfig(
//           showOnLockedScreen: true,
//           showOnFullScreen: true,
//           callChannel: ZegoCallAndroidNotificationChannelConfig(
//             channelID: "zego_call",
//             channelName: "Call Notifications",
//             vibrate: true,
//           ),
//         ),
//         iOSNotificationConfig: ZegoCallIOSNotificationConfig(
//           systemCallingIconName: "CallKitDefaultIcon",
//           isSandboxEnvironment: kDebugMode,
//         ),
//       ),

//       requireConfig: (invitationData) {
//         final config = invitationData.type == ZegoCallInvitationType.videoCall
//             ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
//             : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

//         config.audioVideoView.backgroundBuilder =
//             (context, size, user, extraInfo) {
//               return Container(color: const Color(0xFF1A1A1A));
//             };

//         config.avatarBuilder = (context, size, user, extraInfo) {
//           final initial = (user?.name.isNotEmpty == true)
//               ? user!.name[0].toUpperCase()
//               : '?';
//           return Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white10,
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               initial,
//               style: const TextStyle(color: Colors.white, fontSize: 32),
//             ),
//           );
//         };

//         config.topMenuBar.isVisible = false;
//         return config;
//       },

//       events: ZegoUIKitPrebuiltCallEvents(
//         user: ZegoCallUserEvents(
//           onEnter: (user) {
//             AppLoggerHelper.info('User entered call - enabling wake lock');
//             _enableWakeLock();
//           },
//           onLeave: (user) {
//             AppLoggerHelper.info(
//               'User left call - checking if disabling wake lock',
//             );
//           },
//         ),
//         onCallEnd: (event, defaultAction) {
//           AppLoggerHelper.info('Call ended - disabling wake lock');
//           _disableWakeLock();
//           defaultAction.call();
//         },
//       ),
//     );

//     _initializedUserId = normalizedUserId;
//   }

//   Future<void> initializeFromStorage() async {
//     await StorageService.ensureInitialized();
//     final userId = StorageService.getUserId()?.trim();
//     final userName = StorageService.getDisplayName();
//     if (userId != null && userId.isNotEmpty) {
//       await initialize(userID: userId, userName: userName ?? 'User');
//     }
//   }

//   Future<bool> startAudioCall({
//     required String targetUserId,
//     required String targetUserName,
//     String? callID,
//   }) async {
//     try {
//       final callerName = StorageService.getDisplayName();

//       AppLoggerHelper.info(
//         'Initiating audio call to $targetUserId ($targetUserName) from $callerName',
//       );

//       return await ZegoUIKitPrebuiltCallInvitationService().send(
//         invitees: [ZegoCallUser(targetUserId, targetUserName)],
//         isVideoCall: false,
//         callID: callID,
//         notificationTitle: 'Incoming call',
//         notificationMessage: '$callerName is calling you',
//         resourceID: 'Zego_Call',
//       );
//     } catch (e) {
//       AppLoggerHelper.error('Error starting audio call: $e');
//       return false;
//     }
//   }

//   Future<void> _enableWakeLock() async {
//     try {
//       await WakelockPlus.enable();
//       AppLoggerHelper.info('Wake lock enabled');
//     } catch (e) {
//       AppLoggerHelper.error('Error enabling wake lock: $e');
//     }
//   }

//   Future<void> _disableWakeLock() async {
//     try {
//       await WakelockPlus.disable();
//       AppLoggerHelper.info('Wake lock disabled');
//     } catch (e) {
//       AppLoggerHelper.error('Error disabling wake lock: $e');
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/call_const.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:protiva502/features/audio_call/screens/audio_call.dart';
// Import audioplayers to fix the underlying audio crash configuration
import 'package:audioplayers/audioplayers.dart';

class CallService {
  CallService._();
  static final CallService instance = CallService._();

  String? _initializedUserId;
  GlobalKey<NavigatorState>? _navigatorKey;
  String? lastError;
  final ValueNotifier<String> _outgoingCallStatus = ValueNotifier('Calling...');
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  }

  void _showUnansweredCall(List<ZegoCallUser> callees) {
    final navigator = _navigatorKey?.currentState;
    if (navigator == null || callees.isEmpty) return;

    // The invitation page is dismissed by Zego before this callback. Deferring
    // one frame ensures the result page is placed on the app navigator.
    Future<void>.delayed(const Duration(milliseconds: 250), () async {
      final currentNavigator = _navigatorKey?.currentState;
      if (currentNavigator == null) return;
      await currentNavigator.push(
        MaterialPageRoute<void>(
          builder: (_) => CallUnansweredPage(
            userName: callees.first.name.trim().isEmpty
                ? 'the recipient'
                : callees.first.name,
          ),
        ),
      );
    });
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

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
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);

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

    // CRITICAL FIX: Explicitly configure global context to allow mixWithOthers
    // with a valid playback category before Zego starts up its ringtone service.
    try {
      await AudioPlayer.global.setAudioContext(
        AudioContext(
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.playAndRecord,
            options: const {
              AVAudioSessionOptions.mixWithOthers,
              AVAudioSessionOptions.defaultToSpeaker,
            },
          ),
        ),
      );
    } catch (e) {
      AppLoggerHelper.error('Error setting global audio context: $e');
    }

    await invitationService.init(
      appID: call_Constants.appID,
      appSign: call_Constants.appSign,
      userID: normalizedUserId,
      userName: userName.trim().isEmpty ? 'User' : userName,
      plugins: [ZegoUIKitSignalingPlugin()],

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
          isSandboxEnvironment: kDebugMode,
        ),
      ),
      uiConfig: ZegoCallInvitationUIConfig(
        inviter: ZegoCallInvitationInviterUIConfig(
          showCallingText: false,
          foregroundBuilder: (context, size, info) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 190),
                child: ValueListenableBuilder<String>(
                  valueListenable: _outgoingCallStatus,
                  builder: (_, status, __) => Text(
                    status,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            );
          },
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
            AppLoggerHelper.info('User left call');
          },
        ),
        onCallEnd: (event, defaultAction) async {
          AppLoggerHelper.info(
            'Call ended - disabling wake lock & resetting audio',
          );
          _disableWakeLock();

          // CRITICAL FIX: Revert audio session to simple ambient playback
          // so the hardware channel releases properly for subsequent calls.
          try {
            await AudioPlayer.global.setAudioContext(
              AudioContext(
                iOS: AudioContextIOS(
                  category: AVAudioSessionCategory.ambient,
                  options: const {},
                ),
              ),
            );
          } catch (e) {
            AppLoggerHelper.error('Error resetting audio context: $e');
          }

          // Trigger Zego default teardown actions
          defaultAction.call();
        },
      ),
      invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
        onInvitationUserStateChanged: (users) {
          if (users.any((user) => user.state.name == 'received')) {
            _outgoingCallStatus.value = 'Ringing...';
          } else if (users.any((user) => user.state.name == 'offline')) {
            _outgoingCallStatus.value = 'Calling...';
          }
        },
        onOutgoingCallTimeout: (callID, callees, isVideoCall) {
          AppLoggerHelper.info('Call $callID was unanswered after 30 seconds');
          _showUnansweredCall(callees);
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
      await initialize(userID: userId, userName: userName);
    }
  }

  Future<void> _reinitializeFromStorage() async {
    final invitationService = ZegoUIKitPrebuiltCallInvitationService();
    if (invitationService.isInit) {
      await invitationService.uninit();
    }
    _initializedUserId = null;
    await initializeFromStorage();
  }

  Future<String> _waitForSignalingConnection() async {
    var signalingState = ZegoUIKit().getSignalingPlugin().getConnectionState();
    for (
      var attempt = 0;
      signalingState.name != 'connected' && attempt < 25;
      attempt++
    ) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      signalingState = ZegoUIKit().getSignalingPlugin().getConnectionState();
    }
    return signalingState.name;
  }

  Future<bool> startAudioCall({
    required String targetUserId,
    required String targetUserName,
    String? callID,
  }) async {
    lastError = null;
    _outgoingCallStatus.value = 'Calling...';
    final normalizedTargetUserId = targetUserId.trim();
    if (normalizedTargetUserId.isEmpty) {
      lastError = 'Receiver information is unavailable.';
      return false;
    }

    try {
      final invitationService = ZegoUIKitPrebuiltCallInvitationService();
      if (!invitationService.isInit) {
        AppLoggerHelper.warning(
          'Call invitation service was not initialized; initializing from storage.',
        );
        await initializeFromStorage();
      }

      if (!invitationService.isInit) {
        lastError =
            'Call service is not ready. Please sign in again and retry.';
        AppLoggerHelper.error(lastError!);
        return false;
      }

      var signalingState = await _waitForSignalingConnection();
      if (signalingState != 'connected') {
        AppLoggerHelper.warning(
          'Zego signaling is disconnected; reinitializing the call service.',
        );
        await _reinitializeFromStorage();
        signalingState = await _waitForSignalingConnection();
      }
      AppLoggerHelper.info('Zego signaling state before call: $signalingState');
      if (signalingState != 'connected') {
        lastError = 'Call service is unavailable ($signalingState).';
        AppLoggerHelper.warning(lastError!);
        return false;
      }

      final callerName = StorageService.getDisplayName();

      AppLoggerHelper.info(
        'Initiating audio call to $targetUserId ($targetUserName) from $callerName',
      );

      final didSend = await ZegoUIKitPrebuiltCallInvitationService().send(
        invitees: [ZegoCallUser(normalizedTargetUserId, targetUserName)],
        isVideoCall: false,
        callID: callID,
        notificationTitle: 'Incoming call',
        notificationMessage: '$callerName is calling you',
        resourceID: 'Zego_Call',
        timeoutSeconds: 30,
      );
      if (!didSend) {
        lastError = 'Unable to start the call. Please try again.';
      }
      return didSend;
    } catch (e) {
      AppLoggerHelper.error('Error starting audio call: $e');
      lastError = 'Unable to start the call. Please try again.';
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
