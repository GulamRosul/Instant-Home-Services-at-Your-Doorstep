import 'package:flutter/material.dart';
import 'package:protiva502/core/utils/constants/call_const.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallPage extends StatefulWidget {
  final String callID;
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
    if (!mounted) return;
    setState(() => _statusText = text);
  }

  ZegoUIKitPrebuiltCallConfig _buildConfig() {
    final config = ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

    // ✅ Correct way to set background in v4.x
    config.audioVideoView.backgroundBuilder = (context, size, user, extraInfo) {
      return Container(
        width: size.width,
        height: size.height,
        color: AppColors.textPrimary,
      );
    };

    // ✅ Custom avatar
    config.avatarBuilder = (context, size, user, extraInfo) {
      final initial = (user?.name.isNotEmpty == true)
          ? user!.name[0].toUpperCase()
          : '?';
      return Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.15),
          border: Border.all(color: Colors.white24, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          initial,
          style: TextStyle(
            fontSize: size.width * 0.38,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    };

    // ✅ Hide timer until connected
    config.duration.isVisible = _statusText == 'Connected';

    // ✅ Hide Zego's default top bar
    config.topMenuBar.isVisible = true;
    config.topMenuBar.buttons.insert(
      0,
      ZegoCallMenuBarButtonName.minimizingButton,
    );

    config.bottomMenuBar.margin = const EdgeInsets.only(
      bottom: 48,
      left: 24,
      right: 24,
    );

    return config;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      body: Stack(
        children: [
          // ── Zego Call Widget ──────────────────────────
          ZegoUIKitPrebuiltCall(
            appID: call_Constants.appID,
            appSign: call_Constants.appSign,
            userID: widget.userID,
            userName: widget.userName,
            callID: widget.callID,
            config: _buildConfig(),
            events: ZegoUIKitPrebuiltCallEvents(
              user: ZegoCallUserEvents(onEnter: (_) => _setStatus('Connected')),
            ),
          ),

          // ── Top Bar ───────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            _PulseDot(connected: _statusText == 'Connected'),
                            const SizedBox(width: 6),
                            Text(
                              _statusText,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.75),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Animated pulse dot ────────────────────────────────────────
class _PulseDot extends StatefulWidget {
  final bool connected;
  const _PulseDot({required this.connected});

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.connected ? Colors.greenAccent : Colors.orangeAccent;
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:protiva502/core/utils/constants/call_const.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class AudioCallPage extends StatefulWidget {
//   final String callID; // Unique ID for the call session
//   final String userID;
//   final String userName;
//   final String initialStatus;

//   const AudioCallPage({
//     super.key,
//     required this.callID,
//     required this.userID,
//     required this.userName,
//     this.initialStatus = 'Connecting...',
//   });

//   @override
//   State<AudioCallPage> createState() => _AudioCallPageState();
// }

// class _AudioCallPageState extends State<AudioCallPage> {
//   late String _statusText;

//   @override
//   void initState() {
//     super.initState();
//     _statusText = widget.initialStatus;
//   }

//   void _setStatus(String text) {
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _statusText = text;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final config = ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
//       ..duration.isVisible = true;

//     return Stack(
//       children: [
//         ZegoUIKitPrebuiltCall(
//           appID: call_Constants.appID,
//           appSign: call_Constants.appSign,
//           userID: widget.userID,
//           userName: widget.userName,
//           callID: widget.callID,
//           config: config,
//           // ✅ Pass events directly to the widget, not via config
//           events: ZegoUIKitPrebuiltCallEvents(
//             user: ZegoCallUserEvents(onEnter: (_) => _setStatus('Connected')),
//           ),
//         ),
//         SafeArea(
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               margin: const EdgeInsets.only(top: 16),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 _statusText,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
