import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/socket_io_service.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';

class SingleChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Socket.IO Service
  late SocketIOService socketService;

  // Chat Data
  var messages = <Map<String, dynamic>>[].obs;
  late Rx<String> bookingId = ''.obs;
  late Rx<String> receiverId = ''.obs;
  late Rx<String> currentUserId = ''.obs;
  late Rx<String> otherUserName = 'Provider'.obs;
  late Rx<String> userRole = ''.obs; // 'user' or 'provider'
  late Rx<bool> isOtherUserTyping = false.obs;
  late Rx<String> connectionStatus = 'Connecting...'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadChatArguments();
    _initializeSocket();
  }

  /// Load chat arguments passed from previous screen
  void _loadChatArguments() {
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      bookingId.value = arguments['bookingId'] ?? '';
      currentUserId.value =
          arguments['userId'] ?? StorageService.getUserId() ?? 'user_123';
      userRole.value =
          arguments['userRole'] ?? StorageService.getRole() ?? 'user';
      otherUserName.value = arguments['providerName'] ?? 'Provider';

      // Determine receiverId based on userRole
      if (userRole.value == 'provider') {
        // Provider sends to client
        receiverId.value = arguments['clientId'] ?? '';
      } else {
        // User (client) sends to provider
        receiverId.value = arguments['providerId'] ?? '';
      }

      // Fallback: if receiverId is still empty, try to infer from other arguments
      if (receiverId.value.isEmpty) {
        if (userRole.value == 'provider' &&
            arguments.containsKey('receiverId')) {
          receiverId.value = arguments['receiverId'];
        } else if (userRole.value == 'user' &&
            arguments.containsKey('receiverId')) {
          receiverId.value = arguments['receiverId'];
        }
      }

      // Log for debugging
      print('Chat initialized:');
      print('  BookingId: ${bookingId.value}');
      print('  CurrentUserId: ${currentUserId.value}');
      print('  ReceiverId: ${receiverId.value}');
      print('  UserRole: ${userRole.value}');
      print('  OtherUserName: ${otherUserName.value}');
    }
  }

  /// Initialize Socket.IO connection for messaging
  Future<void> _initializeSocket() async {
    socketService = SocketIOService();

    // Setup callbacks
    socketService.onMessageReceived = _handleMessageReceived;
    socketService.onMessageRead = _handleMessageRead;
    socketService.onTypingStart = _handleTypingStart;
    socketService.onTypingStop = _handleTypingStop;
    socketService.onMessageDeleted = _handleMessageDeleted;
    socketService.onError = _handleError;

    // Get auth token from secure storage
    final token = await SecureStorageService.getToken();

    // Connect to socket with auth token
    socketService.connect(userId: currentUserId.value, token: token);

    // Join messaging room
    if (bookingId.value.isNotEmpty) {
      socketService.joinMessagingRoom(bookingId.value);
      connectionStatus.value = 'Connected';
    }
  }

  /// Handle incoming message
  void _handleMessageReceived(Map<String, dynamic> data) {
    try {
      final message = data['content'] ?? '';
      final senderName = data['senderName'] ?? otherUserName.value;
      final messageId = data['messageId'] ?? _generateMessageId();
      final messageType = data['messageType'] ?? 'TEXT';

      messages.add({
        'message': message,
        'isMe': false,
        'time': _getCurrentTime(),
        'messageId': messageId,
        'messageType': messageType,
        'isRead': false,
        'senderId': data['senderId'],
      });

      // Auto-scroll to latest message
      scrollToBottom();

      // Mark message as read
      if (messageId.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          socketService.markMessagesAsRead([messageId]);
        });
      }

      print('Message received: $message');
    } catch (e) {
      print('Error handling received message: $e');
    }
  }

  /// Handle message read receipt
  void _handleMessageRead(Map<String, dynamic> data) {
    try {
      final messageIds = data['messageIds'] as List<dynamic>?;
      if (messageIds != null) {
        // Update UI to show message read status
        for (var msg in messages) {
          if (messageIds.contains(msg['messageId'])) {
            msg['isRead'] = true;
          }
        }
        messages.refresh(); // Notify observers
      }
    } catch (e) {
      print('Error handling message read: $e');
    }
  }

  /// Handle other user typing
  void _handleTypingStart(String userId) {
    if (userId == receiverId.value) {
      isOtherUserTyping.value = true;
    }
  }

  /// Handle other user stopped typing
  void _handleTypingStop(String userId) {
    if (userId == receiverId.value) {
      isOtherUserTyping.value = false;
    }
  }

  /// Handle message deletion
  void _handleMessageDeleted(String messageId) {
    messages.removeWhere((msg) => msg['messageId'] == messageId);
    messages.refresh();
    print('Message deleted: $messageId');
  }

  /// Handle socket errors
  void _handleError(String error) {
    connectionStatus.value = 'Error: $error';
    print('Socket error: $error');
  }

  /// Send a message
  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    // Validate receiverId is set
    if (receiverId.value.isEmpty) {
      print('Error: Receiver ID not set. Cannot send message.');
      print(
        'Current state: receiverId=$receiverId, userRole=$userRole.value, bookingId=$bookingId.value',
      );
      Get.snackbar('Error', 'Cannot send message: receiver not found');
      return;
    }

    final messageText = messageController.text.trim();
    final messageId = _generateMessageId();

    // Add to local messages immediately for UI feedback
    messages.add({
      'message': messageText,
      'isMe': true,
      'time': _getCurrentTime(),
      'messageId': messageId,
      'messageType': 'TEXT',
      'isRead': false,
      'senderId': currentUserId.value,
    });

    messageController.clear();
    scrollToBottom();

    // Send via socket
    socketService.sendMessage(
      receiverId: receiverId.value,
      content: messageText,
      messageType: 'TEXT',
    );

    // Emit typing stop after sending
    socketService.emitTypingStop();
  }

  /// Emit typing indicator when user starts typing
  void emitTypingStart() {
    socketService.emitTypingStart();
  }

  /// Emit typing stop when user finishes typing
  void emitTypingStop() {
    socketService.emitTypingStop();
  }

  /// Delete a message
  void deleteMessage(String messageId) {
    socketService.deleteMessage(messageId);
    messages.removeWhere((msg) => msg['messageId'] == messageId);
    messages.refresh();
  }

  /// Get current time in HH:MM format
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  /// Generate unique message ID
  String _generateMessageId() {
    return 'msg_${DateTime.now().millisecondsSinceEpoch}_${(DateTime.now().microsecond).toString().padLeft(6, '0')}';
  }

  /// Scroll to bottom of chat
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
    socketService.leaveRoom();
    socketService.disconnect();
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
