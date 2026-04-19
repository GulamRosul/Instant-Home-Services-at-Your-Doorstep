# Socket.IO Message Debugging Guide

## Overview
This guide helps you track and debug the complete message flow from sender to receiver using the comprehensive logging system.

## How to Access Debug Logs

1. Add a debug button to your chat screen or use the DebugLogsScreen
2. Navigate to the debug logs screen while testing
3. Filter by category or log level to focus on relevant events

## Message Flow Checklist

### 1. **Sender Side (Message Sent)**

#### Expected Log Sequence:
```
✅ SOCKET_CONNECTION: Socket connected (socket id should be present)
✅ SOCKET: 📤 EMIT join:room with bookingId
✅ CHAT_ACTION: Chat initialized from arguments (verify receiverId is NOT empty)
✅ CHAT_ACTION: Message prepare to send (with valid receiverId)
✅ SOCKET: 📤 EMIT message:send with payload:
   - bookingId: [value]
   - receiverId: [value] ⚠️ THIS MUST NOT BE EMPTY!
   - content: [message text]
   - messageType: TEXT
```

#### What to check:
- [ ] Is `bookingId` present and not empty?
- [ ] Is `receiverId` present and not empty?
- [ ] Is `messageType` set to "TEXT"?
- [ ] Is the message `content` not empty?
- [ ] Is the socket `connected` status showing?

### 2. **Backend Processing (Should see ACK)**

#### Expected:
```
✅ SOCKET: 📥 RECEIVE message:ack (from backend confirming receipt)
   - messageId: [value]
   - status: delivered or pending
```

**If you DON'T see `message:ack`:**
- The backend may not be receiving the message
- Check backend logs for the message:send event
- Verify bookingId and receiverId are valid in the database

### 3. **Receiver Side (Should receive message)**

#### Expected:
```
✅ SOCKET: 📥 RECEIVE message:received
   - bookingId: [value]
   - senderId: [sender's userId]
   - content: [message text]
   - messageType: TEXT
   - messageId: [value]
```

#### What to check:
- [ ] Is the receiver listening for `message:received` event?
- [ ] Is the receiver in the correct `bookingId` room?
- [ ] Does the received message have a valid `messageId`?
- [ ] Is the message displayed in the UI?

### 4. **Read Receipt Flow**

#### Expected:
```
✅ SOCKET: 📤 EMIT message:read with bookingId and messageIds
✅ SOCKET: 📥 RECEIVE message:read (acknowledgement from backend)
   - messageIds: [array of ids marked as read]
```

## Common Issues & Solutions

### Issue 1: Message Sent But Not Received
**Symptoms:**
- You see `message:send` being emitted ✅
- But receiver never gets `message:received` ❌

**Debug Steps:**
1. Check if `message:ack` is received from backend
2. Verify both users are in the same `bookingId` room
3. Check if `receiverId` matches the receiver's `userId`
4. Look for backend logs showing the message:send event

### Issue 2: Empty receiverId
**Symptoms:**
- CHAT_ACTION: "Chat initialized" shows `receiverId: ""`
- Error: "Cannot send message: receiver not found"

**Debug Steps:**
1. Check if arguments are being passed to chat screen correctly
2. Verify the argument keys: `providerId`, `clientId`, or `receiverId`
3. Check user role is set correctly (`user` or `provider`)
4. Look at the "allArguments" logged in initialization

### Issue 3: Socket Not Connected
**Symptoms:**
- SOCKET_CONNECTION shows "Disconnected"
- No events are being emitted/received

**Debug Steps:**
1. Check auth token is present and valid
2. Verify backend URL is correct
3. Check network connectivity
4. Look for connection_error events

### Issue 4: Events Sent But No Response
**Symptoms:**
- You see `📤 EMIT message:send`
- But no `📥 RECEIVE message:ack` or `message:received`

**Debug Steps:**
1. Check if the event name is exactly: `message:send` (case-sensitive)
2. Verify payload structure matches backend expectations
3. Check for error events: `message:error`
4. Check backend logs to see if event is being received

## Log Categories Reference

| Category | Description |
|----------|-------------|
| SOCKET_CONNECTION | Socket connection/disconnection events |
| SOCKET | Socket.IO event emissions and receptions |
| CHAT_ACTION | High-level chat operations (message send, receive) |
| MESSAGE | Message-specific operations (mark as read, delete) |
| AUTH | Authentication and token-related logs |
| SOCKET_RAW | Raw socket events (for advanced debugging) |

## Quick Filter Tips

1. **Debugging message send issues:** Filter by `CHAT_ACTION` or `SOCKET`
2. **Debugging connection issues:** Filter by `SOCKET_CONNECTION`
3. **Debugging backend communication:** Filter by `SOCKET` + `message` events
4. **Debugging auth issues:** Filter by `AUTH`

## Expected Log Format

Each log entry shows:
- **Timestamp:** When the event occurred
- **Category:** Which system generated the log
- **Message:** Human-readable description
- **Data:** Structured data with all relevant information

Example:
```
[14:23:45] ✅ [SOCKET] 📤 EMIT message:send
  └─ {bookingId: cmo5dysrj00069xqybx15adt6, receiverId: cmntym2og00031wbgt2z0knsz, content: Hello!, messageType: TEXT}
```

## How to Export Logs

1. Open Debug Logs Screen
2. Tap the three-dot menu (⋮)
3. Select "Export Logs"
4. Share or save the logs for troubleshooting

## Next Steps

After identifying the issue using these logs:
1. Note the missing event or error in the flow
2. Check backend logs at that point
3. Verify data payload matches backend expectations
4. Contact backend team with the exported logs for detailed analysis
