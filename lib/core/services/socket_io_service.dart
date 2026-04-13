import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
      }

      _socket = IO.io(
        'https://protiva-backend.onrender.com',
        optionsBuilder.build(),
      );

      _setupSocketListeners();
      _socket.connect();

      print('Socket.IO connecting...');
    } catch (e) {
      print('Socket connection error: $e');
      onError?.call('Failed to connect: $e');
    }
  }

  /// Setup general socket listeners
  void _setupSocketListeners() {
    _socket.on('connect', (_) {
      debugPrint('Socket connected');
    });

    _socket.on('disconnect', (_) {
      debugPrint('Socket disconnected');
    });

    _socket.on('error', (error) {
      debugPrint('Socket error: $error');
      onError?.call(error.toString());
    });

    _socket.on('connect_error', (error) {
      debugPrint('Connection error: $error');
      onError?.call(error.toString());
    });
  }

  // ==================== MESSAGING METHODS ====================

  /// Join a messaging room for a specific booking
  void joinMessagingRoom(String bookingId) {
    _currentBookingId = bookingId;

    _socket.emit('join:room', {'bookingId': bookingId});

    _setupMessagingListeners();
    print('Joined messaging room: $bookingId');
  }

  /// Setup listeners for messaging events
  void _setupMessagingListeners() {
    // Listen for incoming messages
    _socket.on('message:received', (data) {
      print('Message received: $data');
      onMessageReceived?.call(data);
    });

    // Listen for message read receipts
    _socket.on('message:read', (data) {
      print('Message read: $data');
      onMessageRead?.call(data);
    });

    // Listen for typing indicators
    _socket.on('typing:start', (data) {
      print('User typing: ${data['userId']}');
      onTypingStart?.call(data['userId']);
    });

    _socket.on('typing:stop', (data) {
      print('User stopped typing: ${data['userId']}');
      onTypingStop?.call(data['userId']);
    });

    // Listen for message deletion
    _socket.on('message:deleted', (data) {
      print('Message deleted: $data');
      onMessageDeleted?.call(data['messageId']);
    });

    // Listen for messaging errors
    _socket.on('message:error', (data) {
      print('Message error: $data');
      onError?.call(data['error'] ?? 'Unknown error');
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
      onError?.call('No active booking room');
      return;
    }

    _socket.emit('message:send', {
      'bookingId': _currentBookingId,
      'receiverId': receiverId,
      'content': content,
      'messageType': messageType.toUpperCase(),
      'mediaUrl': mediaUrl,
      'metadata': metadata,
    });
  }

  /// Mark messages as read
  void markMessagesAsRead(List<String> messageIds) {
    if (_currentBookingId == null) {
      onError?.call('No active booking room');
      return;
    }

    _socket.emit('message:read', {
      'bookingId': _currentBookingId,
      'messageIds': messageIds,
    });
  }

  /// Delete a message
  void deleteMessage(String messageId) {
    if (_currentBookingId == null) {
      onError?.call('No active booking room');
      return;
    }

    _socket.emit('message:delete', {
      'bookingId': _currentBookingId,
      'messageId': messageId,
    });
  }

  /// Emit typing start event
  void emitTypingStart() {
    if (_currentBookingId == null) {
      onError?.call('No active booking room');
      return;
    }

    _socket.emit('typing:start', {'bookingId': _currentBookingId});
  }

  /// Emit typing stop event
  void emitTypingStop() {
    if (_currentBookingId == null) {
      onError?.call('No active booking room');
      return;
    }

    _socket.emit('typing:stop', {'bookingId': _currentBookingId});
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
      _socket.emit('room:leave', {'bookingId': _currentBookingId});
      _currentBookingId = null;
    }
  }

  /// Disconnect socket
  void disconnect() {
    leaveRoom();
    _socket.disconnect();
    _socket.dispose();
    print('Socket disconnected');
  }

  /// Reconnect socket
  void reconnect() {
    _socket.connect();
  }
}
