import 'package:flutter/material.dart';
import 'package:protiva502/core/services/debug_logger_service.dart';

class DebugLogsScreen extends StatefulWidget {
  const DebugLogsScreen({super.key});

  @override
  State<DebugLogsScreen> createState() => _DebugLogsScreenState();
}

class _DebugLogsScreenState extends State<DebugLogsScreen> {
  String? selectedCategory;
  LogLevel? selectedLevel;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket.IO Debug Logs'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Clear Logs'),
                onTap: () {
                  DebugLoggerService.clearLogs();
                  setState(() {});
                },
              ),
              PopupMenuItem(
                child: const Text('Export Logs'),
                onTap: () {
                  _showExportDialog();
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String?>(
                    value: selectedCategory,
                    hint: const Text('Filter by category'),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('All')),
                      const DropdownMenuItem(
                        value: 'SOCKET',
                        child: Text('SOCKET'),
                      ),
                      const DropdownMenuItem(
                        value: 'SOCKET_CONNECTION',
                        child: Text('SOCKET_CONNECTION'),
                      ),
                      const DropdownMenuItem(
                        value: 'CHAT_ACTION',
                        child: Text('CHAT_ACTION'),
                      ),
                      const DropdownMenuItem(
                        value: 'MESSAGE',
                        child: Text('MESSAGE'),
                      ),
                      const DropdownMenuItem(
                        value: 'AUTH',
                        child: Text('AUTH'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => selectedCategory = value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<LogLevel?>(
                    value: selectedLevel,
                    hint: const Text('Filter by level'),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('All')),
                      const DropdownMenuItem(
                        value: LogLevel.debug,
                        child: Text('Debug'),
                      ),
                      const DropdownMenuItem(
                        value: LogLevel.info,
                        child: Text('Info'),
                      ),
                      const DropdownMenuItem(
                        value: LogLevel.warning,
                        child: Text('Warning'),
                      ),
                      const DropdownMenuItem(
                        value: LogLevel.error,
                        child: Text('Error'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => selectedLevel = value);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Logs
          Expanded(
            child: StatefulBuilder(
              builder: (context, setState) {
                final logs = DebugLoggerService.getLogs(
                  category: selectedCategory,
                  level: selectedLevel,
                );

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    return _buildLogTile(log);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }

  Widget _buildLogTile(LogEntry log) {
    final bgColor = _getLogColor(log.level);
    final textColor = _getTextColor(log.level);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        // border: Border.left(color: textColor, width: 4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log.message,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '[${log.category}] ${log.timestamp.toIso8601String().split('T')[1].split('.')[0]}',
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  log.level.name.toUpperCase(),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          if (log.data != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                log.data.toString(),
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getLogColor(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return Colors.blue[50]!;
      case LogLevel.info:
        return Colors.green[50]!;
      case LogLevel.warning:
        return Colors.yellow[50]!;
      case LogLevel.error:
        return Colors.red[50]!;
    }
  }

  Color _getTextColor(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return Colors.blue[900]!;
      case LogLevel.info:
        return Colors.green[900]!;
      case LogLevel.warning:
        return Colors.orange[900]!;
      case LogLevel.error:
        return Colors.red[900]!;
    }
  }

  void _showExportDialog() {
    final logs = DebugLoggerService.exportLogs();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exported Logs'),
        content: SingleChildScrollView(child: SelectableText(logs)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
