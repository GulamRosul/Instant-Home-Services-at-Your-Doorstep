import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:protiva502/core/services/debug_logger_service.dart';

enum MessageType { TEXT, IMAGE, VIDEO, AUDIO, FILE, LOCATION }

class SocketIOService {
  static final SocketIOService _instance = SocketIOService._internal();

  late IO.Socket _socket;
  String? _currentBookingId;
  String? _currentUserId;

  // Callbacks for messaging
  Function(Map<String, dynamic>)? onMessageReceived;
  Function(Map<String, dynamic>)? onMessageRead;
  Function(String)? onTypingStart;
  Function(String)? onTypingStop;
  Function(String)? onError;
  Function(String)? onMessageDeleted;

  // Callbacks for tracking
  Function(Map<String, dynamic>)? onLocationBroadcast;
  Function(Map<String, dynamic>)? onTrackingState;
  Function(String)? onTrackingError;

  SocketIOService._internal();

  factory SocketIOService() {
    return _instance;
  }

  /// Initialize Socket.IO connection
  Future<void> connect({required String userId, String? token}) async {
    _currentUserId = userId;

    try {
      DebugLoggerService.socketConnection(
        'Initializing',
        details: 'userId=$userId',
      );

      final optionsBuilder = IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setPath('/socket.io')
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setReconnectionAttempts(5)
          .setExtraHeaders({
            'Content-Type': 'application/json',
            'Accept': '*/*',
          });

      // Add auth token if provided
      if (token != null && token.isNotEmpty) {
        optionsBuilder.setAuth({'Authorization': 'Bearer $token'});
        DebugLoggerService.log('SOCKET', 'Auth token set');
      } else {
        DebugLoggerService.log('SOCKET', '⚠️ Warning: No auth token provided');
      }

      _socket = IO.io(
        'https://protiva-be.onrender.com',
        optionsBuilder.build(),
      );

      _setupSocketListeners();
      _socket.connect();

      DebugLoggerService.socketConnection(
        'Connecting to https://protiva-be.onrender.com',
      );
    } catch (e) {
      DebugLoggerService.error(
        'SOCKET',
        'Connection initialization failed',
        error: e,
      );
      onError?.call('Failed to connect: $e');
    }
  }

  /// Setup general socket listeners
  void _setupSocketListeners() {
    _socket.on('connect', (_) {
      DebugLoggerService.socketConnection(
        '✅ Connected',
        details: 'id=${_socket.id}',
      );
      debugPrint('Socket connected');
    });

    _socket.on('disconnect', (reason) {
      DebugLoggerService.socketConnection(
        '❌ Disconnected',
        details: reason.toString(),
      );
      debugPrint('Socket disconnected');
    });

    _socket.on('error', (error) {
      DebugLoggerService.socketEvent('error', isEmit: false, payload: error);
      DebugLoggerService.error('SOCKET', 'Socket error', error: error);
      onError?.call(error.toString());
    });

    _socket.on('connect_error', (error) {
      DebugLoggerService.socketEvent(
        'connect_error',
        isEmit: false,
        payload: error,
      );
      DebugLoggerService.error('SOCKET', 'Connection error', error: error);
      onError?.call(error.toString());
    });

    // Log all other events for debugging
    _socket.onAny((event, data) {
      DebugLoggerService.log('SOCKET_RAW', '🔄 Event: $event', data: data);
    });
  }

  // ==================== MESSAGING METHODS ====================

  /// Join a messaging room for a specific booking
  void joinMessagingRoom(String bookingId) {
    _currentBookingId = bookingId;

    DebugLoggerService.socketEvent(
      'join:room',
      isEmit: true,
      payload: {'bookingId': bookingId},
    );
    _socket.emit('join:room', {'bookingId': bookingId});

    _setupMessagingListeners();
    DebugLoggerService.chatAction(
      'Joined messaging room',
      data: {'bookingId': bookingId, 'userId': _currentUserId},
    );
  }

  /// Setup listeners for messaging events
  void _setupMessagingListeners() {
    // Remove old listeners if they exist (prevents duplicates)
    _socket.off('message:new');
    _socket.off('message:read');
    _socket.off('typing:start');
    _socket.off('typing:stop');
    _socket.off('message:delete');
    _socket.off('error');
    _socket.off('message:notification');
    _socket.off('join:room');
    _socket.off('leave:room');

    // Listen for incoming messages
    _socket.on('message:new', (data) {
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
    _socket.on('message:read', (data) {
      DebugLoggerService.socketEvent(
        'message:read',
        isEmit: false,
        payload: data,
      );
      onMessageRead?.call(data);
    });

    // Listen for typing start indicator
    _socket.on('typing:start', (data) {
      DebugLoggerService.socketEvent(
        'typing:start',
        isEmit: false,
        payload: data,
      );
      onTypingStart?.call(data['userId'] ?? '');
    });

    // Listen for typing stop indicator
    _socket.on('typing:stop', (data) {
      DebugLoggerService.socketEvent(
        'typing:stop',
        isEmit: false,
        payload: data,
      );
      onTypingStop?.call(data['userId'] ?? '');
    });

    // Listen for message deletion
    _socket.on('message:delete', (data) {
      DebugLoggerService.socketEvent(
        'message:delete',
        isEmit: false,
        payload: data,
      );
      onMessageDeleted?.call(data['messageId']);
    });

    // Listen for message notifications
    _socket.on('message:notification', (data) {
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
    _socket.on('join:room', (data) {
      DebugLoggerService.socketEvent(
        'join:room',
        isEmit: false,
        payload: data,
      );
      DebugLoggerService.log(
        'MESSAGE',
        '✅ Joined room',
        data: data,
      );
    });

    // Listen for room left event
    _socket.on('leave:room', (data) {
      DebugLoggerService.socketEvent(
        'leave:room',
        isEmit: false,
        payload: data,
      );
      DebugLoggerService.log(
        'MESSAGE',
        '✅ Left room',
        data: data,
      );
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
    if (_currentBookingId == null) {
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
      'bookingId': _currentBookingId,
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
        'bookingId': _currentBookingId,
        'receiverId': receiverId,
        'contentLength': content.length,
        'messageType': messageType,
        'sentAt': DateTime.now().toIso8601String(),
        'socketId': _socket.id,
      },
    );

    _socket.emit('message:send', payload);
  }

  /// Mark messages as read
  void markMessagesAsRead(List<String> messageIds) {
    if (_currentBookingId == null) {
      DebugLoggerService.error(
        'MESSAGE',
        'Cannot mark as read: No active booking room',
      );
      onError?.call('No active booking room');
      return;
    }

    final payload = {'bookingId': _currentBookingId, 'messageIds': messageIds};

    DebugLoggerService.socketEvent(
      'message:read',
      isEmit: true,
      payload: payload,
    );
    _socket.emit('message:read', payload);
  }

  /// Delete a message
  void deleteMessage(String messageId) {
    if (_currentBookingId == null) {
      DebugLoggerService.error(
        'MESSAGE',
        'Cannot delete: No active booking room',
      );
      onError?.call('No active booking room');
      return;
    }

    final payload = {'bookingId': _currentBookingId, 'messageId': messageId};

    DebugLoggerService.socketEvent(
      'message:delete',
      isEmit: true,
      payload: payload,
    );
    _socket.emit('message:delete', payload);
  }

  /// Emit typing start event
  void emitTypingStart() {
    if (_currentBookingId == null) {
      DebugLoggerService.error(
        'MESSAGE',
        'Cannot emit typing:start: No active booking room',
      );
      onError?.call('No active booking room');
      return;
    }

    final payload = {'bookingId': _currentBookingId};
    DebugLoggerService.socketEvent(
      'typing:start',
      isEmit: true,
      payload: payload,
    );
    _socket.emit('typing:start', payload);
  }

  /// Emit typing stop event
  void emitTypingStop() {
    if (_currentBookingId == null) {
      DebugLoggerService.error(
        'MESSAGE',
        'Cannot emit typing:stop: No active booking room',
      );
      onError?.call('No active booking room');
      return;
    }

    final payload = {'bookingId': _currentBookingId};
    DebugLoggerService.socketEvent(
      'typing:stop',
      isEmit: true,
      payload: payload,
    );
    _socket.emit('typing:stop', payload);
  }

  // ==================== TRACKING METHODS ====================

  /// Join a tracking room for real-time location sharing
  void joinTrackingRoom(String bookingId) {
    _currentBookingId = bookingId;

    _socket.emit('tracking:join', {'bookingId': bookingId});

    _setupTrackingListeners();
    debugPrint('Joined tracking room: $bookingId');
  }

  /// Setup listeners for tracking events
  void _setupTrackingListeners() {
    // Listen for location broadcasts from other user
    _socket.on('location:broadcast', (data) {
      debugPrint('Location broadcast received: $data');
      onLocationBroadcast?.call(data);
    });

    // Listen for current tracking state
    _socket.on('tracking:state', (data) {
      debugPrint('Tracking state received: $data');
      onTrackingState?.call(data);
    });

    // Listen for location updates
    _socket.on('location:updated', (data) {
      debugPrint('Location updated: $data');
      onLocationBroadcast?.call(data);
    });

    // Listen for when other user joins
    _socket.on('tracking:joined', (data) {
      debugPrint('User joined tracking: $data');
    });

    // Listen for when other user leaves
    _socket.on('tracking:left', (data) {
      debugPrint('User left tracking: $data');
    });

    // Listen for tracking errors
    _socket.on('tracking:error', (data) {
      debugPrint('Tracking error: $data');
      onTrackingError?.call(data['error'] ?? 'Unknown error');
    });

    // Listen for generic errors
    _socket.on('error', (data) {
      debugPrint('Tracking error: $data');
      onTrackingError?.call(data.toString());
    });
  }

  /// Update user's location
  void updateLocation({
    required double latitude,
    required double longitude,
    required double accuracy,
    required double speed,
    required double heading,
  }) {
    if (_currentBookingId == null) {
      onTrackingError?.call('No active booking room');
      return;
    }

    _socket.emit('location:update', {
      'bookingId': _currentBookingId,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'speed': speed,
      'heading': heading,
    });
  }

  /// Request current location state
  void requestLocationState() {
    if (_currentBookingId == null) {
      onTrackingError?.call('No active booking room');
      return;
    }

    _socket.emit('location:current', {'bookingId': _currentBookingId});
  }

  // ==================== CONNECTION MANAGEMENT ====================

  /// Check if socket is connected
  bool isConnected() {
    return _socket.connected;
  }

  /// Leave current room
  void leaveRoom() {
    if (_currentBookingId != null) {
      DebugLoggerService.socketEvent(
        'room:leave',
        isEmit: true,
        payload: {'bookingId': _currentBookingId},
      );
      _socket.emit('room:leave', {'bookingId': _currentBookingId});
      DebugLoggerService.log(
        'MESSAGE',
        'Left room',
        data: {'bookingId': _currentBookingId},
      );
      _currentBookingId = null;
    }
  }

  /// Disconnect socket
  void disconnect() {
    leaveRoom();
    _socket.disconnect();
    _socket.dispose();
    DebugLoggerService.socketConnection('Disconnected by client');
  }

  /// Reconnect socket
  void reconnect() {
    DebugLoggerService.socketConnection('Reconnecting...');
    _socket.connect();
  }
}
