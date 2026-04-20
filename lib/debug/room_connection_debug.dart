import 'package:flutter/foundation.dart';
import 'package:protiva502/core/services/socket_io_service.dart';
import 'package:protiva502/core/services/debug_logger_service.dart';

/// Debug utility to connect to a room and monitor bookingId and events
class RoomConnectionDebug {
  static final RoomConnectionDebug _instance = RoomConnectionDebug._internal();

  late SocketIOService socketService;
  final String bookingId = 'cmo5lhl69000q1wf6i7uu0g0h'; // Your bookingId

  RoomConnectionDebug._internal();

  factory RoomConnectionDebug() {
    return _instance;
  }

  /// Connect to room with debugging
  Future<void> connectAndDebugRoom({
    required String userId,
    required String token,
  }) async {
    try {
      socketService = SocketIOService();

      // Setup event listeners BEFORE connecting
      _setupDebugListeners();

      // Print initial debug info
      DebugLoggerService.log(
        'DEBUG',
        '🔍 Starting Room Connection Debug',
        data: {
          'bookingId': bookingId,
          'userId': userId,
          'tokenLength': token.length,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      // Connect socket
      await socketService.connect(
        userId: userId,
        token: token,
        timeout: const Duration(seconds: 15),
      );

      DebugLoggerService.log(
        'DEBUG',
        '✅ Socket Connected Successfully',
        data: {
          'socketId': socketService._socket.id,
          'isConnected': socketService.isConnected,
        },
      );

      // Wait a moment for connection to stabilize
      await Future.delayed(const Duration(milliseconds: 500));

      // Join the room
      _joinRoomWithDebug();

    } catch (e) {
      DebugLoggerService.error(
        'DEBUG',
        'Connection failed',
        error: e,
      );
      printDebug('❌ Connection Error: $e');
    }
  }

  /// Join room with debug output
  void _joinRoomWithDebug() {
    try {
      DebugLoggerService.log(
        'DEBUG',
        '📢 Attempting to join room',
        data: {
          'bookingId': bookingId,
          'isConnected': socketService.isConnected,
        },
      );

      printDebug('═══════════════════════════════════════');
      printDebug('🚀 JOINING ROOM');
      printDebug('═══════════════════════════════════════');
      printDebug('bookingId: $bookingId');
      printDebug('Socket Connected: ${socketService.isConnected}');

      // Join the messaging room
      socketService.joinMessagingRoom(bookingId);

      printDebug('✅ Join event emitted');
      printDebug('═══════════════════════════════════════');

    } catch (e) {
      DebugLoggerService.error('DEBUG', 'Failed to join room', error: e);
      printDebug('❌ Join Error: $e');
    }
  }

  /// Setup listeners for all events
  void _setupDebugListeners() {
    // Connection status
    socketService.onConnectionStatusChanged = (connected) {
      DebugLoggerService.log(
        'DEBUG',
        '🔌 Connection Status Changed',
        data: {'connected': connected},
      );
      printDebug('${connected ? '✅' : '❌'} Connection: ${connected ? 'CONNECTED' : 'DISCONNECTED'}');
    };

    // Message received
    socketService.onMessageReceived = (data) {
      DebugLoggerService.log(
        'DEBUG',
        '📨 Message Received',
        data: data,
      );
      printDebug('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      printDebug('📨 NEW MESSAGE');
      printDebug('From: ${data['senderId']}');
      printDebug('Content: ${data['content']}');
      printDebug('Type: ${data['messageType']}');
      printDebug('ID: ${data['id']}');
      printDebug('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    };

    // Message read
    socketService.onMessageRead = (data) {
      DebugLoggerService.log(
        'DEBUG',
        '✅ Message Read',
        data: data,
      );
      printDebug('✅ Message read: ${data['messageIds']}');
    };

    // Typing start
    socketService.onTypingStart = (userId) {
      DebugLoggerService.log(
        'DEBUG',
        '✍️ User Typing Start',
        data: {'userId': userId},
      );
      printDebug('✍️ $userId is typing...');
    };

    // Typing stop
    socketService.onTypingStop = (userId) {
      DebugLoggerService.log(
        'DEBUG',
        '⏹️ User Typing Stop',
        data: {'userId': userId},
      );
      printDebug('⏹️ $userId stopped typing');
    };

    // Message deleted
    socketService.onMessageDeleted = (messageId) {
      DebugLoggerService.log(
        'DEBUG',
        '🗑️ Message Deleted',
        data: {'messageId': messageId},
      );
      printDebug('🗑️ Message deleted: $messageId');
    };

    // Error
    socketService.onError = (error) {
      DebugLoggerService.error('DEBUG', 'Socket Error', error: error);
      printDebug('⚠️ Socket Error: $error');
    };
  }

  /// Send a test message
  void sendTestMessage({
    required String receiverId,
    String message = 'Test message from debug',
  }) {
    if (!socketService.isConnected) {
      printDebug('❌ Socket not connected!');
      return;
    }

    DebugLoggerService.log(
      'DEBUG',
      '📤 Sending Test Message',
      data: {
        'receiverId': receiverId,
        'message': message,
        'bookingId': bookingId,
      },
    );

    socketService.sendMessage(
      receiverId: receiverId,
      content: message,
      messageType: 'TEXT',
    );

    printDebug('📤 Test message sent to: $receiverId');
  }

  /// Get current room/connection status
  void printConnectionStatus() {
    printDebug('\n╔════════════════════════════════════════╗');
    printDebug('║         CONNECTION STATUS              ║');
    printDebug('╠════════════════════════════════════════╣');
    printDebug('║ BookingId: $bookingId');
    printDebug('║ Connected: ${socketService.isConnected}');
    printDebug('║ Current Room: ${socketService.messagingBookingId ?? 'None'}');
    printDebug('╚════════════════════════════════════════╝\n');
  }

  /// Print all debug logs
  void printAllLogs() {
    final logs = DebugLoggerService.getLogs();
    printDebug('\n═══════════════════════════════════════');
    printDebug('📋 ALL DEBUG LOGS (${logs.length})');
    printDebug('═══════════════════════════════════════');

    for (var log in logs) {
      printDebug('[${log.timestamp.toIso8601String()}] ${log.category}: ${log.message}');
      if (log.data != null) {
        printDebug('  Data: ${log.data}');
      }
    }
    printDebug('═══════════════════════════════════════\n');
  }

  /// Disconnect and cleanup
  void disconnect() {
    socketService.leaveMessagingRoom();
    socketService.disconnect();
    DebugLoggerService.log('DEBUG', '🔌 Disconnected from room');
    printDebug('🔌 Disconnected');
  }
}

/// Helper to print debug messages to console
void printDebug(String message) {
  if (kDebugMode) {
    // ignore: avoid_print
    print(message);
  }
}
