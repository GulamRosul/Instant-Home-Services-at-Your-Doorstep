import 'package:flutter/material.dart';
import 'package:protiva502/core/utils/constants/call_const.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallPage extends StatelessWidget {
  final String callID; // Unique ID for the call session
  final String userID;
  final String userName;

  const AudioCallPage({
    Key? key,
    required this.callID,
    required this.userID,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: call_Constants.appID,     // From ZEGOCLOUD Console
      appSign: call_Constants.appSign, // From ZEGOCLOUD Console
      userID: userID,
      userName: userName,
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}