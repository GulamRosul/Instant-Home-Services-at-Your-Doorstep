import 'package:flutter/material.dart';
import 'package:protiva502/debug/room_connection_debug.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';

/// Example screen showing how to connect to room and debug
/// Usage: Just pass token and userId to test the connection
class RoomDebugScreen extends StatefulWidget {
  const RoomDebugScreen({Key? key}) : super(key: key);

  @override
  State<RoomDebugScreen> createState() => _RoomDebugScreenState();
}

class _RoomDebugScreenState extends State<RoomDebugScreen> {
  late RoomConnectionDebug _roomDebug;
  bool _isConnected = false;
  final TextEditingController _receiverIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _roomDebug = RoomConnectionDebug();
    _connectToRoom();
  }

  /// Connect to the room
  Future<void> _connectToRoom() async {
    try {
      // Get token from secure storage
      final token = await SecureStorageService.getToken() ?? 'YOUR_TOKEN_HERE';
      final userId = 'YOUR_USER_ID'; // Replace with actual user ID

      await _roomDebug.connectAndDebugRoom(
        userId: userId,
        token: token,
      );

      setState(() {
        _isConnected = _roomDebug.socketService.isConnected;
      });

      // Print current status
      _roomDebug.printConnectionStatus();
    } catch (e) {
      print('Connection error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Connection Debug'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Status Card
            Card(
              color: _isConnected ? Colors.green[50] : Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connection Status',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          _isConnected ? Icons.check_circle : Icons.cancel,
                          color: _isConnected ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isConnected ? 'CONNECTED' : 'DISCONNECTED',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _isConnected ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'BookingId: ${_roomDebug.bookingId}',
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Current Room: ${_roomDebug.socketService.messagingBookingId ?? "None"}',
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Send Test Message Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send Test Message',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _receiverIdController,
                      decoration: InputDecoration(
                        labelText: 'Receiver ID',
                        hintText: 'Enter receiver user ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _isConnected
                          ? () {
                              if (_receiverIdController.text.isNotEmpty) {
                                _roomDebug.sendTestMessage(
                                  receiverId: _receiverIdController.text,
                                  message:
                                      'Test message from debug - ${DateTime.now()}',
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Message sent!')),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Send Message'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _roomDebug.printConnectionStatus();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Check console logs'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Print Status'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _roomDebug.printAllLogs();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logs printed to console'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('View Logs'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _roomDebug.disconnect();
                  setState(() {
                    _isConnected = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Disconnected')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Disconnect'),
              ),
            ),
            const SizedBox(height: 16),

            // Info Card
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Debug Info',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '• BookingId: cmo5lhl69000q1wf6i7uu0g0h',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                    const Text(
                      '• Events: join:room, message:new, typing:start/stop',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                    const Text(
                      '• All events logged to DebugLoggerService',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                    const Text(
                      '• Socket URL: from ApiEndpoints.socketUrl',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _receiverIdController.dispose();
    _roomDebug.disconnect();
    super.dispose();
  }
}
