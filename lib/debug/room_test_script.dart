/// Quick Test Script to Connect and Debug Room
///
/// Usage:
/// 1. Update YOUR_USER_ID and YOUR_TOKEN below
/// 2. Run this in your Flutter app initialization
/// 3. Monitor console output
///
/// This script demonstrates:
/// - Connecting to Socket.IO server
/// - Joining a room with bookingId
/// - Printing debug information
/// - Handling all socket events

import 'package:flutter/material.dart';
import 'package:protiva502/core/services/socket_io_service.dart';
import 'package:protiva502/core/services/debug_logger_service.dart';

void runRoomConnectionTest() {
  DebugLoggerService.log(
    'TEST',
    '🚀 Starting Room Connection Test',
    data: {'timestamp': DateTime.now().toIso8601String()},
  );

  // Configuration
  const bookingId = 'cmo5lhl69000q1wf6i7uu0g0h';
  const userId = 'YOUR_USER_ID'; // TODO: Replace with actual user ID
  const token = 'YOUR_TOKEN'; // TODO: Replace with actual auth token

  print('''
╔═══════════════════════════════════════════════════════════════╗
║         ROOM CONNECTION DEBUG TEST                            ║
╠═══════════════════════════════════════════════════════════════╣
║                                                               ║
║ 📋 Configuration:                                            ║
║    • BookingId: $bookingId                      ║
║    • UserId: $userId                                    ║
║    • Token: ${token.substring(0, 20)}... (truncated)                ║
║                                                               ║
║ 📡 Socket Server:                                            ║
║    • https://x3081msx-3000.asse.devtunnels.ms              ║
║                                                               ║
║ 🎯 Expected Events:                                          ║
║    1. Socket connects                                        ║
║    2. Room join event emitted                                ║
║    3. Ready to send/receive messages                         ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
  ''');

  _testConnection(bookingId, userId, token);
}

Future<void> _testConnection(
  String bookingId,
  String userId,
  String token,
) async {
  final socketService = SocketIOService();

  // Setup all callbacks for monitoring
  print('\n📋 Setting up event listeners...\n');

  socketService.onConnectionStatusChanged = (connected) {
    final status = connected ? '✅ CONNECTED' : '❌ DISCONNECTED';
    print('🔌 $status');
    DebugLoggerService.log(
      'TEST',
      'Connection status: $status',
      data: {'connected': connected},
    );
  };

  socketService.onMessageReceived = (data) {
    print('''
╔═══════════════════════════════════════════════════════════════╗
║ 📨 MESSAGE RECEIVED                                           ║
╠═══════════════════════════════════════════════════════════════╣
║ From: ${data['senderId'] ?? 'Unknown'}
║ Content: ${data['content'] ?? '(empty)'}
║ Type: ${data['messageType'] ?? 'TEXT'}
║ ID: ${data['id'] ?? 'N/A'}
║ Timestamp: ${DateTime.now().toIso8601String()}
╚═══════════════════════════════════════════════════════════════╝
    ''');
    DebugLoggerService.chatAction('Test message received', data: data);
  };

  socketService.onMessageRead = (data) {
    print('✅ Messages read: ${data['messageIds']}');
    DebugLoggerService.socketEvent(
      'message:read',
      isEmit: false,
      payload: data,
    );
  };

  socketService.onTypingStart = (userId) {
    print('✍️ $userId is typing...');
    DebugLoggerService.log(
      'TEST',
      'User typing start',
      data: {'userId': userId},
    );
  };

  socketService.onTypingStop = (userId) {
    print('⏹️ $userId stopped typing');
    DebugLoggerService.log(
      'TEST',
      'User typing stop',
      data: {'userId': userId},
    );
  };

  socketService.onMessageDeleted = (messageId) {
    print('🗑️ Message deleted: $messageId');
    DebugLoggerService.log(
      'TEST',
      'Message deleted',
      data: {'messageId': messageId},
    );
  };

  socketService.onError = (error) {
    print('⚠️ ERROR: $error');
    DebugLoggerService.error('TEST', 'Socket error', error: error);
  };

  try {
    print('⏳ Connecting to socket server...\n');

    await socketService.connect(
      userId: userId,
      token: token,
      timeout: const Duration(seconds: 15),
    );

    print('✅ Socket connected successfully!\n');

    // Wait for connection to stabilize
    await Future.delayed(const Duration(milliseconds: 500));

    // Join the room
    print('📢 Joining messaging room...\n');
    socketService.joinMessagingRoom(bookingId);

    print('✅ Join event emitted!\n');

    // Wait a bit to see responses
    await Future.delayed(const Duration(seconds: 2));

    // Print status
    print('''
╔═══════════════════════════════════════════════════════════════╗
║         CURRENT STATUS                                        ║
╠═══════════════════════════════════════════════════════════════╣
║ Connected: ${socketService.isConnected ? '✅ Yes' : '❌ No'}
║ Current Room: ${socketService.messagingBookingId ?? 'None'}
║ User ID: $userId
║ BookingId: $bookingId
╚═══════════════════════════════════════════════════════════════╝
    ''');

    // Print all logs
    print('\n📋 EVENT LOG:\n');
    final logs = DebugLoggerService.getLogs();
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      print('[${i + 1}] ${log.timestamp.toIso8601String()}');
      print('    Category: ${log.category}');
      print('    Message: ${log.message}');
      if (log.data != null) {
        print('    Data: ${log.data}');
      }
      print('');
    }

    // Keep connection alive for demo
    print('⏳ Connection active. Listening for events...');
    print('💡 Tip: Try sending a message from another client to test\n');

    // Wait 30 seconds before cleanup
    await Future.delayed(const Duration(seconds: 30));
  } catch (e) {
    print('''
╔═══════════════════════════════════════════════════════════════╗
║ ❌ CONNECTION FAILED                                          ║
╠═══════════════════════════════════════════════════════════════╣
║ Error: $e
╚═══════════════════════════════════════════════════════════════╝
    ''');
    DebugLoggerService.error('TEST', 'Connection test failed', error: e);
  } finally {
    print('\n🔌 Cleaning up...\n');
    socketService.leaveMessagingRoom();
    socketService.disconnect();
    print('✅ Disconnected\n');
  }
}

/// Helper function to test message sending
void testSendMessage(
  SocketIOService socketService,
  String receiverId,
  String message,
) {
  if (!socketService.isConnected) {
    print('❌ Socket not connected');
    return;
  }

  print('\n📤 Sending test message...\n');
  socketService.sendMessage(
    receiverId: receiverId,
    content: message,
    messageType: 'TEXT',
  );
  print('✅ Message sent!\n');
}

/// Helper function to print formatted debug table
void printDebugTable({
  required String title,
  required Map<String, String> data,
}) {
  print('\n╔════════════════════════════════════════════════════════╗');
  print('║ $title');
  print('╠════════════════════════════════════════════════════════╣');
  data.forEach((key, value) {
    print('║ $key: $value');
  });
  print('╚════════════════════════════════════════════════════════╝\n');
}
