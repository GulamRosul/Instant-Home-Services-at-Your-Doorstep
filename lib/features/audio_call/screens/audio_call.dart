import 'package:flutter/material.dart';
import 'package:protiva502/core/utils/constants/call_const.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallPage extends StatefulWidget {
  final String callID; // Unique ID for the call session
  final String userID;
  final String userName;
  final String initialStatus;

  const AudioCallPage({
    super.key,
    required this.callID,
    required this.userID,
    required this.userName,
    this.initialStatus = 'Connecting...',
  });

  @override
  State<AudioCallPage> createState() => _AudioCallPageState();
}

class _AudioCallPageState extends State<AudioCallPage> {
  late String _statusText;

  @override
  void initState() {
    super.initState();
    _statusText = widget.initialStatus;
  }

  void _setStatus(String text) {
    if (!mounted) {
      return;
    }

    setState(() {
      _statusText = text;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final config = ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
      ..duration.isVisible = true;

    return Stack(
      children: [
        ZegoUIKitPrebuiltCall(
          appID: call_Constants.appID,
          appSign: call_Constants.appSign,
          userID: widget.userID,
          userName: widget.userName,
          callID: widget.callID,
          config: config,
          // ✅ Pass events directly to the widget, not via config
          events: ZegoUIKitPrebuiltCallEvents(
            user: ZegoCallUserEvents(onEnter: (_) => _setStatus('Connected')),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _statusText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
