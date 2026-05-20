import 'package:logger/logger.dart';

class AppLoggerHelper {
  AppLoggerHelper._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,        // No stack trace lines
      errorMethodCount: 8,   // Stack trace lines for errors
      lineLength: 120,       // Wider lines
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.none,
    ),
    output: _ChunkedConsoleOutput(), // 👈 key fix
    level: Level.debug,
  );

  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, [dynamic error]) =>
      _logger.e(message, error: error, stackTrace: StackTrace.current);
}

/// Splits long log lines into chunks to avoid Android logcat truncation
class _ChunkedConsoleOutput extends LogOutput {
  static const _chunkSize = 800;

  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      if (line.length <= _chunkSize) {
        // ignore: avoid_print
        print(line);
      } else {
        for (int i = 0; i < line.length; i += _chunkSize) {
          final end = (i + _chunkSize < line.length) ? i + _chunkSize : line.length;
          // ignore: avoid_print
          print(line.substring(i, end));
        }
      }
    }
  }
}