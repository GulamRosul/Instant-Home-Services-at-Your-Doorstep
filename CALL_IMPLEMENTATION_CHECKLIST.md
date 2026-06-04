# Call Notification Implementation Checklist

## ✅ Flutter Changes (Completed)

- [x] Created `CallApiService` for backend communication
- [x] Updated `CallService` to call backend API instead of direct Zego SDK
- [x] Modified `TrackProviderController.callPerson()` to handle backend response
- [x] Added error handling and logging
- [x] Added API endpoint to `ApiEndpoints`

## 🔧 Backend Implementation (TODO)

### 1. Create Call Invite Endpoint

**Endpoint:** `POST /api/calls/invite`

**Controller Logic:**

```dart
// Example logic (adapt to your backend tech stack)
1. Validate requestbody (callerId, receiverId, etc.)
2. Generate unique callId
3. Call Zego's server API:
   - FromUserId: callerId
   - UserIds: [receiverId]
   - Timeout: 60 seconds
   - OfflinePush: enabled with FCM
4. Save call record to database
5. Return response with callId to Flutter
```

**Database Record:**

```
callId (unique)
callerId
receiverId
callType: "audio"
bookingId
status: "sent"
createdAt
receiverFCMToken (for fallback)
```

### 2. Configure FCM (Firebase Cloud Messaging)

**Android:**

- Add to `google-services.json`
- Add FCM dependency in backend

**iOS:**

- Add Apple Push Notifications certificate
- Create VoIP push certificate

**Share with Zego:**

- Provide FCM Server Key to Zego team
- Enable offline push in Zego console

### 3. Handle Call Accept/Decline

Create additional endpoints:

- `POST /api/calls/{callId}/accept` - receiver accepts call
- `POST /api/calls/{callId}/decline` - receiver declines call

Update call status in database and notify caller via FCM if needed.

### 4. Test Offline Push

**Scenarios to test:**

1. ✅ App open, receiver online
2. ✅ App backgrounded, receiver online
3. ✅ App closed, receiver online
4. ✅ Device locked, receiver online
5. ✅ Phone in airplane mode (after re-enabling)

## 📱 Flutter/Mobile Configuration

### Android

File: `android/app/src/main/AndroidManifest.xml`

- Ensure `POST_NOTIFICATIONS` permission exists
- Check `INTERNET` permission exists

### iOS

File: `ios/Runner/Info.plist`

- Ensure `NSBonjourServices` includes call permissions
- Check VoIP background mode is enabled

## 🧪 Testing

After backend implementation:

1. Test with receiver app fully closed
2. Verify notification appears on lock screen
3. Verify tap opens app and navigates to call screen
4. Test with phone in sleep mode
5. Verify background task handling

## 📋 Zego Configuration

**In Zego Console:**

1. Go to Settings → Push Notifications
2. Enable FCM for Android
3. Enable APNs for iOS
4. Upload FCM Server Key
5. Configure notification titles/messages
6. Test through Zego dashboard

## 🔗 API Response Format Expected

```json
{
  "success": true,
  "message": "Call invite sent",
  "callId": "unique_call_id_from_zego",
  "requestId": "request_tracking_id"
}
```

## ⚠️ Important Notes

- Backend MUST enable `"Enable": 1` in OfflinePush
- FCM credentials must be shared with Zego
- Timeout should be reasonable (60 seconds recommended)
- Store all call records for analytics/history
- Test thoroughly before production deployment
