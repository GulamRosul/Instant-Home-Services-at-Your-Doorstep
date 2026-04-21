import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/socket_io_service.dart';
import 'package:protiva502/core/services/chat_service.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/services/debug_logger_service.dart';

class SingleChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Socket.IO Services
  late SocketIOService socketService;
  late ChatService chatService;

  // Chat Data
  var messages = <Map<String, dynamic>>[].obs;
  late Rx<String> bookingId = ''.obs;
  late Rx<String> receiverId = ''.obs;
  late Rx<String> currentUserId = ''.obs;
  late Rx<String> otherUserName = 'Provider'.obs;
  late Rx<String> userRole = ''.obs; // 'user' or 'provider'
  late Rx<bool> isOtherUserTyping = false.obs;
  late Rx<String> connectionStatus = 'Connecting...'.obs;

  // Map to track pending messages by their local ID for deduplication
  final Map<String, int> _localMessageIndices = {};

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
      bookingId.value = _resolveBookingId(arguments);
      currentUserId.value =
          arguments['userId'] ?? StorageService.getUserId() ?? 'user_123';
      userRole.value =
          arguments['userRole'] ?? StorageService.getRole() ?? 'user';
      otherUserName.value = arguments['providerName'] ?? 'Provider';

      // Determine receiverId based on userRole
      if (userRole.value == 'provider') {
        // Provider sends to client
        receiverId.value =
            arguments['clientId'] ?? arguments['receiverId'] ?? '';
      } else {
        // User (client) sends to provider
        receiverId.value =
            arguments['providerId'] ?? arguments['receiverId'] ?? '';
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
        },
      );

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

  String _resolveBookingId(Map<String, dynamic> arguments) {
    final candidates = [
      arguments['bookingId'],
      arguments['id'],
      arguments['bookingNumber'],
      arguments['reference'],
    ];

    for (final candidate in candidates) {
      final value = candidate?.toString().trim() ?? '';
      if (value.isNotEmpty) {
        return value;
      }
    }

    return '';
  }

  /// Initialize Socket.IO connection for messaging
  Future<void> _initializeSocket() async {
    socketService = SocketIOService();
    chatService = ChatService();

    // Setup messaging callbacks on ChatService
    chatService.onMessageReceived = _handleMessageReceived;
    chatService.onMessageRead = _handleMessageRead;
    chatService.onTypingStart = _handleTypingStart;
    chatService.onTypingStop = _handleTypingStop;
    chatService.onMessageDeleted = _handleMessageDeleted;
    chatService.onError = _handleError;

    // Setup connection callbacks on SocketIOService
    socketService.onConnectionStatusChanged = _handleConnectionStatusChanged;

    // Get auth token from secure storage
    final token = await SecureStorageService.getToken();

    // Print clean status to console
    _printCleanConsole('═══════════════════════════════════════');
    _printCleanConsole('🔌 SOCKET CONNECTION STATUS');
    _printCleanConsole('═══════════════════════════════════════');
    _printCleanConsole(
      '📋 BookingId: ${bookingId.value.isEmpty ? '❌ EMPTY' : bookingId.value}',
    );
    _printCleanConsole('👤 UserId: $currentUserId');
    _printCleanConsole(
      '🔐 Token: ${token == null ? '❌ NO TOKEN' : '✅ HAS TOKEN (${token.length} chars)'}',
    );
    _printCleanConsole('⏳ Status: Connecting...');
    _printCleanConsole('═══════════════════════════════════════\n');

    try {
      await socketService.connect(
        userId: currentUserId.value,
        token: token,
        timeout: const Duration(seconds: 30),
      );

      _printCleanConsole('✅ SOCKET CONNECTED SUCCESSFULLY\n');

      // Connection successful, now join room
      if (bookingId.value.isNotEmpty) {
        _printCleanConsole('📢 Joining messaging room: ${bookingId.value}\n');
        chatService.joinMessagingRoom(bookingId.value);
        connectionStatus.value = 'Connected';
        _printCleanConsole('✅ ROOM JOINED: ${bookingId.value}\n');
      } else {
        _printCleanConsole('❌ ERROR: BookingId is EMPTY - Cannot join room\n');
        connectionStatus.value = 'Error: No booking ID';
      }
    } catch (e) {
      _printCleanConsole('❌ CONNECTION FAILED\n');
      _printCleanConsole('Error: $e\n');
      connectionStatus.value = 'Connection failed';
      _handleError('Failed to connect: $e');
    }
  }

  /// Print clean console output without verbose logging
  void _printCleanConsole(String message) {
    if (kDebugMode) {
      // ignore: avoid_print
      print(message);
    }
  }

  /// Handle connection status changes
  void _handleConnectionStatusChanged(bool connected) {
    if (connected) {
      connectionStatus.value = 'Connected';
      _printCleanConsole('✅ Connection Established\n');
    } else {
      connectionStatus.value = 'Disconnected';
      _printCleanConsole('❌ Connection Lost\n');
    }
  }

  /// Handle incoming message (with deduplication for sent messages)
  void _handleMessageReceived(Map<String, dynamic> data) {
    try {
      final serverId = data['id'] ?? '';
      final senderId = data['senderId'] ?? '';
      final message = data['content'] ?? '';
      final messageType = data['messageType'] ?? 'TEXT';

      // Check if this is a confirmation of a message we just sent
      if (senderId == currentUserId.value) {
        // This is our own message echoing back from server
        // Search through all messages for the local version
        int? localMessageIndex;

        for (int i = 0; i < messages.length; i++) {
          final msg = messages[i];
          // Match on: local message ID + content + type (most reliable)
          if (msg['isLocal'] == true &&
              msg['message'] == message &&
              msg['messageType'] == messageType &&
              msg['senderId'] == currentUserId.value) {
            localMessageIndex = i;
            break;
          }
        }

        if (localMessageIndex != null) {
          // Found our local message - update it with server data
          messages[localMessageIndex] = {
            'message': message,
            'isMe': true,
            'time': messages[localMessageIndex]['time'],
            'messageId': serverId, // Use server ID
            'messageType': messageType,
            'isRead': data['isRead'] ?? false,
            'senderId': senderId,
            'status': 'sent', // Update status to sent
            'isLocal': false, // Mark as confirmed
            'createdAt': data['createdAt'],
            'sender': data['sender'],
          };

          messages.refresh();
          _printCleanConsole('✅ CONFIRMED: "$message" (ID: $serverId...)');

          // Mark as read immediately if socket is connected
          if (serverId.isNotEmpty && chatService.isConnected) {
            chatService.markMessagesAsRead([serverId]);
          }

          return; // Don't add duplicate
        }
      }

      // This is a message from the other user
      if (senderId != currentUserId.value) {
        messages.add({
          'message': message,
          'isMe': false,
          'time': _getCurrentTime(),
          'messageId': serverId,
          'messageType': messageType,
          'isRead': data['isRead'] ?? false,
          'senderId': senderId,
          'status': 'received',
          'isLocal': false,
          'createdAt': data['createdAt'],
          'sender': data['sender'],
        });

        _printCleanConsole(
          '📥 RECEIVED: "${data['sender']?['firstName'] ?? 'User'}" - "$message"',
        );

        // Auto-scroll to latest message
        scrollToBottom();

        // Mark message as read immediately if connected
        if (serverId.isNotEmpty && chatService.isConnected) {
          chatService.markMessagesAsRead([serverId]);
        }
      }
    } catch (e) {
      DebugLoggerService.error(
        'CHAT',
        'Error handling received message',
        error: e,
      );
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
            msg['status'] = 'read';
            DebugLoggerService.chatAction(
              'Message marked as read',
              data: {'messageId': msg['messageId']},
            );
          }
        }
        messages.refresh(); // Notify observers
      }
    } catch (e) {
      DebugLoggerService.error('CHAT', 'Error handling message read', error: e);
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
    try {
      final initialLength = messages.length;
      messages.removeWhere((msg) => msg['messageId'] == messageId);

      if (messages.length < initialLength) {
        messages.refresh();
        DebugLoggerService.chatAction(
          'Message deleted from UI',
          data: {'messageId': messageId},
        );
      } else {
        DebugLoggerService.log(
          'CHAT',
          'Message to delete not found',
          data: {'messageId': messageId},
        );
      }
    } catch (e) {
      DebugLoggerService.error('CHAT', 'Error deleting message', error: e);
    }
  }

  /// Handle socket errors
  void _handleError(String error) {
    connectionStatus.value = 'Error: $error';
    _printCleanConsole('⚠️ Socket Error: $error\n');
  }

  /// Send a message
  void sendMessage() {
    if (messageController.text.trim().isEmpty) {
      DebugLoggerService.log('CHAT', '⚠️ Cannot send empty message');
      return;
    }

    // Validate socket is connected
    if (!socketService.isConnected) {
      DebugLoggerService.error(
        'SOCKET',
        'Cannot send: Socket not connected',
        error: {'connectionStatus': connectionStatus.value},
      );
      Get.snackbar('Error', 'Connection lost. Please reconnect.');
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
      Get.snackbar('Error', 'Cannot send message: receiver not found');
      return;
    }

    final messageText = messageController.text.trim();
    final localMessageId = _generateMessageId();

    // Add to local messages immediately for UI feedback with 'sending' status
    messages.add({
      'message': messageText,
      'isMe': true,
      'time': _getCurrentTime(),
      'messageId': localMessageId,
      'messageType': 'TEXT',
      'isRead': false,
      'senderId': currentUserId.value,
      'status': 'sending', // Mark as sending
      'isLocal': true, // Mark as local (not yet confirmed)
    });

    // Track this message for deduplication
    _localMessageIndices[localMessageId] = messages.length - 1;

    messageController.clear();
    scrollToBottom();

    // Send via socket
    try {
      chatService.sendMessage(
        receiverId: receiverId.value,
        content: messageText,
        messageType: 'TEXT',
      );

      _printCleanConsole('📤 MESSAGE SENT: "$messageText"');
    } catch (e) {
      _printCleanConsole('❌ SEND FAILED: ${e.toString()}');
      DebugLoggerService.error('SOCKET', 'Failed to send message', error: e);
      Get.snackbar('Error', 'Failed to send message: ${e.toString()}');
    }

    // Emit typing stop after sending
    chatService.emitTypingStop();
  }

  /// Emit typing indicator when user starts typing
  void emitTypingStart() {
    if (socketService.isConnected) {
      chatService.emitTypingStart();
    }
  }

  /// Emit typing stop when user finishes typing
  void emitTypingStop() {
    if (socketService.isConnected) {
      chatService.emitTypingStop();
    }
  }

  /// Delete a message
  void deleteMessage(String messageId) {
    if (socketService.isConnected) {
      chatService.deleteMessage(messageId);
    }
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
    chatService.leaveMessagingRoom();
    socketService.disconnect();
    messageController.dispose();
    scrollController.dispose();
    _localMessageIndices.clear();
    super.onClose();
  }
}
