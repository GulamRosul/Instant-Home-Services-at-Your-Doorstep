# Socket.IO Messaging Implementation - Complete Flow

## Current Implementation Status

Based on tested Postman flow and code analysis, here's what's happening in the messaging system.

---

## 📡 Actual Socket.IO Message Flow

### Flow Diagram:

```
SENDER SIDE                          RECEIVER SIDE
═══════════════════════════════════════════════════════════════

User Types Message
         ↓
   sendMessage()
         ↓
1. Add to local messages list
   status: 'sending'
   messageId: 'msg_<local>'
         ↓
2. Emit 'message:send' event
   {bookingId, receiverId, content, messageType}
         ↓
         ┌─────────────────────────────────────────┐
         │    SERVER PROCESSING                    │
         │  - Validate message                     │
         │  - Save to database                     │
         │  - Generate server ID                   │
         │  - Create full message object           │
         └─────────────────────────────────────────┘
         ↓                                        ↓
    Echo back                          Broadcast to room
    'message:send' event                'message:new' event
    (simple payload)                   (full message object)
         ↓                                        ↓
3. Receive 'message:new'      Receive 'message:new'
   Broadcast to entire room           
         ↓                                        ↓
4. DEDUPLICATION:             Display message
   Match with local message   (from other user)
   by: senderId + content     
         ↓
5. UPDATE local message:
   Replace local ID → server ID
   status: 'sending' → 'sent'
   Add: createdAt, sender info
         ↓
6. UI shows message with ✓ icon
   (Message confirmed as sent)
```

---

## 🔄 Complete Event Sequence

### Step 1: Connect Socket

**Code Location:** `socket_io_service.dart:34-82`

```dart
Future<void> connect({required String userId, String? token}) async {
  final optionsBuilder = IO.OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .setPath('/socket.io')
      .setAuth({'Authorization': 'Bearer $token'});
  
  _socket = IO.io('https://x3081msx-3000.asse.devtunnels.ms', optionsBuilder.build());
  _setupSocketListeners();
  _socket.connect();
}
```

**What Happens:**
- ✅ WebSocket connection to `https://x3081msx-3000.asse.devtunnels.ms`
- ✅ Sends Bearer token in auth header
- ✅ Registers base listeners: `connect`, `disconnect`, `error`, `connect_error`
- ✅ Socket ID assigned by server

---

### Step 2: Register All Event Listeners

**Code Location:** `socket_io_service.dart:145-257`

```dart
void _setupMessagingListeners() {
  // Remove old listeners
  _socket.off('message:new');
  _socket.off('message:read');
  _socket.off('typing:start');
  _socket.off('typing:stop');
  _socket.off('message:delete');
  
  // Register new listeners
  _socket.on('message:new', (data) { /* ... */ });
  _socket.on('message:read', (data) { /* ... */ });
  _socket.on('typing:start', (data) { /* ... */ });
  _socket.on('typing:stop', (data) { /* ... */ });
  _socket.on('message:delete', (data) { /* ... */ });
  _socket.on('join:room', (data) { /* ... */ });
  _socket.on('leave:room', (data) { /* ... */ });
}
```

**Listeners Registered:**
- ✅ `message:new` - New message from any user in room
- ✅ `message:read` - Message read status update
- ✅ `typing:start` - User started typing
- ✅ `typing:stop` - User stopped typing
- ✅ `message:delete` - Message deleted
- ✅ `join:room` - User joined room
- ✅ `leave:room` - User left room
- ✅ `message:notification` - Message notification

---

### Step 3: Join Room

**Code Location:** `socket_io_service.dart:127-142`

```dart
void joinMessagingRoom(String bookingId) {
  _currentBookingId = bookingId;
  
  _socket.emit('join:room', {'bookingId': bookingId});
  _setupMessagingListeners();
  
  DebugLoggerService.chatAction('Joined messaging room', 
    data: {'bookingId': bookingId, 'userId': _currentUserId});
}
```

**Postman Request:**
```json
Event: join:room
Payload: {
  "bookingId": "cmo5y6t0500071whwyytrx8ew"
}
```

**What Happens:**
- ✅ Emit `join:room` event with bookingId
- ✅ Server adds this socket to the room
- ✅ Other users in room notified of user join
- ✅ All future messages in this booking go to this room

---

### Step 4: Send Message

**Code Location:** `socket_io_service.dart:260-319`

```dart
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
  
  final payload = {
    'bookingId': _currentBookingId,
    'receiverId': receiverId,
    'content': content,
    'messageType': messageType.toUpperCase(),
    'mediaUrl': mediaUrl,
    'metadata': metadata,
  };
  
  _socket.emit('message:send', payload);
}
```

**Postman Request:**
```json
Event: message:send
Payload: {
  "bookingId": "cmo5y6t0500071whwyytrx8ew",
  "receiverId": "cmntylmxe00021wbgftf9afuf",
  "content": "2nd test pro",
  "messageType": "TEXT"
}
```

**What Happens:**
- ✅ Emits `message:send` event
- ✅ Server receives message
- ✅ Server saves to database
- ✅ Server generates unique ID
- ✅ Prepares full message object

---

### Step 5: Server Response - Two Events

After server saves message, it sends TWO events:

#### Event A: `message:send` (Echo - Unconfirmed)

**Receiver:** Only the sender (same socket)

```json
{
  "bookingId": "cmo5y6t0500071whwyytrx8ew",
  "receiverId": "cmntylmxe00021wbgftf9afuf",
  "content": "2nd test pro",
  "messageType": "TEXT"
}
```

**Purpose:** Immediate echo, shows message sent to server  
**Status:** Unconfirmed (not saved yet)

---

#### Event B: `message:new` (Broadcast - Confirmed)

**Receivers:** ALL users in the room (sender + all receivers)

```json
{
  "id": "cmo6w85vu000kqtqybmrihgd4",
  "senderId": "cmntym2og00031wbgt2z0knsz",
  "receiverId": "cmntylmxe00021wbgftf9afuf",
  "bookingId": "cmo5y6t0500071whwyytrx8ew",
  "roomId": "cmo6s1m1i0000qtqytq8p7xgb",
  "content": "2nd test pro",
  "messageType": "TEXT",
  "mediaUrl": null,
  "isRead": false,
  "readAt": null,
  "createdAt": "2026-04-20T07:48:31.580Z",
  "sender": {
    "id": "cmntym2og00031wbgt2z0knsz",
    "firstName": "hgydfghdf",
    "lastName": "P",
    "avatar": "https://res.cloudinary.com/dpt1l3rco/image/upload/v1776612664/avater/1776612663942-24.jpg.jpg"
  }
}
```

**Purpose:** Confirmed message saved in DB  
**Status:** Confirmed (includes server ID, timestamp, sender details)

---

## 🎯 Critical Implementation Points

### 1. Message Deduplication (Prevent Duplicates)

**Problem:** Sender sends message optimistically, then receives echo + broadcast
- Local message added immediately
- `message:send` echo received 
- `message:new` broadcast received
- **Result: Could create 3 messages if not handled!**

**Solution: Match and Update**

```dart
// When message:new arrives
void _handleMessageReceived(Map<String, dynamic> data) {
  final message = data['content'];
  final senderId = data['senderId'];
  final messageType = data['messageType'];
  
  // DEDUPLICATION: Check if this is our own sent message
  final localMessageIndex = messages.indexWhere(
    (msg) => 
      msg['isLocal'] == true &&                    // Local unconfirmed
      msg['senderId'] == currentUserId &&          // From us
      msg['message'] == message &&                 // Same content
      msg['messageType'] == messageType             // Same type
  );
  
  if (localMessageIndex != -1) {
    // FOUND: Update existing local message
    messages[localMessageIndex].addAll({
      'messageId': data['id'],              // Replace local ID → server ID
      'status': 'sent',                     // Update status
      'isLocal': false,                     // Mark as confirmed
      'createdAt': data['createdAt'],       // Add server timestamp
      'sender': data['sender'],             // Add full sender info
    });
    messages.refresh();
  } else {
    // NOT FOUND: Add as new message from other user
    messages.add({
      'message': message,
      'isMe': false,
      'time': _getCurrentTime(),
      'messageId': data['id'],
      'messageType': messageType,
      'isRead': false,
      'senderId': senderId,
    });
    messages.refresh();
  }
}
```

**How This Prevents Duplicates:**
- ✅ Local unconfirmed messages marked with `isLocal: true`
- ✅ When `message:new` arrives, search for matching local message
- ✅ Match on: sender + content + type (unique combo)
- ✅ If found: UPDATE (replace ID, status, add server data)
- ✅ If not found: ADD as new message
- ✅ **Result: Only ONE message in list, properly confirmed**

---

### 2. Message Status Tracking

```dart
// When user sends message
void sendMessage() {
  final messageText = messageController.text.trim();
  final messageId = _generateMessageId();
  
  // Add LOCALLY with temporary ID
  messages.add({
    'message': messageText,
    'isMe': true,
    'time': _getCurrentTime(),
    'messageId': messageId,          // LOCAL ID (temporary)
    'messageType': 'TEXT',
    'status': 'sending',             // PENDING CONFIRMATION
    'isLocal': true,                 // MARKER FOR DEDUP
    'senderId': currentUserId,
  });
  
  // Send via socket
  socketService.sendMessage(
    receiverId: receiverId.value,
    content: messageText,
    messageType: 'TEXT',
  );
}
```

**Message Lifecycle:**

```
SENDING STATE:
{
  'messageId': 'msg_1713607514000_123456',  ← Local ID (temp)
  'status': 'sending',                      ← Not confirmed
  'isLocal': true,                          ← For deduplication
  'isMe': true,
  'message': 'Hello',
  'messageType': 'TEXT',
}
        ↓ (When message:new arrives) ↓
SENT STATE:
{
  'messageId': 'cmo6w85vu000kqtqybmrihgd4', ← Server ID (final)
  'status': 'sent',                         ← Confirmed in DB
  'isLocal': false,                         ← Dedup complete
  'isMe': true,
  'message': 'Hello',
  'messageType': 'TEXT',
  'createdAt': '2026-04-20T07:48:31.580Z',
  'sender': {...}                           ← Full sender object
}
        ↓ (When message:read arrives) ↓
READ STATE:
{
  'messageId': 'cmo6w85vu000kqtqybmrihgd4',
  'status': 'read',                         ← Read by recipient
  'isRead': true,
  ...
}
```

---

### 3. Handling Different User Types (Client vs Provider)

**Code Location:** `single_chat_controller.dart:43-73`

```dart
// Determine receiverId based on userRole
if (userRole.value == 'provider') {
  // Provider sends to client
  receiverId.value = arguments['clientId'] ?? '';
} else {
  // User (client) sends to provider
  receiverId.value = arguments['providerId'] ?? '';
}

// Validation to prevent sending to self
if (receiverId.value == currentUserId.value) {
  DebugLoggerService.error(
    'CHAT',
    '⚠️ CRITICAL: ReceiverId matches CurrentUserId - messages will be sent to self!',
  );
}
```

**Important:** 
- ✅ Each user type has different logic to determine receiver
- ✅ Critical validation to prevent sending to self
- ✅ Arguments must include correct IDs (clientId or providerId)

---

## 🧪 Testing Checklist

### Test 1: Connection
- [ ] Socket connects with Bearer token
- [ ] Status Code 101 (WebSocket upgrade)
- [ ] All event listeners registered
- [ ] `connected` event received

### Test 2: Room Join
- [ ] Emit `join:room` with bookingId
- [ ] Server confirms room join
- [ ] Ready to send messages

### Test 3: Send & Receive
- [ ] Emit `message:send` with all fields
- [ ] Receive `message:send` echo (unconfirmed)
- [ ] Receive `message:new` broadcast (confirmed)
- [ ] **Message appears ONCE with server ID**
- [ ] **Status changes from 'sending' → 'sent'**

### Test 4: Deduplication Verify
- [ ] Only ONE message in final list (not 3)
- [ ] messageId is server ID (not local ID)
- [ ] isLocal = false (marked as confirmed)
- [ ] createdAt and sender data present

### Test 5: Different Scenarios
- [ ] Rapid successive sends (each gets unique local ID)
- [ ] Other user joins and receives same message
- [ ] Message read receipts update correctly
- [ ] Message deletion works with server ID

---

## ⚠️ Common Bugs & Fixes

| Bug | Cause | Fix |
|-----|-------|-----|
| **Duplicate messages** | Not matching local with server | Use deduplication logic above |
| **Wrong message ID** | Using local ID instead of server | Update with server ID from `message:new` |
| **Message stuck sending** | Not listening to `message:new` | Ensure listener registered in `_setupMessagingListeners()` |
| **Empty receiverId** | Arguments not passed correctly | Validate receiverId before sending |
| **Receiver doesn't see message** | Not joining same room | Ensure both use same bookingId |
| **Sending to self** | receiverId == currentUserId | Add validation check |

---

## 📝 Code References

**File:** `lib/core/services/socket_io_service.dart`
- Line 34: `connect()` - Initialize socket
- Line 85: `_setupSocketListeners()` - Base listeners
- Line 127: `joinMessagingRoom()` - Join room
- Line 145: `_setupMessagingListeners()` - Register message listeners
- Line 260: `sendMessage()` - Send message

**File:** `lib/features/chat/controller/single_chat_controller.dart`
- Line 126: `_initializeSocket()` - Init socket in controller
- Line 154: `socketService.connect()` - Connect with token
- Line 167: `socketService.joinMessagingRoom()` - Join room
- Line 179: `_handleMessageReceived()` - **CRITICAL: Deduplication logic here**
- Line 287: `sendMessage()` - Send message with local ID

**File:** `lib/features/chat/screen/single_chat_screen.dart`
- Line 152: `_buildChatBubble()` - Display message bubble

---

## ✅ What's Working

- ✅ Socket connection with Bearer token
- ✅ Event listeners properly registered
- ✅ Join room functionality
- ✅ Message sending and receiving
- ✅ Message deduplication (when implemented correctly)
- ✅ Event flow matches Postman testing

---

## 🚀 Next Steps

1. **Verify deduplication logic** in `_handleMessageReceived()`
2. **Test with Postman** following test checklist
3. **Monitor debug logs** for message flow
4. **Ensure receiverId validation** before send
5. **Test with different user types** (client vs provider)