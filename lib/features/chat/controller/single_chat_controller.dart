import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Mock initial messages
  var messages = <Map<String, dynamic>>[
    {'message': 'Hello! How can I help you today?', 'isMe': false, 'time': '10:00 AM'},
    {'message': 'I need some help with my kitchen cabinets.', 'isMe': true, 'time': '10:01 AM'},
    {'message': 'Sure, I can help with that. What seems to be the issue?', 'isMe': false, 'time': '10:02 AM'},
  ].obs;

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      messages.add({
        'message': messageController.text.trim(),
        'isMe': true,
        'time': '10:05 AM',
      });
      messageController.clear();
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    // Delay ensures the frame is rendered before scrolling
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}