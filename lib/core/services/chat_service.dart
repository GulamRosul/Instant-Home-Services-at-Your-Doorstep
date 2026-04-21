import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:protiva502/core/services/debug_logger_service.dart';
import 'package:protiva502/core/services/socket_io_service.dart';

enum MessageType { TEXT, IMAGE, VIDEO, AUDIO, FILE, LOCATION }

class ChatService {
  static final ChatService _instance = ChatService._internal();

  late SocketIOService _socketService;
  String? _currentMessagingBookingId;
  bool _messagingListenersSetup = false;

  // Callbacks for messaging
  Function(Map<String, dynamic>)? onMessageReceived;
  Function(Map<String, dynamic>)? onMessageRead;
  Function(String)? onTypingStart;
  Function(String)? onTypingStop;
  Function(String)? onError;
  Function(String)? onMessageDeleted;

  ChatService._internal() {
    _socketService = SocketIOService();
  }

  factory ChatService() {
    return _instance;
  }

  /// Get current messaging booking ID
  String? get messagingBookingId => _currentMessagingBookingId;

  /// Get socket connection status
  bool get isConnected => _socketService.isConnected;

  /// Join a messaging room for a specific booking
  void joinMessagingRoom(String bookingId) {
    if (!_socketService.isConnected) {
      final error = 'Socket not connected. Cannot join room.';
      DebugLoggerService.error('CHAT', error);
      onError?.call(error);
      return;
    }

    _currentMessagingBookingId = bookingId;

    DebugLoggerService.socketEvent(
      'join:room',
      isEmit: true,
      payload: {'bookingId': bookingId},
    );
    _socketService.socket.emit('join:room', {'bookingId': bookingId});

    // Setup listeners only once per socket connection
    if (!_messagingListenersSetup) {
      _setupMessagingListeners();
      _messagingListenersSetup = true;
    }

    DebugLoggerService.chatAction(
      'Joined messaging room',
      data: {'bookingId': bookingId},
    );
  }

  /// Setup listeners for messaging events (called only once)
  void _setupMessagingListeners() {
    final socket = _socketService.socket;

    // Listen for incoming messages
    socket.on('message:new', (data) {
      DebugLoggerService.socketEvent(
        'message:new',
        isEmit: false,
        payload: data,
      );
      DebugLoggerService.chatAction(
        'Message received',
        data: {
          'senderId': data['senderId'],
          'content': data['content'],
          'messageType': data['messageType'],
          'receivedAt': DateTime.now().toIso8601String(),
        },
      );
      onMessageReceived?.call(data);
    });

    // Listen for message read receipts
    socket.on('message:read', (data) {
      DebugLoggerService.socketEvent(
        'message:read',
        isEmit: false,
        payload: data,
      );
      onMessageRead?.call(data);
    });

    // Listen for typing start indicator
    socket.on('typing:start', (data) {
      DebugLoggerService.socketEvent(
        'typing:start',
        isEmit: false,
        payload: data,
      );
      onTypingStart?.call(data['userId'] ?? '');
    });

    // Listen for typing stop indicator
    socket.on('typing:stop', (data) {
      DebugLoggerService.socketEvent(
        'typing:stop',
        isEmit: false,
        payload: data,
      );
      onTypingStop?.call(data['userId'] ?? '');
    });

    // Listen for message deletion
    socket.on('message:delete', (data) {
      DebugLoggerService.socketEvent(
        'message:delete',
        isEmit: false,
        payload: data,
      );
      onMessageDeleted?.call(data['messageId']);
    });

    // Listen for message notifications
    socket.on('message:notification', (data) {
      DebugLoggerService.socketEvent(
        'message:notification',
        isEmit: false,
        payload: data,
      );
      DebugLoggerService.chatAction(
        'Message notification received',
        data: data,
      );
      onMessageReceived?.call(data);
    });

    // Listen for room joined confirmation
    socket.on('join:room', (data) {
      DebugLoggerService.socketEvent('join:room', isEmit: false, payload: data);
      DebugLoggerService.log('MESSAGE', '✅ Joined room', data: data);
    });

    // Listen for room left event
    socket.on('leave:room', (data) {
      DebugLoggerService.socketEvent(
        'leave:room',
        isEmit: false,
        payload: data,
      );
      DebugLoggerService.log('MESSAGE', '✅ Left room', data: data);
    });
  }

  /// Send a message
  void sendMessage({
    required String receiverId,
    required String content,
    required String messageType,
    String? mediaUrl,
    Map<String, dynamic>? metadata,
  }) {
    if (_currentMessagingBookingId == null) {
      final error = 'No active booking room';
      DebugLoggerService.error('MESSAGE', error);
      onError?.call(error);
      return;
    }

    if (receiverId.isEmpty) {
      final error = 'Receiver ID is empty';
      DebugLoggerService.error(
        'MESSAGE',
        error,
        error: {'receiverId': receiverId},
      );
      onError?.call(error);
      return;
    }

    if (content.isEmpty) {
      final error = 'Message content is empty';
      DebugLoggerService.error('MESSAGE', error);
      onError?.call(error);
      return;
    }

    final payload = {
      'bookingId': _currentMessagingBookingId,
      'receiverId': receiverId,
      'content': content,
      'messageType': messageType.toUpperCase(),
      'mediaUrl': mediaUrl,
      'metadata': metadata,
    };

    DebugLoggerService.socketEvent(
      'message:send',
      isEmit: true,
      payload: payload,
    );
    DebugLoggerService.chatAction(
      'Sending message',
      data: {
        'bookingId': _currentMessagingBookingId,
        'receiverId': receiverId,
        'contentLength': content.length,
        'messageType': messageType,
        'sentAt': DateTime.now().toIso8601String(),
        'socketId': _socketService.socket.id,
      },
    );

    _socketService.socket.emit('message:send', payload);
  }

  /// Mark messages as read
  void markMessagesAsRead(List<String> messageIds) {
    if (_currentMessagingBookingId == null) {
      DebugLoggerService.error(
        'MESSAGE',
        'Cannot mark as read: No active booking room',
      );
      onError?.call('No active booking room');
      return;
    }

    final payload = {
      'bookingId': _currentMessagingBookingId,
      'messageIds': messageIds,
    };

    DebugLoggerService.socketEvent(
      'message:read',
      isEmit: true,
      payload: payload,
    );
    _socketService.socket.emit('message:read', payload);
  }

  /// Delete a message
  void deleteMessage(String messageId) {
    if (_currentMessagingBookingId == null) {
      DebugLoggerService.error(
        'MESSAGE',
        'Cannot delete: No active booking room',
      );
      onError?.call('No active booking room');
      return;
    }

    final payload = {
      'bookingId': _currentMessagingBookingId,
      'messageId': messageId,
    };

    DebugLoggerService.socketEvent(
      'message:delete',
      isEmit: true,
      payload: payload,
    );
    _socketService.socket.emit('message:delete', payload);
  }

  /// Emit typing start event
  void emitTypingStart() {
    if (_currentMessagingBookingId == null) {
      DebugLoggerService.error(
        'MESSAGE',
        'Cannot emit typing:start: No active booking room',
      );
      onError?.call('No active booking room');
      return;
    }

    final payload = {'bookingId': _currentMessagingBookingId};
    DebugLoggerService.socketEvent(
      'typing:start',
      isEmit: true,
      payload: payload,
    );
    _socketService.socket.emit('typing:start', payload);
  }

  /// Emit typing stop event
  void emitTypingStop() {
    if (_currentMessagingBookingId == null) {
      DebugLoggerService.error(
        'MESSAGE',
        'Cannot emit typing:stop: No active booking room',
      );
      onError?.call('No active booking room');
      return;
    }

    final payload = {'bookingId': _currentMessagingBookingId};
    DebugLoggerService.socketEvent(
      'typing:stop',
      isEmit: true,
      payload: payload,
    );
    _socketService.socket.emit('typing:stop', payload);
  }

  /// Leave current messaging room
  void leaveMessagingRoom() {
    if (_currentMessagingBookingId != null) {
      DebugLoggerService.socketEvent(
        'room:leave',
        isEmit: true,
        payload: {'bookingId': _currentMessagingBookingId},
      );
      _socketService.socket.emit('room:leave', {
        'bookingId': _currentMessagingBookingId,
      });
      DebugLoggerService.log(
        'MESSAGE',
        'Left messaging room',
        data: {'bookingId': _currentMessagingBookingId},
      );
      _currentMessagingBookingId = null;
      _messagingListenersSetup = false;
    }
  }
}
