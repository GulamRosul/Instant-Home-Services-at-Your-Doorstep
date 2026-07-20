// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:protiva502/core/utils/constants/call_const.dart';
// import 'package:protiva502/core/utils/constants/colors.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class AudioCallPage extends StatefulWidget {
//   final String callID;
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
//   bool _isDisposing = false;

//   @override
//   void initState() {
//     super.initState();
//     _statusText = widget.initialStatus;
//   }

//   @override
//   void dispose() {
//     _isDisposing = true;
//     super.dispose();
//   }

//   void _setStatus(String text) {
//     if (!mounted || _isDisposing) return;
//     setState(() => _statusText = text);
//   }

//   ZegoUIKitPrebuiltCallConfig _buildConfig() {
//     final config = ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

//     config.audioVideoView.backgroundBuilder = (context, size, user, extraInfo) {
//       return Container(
//         width: size.width,
//         height: size.height,
//         color: AppColors.textPrimary,
//       );
//     };

//     config.avatarBuilder = (context, size, user, extraInfo) {
//       final initial = (user?.name.isNotEmpty == true)
//           ? user!.name[0].toUpperCase()
//           : '?';
//       return Container(
//         width: size.width,
//         height: size.height,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white.withOpacity(0.15),
//           border: Border.all(color: Colors.white24, width: 2),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           initial,
//           style: TextStyle(
//             fontSize: size.width * 0.38,
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       );
//     };

//     config.duration.isVisible = _statusText == 'Connected';
//     config.topMenuBar.isVisible = false;
//     config.bottomMenuBar.margin = const EdgeInsets.only(
//       bottom: 48,
//       left: 24,
//       right: 24,
//     );

//     config.hangUpConfirmDialog = ZegoCallHangUpConfirmDialogConfig(
//       // info: 'End the call?',
//     );

//     return config;
//   }

//   Uint8List _convertHexToBytes(String hex) {
//     final buffer = StringBuffer();
//     for (int i = 0; i < hex.length; i += 2) {
//       buffer.write(
//         String.fromCharCode(int.parse(hex.substring(i, i + 2), radix: 16)),
//       );
//     }
//     return Uint8List.fromList(buffer.toString().codeUnits);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.textPrimary,
//       body: Stack(
//         children: [
//           // ── Zego Call Widget ──────────────────────────
//           ZegoUIKitPrebuiltCall(
//             appID: call_Constants.appID,
//             // appSign: _convertHexToBytes(call_Constants.appSign),
//             appSign: call_Constants.appSign,
//             userID: widget.userID,
//             userName: widget.userName,
//             callID: widget.callID,
//             config: _buildConfig(),
//             events: ZegoUIKitPrebuiltCallEvents(
//               user: ZegoCallUserEvents(onEnter: (_) => _setStatus('Connected')),
//               onHangUpConfirmation: (event, defaultAction) async {
//                 return true;
//               },
//               onCallEnd: (event, defaultAction) async {
//                 if (!mounted) return;
//                 await Future.delayed(const Duration(milliseconds: 500));
//                 if (mounted && Navigator.of(context).canPop()) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     if (mounted && Navigator.of(context).canPop()) {
//                       Navigator.of(context).pop();
//                     }
//                   });
//                 }
//               },
//             ),
//           ),

//           // ── Top Bar ───────────────────────────────────
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       if (Navigator.of(context).canPop()) {
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.12),
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           widget.userName,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 17,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.2,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 2),
//                         Row(
//                           children: [
//                             _PulseDot(connected: _statusText == 'Connected'),
//                             const SizedBox(width: 6),
//                             Text(
//                               _statusText,
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.75),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Animated pulse dot ────────────────────────────────────────
// class _PulseDot extends StatefulWidget {
//   final bool connected;
//   const _PulseDot({required this.connected});

//   @override
//   State<_PulseDot> createState() => _PulseDotState();
// }

// class _PulseDotState extends State<_PulseDot>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _ctrl;
//   late final Animation<double> _anim;

//   @override
//   void initState() {
//     super.initState();
//     _ctrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     )..repeat(reverse: true);
//     _anim = Tween<double>(
//       begin: 0.4,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
//   }

//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final color = widget.connected ? Colors.greenAccent : Colors.orangeAccent;
//     return FadeTransition(
//       opacity: _anim,
//       child: Container(
//         width: 7,
//         height: 7,
//         decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // CRITICAL: Reset audio stack on page close
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
  bool _isDisposing = false;

  @override
  void initState() {
    super.initState();
    _statusText = widget.initialStatus;
  }

  @override
  void dispose() {
    _isDisposing = true;
    super.dispose();
  }

  void _setStatus(String text) {
    if (!mounted || _isDisposing) return;
    setState(() => _statusText = text);
  }

  ZegoUIKitPrebuiltCallConfig _buildConfig() {
    final config = ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

    config.audioVideoView.backgroundBuilder = (context, size, user, extraInfo) {
      return Container(
        width: size.width,
        height: size.height,
        color: AppColors.textPrimary,
      );
    };

    config.avatarBuilder = (context, size, user, extraInfo) {
      final initial = (user?.name.isNotEmpty == true)
          ? user!.name[0].toUpperCase()
          : '?';
      return Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.15),
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

    config.duration.isVisible = _statusText == 'Connected';
    config.topMenuBar.isVisible = false;
    config.bottomMenuBar.margin = const EdgeInsets.only(
      bottom: 48,
      left: 24,
      right: 24,
    );

    config.hangUpConfirmDialog = ZegoCallHangUpConfirmDialogConfig();

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
              user: ZegoCallUserEvents(
                onEnter: (_) => _setStatus('Connected'),
              ),
              onHangUpConfirmation: (event, defaultAction) async {
                return true;
              },
              onCallEnd: (event, defaultAction) async {
                // 1. Inform Zego Signaling engine to clean up current call state globally
                defaultAction.call(); 
                
                // 2. Free up hardware audio pipeline to avoid second call audio zombie crash
                try {
                  await AudioPlayer.global.setAudioContext(AudioContext(
                    iOS: AudioContextIOS(
                      category: AVAudioSessionCategory.ambient,
                      options: const {},
                    ),
                  ));
                } catch (_) {}

                // 3. Safe Pop validation routine
                if (!mounted) return;
                await Future.delayed(const Duration(milliseconds: 300));
                if (mounted && Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),

          // ── Top Bar ───────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handing fallback pop safely via Zego engine instance
                      ZegoUIKitPrebuiltCallController().hangUp(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
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
                                color: Colors.white.withValues(alpha: 0.75),
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

class _PulseDot extends StatefulWidget {
  final bool connected;
  const _PulseDot({required this.connected});

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
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
