import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:protiva502/core/services/debug_logger_service.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';

class LocationTrackingService {
  static final LocationTrackingService _instance =
      LocationTrackingService._internal();

  late IO.Socket _socket;
  String? _currentTrackingBookingId;
  String? _currentUserId;

  bool _isConnected = false;
  bool _trackingListenersSetup = false;

  Function(String)? onError;
  Function(bool)? onConnectionStatusChanged;
  Function(Map<String, dynamic>)? onLocationBroadcast;
  Function(Map<String, dynamic>)? onTrackingState;
  Function(String)? onTrackingError;

  LocationTrackingService._internal();

  factory LocationTrackingService() {
    return _instance;
  }

  bool get isConnected => _isConnected;

  IO.Socket get socket => _socket;

  Future<void> connect({
    required String userId,
    String? token,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    if (_isConnected) {
      DebugLoggerService.log('TRACKING', 'Already connected, skipping connect');
      return;
    }

    _currentUserId = userId;

    try {
      final resolvedToken = (token != null && token.trim().isNotEmpty)
          ? token.trim()
          : await SecureStorageService.getToken();

      DebugLoggerService.socketConnection(
        'Initializing tracking socket',
        details: 'userId=$userId, url=${ApiEndpoints.socketTrackingUrl}',
      );

      final optionsBuilder = IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setPath('/socket.io')
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setReconnectionAttempts(5);

      if (resolvedToken != null && resolvedToken.isNotEmpty) {
        optionsBuilder.setExtraHeaders({
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $resolvedToken',
        });
        DebugLoggerService.log('TRACKING', 'Auth token added to headers');
      } else {
        optionsBuilder.setExtraHeaders({
          'Content-Type': 'application/json',
          'Accept': '*/*',
        });
        DebugLoggerService.log('TRACKING', 'Warning: No auth token provided');
      }

      _socket = IO.io(ApiEndpoints.socketTrackingUrl, optionsBuilder.build());

      _setupSocketListeners();
      _socket.connect();

      DebugLoggerService.socketConnection(
        'Connecting to ${ApiEndpoints.socketTrackingUrl}',
      );

      try {
        await _waitForConnection(timeout);
      } catch (e) {
        DebugLoggerService.error(
          'TRACKING',
          'Connection timeout - server not responding',
          error: 'Timeout after ${timeout.inSeconds}s: $e',
        );
        _socket.disconnect();
        rethrow;
      }
    } catch (e) {
      DebugLoggerService.error(
        'TRACKING',
        'Connection initialization failed',
        error: e,
      );
      onError?.call('Failed to connect: $e');
      _isConnected = false;
      onConnectionStatusChanged?.call(false);
    }
  }

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

  void _setupSocketListeners() {
    _socket.on('connect', (_) {
      _isConnected = true;
      onConnectionStatusChanged?.call(true);
      DebugLoggerService.socketConnection(
        'Tracking socket connected',
        details: 'id=${_socket.id}',
      );
      debugPrint('Tracking socket connected');
    });

    _socket.on('disconnect', (reason) {
      _isConnected = false;
      onConnectionStatusChanged?.call(false);
      _trackingListenersSetup = false;
      DebugLoggerService.socketConnection(
        'Tracking socket disconnected',
        details: reason.toString(),
      );
      debugPrint('Tracking socket disconnected');
    });

    _socket.on('error', (error) {
      DebugLoggerService.socketEvent('error', isEmit: false, payload: error);
      DebugLoggerService.error('TRACKING', 'Socket error', error: error);
      onError?.call(error.toString());
    });

    _socket.on('connect_error', (error) {
      DebugLoggerService.socketEvent(
        'connect_error',
        isEmit: false,
        payload: error,
      );
      DebugLoggerService.error('TRACKING', 'Connection error', error: error);
      onError?.call(error.toString());
    });
  }

  void joinTrackingRoom(String bookingId) {
    if (!_isConnected) {
      final error = 'Socket not connected. Cannot join tracking room.';
      DebugLoggerService.error('TRACKING', error);
      onTrackingError?.call(error);
      return;
    }

    _currentTrackingBookingId = bookingId;

    final payload = {'bookingId': bookingId};
    DebugLoggerService.socketEvent(
      'tracking:join',
      isEmit: true,
      payload: payload,
    );
    _socket.emit('tracking:join', payload);

    if (!_trackingListenersSetup) {
      _setupTrackingListeners();
      _trackingListenersSetup = true;
    }

    DebugLoggerService.chatAction(
      'Joined tracking room',
      data: {'bookingId': bookingId, 'userId': _currentUserId},
    );
  }

  void _setupTrackingListeners() {
    _socket.on('location:broadcast', (data) {
      DebugLoggerService.socketEvent(
        'location:broadcast',
        isEmit: false,
        payload: data,
      );
      onLocationBroadcast?.call(_asMap(data));
    });

    _socket.on('tracking:state', (data) {
      DebugLoggerService.socketEvent(
        'tracking:state',
        isEmit: false,
        payload: data,
      );
      onTrackingState?.call(_asMap(data));
    });

    _socket.on('location:update', (data) {
      DebugLoggerService.socketEvent(
        'location:update',
        isEmit: false,
        payload: data,
      );
      onLocationBroadcast?.call(_asMap(data));
    });

    _socket.on('location:updated', (data) {
      DebugLoggerService.socketEvent(
        'location:updated',
        isEmit: false,
        payload: data,
      );
      onLocationBroadcast?.call(_asMap(data));
    });

    _socket.on('tracking:join', (data) {
      DebugLoggerService.socketEvent(
        'tracking:join',
        isEmit: false,
        payload: data,
      );
    });

    _socket.on('tracking:joined', (data) {
      DebugLoggerService.socketEvent(
        'tracking:joined',
        isEmit: false,
        payload: data,
      );
    });

    _socket.on('tracking:left', (data) {
      DebugLoggerService.socketEvent(
        'tracking:left',
        isEmit: false,
        payload: data,
      );
    });

    _socket.on('tracking:error', (data) {
      DebugLoggerService.socketEvent(
        'tracking:error',
        isEmit: false,
        payload: data,
      );

      final mapped = _asMap(data);
      if (mapped['error'] != null) {
        onTrackingError?.call(mapped['error'].toString());
      } else {
        onTrackingError?.call('Unknown error');
      }
    });
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return <String, dynamic>{'data': data};
  }

  void updateLocation({
    required double latitude,
    required double longitude,
    required double accuracy,
    required double speed,
    required double heading,
  }) {
    if (!_isConnected) {
      onTrackingError?.call('Socket not connected');
      return;
    }

    if (_currentTrackingBookingId == null) {
      onTrackingError?.call('No active tracking room');
      return;
    }

    final payload = {
      'bookingId': _currentTrackingBookingId,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'speed': speed,
      'heading': heading,
    };

    DebugLoggerService.socketEvent(
      'location:update',
      isEmit: true,
      payload: payload,
    );
    _socket.emit('location:update', payload);
  }

  void requestLocationState() {
    if (!_isConnected) {
      onTrackingError?.call('Socket not connected');
      return;
    }

    if (_currentTrackingBookingId == null) {
      onTrackingError?.call('No active tracking room');
      return;
    }

    final payload = {'bookingId': _currentTrackingBookingId};
    DebugLoggerService.socketEvent(
      'location:current',
      isEmit: true,
      payload: payload,
    );
    _socket.emit('location:current', payload);
  }

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

  void disconnect() {
    leaveTrackingRoom();
    _socket.disconnect();
    _socket.dispose();
    _isConnected = false;
    _trackingListenersSetup = false;
    DebugLoggerService.socketConnection(
      'Tracking socket disconnected by client',
    );
  }

  void reconnect() {
    DebugLoggerService.socketConnection('Reconnecting tracking socket...');
    _socket.connect();
  }
}
