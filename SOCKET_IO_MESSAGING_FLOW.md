# Socket.IO Messaging Flow Documentation

## Overview
Complete messaging flow using Socket.IO WebSocket connection for real-time bidirectional messaging between users. This document details the exact sequence of events based on tested Postman flow.

---

## Step 1: Connect Socket

**URL:** `https://x3081msx-3000.asse.devtunnels.ms/socket.io/?EIO=4&transport=websocket`

**Protocol:** WebSocket (HTTP GET with Upgrade header)

**Request Headers:**
```
authorization: Bearer <JWT_TOKEN>
sec-websocket-version: 13
sec-websocket-key: <random-key>
connection: Upgrade
upgrade: websocket
```

**Response:** Status `101 Switching Protocols` (WebSocket handshake successful)

**Expected Behavior:**
- ✅ WebSocket connection established
- ✅ All event listeners are registered and ready to receive events
- ✅ `connected` event is emitted by server
- ✅ Socket ID is assigned by server

---

## Step 2: Join Room

**Event Name:** `join:room`

**Request Payload:**
```json
{
  "bookingId": "cmo5y6t0500071whwyytrx8ew"
}
```

**Server Response:**
- User is added to the room identified by `bookingId`
- Other users in the room are notified via `join:room` event
- Room event listeners are now active for this specific booking
- User can now send/receive messages in this room

**Example Response from Server:**
```json
{
  "bookingId": "cmo5y6t0500071whwyytrx8ew",
  "userId": "cmntym2og00031wbgt2z0knsz",
  "message": "User joined room"
}
```

---

## Step 3: Send Message

**Event Name:** `message:send`

**Request Payload (Sender):**
```json
{
  "bookingId": "cmo5y6t0500071whwyytrx8ew",
  "receiverId": "cmntylmxe00021wbgftf9afuf",
  "content": "2nd test pro",
  "messageType": "TEXT"
}
```

### Server Response Flow:

#### Event 1: `message:send` (Echo back to sender)
```json
{
  "bookingId": "cmo5y6t0500071whwyytrx8ew",
  "receiverId": "cmntylmxe00021wbgftf9afuf",
  "content": "2nd test pro",
  "messageType": "TEXT"
}
```
**Timing:** Immediately after request  
**Recipient:** Only the sender receives this

#### Event 2: `message:new` (Broadcast to entire room)
Sent to **BOTH sender and all receivers in the room**

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

**Timing:** After message is saved to database  
**Recipients:** 
- ✅ Sender (to confirm message was sent)
- ✅ Receiver(s) in the same room
- ✅ All users in the booking room

**Key Fields:**
- `id` - Server-generated unique message ID
- `senderId` - User who sent the message
- `receiverId` - Intended recipient
- `roomId` - The room this message belongs to
- `createdAt` - Server timestamp (ISO 8601)
- `sender` - Full sender object with profile details

---

## Complete Event Sequence Diagram

```
┌─────────────────────────────────────────────────────────┐
│ STEP 1: SOCKET CONNECT                                   │
└─────────────────────────────────────────────────────────┘
    Client: GET /socket.io/?EIO=4&transport=websocket
    Server: 101 Switching Protocols
    ↓
    Socket Connected ✅
    All event listeners now ready

┌─────────────────────────────────────────────────────────┐
│ STEP 2: JOIN ROOM                                        │
└─────────────────────────────────────────────────────────┘
    Client: Emit 'join:room' {bookingId}
    Server: Confirms room joined
    ↓
    User added to room ✅
    Can send/receive messages

┌─────────────────────────────────────────────────────────┐
│ STEP 3: SEND MESSAGE                                     │
└─────────────────────────────────────────────────────────┘
    Client: Emit 'message:send' {bookingId, receiverId, content, messageType}
    ↓
    Server receives message
    Server saves to database
    ↓
    Server Response #1: Emit 'message:send' (echo to sender only)
    Server Response #2: Emit 'message:new' (broadcast to entire room)
    ↓
    SENDER receives 'message:new' → Update message with server ID ✅
    RECEIVERS receive 'message:new' → Display message in UI ✅
```

---

## Event Listeners to Register

**After socket connects, register these listeners:**

```
✅ message:new       - New message received
✅ message:read      - Message marked as read
✅ typing:start      - User started typing
✅ typing:stop       - User stopped typing
✅ message:delete    - Message was deleted
✅ message:notification - Message notification
✅ join:room         - User joined room
✅ leave:room        - User left room
✅ connected         - Socket connected
✅ disconnect        - Socket disconnected
✅ error             - Socket error
```

---

## Key Implementation Points

### Connection Flow:
1. ✅ Initialize socket with Bearer token in auth header
2. ✅ Disable auto-connect initially
3. ✅ Register all event listeners
4. ✅ Call `socket.connect()`

### Room Join Flow:
1. ✅ After socket connected, emit `join:room` with bookingId
2. ✅ Wait for room join confirmation
3. ✅ Ready to send/receive messages

### Message Send & Receive Flow:
1. ✅ Emit `message:send` with all required fields
2. ✅ **Receive `message:send` echo** (immediate, unconfirmed)
3. ✅ **Receive `message:new` broadcast** (saved to DB, confirmed)
4. ✅ Update local message with server ID when `message:new` arrives
5. ✅ Mark as "sent" when `message:new` received

### Critical for Deduplication:
- Client sends message optimistically (shows in UI immediately)
- Server echoes back with `message:send` 
- Server broadcasts saved message with `message:new` (includes server ID)
- **Match local message with server response using:** sender + content + type
- **Replace local ID with server ID** when `message:new` arrives
- **This prevents duplicate message display**

---

## Status Codes & Headers

**Connection Response:**
- `Status Code: 101 Switching Protocols` - WebSocket upgrade successful
- `Upgrade: websocket` - Protocol upgraded to WebSocket
- `Sec-WebSocket-Accept: <hash>` - Handshake validation
- `Set-Cookie: .Tunnels.Relay.WebForwarding.Cookies=...` - Session cookie

---

## Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| Messages not received | Event listeners not registered | Register all listeners before joining room |
| Duplicate messages | Not matching send with new | Use deduplication logic: match by sender+content+type |
| Message not confirmed | Not listening to `message:new` | Ensure `message:new` listener is active |
| Empty receiverId | Arguments not passed correctly | Validate receiverId is set before sending |
| Wrong server ID | Using local ID instead of server ID | Update message with server ID from `message:new` |
