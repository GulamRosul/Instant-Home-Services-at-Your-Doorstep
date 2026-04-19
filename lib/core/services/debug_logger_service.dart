import 'package:flutter/foundation.dart';

class DebugLoggerService {
  static final List<LogEntry> _logs = [];
  static const int maxLogs = 500;

  static void log(
    String category,
    String message, {
    dynamic data,
    LogLevel level = LogLevel.info,
  }) {
    final entry = LogEntry(
      timestamp: DateTime.now(),
      category: category,
      message: message,
      data: data,
      level: level,
    );

    _logs.add(entry);

    // Keep only recent logs
    if (_logs.length > maxLogs) {
      _logs.removeRange(0, _logs.length - maxLogs);
    }

    // Print to console for immediate visibility
    _printLog(entry);
  }

  static void socketEvent(
    String eventName, {
    required bool isEmit,
    required dynamic payload,
    String? error,
  }) {
    final direction = isEmit ? '📤 EMIT' : '📥 RECEIVE';
    final message = '$direction: $eventName';

    log(
      'SOCKET',
      message,
      data: {
        'event': eventName,
        'direction': isEmit ? 'outgoing' : 'incoming',
        'payload': payload,
        'error': error,
      },
      level: error != null ? LogLevel.error : LogLevel.debug,
    );
  }

  static void socketConnection(String status, {String? details}) {
    log(
      'SOCKET_CONNECTION',
      '🔌 Connection: $status',
      data: {'details': details},
    );
  }

  static void chatAction(String action, {required Map<String, dynamic> data}) {
    log('CHAT_ACTION', '💬 $action', data: data);
  }

  static void error(
    String category,
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    log(
      category,
      '❌ ERROR: $message',
      data: {'error': error.toString(), 'stackTrace': stackTrace.toString()},
      level: LogLevel.error,
    );
  }

  static List<LogEntry> getLogs({String? category, LogLevel? level}) {
    return _logs.where((entry) {
      if (category != null && entry.category != category) return false;
      if (level != null && entry.level != level) return false;
      return true;
    }).toList();
  }

  static String exportLogs() {
    return _logs
        .map(
          (e) =>
              '${e.timestamp.toIso8601String()} [${e.level.name}] ${e.category}: ${e.message}\n${e.data}',
        )
        .join('\n');
  }

  static void clearLogs() {
    _logs.clear();
  }

  static void _printLog(LogEntry entry) {
    if (kDebugMode) {
      final timeStr = entry.timestamp
          .toIso8601String()
          .split('T')[1]
          .split('.')[0];
      final levelEmoji = _getLevelEmoji(entry.level);
      print('[$timeStr] $levelEmoji [${entry.category}] ${entry.message}');
      if (entry.data != null) {
        print('  └─ ${entry.data}');
      }
    }
  }

  static String _getLevelEmoji(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🔍';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
    }
  }
}

class LogEntry {
  final DateTime timestamp;
  final String category;
  final String message;
  final dynamic data;
  final LogLevel level;

  LogEntry({
    required this.timestamp,
    required this.category,
    required this.message,
    required this.data,
    required this.level,
  });

  @override
  String toString() => '$timestamp [$category] $message - $data';
}

enum LogLevel { debug, info, warning, error }
