# Call Invite with Offline Push Implementation Guide

## Problem

Receivers don't get call notifications when the app is backgrounded or phone is locked.

## Solution Overview

1. Flutter app calls backend `/api/calls/invite` endpoint
2. Backend calls Zego server API with `OfflinePush` enabled
3. Zego sends FCM notification to receiver's device
4. Receiver gets notification even if app is closed/backgrounded

## Backend Endpoint Required

### POST /api/calls/invite

**Request:**

```json
{
  "callerId": "user_123",
  "callerName": "Rahim",
  "receiverId": "user_456",
  "receiverName": "Karim",
  "callType": "audio",
  "bookingId": "BK001"
}
```

**Zego Server API Call:**

```json
POST https://zim-api.zego.im/?Action=CallInvite

{
  "FromUserId": "user_123",
  "UserIds": ["user_456"],
  "Timeout": 60,
  "ExtendedData": "{\"callType\":\"audio\",\"bookingId\":\"BK001\"}",
  "OfflinePush": {
    "Enable": 1,
    "Title": "Incoming call",
    "Content": "Rahim is calling you",
    "Payload": "{\"callType\":\"audio\"}"
  }
}
```

**Backend Response:**

```json
{
  "success": true,
  "message": "Call invite sent",
  "callId": "12261423186766631832",
  "requestId": "req_abc123"
}
```

## Backend Must Store

- callerId
- receiverId
- callType
- bookingId
- callId (from Zego)
- status (sent, accepted, declined, missed, ended)
- createdAt timestamp

## What Must Be Configured

### 1. FCM Setup

- Get FCM Server Key from Firebase Console
- Share with Zego (they need it to send offline push)
- Ensure FCM is enabled in your app

### 2. Zego Account Configuration

- Enable offline push in Zego console
- Configure FCM credentials
- Test offline push through Zego dashboard

### 3. Android Configuration

- Add FCM dependencies in `android/app/build.gradle`
- Add FirebaseMessagingService

### 4. iOS Configuration

- Add Apple Push Notifications capability
- Add VoIP push certificate to Apple Developer
- Configure in Zego console

## Next Steps

1. Create backend endpoint
2. Update Flutter to call backend instead of direct Zego SDK
3. Configure FCM properly
4. Test with phone in flight mode / app closed
