import 'package:flutter/material.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/call_const.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallService {
  CallService._();

  static final CallService instance = CallService._();

  String? _initializedUserId;
  String? _lastError;

  String? get lastError => _lastError;

  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  }

  Future<void> initializeFromStorage() async {
    await StorageService.ensureInitialized();

    if (!StorageService.hasActiveSession()) {
      return;
    }

    final userId = (StorageService.getUserId() ?? '').trim();
    if (userId.isEmpty) {
      return;
    }

    final userName = StorageService.getDisplayName();
    await initialize(userID: userId, userName: userName);
  }

  Future<void> initialize({
    required String userID,
    required String userName,
  }) async {
    _lastError = null;
    final normalizedUserId = userID.trim();
    final normalizedUserName = userName.trim().isEmpty ? 'User' : userName;

    if (normalizedUserId.isEmpty) {
      _lastError = 'Current user ID is empty';
      return;
    }

    final invitationService = ZegoUIKitPrebuiltCallInvitationService();

    if (invitationService.isInit && _initializedUserId == normalizedUserId) {
      return;
    }

    if (invitationService.isInit) {
      invitationService.uninit();
    }

    await invitationService.init(
      appID: call_Constants.appID,
      appSign: call_Constants.appSign,
      userID: normalizedUserId,
      userName: normalizedUserName,
      plugins: [ZegoUIKitSignalingPlugin()],
      requireConfig: (invitationData) {
        if (invitationData.type == ZegoCallInvitationType.videoCall) {
          return ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();
        }

        return ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
      },
    );

    _initializedUserId = normalizedUserId;
    AppLoggerHelper.info(
      'Call service initialized for userId=$normalizedUserId',
    );
  }

  Future<void> uninitialize() async {
    final invitationService = ZegoUIKitPrebuiltCallInvitationService();

    if (invitationService.isInit) {
      invitationService.uninit();
    }

    _initializedUserId = null;
  }

  Future<bool> startAudioCall({
    required String targetUserId,
    required String targetUserName,
    String? callID,
  }) async {
    _lastError = null;
    final inviteeId = targetUserId.trim();
    if (inviteeId.isEmpty) {
      _lastError = 'Target user ID is empty';
      return false;
    }

    if (!ZegoUIKitPrebuiltCallInvitationService().isInit) {
      await initializeFromStorage();
    }

    if (!ZegoUIKitPrebuiltCallInvitationService().isInit) {
      _lastError =
          'Invitation service is not initialized. Ensure both users are logged in.';
      return false;
    }

    final callerName = StorageService.getDisplayName();
    final normalizedCallId = callID?.trim();

    try {
      final didSend = await ZegoUIKitPrebuiltCallInvitationService().send(
        invitees: [ZegoCallUser(inviteeId, targetUserName.trim())],
        isVideoCall: false,
        callID: (normalizedCallId == null || normalizedCallId.isEmpty)
            ? null
            : normalizedCallId,
        notificationTitle: 'Incoming call',
        notificationMessage: '$callerName is calling you',
        timeoutSeconds: 60,
      );

      if (!didSend) {
        _lastError =
            'Call invite send failed. Receiver may be offline or not initialized in signaling.';
      }

      return didSend;
    } catch (e) {
      _lastError = 'Exception while sending invite: $e';
      AppLoggerHelper.error('Call invitation error', e);
      return false;
    }
  }
}
