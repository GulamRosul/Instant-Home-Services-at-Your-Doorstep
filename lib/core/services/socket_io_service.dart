import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:protiva502/core/services/debug_logger_service.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';

class SocketIOService {
  static final SocketIOService _instance = SocketIOService._internal();

  late IO.Socket _socket;
  String? _currentTrackingBookingId;
  String? _currentUserId;

  // Connection state tracking
  bool _isConnected = false;
  bool _trackingListenersSetup = false;

  // Callbacks for connection
  Function(String)? onError;
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

  /// Get socket instance for direct access
  IO.Socket get socket => _socket;

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
      final resolvedToken = (token != null && token.trim().isNotEmpty)
          ? token.trim()
          : await SecureStorageService.getToken();

      DebugLoggerService.socketConnection(
        'Initializing',
        details: 'userId=$userId, url=${ApiEndpoints.socketMessageUrl}',
      );

      final optionsBuilder = IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setPath('/socket.io')
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setReconnectionAttempts(5);

      // Add auth token to headers if provided
      if (resolvedToken != null && resolvedToken.isNotEmpty) {
        optionsBuilder.setExtraHeaders({
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $resolvedToken',
        });
        DebugLoggerService.log('SOCKET', '✅ Auth token added to headers');
      } else {
        optionsBuilder.setExtraHeaders({
          'Content-Type': 'application/json',
          'Accept': '*/*',
        });
        DebugLoggerService.log('SOCKET', '⚠️ Warning: No auth token provided');
      }

      _socket = IO.io(ApiEndpoints.socketMessageUrl, optionsBuilder.build());

      _setupSocketListeners();
      _socket.connect();

      DebugLoggerService.socketConnection(
        'Connecting to ${ApiEndpoints.socketMessageUrl}',
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
    leaveTrackingRoom();
    _socket.disconnect();
    _socket.dispose();
    _isConnected = false;
    _trackingListenersSetup = false;
    DebugLoggerService.socketConnection('Disconnected by client');
  }

  /// Reconnect socket
  void reconnect() {
    DebugLoggerService.socketConnection('Reconnecting...');
    _socket.connect();
  }
}
