import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/socket_io_service.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/services/debug_logger_service.dart';

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

        // FIX: If clientId equals currentUserId (backend sends wrong ID),
        // try to use the userId from arguments or look for the other party
        if (receiverId.value == currentUserId.value ||
            receiverId.value.isEmpty) {
          // Try alternative argument names
          if (arguments.containsKey('userId') &&
              arguments['userId'] != currentUserId.value) {
            receiverId.value = arguments['userId'];
          } else if (arguments.containsKey('receiverId')) {
            receiverId.value = arguments['receiverId'];
          }
        }
      } else {
        // User (client) sends to provider
        receiverId.value = arguments['providerId'] ?? '';
      }

      // Additional fallback: if receiverId is still empty or matches currentUserId
      if (receiverId.value.isEmpty || receiverId.value == currentUserId.value) {
        if (userRole.value == 'provider' &&
            arguments.containsKey('receiverId')) {
          receiverId.value = arguments['receiverId'];
        } else if (userRole.value == 'user' &&
            arguments.containsKey('receiverId')) {
          receiverId.value = arguments['receiverId'];
        }
      }

      // Log for debugging
      DebugLoggerService.chatAction(
        'Chat initialized from arguments',
        data: {
          'bookingId': bookingId.value,
          'currentUserId': currentUserId.value,
          'receiverId': receiverId.value,
          'userRole': userRole.value,
          'otherUserName': otherUserName.value,
          'allArguments': arguments,
        },
      );

      print('Chat initialized:');
      print('  BookingId: ${bookingId.value}');
      print('  CurrentUserId: ${currentUserId.value}');
      print('  ReceiverId: ${receiverId.value}');
      print('  UserRole: ${userRole.value}');
      print('  OtherUserName: ${otherUserName.value}');

      // Validate receiverId is not the same as currentUserId
      if (receiverId.value == currentUserId.value) {
        DebugLoggerService.error(
          'CHAT',
          '⚠️ CRITICAL: ReceiverId matches CurrentUserId - messages will be sent to self!',
          error: {
            'currentUserId': currentUserId.value,
            'receiverId': receiverId.value,
            'userRole': userRole.value,
          },
        );
        // Defer snackbar to after build phase
        Future.microtask(() {
          Get.snackbar(
            'Error',
            'Chat initialization failed: Invalid receiver ID',
            duration: const Duration(seconds: 5),
          );
        });
      }
    } else {
      DebugLoggerService.error(
        'CHAT',
        'No arguments provided to chat screen',
        error: arguments,
      );
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
    DebugLoggerService.log(
      'AUTH',
      'Token retrieved',
      data: {'tokenLength': token?.length ?? 0},
    );

    // Connect to socket with auth token
    DebugLoggerService.log(
      'SOCKET',
      'Initiating socket connection',
      data: {
        'userId': currentUserId.value,
        'hasToken': token != null && token.isNotEmpty,
      },
    );
    socketService.connect(userId: currentUserId.value, token: token);

    // Join messaging room
    if (bookingId.value.isNotEmpty) {
      DebugLoggerService.log(
        'SOCKET',
        'Joining messaging room',
        data: {
          'bookingId': bookingId.value,
          'userId': currentUserId.value,
          'receiverId': receiverId.value,
        },
      );
      socketService.joinMessagingRoom(bookingId.value);
      connectionStatus.value = 'Connected';
    } else {
      DebugLoggerService.error(
        'SOCKET',
        'Cannot join room: bookingId is empty',
      );
      connectionStatus.value = 'Error: No booking ID';
    }
  }

  /// Handle incoming message
  void _handleMessageReceived(Map<String, dynamic> data) {
    try {
      final message = data['content'] ?? '';
      final senderName = data['senderName'] ?? otherUserName.value;
      final messageId = data['messageId'] ?? _generateMessageId();
      final messageType = data['messageType'] ?? 'TEXT';

      DebugLoggerService.chatAction(
        'Displaying received message on UI',
        data: {
          'messageId': messageId,
          'senderId': data['senderId'],
          'contentLength': message.length,
          'messageType': messageType,
        },
      );

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
          DebugLoggerService.log(
            'CHAT',
            'Marking message as read',
            data: {'messageId': messageId},
          );
          socketService.markMessagesAsRead([messageId]);
        });
      }

      print('Message received and displayed: $message');
    } catch (e) {
      DebugLoggerService.error(
        'CHAT',
        'Error handling received message',
        error: e,
      );
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

  /// Handle typing start indicator
  void _handleTypingStart(String userId) {
    if (userId == receiverId.value) {
      isOtherUserTyping.value = true;
      DebugLoggerService.chatAction(
        'Other user started typing',
        data: {'userId': userId},
      );
    }
  }

  /// Handle typing stop indicator
  void _handleTypingStop(String userId) {
    if (userId == receiverId.value) {
      isOtherUserTyping.value = false;
      DebugLoggerService.chatAction(
        'Other user stopped typing',
        data: {'userId': userId},
      );
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
    DebugLoggerService.error('SOCKET', 'Socket error received', error: error);
    print('Socket error: $error');
  }

  /// Send a message
  void sendMessage() {
    if (messageController.text.trim().isEmpty) {
      DebugLoggerService.log('CHAT', '⚠️ Cannot send empty message');
      return;
    }

    // Validate receiverId is set
    if (receiverId.value.isEmpty) {
      final errorMsg = 'Error: Receiver ID not set. Cannot send message.';
      DebugLoggerService.error(
        'CHAT',
        errorMsg,
        error: {
          'receiverId': receiverId.value,
          'userRole': userRole.value,
          'bookingId': bookingId.value,
        },
      );
      print(errorMsg);
      print(
        'Current state: receiverId=$receiverId, userRole=$userRole.value, bookingId=$bookingId.value',
      );
      Get.snackbar('Error', 'Cannot send message: receiver not found');
      return;
    }

    final messageText = messageController.text.trim();
    final messageId = _generateMessageId();

    DebugLoggerService.chatAction(
      'Message prepare to send',
      data: {
        'messageId': messageId,
        'contentLength': messageText.length,
        'receiverId': receiverId.value,
        'bookingId': bookingId.value,
        'currentUserId': currentUserId.value,
      },
    );

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
    try {
      DebugLoggerService.log(
        'SOCKET',
        'Emitting message:send via socket service',
        data: {
          'receiverId': receiverId.value,
          'bookingId': bookingId.value,
          'messageLength': messageText.length,
        },
      );

      socketService.sendMessage(
        receiverId: receiverId.value,
        content: messageText,
        messageType: 'TEXT',
      );

      DebugLoggerService.chatAction(
        'Message sent successfully',
        data: {'messageId': messageId, 'receiverId': receiverId.value},
      );
    } catch (e) {
      DebugLoggerService.error('SOCKET', 'Failed to send message', error: e);
      Get.snackbar('Error', 'Failed to send message: ${e.toString()}');
    }

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
