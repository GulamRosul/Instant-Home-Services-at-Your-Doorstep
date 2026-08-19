# 📱 VoIP & Background Audio Restoration Guide for App Store Release

## 📌 Background & Issue Summary

### Apple Rejection Notice (Guideline 2.5.4 - Performance - Software Requirements)
Apple rejected the app during review because `ios/Runner/Info.plist` declared:
- `voip` under `UIBackgroundModes` (without active VoIP service functional in app)
- `audio` under `UIBackgroundModes` (without background audio playback)

### Why Microphone Permission was requested on launch/login
`ZegoUIKitPrebuiltCallInvitationService.init()` initializes the Zego UIKit signaling plugin and audio context on startup/login, which triggers the system permission dialog:
> *"Kaaj BD would like to access the Microphone. We need microphone access for voice calls."*

Since VoIP features are disabled for the initial release, asking for microphone permissions on launch/login causes confusion for users and reviewers.

---

## 🛠️ Changes Applied for Initial Build (Release v1.0)

To resolve the rejection and ensure initial release approval:

1. **`ios/Runner/Info.plist`**:
   - `voip` and `audio` entries under `UIBackgroundModes` were commented out.
   - `remote-notification` remains active for Push Notifications (FCM).

2. **`lib/features/google_map/screen/map_screen.dart`**:
   - The **Call Button UI** block has been commented out for both `CLIENT` and provider roles so only the **Message** button is visible.

3. **Call Service Initialization (`lib/main.dart`, `user_login_controller.dart`, `provider_login_controller.dart`)**:
   - Commented out `CallService.instance.initialize(...)` so Zego does not prompt for microphone permissions on startup or login.

---

## 🔄 How to Restore Call & VoIP Features in Future Releases

When your ZegoCloud subscription is active and you are ready to enable VoIP calling again, follow these steps:

### Step 1: Re-enable Background Modes in iOS (`ios/Runner/Info.plist`)

Open `ios/Runner/Info.plist` and change lines 45–50 from:

```xml
	<key>UIBackgroundModes</key>
	<array>
		<!-- <string>voip</string> -->
		<string>remote-notification</string>
		<!-- <string>audio</string> -->
	</array>
```

Back to:

```xml
	<key>UIBackgroundModes</key>
	<array>
		<string>voip</string>
		<string>remote-notification</string>
		<string>audio</string>
	</array>
```

---

### Step 2: Uncomment Call Service Initialization

Uncomment `CallService.instance.initialize(...)` in the following 3 files:

1. **`lib/main.dart`**:
```dart
CallService.instance.setNavigatorKey(appNavigatorKey);
await CallService.instance.initializeFromStorage();
```

2. **`lib/features/user/authentication/controller/user_login_controller.dart`**:
```dart
await CallService.instance.initialize(
  userID: userId ?? '',
  userName: StorageService.getDisplayName(),
);
```

3. **`lib/features/service_provider/auhecntication/controller/provider_login_controller.dart`**:
```dart
await CallService.instance.initialize(
  userID: user?['id']?.toString() ?? '',
  userName: StorageService.getDisplayName(),
);
```

---

### Step 3: Uncomment Call Button in `lib/features/google_map/screen/map_screen.dart`

Open `lib/features/google_map/screen/map_screen.dart`.

#### For Client Role (Lines ~961–987):
Uncomment the call button code block:

```dart
Expanded(
  child: Container(
    height: 48.h,
    decoration: BoxDecoration(
      color: AppColors.textPurple,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: controller.callPerson,
        borderRadius: BorderRadius.circular(8.r),
        child: Center(
          child: Text(
            'call'.tr,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  ),
),
SizedBox(width: 12.w),
```

#### For Provider Role (Lines ~1021–1047):
Uncomment the provider call button block similarly.

---

### Step 4: Apple Submission Requirement for Future VoIP Releases

When submitting a version with `voip` or `audio` enabled in `UIBackgroundModes`, Apple requires:
- A **screen recording** on a physical device showing the VoIP/call feature functioning in foreground and background.
- Uploading/attaching the recording in the **Notes** section of App Review Information in App Store Connect.

---

**Last Updated**: August 2026  
**Status**: Ready for Initial App Store Submission (v1.0)
