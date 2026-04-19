// Add this to your routing or wherever you manage screen navigation
// You can add it as a temporary floating action button or a menu item

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/chat/screen/single_chat_screen.dart';
import 'package:protiva502/features/debug/screens/debug_logs_screen.dart';

// Option 1: Add to SingleChatScreen as a debug button
class ChatScreenWithDebugButton extends StatelessWidget {
  const ChatScreenWithDebugButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Your regular SingleChatScreen widget here
        const SingleChatScreen(),
        // Debug button (remove in production)
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.grey[800],
            onPressed: () {
              Get.to(() => const DebugLogsScreen());
            },
            child: const Icon(Icons.bug_report, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Option 2: Add to your main app routing
void setupDebugRoutes() {
  Get.put(DebugLogsScreen(), tag: 'debugLogs');

  // Add to your routing:
  // GetPage(
  //   name: '/debug/logs',
  //   page: () => const DebugLogsScreen(),
  // ),
}

// Option 3: Quick access via Get.to
void openDebugLogs() {
  Get.to(() => const DebugLogsScreen());
}
