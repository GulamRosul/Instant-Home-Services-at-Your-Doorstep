import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:protiva502/core/services/debug_logger_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';

enum MessageType { TEXT, IMAGE, VIDEO, AUDIO, FILE, LOCATION }

class SocketIOService {
  static final SocketIOService _instance = SocketIOService._internal();

  late IO.Socket _socket;
  String? _currentMessagingBookingId;
  String? _currentTrackingBookingId;
  String? _currentUserId;

  // Connection state tracking
  bool _isConnected = false;
  bool _messagingListenersSetup = false;
  bool _trackingListenersSetup = false;

  // Callbacks for messaging
  Function(Map<String, dynamic>)? onMessageReceived;
  Function(Map<String, dynamic>)? onMessageRead;
  Function(String)? onTypingStart;
  Function(String)? onTypingStop;
  Function(String)? onError;
  Function(String)? onMessageDeleted;
  Function(bool)? onConnectionStatusChanged;

  // Callbacks for tracking
  Function(Map<String, dynamic>)? onLocationBroadcast;
  Function(Map<String, dynamic>)? onTrackingState;
  Function(String)? onTrackingError;

  SocketIOService._internal();

  factory SocketIOService() {
    return _instance;
  }

  /// Get current connection status
  bool get isConnected => _isConnected;

  /// Get messaging booking ID
  String? get messagingBookingId => _currentMessagingBookingId;

  /// Initialize Socket.IO connection
  Future<void> connect({
    required String userId,
    String? token,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    if (_isConnected) {
      DebugLoggerService.log('SOCKET', 'Already connected, skipping connect');
      return;
    }

    _currentUserId = userId;

    try {
      DebugLoggerService.socketConnection(
        'Initializing',
        details: 'userId=$userId, url=${ApiEndpoints.socketUrl}',
      );

      final optionsBuilder = IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setPath('/socket.io')
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setReconnectionAttempts(5);

      // Add auth token to headers if provided
      if (token != null && token.isNotEmpty) {
        optionsBuilder.setExtraHeaders({
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        });
        DebugLoggerService.log('SOCKET', '✅ Auth token added to headers');
      } else {
        optionsBuilder.setExtraHeaders({
          'Content-Type': 'application/json',
          'Accept': '*/*',
        });
        DebugLoggerService.log('SOCKET', '⚠️ Warning: No auth token provided');
      }

      _socket = IO.io(ApiEndpoints.socketUrl, optionsBuilder.build());

      _setupSocketListeners();
      _socket.connect();

      DebugLoggerService.socketConnection(
        'Connecting to ${ApiEndpoints.socketUrl}',
      );

      // Wait for connection with timeout
      try {
        await _waitForConnection(timeout);
      } catch (e) {
        DebugLoggerService.error(
          'SOCKET',
          '⏱️ Connection timeout - server not responding',
          error: 'Timeout after ${timeout.inSeconds}s: $e',
        );
        _socket.disconnect();
        rethrow;
      }
    } catch (e) {
      DebugLoggerService.error(
        'SOCKET',
        'Connection initialization failed',
        error: e,
      );
      onError?.call('Failed to connect: $e');
      _isConnected = false;
      onConnectionStatusChanged?.call(false);
    }
  }

  /// Wait for socket connection with timeout
  Future<void> _waitForConnection(Duration timeout) async {
    final startTime = DateTime.now();
    while (!_isConnected) {
      if (DateTime.now().difference(startTime) > timeout) {
        throw TimeoutException(
          'Socket connection timeout after ${timeout.inSeconds} seconds',
        );
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Setup general socket listeners
  void _setupSocketListeners() {
    _socket.on('connect', (_) {
      _isConnected = true;
      onConnectionStatusChanged?.call(true);
      DebugLoggerService.socketConnection(
        '✅ Connected',
        details: 'id=${_socket.id}',
      );
      debugPrint('Socket connected');
    });

    _socket.on('disconnect', (reason) {
      _isConnected = false;
      onConnectionStatusChanged?.call(false);
      _messagingListenersSetup = false;
      _trackingListenersSetup = false;
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
  }

  // ==================== MESSAGING METHODS ====================

  /// Join a messaging room for a specific booking
  void joinMessagingRoom(String bookingId) {
    if (!_isConnected) {
      final error = 'Socket not connected. Cannot join room.';
      DebugLoggerService.error('SOCKET', error);
      onError?.call(error);
      return;
    }

    _currentMessagingBookingId = bookingId;

    DebugLoggerService.socketEvent(
      'join:room',
      isEmit: true,
      payload: {'bookingId': bookingId},
    );
    _socket.emit('join:room', {'bookingId': bookingId});

    // Setup listeners only once per socket connection
    if (!_messagingListenersSetup) {
      _setupMessagingListeners();
      _messagingListenersSetup = true;
    }

    DebugLoggerService.chatAction(
      'Joined messaging room',
      data: {'bookingId': bookingId, 'userId': _currentUserId},
    );
  }

  /// Setup listeners for messaging events (called only once)
  void _setupMessagingListeners() {
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
      DebugLoggerService.socketEvent('join:room', isEmit: false, payload: data);
      DebugLoggerService.log('MESSAGE', '✅ Joined room', data: data);
    });

    // Listen for room left event
    _socket.on('leave:room', (data) {
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
        'socketId': _socket.id,
      },
    );

    _socket.emit('message:send', payload);
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
    _socket.emit('message:read', payload);
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
    _socket.emit('message:delete', payload);
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
    _socket.emit('typing:start', payload);
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
    _socket.emit('typing:stop', payload);
  }

  // ==================== TRACKING METHODS ====================

  /// Join a tracking room for real-time location sharing
  void joinTrackingRoom(String bookingId) {
    if (!_isConnected) {
      final error = 'Socket not connected. Cannot join tracking room.';
      DebugLoggerService.error('SOCKET', error);
      onTrackingError?.call(error);
      return;
    }

    _currentTrackingBookingId = bookingId;

    _socket.emit('tracking:join', {'bookingId': bookingId});

    // Setup listeners only once per socket connection
    if (!_trackingListenersSetup) {
      _setupTrackingListeners();
      _trackingListenersSetup = true;
    }

    DebugLoggerService.chatAction(
      'Joined tracking room',
      data: {'bookingId': bookingId, 'userId': _currentUserId},
    );
  }

  /// Setup listeners for tracking events (called only once)
  void _setupTrackingListeners() {
    // Listen for location broadcasts from other user
    _socket.on('location:broadcast', (data) {
      DebugLoggerService.socketEvent(
        'location:broadcast',
        isEmit: false,
        payload: data,
      );
      onLocationBroadcast?.call(data);
    });

    // Listen for current tracking state
    _socket.on('tracking:state', (data) {
      DebugLoggerService.socketEvent(
        'tracking:state',
        isEmit: false,
        payload: data,
      );
      onTrackingState?.call(data);
    });

    // Listen for location updates
    _socket.on('location:updated', (data) {
      DebugLoggerService.socketEvent(
        'location:updated',
        isEmit: false,
        payload: data,
      );
      onLocationBroadcast?.call(data);
    });

    // Listen for when other user joins
    _socket.on('tracking:joined', (data) {
      DebugLoggerService.socketEvent(
        'tracking:joined',
        isEmit: false,
        payload: data,
      );
    });

    // Listen for when other user leaves
    _socket.on('tracking:left', (data) {
      DebugLoggerService.socketEvent(
        'tracking:left',
        isEmit: false,
        payload: data,
      );
    });

    // Listen for tracking errors
    _socket.on('tracking:error', (data) {
      DebugLoggerService.socketEvent(
        'tracking:error',
        isEmit: false,
        payload: data,
      );
      onTrackingError?.call(data['error'] ?? 'Unknown error');
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
    if (_currentTrackingBookingId == null) {
      onTrackingError?.call('No active tracking room');
      return;
    }

    _socket.emit('location:update', {
      'bookingId': _currentTrackingBookingId,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'speed': speed,
      'heading': heading,
    });
  }

  /// Request current location state
  void requestLocationState() {
    if (_currentTrackingBookingId == null) {
      onTrackingError?.call('No active tracking room');
      return;
    }

    _socket.emit('location:current', {'bookingId': _currentTrackingBookingId});
  }

  // ==================== CONNECTION MANAGEMENT ====================

  /// Leave current messaging room
  void leaveMessagingRoom() {
    if (_currentMessagingBookingId != null) {
      DebugLoggerService.socketEvent(
        'room:leave',
        isEmit: true,
        payload: {'bookingId': _currentMessagingBookingId},
      );
      _socket.emit('room:leave', {'bookingId': _currentMessagingBookingId});
      DebugLoggerService.log(
        'MESSAGE',
        'Left messaging room',
        data: {'bookingId': _currentMessagingBookingId},
      );
      _currentMessagingBookingId = null;
    }
  }

  /// Leave current tracking room
  void leaveTrackingRoom() {
    if (_currentTrackingBookingId != null) {
      DebugLoggerService.socketEvent(
        'tracking:leave',
        isEmit: true,
        payload: {'bookingId': _currentTrackingBookingId},
      );
      _socket.emit('tracking:leave', {'bookingId': _currentTrackingBookingId});
      DebugLoggerService.log(
        'TRACKING',
        'Left tracking room',
        data: {'bookingId': _currentTrackingBookingId},
      );
      _currentTrackingBookingId = null;
    }
  }

  /// Disconnect socket
  void disconnect() {
    leaveMessagingRoom();
    leaveTrackingRoom();
    _socket.disconnect();
    _socket.dispose();
    _isConnected = false;
    _messagingListenersSetup = false;
    _trackingListenersSetup = false;
    DebugLoggerService.socketConnection('Disconnected by client');
  }

  /// Reconnect socket
  void reconnect() {
    DebugLoggerService.socketConnection('Reconnecting...');
    _socket.connect();
  }
}
