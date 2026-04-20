# Room Connection & BookingId Debug Guide

## Overview
Your Protiva502 app uses **Socket.IO** for real-time messaging. Here's how to connect to a room with a specific bookingId and debug the connection.

## BookingId & Room Details
```json
{
  "bookingId": "cmo5lhl69000q1wf6i7uu0g0h"
}
```

## Socket Events You Can Handle

### 📥 **Listening Events** (incoming from server):
- `connected` - Socket connection established
- `join:room` - Room join confirmation
- `message:new` - New message received
- `message:read` - Message read receipt
- `typing:start` - User started typing
- `typing:stop` - User stopped typing
- `message:delete` - Message deleted
- `leave:room` - Left room

### 📤 **Emitting Events** (send to server):
- `join:room` - { bookingId: string }
- `message:send` - { bookingId, receiverId, content, messageType, ... }
- `typing:start` - { bookingId }
- `typing:stop` - { bookingId }
- `message:read` - { bookingId, messageIds }
- `message:delete` - { bookingId, messageId }
- `leave:room` - { bookingId }

---

## Quick Start: Using RoomConnectionDebug

### 1. **Basic Connection**
```dart
import 'package:protiva502/debug/room_connection_debug.dart';

final roomDebug = RoomConnectionDebug();

// Connect to room
await roomDebug.connectAndDebugRoom(
  userId: 'your_user_id',
  token: 'your_auth_token',
);

// Check status
roomDebug.printConnectionStatus();
```

### 2. **Send a Test Message**
```dart
roomDebug.sendTestMessage(
  receiverId: 'recipient_user_id',
  message: 'Hello, World!',
);
```

### 3. **Monitor All Events**
The debug utility automatically logs:
- Connection/disconnection
- All socket events (emit & receive)
- Message send/receive/read
- Typing indicators
- Errors

All logs are printed to console AND stored in `DebugLoggerService`.

### 4. **View All Logs**
```dart
roomDebug.printAllLogs();

// Or access programmatically
final logs = DebugLoggerService.getLogs();
final socketLogs = DebugLoggerService.getLogs(category: 'SOCKET');
final chatLogs = DebugLoggerService.getLogs(category: 'CHAT_ACTION');
```

---

## Technical Implementation Details

### SocketIOService (Core Service)
Located: `lib/core/services/socket_io_service.dart`

**Key Methods:**
```dart
// Connect to socket server
await socketService.connect(
  userId: userId,
  token: token,
);

// Join a messaging room
socketService.joinMessagingRoom(bookingId);

// Send message
socketService.sendMessage(
  receiverId: receiverId,
  content: 'message text',
  messageType: 'TEXT',
);

// Other methods
socketService.markMessagesAsRead(messageIds);
socketService.deleteMessage(messageId);
socketService.emitTypingStart();
socketService.emitTypingStop();
socketService.leaveMessagingRoom();
socketService.disconnect();
```

**Available Callbacks:**
```dart
socketService.onConnectionStatusChanged = (connected) { };
socketService.onMessageReceived = (data) { };
socketService.onMessageRead = (data) { };
socketService.onTypingStart = (userId) { };
socketService.onTypingStop = (userId) { };
socketService.onMessageDeleted = (messageId) { };
socketService.onError = (error) { };
```

### SingleChatController Example
Located: `lib/features/chat/controller/single_chat_controller.dart`

Shows how to:
- Initialize socket connection
- Join a room
- Send/receive messages
- Handle typing indicators
- Mark messages as read
- Manage deduplication

---

## API Endpoints

**Socket Server URL:**
```
https://x3081msx-3000.asse.devtunnels.ms
```

**Auth Headers:**
```
Authorization: Bearer {token}
Content-Type: application/json
```

---

## Debugging Console Output

When connected, you'll see formatted debug output like:

```
═══════════════════════════════════════
🚀 JOINING ROOM
═══════════════════════════════════════
bookingId: cmo5lhl69000q1wf6i7uu0g0h
Socket Connected: true
✅ Join event emitted
═══════════════════════════════════════

✍️ user_123 is typing...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📨 NEW MESSAGE
From: provider_456
Content: Hello there!
Type: TEXT
ID: msg_123456789
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

╔════════════════════════════════════════╗
║         CONNECTION STATUS              ║
║ BookingId: cmo5lhl69000q1wf6i7uu0g0h  ║
║ Connected: true                        ║
║ Current Room: cmo5lhl69000q1wf6i7uu0g0h ║
╚════════════════════════════════════════╝
```

---

## Complete Example: Chat Flow

```dart
// 1. Initialize
final roomDebug = RoomConnectionDebug();

// 2. Connect
await roomDebug.connectAndDebugRoom(
  userId: 'user_123',
  token: 'jwt_token_here',
);
// ✅ Socket Connected
// ✅ Room Joined: cmo5lhl69000q1wf6i7uu0g0h

// 3. Listen for messages
// (automatic - all events logged)

// 4. Send message
roomDebug.sendTestMessage(
  receiverId: 'provider_456',
  message: 'Hi, are you available?',
);
// 📤 Test message sent to: provider_456

// 5. Receive message (from other user)
// 📨 NEW MESSAGE
// From: provider_456
// Content: Yes, I'm available!

// 6. Typing indicator
// ✍️ provider_456 is typing...

// 7. Check status
roomDebug.printConnectionStatus();
// ╔════════════════════════════════════════╗
// ║ BookingId: cmo5lhl69000q1wf6i7uu0g0h  ║
// ║ Connected: true                        ║
// ║ Current Room: cmo5lhl69000q1wf6i7uu0g0h ║
// ╚════════════════════════════════════════╝

// 8. Disconnect
roomDebug.disconnect();
// 🔌 Disconnected
```

---

## File Structure

```
lib/
├── debug/
│   ├── room_connection_debug.dart    ← Main debug utility
│   └── room_debug_screen.dart        ← Debug UI screen
├── core/
│   ├── services/
│   │   ├── socket_io_service.dart    ← Core socket service
│   │   └── debug_logger_service.dart ← Logging service
│   └── utils/
│       └── constants/
│           └── apiendpoint.dart      ← Socket URL config
└── features/
    └── chat/
        ├── controller/
        │   └── single_chat_controller.dart
        └── screen/
            └── single_chat_screen.dart
```

---

## Troubleshooting

### ❌ "Socket not connected"
- Verify internet connection
- Check auth token is valid
- Check socket server URL in ApiEndpoints
- Increase timeout duration

### ❌ "Cannot join room"
- Ensure bookingId is valid and non-empty
- Verify socket is fully connected before joining
- Check server-side room configuration

### ❌ "Message not sending"
- Verify receiverId is correct and not same as userId
- Check socket is connected
- Verify receiverId exists on server

### ❌ No messages received
- Check if other user has joined same room
- Verify message read callbacks are setup
- Check DebugLoggerService logs for errors

---

## Integration with Your App

To use in your actual chat screen, replace:

```dart
// In your chat controller
socketService.joinMessagingRoom(bookingId);
```

With debug version:
```dart
// In your chat controller
if (kDebugMode) {
  final roomDebug = RoomConnectionDebug();
  roomDebug.connectAndDebugRoom(userId: userId, token: token);
}
```

Or use the dedicated `RoomDebugScreen` by adding to navigation:

```dart
Get.to(() => const RoomDebugScreen());
```

---

## Next Steps

1. ✅ Test connection with `RoomConnectionDebug`
2. ✅ Verify all events in console logs
3. ✅ Test message send/receive flow
4. ✅ Integrate with actual chat UI
5. ✅ Remove debug files before production

---

## Resources

- **Socket.IO Documentation:** https://socket.io/docs/v4/client-api/
- **socket_io_client Package:** https://pub.dev/packages/socket_io_client
- **Your Socket Service:** `lib/core/services/socket_io_service.dart`
- **Your Chat Controller:** `lib/features/chat/controller/single_chat_controller.dart`
