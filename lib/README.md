I/zego_jni( 7504): [2026-5-4 11:2:54:574][Verbose][API] callInvite. handle: 12970495528517775566, mode: 0, invitess count: 1, timeout: 60, extended data: {"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863774548\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, enable_not_received_check:falseoffline push: (title size: 13, content size: 29, extended_data size: 331, resources id:)
I/PLogger ( 7504): {call-invitation}  {service, send}  {send call invitation}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service.p, send call invitation}  {callees:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}], isVideoCall:false, callID:cmomfeqzy000mj3qnrjz2x60e_1777863774548, customData:, resourceID:null, notificationTitle:Incoming call, notificationMessage:Nowshin Fabiha is calling you, timeoutSeconds:60}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}]}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}], }  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation service, send invitation}  {time:2026-05-04 09:02:54.560376, network state:ZegoUIKitNetworkState.online, invitees:[cmntym2og00031wbgt2z0knsz], timeout:60, type:0, zimExtendedData:{"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863774548\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, notification config:title:Incoming call, message:Nowshin Fabiha is calling you, resource id:, voIPConfig:null, notify:true}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {signaling}  {invitation}  {send invitation, invitees:[cmntym2og00031wbgt2z0knsz], timeout:60, extendedData:{"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863774548\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, push config:{title: Incoming call, message: Nowshin Fabiha is calling you, payload: {"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863774548\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, resourceID: , voipConfig:{iOSVoIPHasVideo: false, }}}  {04/05/2026 09:02:54}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:2:54:734][Verbose][Callback] OnCallInvitationSent: call id: 7145345972660563812, code: 0, msg: operation was successful, seq: 2
I/zego_jni( 7504): [2026-5-4 11:2:54:735][Verbose][Callback] OnCallUserStateChanged: call id: 7145345972660563812,call user info list:2
I/zego_jni( 7504): [2026-5-4 11:2:54:735][Verbose][Callback] OnCallInvitationCreated: call id: 7145345972660563812,call user list size:2
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUIKitCallPlugin( 7504): onMethodCall: startMonitoringAudioRoute
D/ZegoUIKitCallPlugin( 7504): Audio route monitoring started (BroadcastReceiver)
I/PLogger ( 7504): {signaling}  {invitation}  {send invitation, done, invitation id:7145345972660563812, error user list:(), error invitees:()}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {send invitation done, invitationID:7145345972660563812}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {add invitation data id:7145345972660563812, type:0, inviter id:cmogzn2620001ytqnylkf4tgh, invitees:(userid :cmntym2og00031wbgt2z0knsz, state:InvitationState.waiting), data:{"call_id":"cmomfeqzy000mj3qnrjz2x60e_1777863774548","inviter_name":"Nowshin Fabiha","invitees":[{"user_id":"cmntym2og00031wbgt2z0knsz","user_name":"Service Provider"}],"timeout":60,"custom_data":"","v":"f1.0"}, resourceID:}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {invite success, invitationID:7145345972660563812}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:callInvite, params:{call_id: 7145345972660563812, invitees: [cmntym2og00031wbgt2z0knsz], count: 1, error_userlist: [], error_count: 0, extended_data: {"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863774548\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}}, }  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/invite, params:{call_id: 7145345972660563812, source: api}, }  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {local send invitation, call id:cmomfeqzy000mj3qnrjz2x60e_1777863774548, invitees:(cmntym2og00031wbgt2z0knsz), type:ZegoCallInvitationType.voiceCall, customData:, code:, message:, error invitees:[], invitation id:7145345972660563812, localConfig:ZegoCallInvitationLocalParameter:{resourceID:null, notificationTitle:Incoming call, notificationMessage:Nowshin Fabiha is calling you, timeoutSeconds:60, }, }  {04/05/2026 09:02:54}  {INFO}
D/ZegoUIKitCallPlugin( 7504): Audio route broadcast received: android.media.ACTION_SCO_AUDIO_STATE_UPDATED
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
D/ZegoUIKitCallPlugin( 7504): 🔊 Audio route changed
D/ZegoUIKitCallPlugin( 7504): Event: android.media.ACTION_SCO_AUDIO_STATE_UPDATED
D/ZegoUIKitCallPlugin( 7504): Speakerphone: false
D/ZegoUIKitCallPlugin( 7504): BluetoothSco: false
D/ZegoUIKitCallPlugin( 7504): WiredHeadset: false
D/ZegoUIKitCallPlugin( 7504): Mode: 0
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {call-invitation}  {machine}  {entry, page state:CallingState.kCallingWithVoice}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call}  {machine, Navigator}  {push from onCallingEntry, }  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from State[CallingState.kIdle] to State[CallingState.kCallingWithVoice]}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallUserStateChanged, callUserList:({userID:cmntym2og00031wbgt2z0knsz, state:ZIMCallUserState.inviting, extendedData:}, {userID:cmogzn2620001ytqnylkf4tgh, state:ZIMCallUserState.accepted, extendedData:}),invitationID:7145345972660563812}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onInvitationUserStateChanged, {invitationID:7145345972660563812, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.inviting, extended data:}, {userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:}]}}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {onAdvanceInvitationUserStateChanged, {invitationID:7145345972660563812, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.inviting, extended data:}, {userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:}]}}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmntym2og00031wbgt2z0knsz}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmogzn2620001ytqnylkf4tgh}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {invitation map: {}}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {on invitation user state changed, event:{invitationID:7145345972660563812, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.inviting, extended data:}, {userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:}]}}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}]}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}], }  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call}  {machine, Navigator}  {push from onCallingEntry, onInitState}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {onStateChanged, currentState:CallingState.kCallingWithVoice, }  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {set _isRingTimerRunning to true}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {startMonitoringAudioRoute}  {startMonitoringAudioRoute}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {✅ Android audio route monitoring started}  {04/05/2026 09:02:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [muteMicrophone]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setAudioRouteToSpeaker]
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:02:54}  {INFO}
D/ZegoUIKitCallPlugin( 7504): Audio route broadcast received: android.media.action.SPEAKERPHONE_STATE_CHANGED
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
D/ZegoUIKitCallPlugin( 7504): 🔊 Audio route changed
D/ZegoUIKitCallPlugin( 7504): Event: android.media.action.SPEAKERPHONE_STATE_CHANGED
D/ZegoUIKitCallPlugin( 7504): Speakerphone: true
D/ZegoUIKitCallPlugin( 7504): BluetoothSco: false
D/ZegoUIKitCallPlugin( 7504): WiredHeadset: false
D/ZegoUIKitCallPlugin( 7504): Mode: 0
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: muteMicrophone, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [mutePublishStreamAudio]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setAudioRouteToSpeaker, info: Execution successful.
I/PLogger ( 7504): {call-channel}  {handler}  {MethodCallHandler, method:onAudioRouteChanged, arguments:{mode: 0, event: android.media.ACTION_SCO_AUDIO_STATE_UPDATED, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}.}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): 🔊 Android Audio Route Changed
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): Event: android.media.ACTION_SCO_AUDIO_STATE_UPDATED
I/PLogger ( 7504): Speakerphone: ❌ OFF
I/PLogger ( 7504): Bluetooth: ❌ OFF
I/PLogger ( 7504): Wired Headset: ❌ Disconnected
I/PLogger ( 7504): Mode: NORMAL
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 Initial audio route state: {mode: 0, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(235783631) start ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, isPlayByRingtone:false, testPlayRingtone:true, audioPlayerVolume:1.0, }  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Routing info: route=ZegoUIKitAudioRoute.speaker, isSpeaker=true}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Setting audio context to speaker on player instance (attempt 1/4)}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-microphone}  {switch microphone}  {turn on local microphone, muteMode:false}  {04/05/2026 09:02:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: mutePublishStreamAudio, info: Execution successful.
I/PLogger ( 7504): {uikit-audio-output}  {switch audio output button}  {update audio route by default, target is speaker:false}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {target is speaker:false, current audio route is:ZegoUIKitAudioRoute.speaker, }  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {now audio route is:ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:02:54}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio context successfully set to speaker on attempt 1}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {handler}  {MethodCallHandler, method:onAudioRouteChanged, arguments:{mode: 0, event: android.media.action.SPEAKERPHONE_STATE_CHANGED, isSpeakerphoneOn: true, isBluetoothScoOn: false, isWiredHeadsetOn: false}.}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): 🔊 Android Audio Route Changed
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): Event: android.media.action.SPEAKERPHONE_STATE_CHANGED
I/PLogger ( 7504): Speakerphone: ✅ ON
I/PLogger ( 7504): Bluetooth: ❌ OFF
I/PLogger ( 7504): Wired Headset: ❌ Disconnected
I/PLogger ( 7504): Mode: NORMAL
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━}  {04/05/2026 09:02:54}  {INFO}
E/PLogger ( 7504): {uikit-stream}  {publish stream}  {room id is empty}  {04/05/2026 09:02:54}  {WARNING}
E/PLogger ( 7504): {uikit-stream}  {syncDeviceStatusByStreamExtraInfo}  {not publishing}  {04/05/2026 09:02:54}  {WARNING}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {local user audio route changed to ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:02:54}  {INFO}
D/AudioSystem( 7504): onNewServiceWithAdapter: media.audio_flinger service obtained 0xb40074f69a21f800
D/AudioSystem( 7504): getService: IAudioFlingerService retrieved: 0xb40074f5fa0ed530  IAudioFlinger cached: 0xb40074f69a21f800
V/MediaPlayer( 7504): resetDrmState:  mDrmInfo=null mDrmProvisioningThread=null mPrepareDrmInProgress=false mActiveDrmScheme=false
V/MediaPlayer( 7504): cleanDrmObj: mDrmObj=null mDrmSessionId=null
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/zego_jni( 7504): [2026-5-4 11:2:55:156][Verbose][Callback] OnCallUserStateChanged: call id: 7145345972660563812,call user info list:1
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Attempting to play audio (attempt 1/4)}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [switchTo - BEFORE] Current audio route: {mode: 0, isSpeakerphoneOn: true, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {switch to earpiece, update context}  {04/05/2026 09:02:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Setting audio context to earpiece on player instance (attempt 1/4)}  {04/05/2026 09:02:54}  {INFO}
D/ZegoUIKitCallPlugin( 7504): Audio route broadcast received: android.media.action.SPEAKERPHONE_STATE_CHANGED
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
D/ZegoUIKitCallPlugin( 7504): 🔊 Audio route changed
D/ZegoUIKitCallPlugin( 7504): Event: android.media.action.SPEAKERPHONE_STATE_CHANGED
D/ZegoUIKitCallPlugin( 7504): Speakerphone: false
D/ZegoUIKitCallPlugin( 7504): BluetoothSco: false
D/ZegoUIKitCallPlugin( 7504): WiredHeadset: false
D/ZegoUIKitCallPlugin( 7504): Mode: 3
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio context successfully set to earpiece on attempt 1}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {re-play after update context}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Starting playback after context switch (waiting for player ready)}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Waiting for AudioPlayer to be ready after context change...}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [switchTo - AFTER (final)] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer is ready (duration event received)}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Attempting to play audio (attempt 1/4)}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallUserStateChanged, callUserList:({userID:cmntym2og00031wbgt2z0knsz, state:ZIMCallUserState.received, extendedData:}),invitationID:7145345972660563812}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onInvitationUserStateChanged, {invitationID:7145345972660563812, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.received, extended data:}]}}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {onAdvanceInvitationUserStateChanged, {invitationID:7145345972660563812, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.received, extended data:}]}}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmntym2og00031wbgt2z0knsz}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {invitation map: {}}  {04/05/2026 09:02:55}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {call-invitation}  {page manager}  {on invitation user state changed, event:{invitationID:7145345972660563812, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.received, extended data:}]}}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-channel}  {handler}  {MethodCallHandler, method:onAudioRouteChanged, arguments:{mode: 3, event: android.media.action.SPEAKERPHONE_STATE_CHANGED, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}.}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): 🔊 Android Audio Route Changed
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): Event: android.media.action.SPEAKERPHONE_STATE_CHANGED
I/PLogger ( 7504): Speakerphone: ❌ OFF
I/PLogger ( 7504): Bluetooth: ❌ OFF
I/PLogger ( 7504): Wired Headset: ❌ Disconnected
I/PLogger ( 7504): Mode: IN_COMMUNICATION
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio playback started successfully on attempt 1}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {audioPlayer initial play completed}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.playing, isRingTimerRunning:true, isRingtoneRunning:false, }  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.playing}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio playback started successfully on attempt 1}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.playing, isRingTimerRunning:true, isRingtoneRunning:false, }  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.playing}  {04/05/2026 09:02:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [switchTo - AFTER] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:02:55}  {INFO}
D/BufferPoolAccessor2.0( 7504): bufferpool2 0xb40074f66a115d28 : 0(0 size) total buffers - 0(0 size) used buffers - 0/5 (recycle/alloc) - 2/4 (fetch/transfer)
D/BufferPoolAccessor2.0( 7504): Destruction - bufferpool2 0xb40074f66a115d28 cached: 0/0M, 0/0% in use; allocs: 5, 0% recycled; transfers: 4, 50% unfetched
D/BufferPoolAccessor2.0( 7504): bufferpool2 0xb40074f66a13f4d8 : 0(0 size) total buffers - 0(0 size) used buffers - 0/5 (recycle/alloc) - 2/4 (fetch/transfer)
D/BufferPoolAccessor2.0( 7504): Destruction - bufferpool2 0xb40074f66a13f4d8 cached: 0/0M, 0/0% in use; allocs: 5, 0% recycled; transfers: 4, 50% unfetched
D/BufferPoolAccessor2.0( 7504): bufferpool2 0xb40074f66a0ee138 : 0(0 size) total buffers - 0(0 size) used buffers - 0/5 (recycle/alloc) - 2/4 (fetch/transfer)
D/BufferPoolAccessor2.0( 7504): Destruction - bufferpool2 0xb40074f66a0ee138 cached: 0/0M, 0/0% in use; allocs: 5, 0% recycled; transfers: 4, 50% unfetched
D/BufferPoolAccessor2.0( 7504): evictor expired: 3, evicted: 0
I/zego_jni( 7504): [2026-5-4 11:3:5:825][Verbose][Callback] OnCallInvitationAccepted: call id: 7145345972660563812
I/zego_jni( 7504): [2026-5-4 11:3:5:825][Verbose][Callback] OnCallUserStateChanged: call id: 7145345972660563812,call user info list:1
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/ZegoUIKitCallPlugin( 7504): onMethodCall: stopMonitoringAudioRoute
D/ZegoUIKitCallPlugin( 7504): Audio route monitoring stopped
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallInvitationAccepted, info:Instance of 'ZIMCallInvitationAcceptedInfo', invitationID:7145345972660563812}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onOutgoingInvitationAccepted, {invitationID: 7145345972660563812, inviteeID: cmntym2og00031wbgt2z0knsz, extendedData: {"custom_data":"","v":"f1.0"}}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {remove invitation data, invitationID: 7145345972660563812, containsKey:truemap:{7145345972660563812: id:7145345972660563812, type:0, inviter id:cmogzn2620001ytqnylkf4tgh, invitees:(userid :cmntym2og00031wbgt2z0knsz, state:InvitationState.accept), data:{"call_id":"cmomfeqzy000mj3qnrjz2x60e_1777863774548","inviter_name":"Nowshin Fabiha","invitees":[{"user_id":"cmntym2og00031wbgt2z0knsz","user_name":"Service Provider"}],"timeout":60,"custom_data":"","v":"f1.0"}, resourceID:}, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, on invitation accepted}  {invitee:{id:cmntym2og00031wbgt2z0knsz, name:, in-room attributes:{}, camera:false, microphone:false, }, data:{"custom_data":"","v":"f1.0"}, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {check is in calling, state:CallingState.kCallingWithVoice, inCallingByIOSBackgroundLock:false, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {page had pushed}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from State[CallingState.kCallingWithVoice] to State[CallingState.kOnlineAudioVideo]}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {onStateChanged, currentState:CallingState.kOnlineAudioVideo, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallUserStateChanged, callUserList:({userID:cmntym2og00031wbgt2z0knsz, state:ZIMCallUserState.accepted, extendedData:{"custom_data":"","v":"f1.0"}}),invitationID:7145345972660563812}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onInvitationUserStateChanged, {invitationID:7145345972660563812, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:{"custom_data":"","v":"f1.0"}}]}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {onAdvanceInvitationUserStateChanged, {invitationID:7145345972660563812, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:{"custom_data":"","v":"f1.0"}}]}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmntym2og00031wbgt2z0knsz}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {invitation map: {}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {on invitation user state changed, event:{invitationID:7145345972660563812, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:{"custom_data":"","v":"f1.0"}}]}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, on invitation accepted}  {invitee:{id:cmntym2og00031wbgt2z0knsz, name:, in-room attributes:{}, camera:false, microphone:false, }, data:{"custom_data":"","v":"f1.0"}, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, on invitation accepted}  {invitee is not in list, invitee:cmntym2og00031wbgt2z0knsz, list:()}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[]}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[], }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 0, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(235783631) stop ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-channel}  {stopMonitoringAudioRoute}  {stopMonitoringAudioRoute}  {04/05/2026 09:03:05}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: reporterUpdateCommonParams
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {⏹️ Android audio route monitoring stopped}  {04/05/2026 09:03:05}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setEngineConfig]
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.stopped, isRingTimerRunning:true, isRingtoneRunning:false, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.stopped}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {create prebuilt call page, is group call:false, invitationData:ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, invitationID: 7145345972660563812, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, customData: .}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {create prebuilt call page}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {appID:1683382177, params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh}}  {04/05/2026 09:03:05}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setEngineConfig, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCustomVideoProcessing]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setEngineConfig]
I/PLogger ( 7504): {uikit-reporter}  {create}  {had created before}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {update common params}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {mini machine state is ZegoCallMiniOverlayPageState.idle}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {init duration}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }, ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, onLocalInvitingUsersUpdated}  {localInvitingUsers:[]}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, onLocalInvitingUsersUpdated}  {no wait inviting users now, currentInvitationID:7145345972660563812, remoteUserIsEmpty:true, localIsInitiator:false, hasWaitingInvitee:false, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {controller.p}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCustomVideoProcessing, info: Execution successful.
I/PLogger ( 7504): {call}  {controller.user.p}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setEngineConfig, info: Execution successful.
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {controller.minimize.p}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {add listener:Closure: (ZegoCallMiniOverlayPageState) => void from Function 'onMiniOverlayMachineStateChanged':., size:2}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {controller.pip.p android}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {live-streaming}  {controller.screenSharing.p}  {init by prebuilt}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {change state outside to ZegoCallMiniOverlayPageState.idle}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {mini overlay, from State[ZegoCallMiniOverlayPageState.idle] to State[ZegoCallMiniOverlayPageState.idle]}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {onAudioRouteChanged}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {audio route changed: speaker=false, earpiece=true}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {enabling proximity sensor for earpiece mode}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, checkRequiredParticipant}  {requiredUsers not enabled}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-user}  {getLeaveUsers}  {get leave users, leave users:[]}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {get leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {no response end timer is disabled}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {updateCommonParams}  {{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterUpdateCommonParams}  {params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/init, params:{source: page, error: 0, start_time: 1777863785858}, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {version: zego_uikit_prebuilt_call:4.23.0; zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys,
I/PLogger ( 7504): appID:1683382177,
I/PLogger ( 7504): callID:cmomfeqzy000mj3qnrjz2x60e_1777863774548,
I/PLogger ( 7504): userID:cmogzn2620001ytqnylkf4tgh,
I/PLogger ( 7504): userName:Nowshin Fabiha,
I/PLogger ( 7504): config:ZegoUIKitPrebuiltCallConfig:{video:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }, audioVideoView:ZegoCallAudioVideoViewConfig:{containerBuilder:null, isVideoMirror:true, showMicrophoneStateOnView:true, showCameraStateOnView:false, showUserNameOnView:true, foregroundBuilder:null, backgroundBuilder:null, useVideoViewAspectFill:true, showAvatarInAudioMode:true, showSoundWavesInAudioMode:true, }, topMenuBar:ZegoCallTopMenuBarConfig:{isVisible:false, title:, hideAutomatically:true, hideByClick:true, buttons:[], extendButtons:[], style:ZegoCallMenuBarStyle.light, padding:null, margin:null, backgroundColor:null, height:null, }, bottomMenuBar:ZegoCallBottomMenuBarConfig:{hideAutomatically:true, hideByClick:true, buttons:[ZegoCallMenuBarButtonName.toggleMicrophoneButton, ZegoCallMenuBarButtonName.hangUpButton, ZegoCallMenuBarButtonName.switchAudioOutputButton], extendButtons:[], maxCount:5, style:ZegoCallMenuBarStyle.light, padding:null, margin:null, backgroundColor:null, height:null, }, memberList:ZegoCallMemberListConfig:{showMicrophoneState:true, showCameraState:true, itemBuilder:null, }, duration:ZegoCallDurationConfig:{isVisible:true, onDurationUpdate:null, }, chatView:ZegoCallInRoomChatViewConfig:{itemBuilder:null, }, user:Instance of 'ZegoCallUserConfig', device:{enableSyncDeviceStatusBySEI:true, }, layout:Instance of 'ZegoLayoutPictureInPictureConfig', pip:ZegoCallPIPConfig:{android:ZegoCallPIPAndroidConfig:{background:null, }, iOS:ZegoCallPIPIOSConfig:{support:true, }, aspectWidth:9, aspectHeight:16, enableWhenAppBackToDesktop:true, }, screenSharing:ZegoCallScreenSharingConfig:{autoStop:ZegoCallScreenSharingAutoStopConfig:{invalidCount:3, canEnd:false, }, defaultFullScreen:false, }, noResponseEnd:ZegoCallNoResponseEndConfig:{enabled:false, timeoutSeconds:3, }, turnOnCameraWhenJoining:false, useFrontCameraWhenJoining:true, turnOnMicrophoneWhenJoining:true, useSpeakerWhenJoining:false, rootNavigator:false, advanceConfigs:{}, enableAccidentalTouchPrevention:true, foreground:null, background:null, hangUpConfirmDialog:ZegoCallHangUpConfirmDialogConfig:{info:null, titleStyle:null, contentStyle:null, actionTextStyle:null, backgroundBrightness:null, }, avatarBuilder:null, },
I/PLogger ( 7504): events:ZegoUIKitPrebuiltCallEvents:{onCallEnd:Closure: (ZegoCallEndEvent, () => void) => Future<void>, onHangUpConfirmation:null, onError:null, user:null, room:null, audioVideo:null, beauty:null, },
I/PLogger ( 7504): }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548(key:zego_uikit_leave_users_cmomfeqzy000mj3qnrjz2x60e_1777863774548)}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {get deleted stream users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached deleted stream users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548(key:zego_uikit_deleted_stream_users_cmomfeqzy000mj3qnrjz2x60e_1777863774548)}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, checkInvitationParticipant}  {some other members are still in the room, otherMembersInCall:({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, }), leavedRoomUsers:(),
I/PLogger ( 7504): ---inviter:{id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, }, invitees:({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, }), localUser:{id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, }, leavedRoomUsersInMemory:(), leavedRoomUsersInCache:(), deletedStreamUsersInCache:(), }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {audioPlayer stop done}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {set _isRingTimerRunning to false}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit}  {permission}  {Permission.microphone status: PermissionStatus.granted}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-user}  {login}  {id:"cmogzn2620001ytqnylkf4tgh", name:Nowshin Fabiha}  {04/05/2026 09:03:05}  {INFO}
E/PLogger ( 7504): {uikit-user}  {login}  {user is same}  {04/05/2026 09:03:05}  {WARNING}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set advance configs}  {configs:{}}  {04/05/2026 09:03:05}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setMinVideoBitrateForTrafficControl]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setVideoMirrorMode]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setAudioRouteToSpeaker]
D/ZEGO    ( 7504): [Flutter] [DartCall] [loginRoom]
I/PLogger ( 7504): {call}  {prebuilt}  {proximity cleared, restoring screen brightness and touch}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {reset _pageManager.isCurrentInvitationFromAcceptedAndroidOffline}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {isFromAcceptedAndroidOfflineInvitation:false}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {enableSyncDeviceStatusByStreamExtraInfo}  {value: true}  {04/05/2026 09:03:05}  {INFO}
E/PLogger ( 7504): {uikit-service-core(618137614)}  {init}  {had init}  {04/05/2026 09:03:05}  {WARNING}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }, ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {enableCustomVideoProcessing}  {disable custom video processing, buffer type:ZegoVideoBufferType.GLTexture2D, express engineState:ZegoUIKitExpressEngineState.stop, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set advance configs}  {configs:{}}  {04/05/2026 09:03:05}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setMinVideoBitrateForTrafficControl, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setMinVideoResolutionForTrafficControl]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setVideoMirrorMode, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setAudioRouteToSpeaker, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onRoomStateUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, state: CONNECTING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStateChanged] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, reason: LOGINING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: loginRoom, info: Execution successful.
I/PLogger ( 7504): {call}  {controller.pip.p android}  {onPIPStatusUpdated, PiPStatus.disabled, lifecycleState: AppLifecycleState.resumed}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {isEnabled:false, express engineState:ValueNotifier<ZegoUIKitExpressEngineState>#0577a(ZegoUIKitExpressEngineState.stop), roomState:ZegoUIKitRoomState:{reason:ZegoRoomStateChangedReason.Logout, error code:0, extended data:{}, }, isPreviewing:false, isPublishingStream:false, isPlayingStream:false, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {state is same, ignore}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {video config:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {traffic control}  {enable:true, properties:[ZegoUIKitTrafficControlProperty.adaptiveResolution, ZegoUIKitTrafficControlProperty.adaptiveFPS], minimizeVideoConfig:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }, isFocusOnRemote:true, bitmask:3}  {04/05/2026 09:03:05}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setMinVideoResolutionForTrafficControl, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setMinVideoFpsForTrafficControl]
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }, ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {use front facing camera}  {Already front}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {update video view mode}  {mode:true}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-microphone}  {switch microphone}  {turn on local microphone, muteMode:false, already on.}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {target is speaker:false, current audio route is:ZegoUIKitAudioRoute.receiver, }  {04/05/2026 09:03:05}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setMinVideoFpsForTrafficControl, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setTrafficControlFocusOn]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setTrafficControlFocusOn, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableTrafficControl]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableTrafficControl, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setVideoConfig]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setVideoConfig, info: Execution successful.
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {now audio route is:ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-room}  {join room}  {room id:"cmomfeqzy000mj3qnrjz2x60e_1777863774548", has token:false, markAsLargeRoom:false, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit}  {core data}  {clear}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {clearStream}  {clear stream}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-media}  {clear}  {clear}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {clear}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-room}  {setRoom}  {set room:"cmomfeqzy000mj3qnrjz2x60e_1777863774548", markAsLargeRoom:false}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-event}  {init}  {had init before}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-room}  {join room}  {try join room id:"cmomfeqzy000mj3qnrjz2x60e_1777863774548" by id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, isSimulated:false, }  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStateChanged roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, reason: ZegoRoomStateChangedReason.Logining, errorCode: 0, extendedData: {}}  {04/05/2026 09:03:05}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {set video config}  {config:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }, streamType:ZegoStreamType.main, }  {04/05/2026 09:03:05}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onRoomStateUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, state: CONNECTED, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStateChanged] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, reason: LOGINED, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStreamUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, updateType: ADD, streamListCount: 1, extendedDataLength: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStreamExtraInfoUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, streamListCount: 1
D/ZEGO    ( 7504): [Flutter] [onRoomOnlineUserCountUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, count: 2
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCamera]
D/ZEGO    ( 7504): [Flutter] [DartCall] [startPlayingStream]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCamera, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [muteMicrophone]
D/ZEGO    ( 7504): [Flutter] [onPlayerStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state: PLAY_REQUESTING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: startPlayingStream, info: Execution successful.
W/libc    ( 7504): Access denied finding property "ro.hardware.chipname"
D/ZEGO    ( 7504): [Flutter] [DartCall] [createTextureRenderer]
D/ZEGO    ( 7504): [Flutter] [ZegoTextureRenderer] [init] renderer:188220088
D/ZEGO    ( 7504): [Flutter] [createTextureRenderer] textureID:1, renderer:188220088
D/ZEGO    ( 7504): [Flutter] [ZegoTextureRendererController] currentRenderers: [ID:1|Rnd:188220088]
D/ZEGO    ( 7504): [Flutter] [createTextureRenderer][Result] w: 0, h: 0, textureID: 1
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStateChanged roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, reason: ZegoRoomStateChangedReason.Logined, errorCode: 0, extendedData: {room_session_id: 1271129530953904128}}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-room}  {join room}  {result:0,extendedData:{}}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start publish stream}  {updateConfigBeforeStartPublishingStream, view id:-1, }  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: muteMicrophone, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [startPublishingStream]
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStreamUpdate, roomID:cmomfeqzy000mj3qnrjz2x60e_1777863774548, update type:ZegoUpdateType.Add, stream list:(ZegoStreamExtension{user:(cmntym2og00031wbgt2z0knsz,gruff P), streamID:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, extraInfo:{"isCameraOn":false,"isMicrophoneOn":true}, }), extended data:{}}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {get deleted streams for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548}  {04/05/2026 09:03:06}  {INFO}
V/MediaRouter( 7504): Selecting route: RouteInfo{ name=Phone, description=null, status=null, category=RouteCategory{ name=System types=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO  groupable=false }, supportedTypes=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO , presentationDisplay=null }
I/MediaRouter( 7504): Skip setBluetoothA2dpOn(): types=8388615, isPlaybackActive()=false, BT route=null
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStreamExtraInfoUpdate, roomID:cmomfeqzy000mj3qnrjz2x60e_1777863774548, stream list:(stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, extra info{"isCameraOn":false,"isMicrophoneOn":true}, user id:cmntym2og00031wbgt2z0knsz)}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {try parse stream extra info({"isCameraOn":false,"isMicrophoneOn":true})}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteCameraStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state:{ZegoRemoteDeviceState.Mute,Mute}}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteCameraStateUpdate, stream cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main is not exist}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteMicStateUpdate, stream cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state:ZegoRemoteDeviceState.Open}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteMicStateUpdate, stream cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main is not exist}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached deleted streams for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548(key:zego_uikit_deleted_streams_cmomfeqzy000mj3qnrjz2x60e_1777863774548)}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {get deleted stream users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548}  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onAudioRouteChange] audioRoute: RECEIVER
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached deleted stream users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548(key:zego_uikit_deleted_stream_users_cmomfeqzy000mj3qnrjz2x60e_1777863774548)}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {stream dict add cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main for cmntym2og00031wbgt2z0knsz, dict: {cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main: user id:cmntym2og00031wbgt2z0knsz, player state:ZegoPlayerState.NoPlay, publisher state:ZegoPublisherState.NoPublish}}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {stream's user cmntym2og00031wbgt2z0knsz  gruff P is not exist, create}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start play stream}  {stream id: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, user id:cmntym2og00031wbgt2z0knsz}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start play stream}  {current stream channel, view id:-1,view:ValueNotifier<Widget?>#9d312(null)}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start play stream}  {ready start, stream id: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start play stream by express}  {streamID:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, startPlayingStreamInIOSPIP:false, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start play stream}  {call express startPlayingStream, for trace enableCustomVideoRender, isEnableCustomVideoRender:false}  {04/05/2026 09:03:06}  {INFO}
I/CameraManagerGlobal( 7504): Connecting to camera service
D/ZEGO    ( 7504): [Flutter] [DartCall] [sendCustomLogMessage]
D/ZEGO    ( 7504): [Flutter] [WidgetState] setViewMode. widget: 1, viewMode: ZegoViewMode.AspectFill
D/ZEGO    ( 7504): [Flutter] [DartCall] [sendCustomLogMessage]
D/ZEGO    ( 7504): [Flutter] [WidgetState] setBackgroundColor. widget: 1, backgroundColor: 0, hasAlpha: false
D/ZEGO    ( 7504): [Flutter] [DartCall] [updatePlayingCanvas]
D/ZEGO    ( 7504): [Flutter] [getTextureRenderer] textureID:1, renderer:188220088
D/ZEGO    ( 7504): [Flutter] [ZegoTextureRendererController] currentRenderers: [ID:1|Rnd:188220088]
D/ZEGO    ( 7504): [Flutter] [onPublisherStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, state: PUBLISH_REQUESTING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: startPublishingStream, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setStreamExtraInfo]
I/PLogger ( 7504): {uikit-stream}  {start play stream}  {finish play, stream id: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, }  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: updatePlayingCanvas, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setStreamExtraInfo, info: Execution successful.
I/PLogger ( 7504): {uikit-stream}  {create canvas view}  {with express with key:null(null)}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start publish stream}  {stream dict add ZegoStreamType.main cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main for cmogzn2620001ytqnylkf4tgh, now stream dict:{cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main: user id:cmntym2og00031wbgt2z0knsz, player state:ZegoPlayerState.NoPlay, publisher state:ZegoPublisherState.NoPublish, cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main: user id:cmogzn2620001ytqnylkf4tgh, player state:ZegoPlayerState.NoPlay, publisher state:ZegoPublisherState.NoPublish}}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start publish stream}  {start publish, cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start publish stream}  {call express startPublishingStream, for trace enableCustomVideoRender, isEnableCustomVideoRender:false}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onPlayerStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state:ZegoPlayerState.PlayRequesting, errorCode:0, extendedData:{}, isAllPlayStreamAudioVideoMuted:false, isAllPlayStreamAudioMuted:false, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {create canvas view}  {createCanvasView onViewCreated, viewID:1, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start play stream}  {canvas view id done viewID:1, user id:cmntym2og00031wbgt2z0knsz, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {view id update, view id:1, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start play stream}  {ready start, stream id: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, view mode:ZegoViewMode.AspectFill(1), }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start play stream}  {widget done, widget:ZegoTextureWidget 32213392, user id:cmntym2og00031wbgt2z0knsz, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {view update, view:ZegoTextureWidget, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, }  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onEngineStateUpdate] state: START
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStreamExtraInfoUpdate, roomID:cmomfeqzy000mj3qnrjz2x60e_1777863774548, stream list:(stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, extra info{"isCameraOn":false,"isMicrophoneOn":true}, user id:cmntym2og00031wbgt2z0knsz)}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {try parse stream extra info({"isCameraOn":false,"isMicrophoneOn":true})}  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onRecvExperimentalAPI] content: {"method":"liveroom.device.on_device_state_changed","params":{"channel":0,"devcie_type":"camera","reason":2,"state":"off"}}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteCameraStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state:{ZegoRemoteDeviceState.Mute,Mute}}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteCameraStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, user:id:cmntym2og00031wbgt2z0knsz, name:gruff P, state:ZegoRemoteDeviceState.Mute, old value:false, old mute value:false}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteMicStateUpdate, stream cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state:ZegoRemoteDeviceState.Open}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteMicStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, user:id:cmntym2og00031wbgt2z0knsz, name:gruff P, state:ZegoRemoteDeviceState.Open}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onAudioRouteChange, audioRoute: Receiver}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start play stream}  {finish update stream view/canvas, stream id: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, canvas:Instance of 'ZegoCanvas', }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onPublisherStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, state:ZegoPublisherState.PublishRequesting, errorCode:0, extendedData:{}}  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [getAudioRouteType]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: getAudioRouteType, info: Execution successful.
I/PLogger ( 7504): {uikit-service-core}  {event}  {onEngineStateUpdate, state:ZegoEngineState.Start, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {update audio route by onEngineStateUpdate, state:ZegoEngineState.Start, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {local user}  {init default audio route:ZegoAudioRoute.Receiver}  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onRoomUserUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, updateType: ADD, userListCount: 1
D/ZEGO    ( 7504): [Flutter] [onRoomOnlineUserCountUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, count: 2
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomUserUpdate, room id:"cmomfeqzy000mj3qnrjz2x60e_1777863774548", update type:ZegoUpdateType.Adduser list:("cmntym2og00031wbgt2z0knsz":gruff P, )}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {get leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548(key:zego_uikit_leave_users_cmomfeqzy000mj3qnrjz2x60e_1777863774548)}  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [sendSEI]
D/ZEGO    ( 7504): [Flutter] [DartCall] [startSoundLevelMonitor]
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: startSoundLevelMonitor, info: Execution successful.
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:loginRoom, params:{room_id: cmomfeqzy000mj3qnrjz2x60e_1777863774548, token: , start_time: 1777863785937, error: 0, msg: {}}, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {initContext done}  {04/05/2026 09:03:06}  {INFO}
W/libc    ( 7504): Access denied finding property "ro.hardware.chipname"
D/ajbd.protiva502( 7504): PlayerBase::PlayerBase()
D/ajbd.protiva502( 7504): TrackPlayerBase::TrackPlayerBase()
I/libOpenSLES( 7504): Emulating old channel mask behavior (ignoring positional mask 0x3, using default mask 0x3 based on channel count of 2)
W/libOpenSLES( 7504): Conversion from OpenSL ES positional channel mask 0x4 to Android mask 0 loses channels
I/libOpenSLES( 7504): Emulating old channel mask behavior (ignoring positional mask 0x4, using default mask 0x10 based on channel count of 1)
D/ZEGO    ( 7504): [Flutter] [onRecvExperimentalAPI] content: {"method":"liveroom.device.on_device_state_changed","params":{"channel":0,"devcie_type":"speaker","reason":0,"state":"on"}}
D/MediaRouter( 7504): onRestoreRoute() : route=RouteInfo{ name=Phone, description=null, status=null, category=RouteCategory{ name=System types=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO  groupable=false }, supportedTypes=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO , presentationDisplay=null }
V/MediaRouter( 7504): Selecting route: RouteInfo{ name=Phone, description=null, status=null, category=RouteCategory{ name=System types=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO  groupable=false }, supportedTypes=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO , presentationDisplay=null }
D/ZEGO    ( 7504): [Flutter] [onPublisherStreamEvent] eventID: PUBLISH_START, streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, extraInfo: {"resourceType":"rtc","streamProtocol":"avertp","url":"avertp://udp1683382177.coolzcloud.com/1683382177/cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main"}
I/NDOP    ( 7504): listening using window listener
D/ZEGO    ( 7504): [Flutter] [onPlayerStreamEvent] eventID: PLAY_START, streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, extraInfo: {"resourceType":"rtc","streamProtocol":"avertp","url":"avertp://udp1683382177.coolzcloud.com/1683382177/cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main"}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setAudioRouteToSpeaker]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setAudioRouteToSpeaker, info: Execution successful.
I/PLogger ( 7504): {uikit-component}  {audio video container}  {use pictureInPictureLayout, userList:({id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:true, }, , {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, ), }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh' build,}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's camera changed false,}  {04/05/2026 09:03:06}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's view is null}  {04/05/2026 09:03:06}  {ERROR}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz' build,}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz's camera changed false,}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-microphone}  {switch microphone}  {turn on local microphone, muteMode:false, already on.}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-audio-output}  {switch audio output button}  {update audio route by default, target is speaker:false}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {target is speaker:false, current audio route is:ZegoUIKitAudioRoute.receiver, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {now audio route is:ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {ring timer ended}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.stopped, isRingTimerRunning:false, isRingtoneRunning:false, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.stopped}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {audioPlayer stop done}  {04/05/2026 09:03:06}  {INFO}
I/NDOP    ( 7504): listening using window listener
I/PLogger ( 7504): {uikit-component}  {audio video container}  {use pictureInPictureLayout, userList:({id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:true, }, , {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, ), }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh' build,}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's camera changed false,}  {04/05/2026 09:03:06}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's view is null}  {04/05/2026 09:03:06}  {ERROR}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz' build,}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz's camera changed false,}  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onPublisherCapturedAudioFirstFrame]
D/ZEGO    ( 7504): [Flutter] [onPlayerStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state: PLAYING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onPlayerStreamEvent] eventID: PLAY_SUCCESS, streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, extraInfo: {"resourceType":"rtc","streamProtocol":"avertp","url":"avertp://udp1683382177.coolzcloud.com/1683382177/cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main"}
D/ZEGO    ( 7504): [Flutter] [onRemoteCameraStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state: DISABLE
D/ZEGO    ( 7504): [Flutter] [onRemoteMicStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state: OPEN
D/ZEGO    ( 7504): [Flutter] [onRemoteSpeakerStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state: OPEN
I/PLogger ( 7504): {uikit-service-core}  {event}  {onPlayerStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state:ZegoPlayerState.Playing, errorCode:0, extendedData:{}, isAllPlayStreamAudioVideoMuted:false, isAllPlayStreamAudioMuted:false, }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteCameraStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state:{ZegoRemoteDeviceState.Disable,Disable}}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteCameraStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, user:id:cmntym2og00031wbgt2z0knsz, name:gruff P, state:ZegoRemoteDeviceState.Disable, old value:false, old mute value:true}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteMicStateUpdate, stream cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state:ZegoRemoteDeviceState.Open}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRemoteMicStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, user:id:cmntym2og00031wbgt2z0knsz, name:gruff P, state:ZegoRemoteDeviceState.Open}  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onPlayerRecvAudioFirstFrame] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main
I/NDOP    ( 7504): listening using window listener
I/PLogger ( 7504): {uikit-component}  {audio video container}  {use pictureInPictureLayout, userList:({id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:true, }, , {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, ), }  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh' build,}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's camera changed false,}  {04/05/2026 09:03:06}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's view is null}  {04/05/2026 09:03:06}  {ERROR}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz' build,}  {04/05/2026 09:03:06}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz's camera changed false,}  {04/05/2026 09:03:06}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onRecvExperimentalAPI] content: {"method":"liveroom.device.on_device_state_changed","params":{"channel":0,"devcie_type":"camera","reason":2,"state":"off"}}
D/ZEGO    ( 7504): [Flutter] [onRecvExperimentalAPI] content: {"method":"liveroom.device.on_device_state_changed","params":{"channel":0,"devcie_type":"mic","reason":0,"state":"on"}}
D/ZEGO    ( 7504): [Flutter] [onPublisherStreamEvent] eventID: PUBLISH_SUCCESS, streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, extraInfo: {"resourceType":"rtc","streamProtocol":"avertp","url":"avertp://udp1683382177.coolzcloud.com/1683382177/cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main"}
D/ZEGO    ( 7504): [Flutter] [onPublisherSendAudioFirstFrame] channel: MAIN
D/ZEGO    ( 7504): [Flutter] [onPublisherStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, state: PUBLISHING, errorCode: 0
I/PLogger ( 7504): {uikit-service-core}  {event}  {onPublisherStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, state:ZegoPublisherState.Publishing, errorCode:0, extendedData:{}}  {04/05/2026 09:03:06}  {INFO}
I/ajbd.protiva502( 7504): Compiler allocated 5464KB to compile void m140.fkj.f()
D/ZEGO    ( 7504): [Flutter] [onRoomOnlineUserCountUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, count: 2
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopPlayingStream]
D/ZEGO    ( 7504): [Flutter] [DartCall] [destroyTextureRenderer]
D/ZEGO    ( 7504): [Flutter] [destroyTextureRenderer] textureID:1, renderer: 188220088
D/ZEGO    ( 7504): [Flutter] [ZegoTextureRenderer] [release] renderer:188220088
D/ZEGO    ( 7504): [Flutter] [ZegoTextureRendererController] currentRenderers:
D/ZEGO    ( 7504): [Flutter] [destroyTextureRenderer][Result] textureID: 1, success: true
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopPreview]
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopSoundLevelMonitor]
D/ZegoUikitPlugin( 7504): onMethodCall: activeAppToForeground
D/ZegoUikitPlugin( 7504): active app to foreground
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopPublishingStream]
D/ZEGO    ( 7504): [Flutter] [onPlayerStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state: NO_PLAY, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopPlayingStream, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopPreview, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onPlayerMediaEvent] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, event: AUDIO_BREAK_RESUME
D/ZEGO    ( 7504): [Flutter] [onPlayerMediaEvent] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, event: VIDEO_BREAK_RESUME
D/ZEGO    ( 7504): [Flutter] [onPlayerMediaEvent] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, event: AUDIO_BREAK_RESUME
D/ZEGO    ( 7504): [Flutter] [onPlayerMediaEvent] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, event: VIDEO_BREAK_RESUME
D/ZEGO    ( 7504): [Flutter] [onPlayerStreamEvent] eventID: PLAY_END, streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, extraInfo: {"resourceType":"rtc","streamProtocol":"avertp","url":"avertp://udp1683382177.coolzcloud.com/1683382177/cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main"}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopSoundLevelMonitor, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [logoutRoom]
D/ajbd.protiva502( 7504): PlayerBase::stop() from IPlayer
D/AudioTrack( 7504): stop(41): called with 330240 frames delivered
I/PLogger ( 7504): {uikit-room}  {leave room}  {current room is cmomfeqzy000mj3qnrjz2x60e_1777863774548, target room id:null, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onPublisherStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, state: NO_PUBLISH, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopPublishingStream, info: Execution successful.
I/PLogger ( 7504): {uikit}  {core data}  {clear}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {clearStream}  {clear stream}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {stop play stream}  {ready stop stream id: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {stop play stream by express}  {streamID:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, stopPlayingStreamInIOSPIP:false, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {stop publish stream}  {stop ZegoStreamType.main cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main}, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {stop publish stream}  {stream dict remove cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, now stream dict:{cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main: user id:cmntym2og00031wbgt2z0knsz, player state:ZegoPlayerState.Playing, publisher state:ZegoPublisherState.NoPublish}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-media}  {clear}  {clear}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {clear}  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onRoomStateUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, state: DISCONNECTED, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStateChanged] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, reason: LOGOUT, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: logoutRoom, info: Execution successful.
I/PLogger ( 7504): {call}  {bottom bar}  {restore mini state by hang up}  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onEngineStateUpdate] state: STOP
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {change state outside to ZegoCallMiniOverlayPageState.idle}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {mini overlay, from State[ZegoCallMiniOverlayPageState.idle] to State[ZegoCallMiniOverlayPageState.idle]}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {activeAppToForeground}  {activeAppToForeground}  {04/05/2026 09:03:13}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {uikit-stream}  {stop play stream}  {stop play done, stream id: cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {stop play stream}  {stopped, stream id cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, user id  is: }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {stop play stream}  {stream dict remove cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, {}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {view id update, view id:-1, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {view update, view:null, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, }  {04/05/2026 09:03:13}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz's view is null}  {04/05/2026 09:03:13}  {ERROR}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onPlayerStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmntym2og00031wbgt2z0knsz_main, state:ZegoPlayerState.NoPlay, errorCode:0, extendedData:{}, isAllPlayStreamAudioVideoMuted:false, isAllPlayStreamAudioMuted:false, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video container}  {use pictureInPictureLayout, userList:({id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:false, }, ), }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh' build,}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's camera changed false,}  {04/05/2026 09:03:13}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's view is null}  {04/05/2026 09:03:13}  {ERROR}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.inactive}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.inactive to AppLifecycleState.inactive, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.inactive(from AppLifecycleState.inactive)}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.resumed}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.resumed to AppLifecycleState.resumed, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.resumed(from AppLifecycleState.resumed)}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {default call end event, event:ZegoCallEndEvent{callID:cmomfeqzy000mj3qnrjz2x60e_1777863774548, kickerUserID:null, reason:ZegoCallEndReason.localHangUp, invitationData: ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, invitationID: 7145345972660563812, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:false, }, customData: .}, }}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, Navigator}  {pop from call end, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onPublisherStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863774548_cmogzn2620001ytqnylkf4tgh_main, state:ZegoPublisherState.NoPublish, errorCode:0, extendedData:{}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStateChanged roomID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, reason: ZegoRoomStateChangedReason.Logout, errorCode: 0, extendedData: {}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-room}  {leave room}  {success}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-event}  {uninit}  {uninit}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onEngineStateUpdate, state:ZegoEngineState.Stop, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-media}  {event}  {uninit}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:logoutRoom, params:{room_id: cmomfeqzy000mj3qnrjz2x60e_1777863774548, error: 0, msg: {}}, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-component}  {leave button}  {leave room result, 0 {}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.inactive, isAppInBackground:true, isScreenLockEnabled:false}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, didChangeAppLifecycleState}  {is app in background: previous:false, current: true, call machine page state:CallingState.kOnlineAudioVideo, invitation data:ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, invitationID: 7145345972660563812, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:false, }, customData: .}, in calling by ios background lock:false, current room info:ZegoUIKitRoom:{id:, }}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:true}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.resumed, isAppInBackground:false, isScreenLockEnabled:false}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, didChangeAppLifecycleState}  {is app in background: previous:true, current: false, call machine page state:CallingState.kOnlineAudioVideo, invitation data:ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, invitationID: 7145345972660563812, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:false, }, customData: .}, in calling by ios background lock:false, current room info:ZegoUIKitRoom:{id:, }}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:false}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {app active from background, try re-login}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, initialized:true, state:ZegoSignalingPluginConnectionState.connected}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, user state is not disconnected}  {04/05/2026 09:03:13}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: activeAppToForeground
D/ZegoUikitPlugin( 7504): active app to foreground
D/ZEGO    ( 7504): [Flutter] [DartCall] [setReverbPreset]
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopSoundLevelMonitor]
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/FlutterJNI( 7504): Sending viewport metrics to the engine.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setReverbPreset, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setVoiceChangerPreset]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopSoundLevelMonitor, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [logoutRoom]
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/ZegoUIKitCallPlugin( 7504): onMethodCall: dismissNotification
I/call plugin( 7504): dismissNotification, id: 562159262
I/zego_jni( 7504): [2026-5-4 11:3:13:603][Verbose][API] logout. handle: 12970495528517775566
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {call}  {prebuilt}  {disabling proximity sensor}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {activeAppToForeground}  {activeAppToForeground}  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setEffectsBeautyParam]
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[]}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[], }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {clear advance invitation, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }, ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), cancel group call invitation}  {invitationData:ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863774548, invitationID: 7145345972660563812, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:false, }, customData: .}, invitingInvitees:[], }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), cancel group call invitation}  {have already some one accept, not need to cancel}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {controller.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {controller.minimize.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {remove listener:Closure: (ZegoCallMiniOverlayPageState) => void from Function 'onMiniOverlayMachineStateChanged':., size:1}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {controller.pip.p android}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {live-streaming}  {controller.pip.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setVoiceChangerPreset, info: Execution successful.
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }, ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null}}  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: logoutRoom, info: Execution successful.
I/PLogger ( 7504): {uikit-room}  {leave room}  {current room is , target room id:null, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit}  {core data}  {clear}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {clearStream}  {clear stream}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-media}  {clear}  {clear}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {clear}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, setPendingCallPageDisposeFlag}  {needWait:false}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {prebuilt call page dispose, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {needPop:false, needHideInvitationTopSheet:true, needClearCallKit:true}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/unInit, params:{source: page}, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call}  {machine, Navigator}  {push from onCallingEntry, onDispose}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }, ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), end/quit advance invitation,}  {is not advance mode}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {needPop:false, needHideInvitationTopSheet:true, needClearCallKit:false}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 1007022, funcName: setEffectsBeautyParam, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [onDebugError] errorCode: 1007022, funcName: setEffectsBeautyParam, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopEffectsEnv]
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableEffectsBeauty]
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCustomVideoProcessing]
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 0, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(235783631) stop ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), uninit}  {service un-init}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {uninit private}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {unregister offline call isolate name server, port:85953764}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {unregister message handler:320449901}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {uninit}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelMissedCallNotification}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelCallNotification}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-channel}  {dismissNotification}  {id:562159262}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {uninit}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {set hasCallkitIncomingCauseAppInBackground:false}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {set waitingCallInvitationReceivedAfterCallKitIncomingAccepted:false}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {set waitingCallInvitationReceivedAfterCallKitIncomingRejected:false}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {remove listener:Closure: (ZegoCallMiniOverlayPageState) => void from Function 'onMiniOverlayMachineStateChanged':., size:1}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {remove stream}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {internal instance}  {unregister}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service.p}  {un-init by prebuilt}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {callkit service uninit}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit id}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params done}  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopEffectsEnv, info: Execution successful.
I/PLogger ( 7504): {call-invitation}  {service private(431754313), uninit plugins}  {uninit plugins}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {user logout, currentUserID:cmogzn2620001ytqnylkf4tgh, currentUserName:Nowshin Fabiha, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, current id:cmogzn2620001ytqnylkf4tgh, current name:Nowshin Fabiha, connectionState:ZIMConnectionState.connected}  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 1007021, funcName: enableEffectsBeauty, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [onDebugError] errorCode: 1007021, funcName: enableEffectsBeauty, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, waitForDisconnect...}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 0, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(235783631) stop ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.inactive}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.inactive to AppLifecycleState.inactive, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.inactive(from AppLifecycleState.inactive)}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.resumed}  {04/05/2026 09:03:13}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCustomVideoProcessing, info: Execution successful.
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.resumed to AppLifecycleState.resumed, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.resumed(from AppLifecycleState.resumed)}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 0, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(414883125) stop ring, prefix:, source path:, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {cancelInvitationNotification}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {clear callkit infos}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit id}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear all callKit calls}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 0, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(414883125) stop ring, prefix:, source path:, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {cancelInvitationNotification}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, hideInvitationTopSheet}  {hideInvitationTopSheet}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {restore to idle, current state:CallingState.kOnlineAudioVideo, inCallPage:false}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling machine to be idle}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from State[CallingState.kOnlineAudioVideo] to State[CallingState.kIdle]}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {done}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-beauty}  {effects}  {stop effects env}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-beauty}  {effects}  {disable beauty}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {clear callkit infos done}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, hideInvitationTopSheet}  {hideInvitationTopSheet}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-room}  {leave room}  {success}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-event}  {uninit}  {is not init}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:logoutRoom, params:{room_id: , error: 0, msg: {}}, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear deleted stream users for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {enableCustomVideoProcessing}  {disable custom video processing, buffer type:ZegoVideoBufferType.GLTexture2D, express engineState:ZegoUIKitExpressEngineState.stop, }  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear leave users done for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear deleted stream users done for room:cmomfeqzy000mj3qnrjz2x60e_1777863774548}  {04/05/2026 09:03:13}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:13:774][Verbose][Callback] OnConnectionStateChanged: state: 0, event: 0, extended_data: {}
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, state:ZIMConnectionState.disconnected, event:ZIMConnectionEvent.success, extendedData:{}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, disconnected, clear current user}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {[call invitation] onInvitationConnectionState, {state: ZegoSignalingPluginConnectionState.disconnected, action: ZegoSignalingPluginConnectionAction.unknown, extendedData: {}}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {connection state changed, {state: ZegoSignalingPluginConnectionState.disconnected, action: ZegoSignalingPluginConnectionAction.unknown, extendedData: {}}}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {disconnected, auto logout}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {user logout, not login before.}  {04/05/2026 09:03:13}  {INFO}
I/flutter ( 7504): [core] user in-room private is not init
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, waitForDisconnect success}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {logout success}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {clear}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {logout done.}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {uninit}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {removePreferenceValue, key:call_app_sign.}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {removePreferenceValue, key:handler_info.}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {user attributes}  {user in-room uninit}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {destroy.}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {clear}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {uninit data.}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {uninit}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {uninit}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {notification data}  {uninit notification data}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {adapter}  {uninstall plugins}  {plugin type:ZegoUIKitPluginType.signaling uninstalled}  {04/05/2026 09:03:13}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/unInit, params:{source: service}, }  {04/05/2026 09:03:13}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: reporterUpdateCommonParams
D/permissions_handler( 7504): No permissions found in manifest for: []1
I/PLogger ( 7504): {uikit-reporter}  {create}  {appID:1683382177, params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {had created before}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {update common params}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {updateCommonParams}  {{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterUpdateCommonParams}  {params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}, }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {versions: zego_uikit_prebuilt_call:4.23.0; zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {service init, appID:1683382177, userID:cmogzn2620001ytqnylkf4tgh, userName:Nowshin Fabiha, plugins:[IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }], ringtoneConfig:null, config:null, uiConfig:null, notificationConfig:ZegoCallInvitationNotificationConfig:{androidNotificationConfig:ZegoCallAndroidNotificationConfig:{callIDVisibility:true, certificateIndex:ZegoSignalingPluginMultiCertificate.firstCertificate, showFullScreen:true, call channel config:ZegoCallAndroidNotificationChannelConfig:{channelID:zego_call, channelName:Call Notifications, icon:, sound:, vibrate:true, }, missed call channel config:ZegoCallAndroidNotificationChannelConfig:{channelID:missed_call, channelName:Missed Call, icon:, sound:, vibrate:false, }, message channel config:ZegoCallAndroidNotificationChannelConfig:{channelID:zimkit_message, channelName:Chat Message, icon:, sound:, vibrate:false, }, }, iOSNotificationConfig:ZegoCallIOSNotificationConfig:{appName:Protiva502, certificateIndex:ZegoSignalingPluginMultiCertificate.firstCertificate, isSandboxEnvironment:false, systemCallingIconName:, }, }, }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init data, }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init permissions}  {04/05/2026 09:03:14}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: createNotificationChannel
I/call plugin( 7504): create channel, channelId:zego_call,channelName:Call Notifications,soundSource:, enableVibration:true
I/call plugin( 7504): channel exist
I/PLogger ( 7504): {uikit}  {permission}  {Permission.camera status: PermissionStatus.denied}  {04/05/2026 09:03:14}  {INFO}
E/PLogger ( 7504): {uikit}  {permission}  {Permission.camera permission not granted, PermissionStatus.denied}  {04/05/2026 09:03:14}  {ERROR}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: createNotificationChannel
I/call plugin( 7504): create channel, channelId:missed_call,channelName:Missed Call,soundSource:, enableVibration:false
I/call plugin( 7504): channel exist
I/PLogger ( 7504): {uikit}  {permission}  {Permission.microphone status: PermissionStatus.granted}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initPermissions done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init private, }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {Close The lookupIsolate or not, needClose:false, hash(null), isMainIsolatePort:false}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {register, _backgroundPort(130737561), _backgroundPort!.sendPort(269196000)}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {add port:Instance of '_ReceivePortImpl', name:bg_msg_isolate_port}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {register offline call isolate name server, port:130737561}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {register message handler:320449901}  {04/05/2026 09:03:14}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: createNotificationChannel
I/call plugin( 7504): create channel, channelId:zimkit_message,channelName:Chat Message,soundSource:, enableVibration:false
I/call plugin( 7504): channel exist
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {update contextQuery in call invitation config}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {init, context:Navigator-[LabeledGlobalKey<NavigatorState>#90875](dependencies: [HeroControllerScope, InheritedCupertinoTheme, UnmanagedRestorationScope, _InheritedTheme, _LocalizationsScope-[GlobalKey#526ce]], state: NavigatorState#6ab75(tickers: tracking 2 tickers)), permissions:[ZegoCallInvitationPermission.camera, ZegoCallInvitationPermission.microphone], }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {start create channels}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-channel}  {createNotificationChannel}  {config:ZegoCallNotificationChannelConfig:{sound source:null, vibrate:true, channel id:zego_call, channel name:Call Notifications}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {createNotificationChannel of call done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-channel}  {createNotificationChannel}  {config:ZegoCallNotificationChannelConfig:{sound source:null, vibrate:false, channel id:missed_call, channel name:Missed Call}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {createNotificationChannel of missed call done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-channel}  {createNotificationChannel}  {config:ZegoCallNotificationChannelConfig:{sound source:null, vibrate:false, channel id:zimkit_message, channel name:Chat Message}}  {04/05/2026 09:03:14}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: dismissNotification
I/call plugin( 7504): dismissNotification, id: 1020110899
E/flutter ( 7504): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: 'package:audioplayers_platform_interface/src/api/audio_context.dart': Failed assertion: line 178 pos 13: 'category == AVAudioSessionCategory.playback ||
E/flutter ( 7504):                 category == AVAudioSessionCategory.playAndRecord ||
E/flutter ( 7504):                 category == AVAudioSessionCategory.multiRoute ||
E/flutter ( 7504):                 !options.contains(AVAudioSessionOptions.mixWithOthers)': You can set the option `mixWithOthers` explicitly only if the audio session category is `playAndRecord`, `playback`, or `multiRoute`.
E/flutter ( 7504): #0      _AssertionError._doThrowNew (dart:core-patch/errors_patch.dart:67:4)
E/flutter ( 7504): #1      _AssertionError._throwNew (dart:core-patch/errors_patch.dart:49:5)
E/flutter ( 7504): #2      new AudioContextIOS (package:audioplayers_platform_interface/src/api/audio_context.dart:178:13)
E/flutter ( 7504): #3      ZegoRingtone.defaultAudioContext (package:zego_uikit_prebuilt_call/src/invitation/notification/notification_ring.dart:75:14)
E/flutter ( 7504): #4      ZegoRingtone.init (package:zego_uikit_prebuilt_call/src/invitation/notification/notification_ring.dart:617:28)
E/flutter ( 7504): #5      ZegoCallInvitationPageManager.initRing (package:zego_uikit_prebuilt_call/src/invitation/pages/page_manager.dart:297:23)
E/flutter ( 7504): #6      ZegoCallInvitationPageManager.init (package:zego_uikit_prebuilt_call/src/invitation/pages/page_manager.dart:230:5)
E/flutter ( 7504): #7      ZegoCallInvitationServicePrivateImpl._initPrivate (package:zego_uikit_prebuilt_call/src/invitation/mixins/private/private.dart:192:19)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #8      ZegoUIKitPrebuiltCallInvitationService.init.<anonymous closure> (package:zego_uikit_prebuilt_call/src/invitation/service.dart:427:15)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #9      ZegoUIKitPrebuiltCallInvitationService.init (package:zego_uikit_prebuilt_call/src/invitation/service.dart:409:5)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #10     CallService.initialize (package:protiva502/core/services/call_service.dart:61:5)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #11     CallService.initializeFromStorage (package:protiva502/core/services/call_service.dart:35:5)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #12     CallService._fullReset (package:protiva502/core/services/call_service.dart:118:7)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #13     CallService.initialize.<anonymous closure> (package:protiva502/core/services/call_service.dart:98:11)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504):
I/flutter ( 7504): [core] user in-room private init
I/PLogger ( 7504): {call-invitation}  {notification manager}  {createNotificationChannel of message done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {start request notification permission}  {04/05/2026 09:03:14}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCustomVideoProcessing]
I/zego_jni( 7504): [2026-5-4 11:3:14:123][Verbose][API] login. handle: 12970495528517775566, user id: cmogzn2620001ytqnylkf4tgh, user name: Nowshin Fabiha, is_offline: 0, token:
I/PLogger ( 7504): {uikit}  {permission}  {Permission.notification status: PermissionStatus.granted}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {request notification permission result:true}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {requestPermission of notification done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {start request system alert window permission}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelCallNotification}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-channel}  {dismissNotification}  {id:1020110899}  {04/05/2026 09:03:14}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCustomVideoProcessing, info: Execution successful.
I/zego_jni( 7504): [2026-5-4 11:3:14:128][Verbose][Callback] OnConnectionStateChanged: state: 1, event: 1, extended_data: {}
I/PLogger ( 7504): {call-channel}  {setAudioRouteChangedCallback}  {setAudioRouteChangedCallback, callback: true}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-channel}  {setAudioRouteChangedCallback}  {setAudioRouteChangedCallback, callback: true}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {init}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling machine to be idle}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from null to State[CallingState.kIdle]}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {init: prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {internal instance}  {register, pageManager:Instance of 'ZegoCallInvitationPageManager', callInvitationData:Instance of 'ZegoUIKitPrebuiltCallInvitationData'}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initPrivate done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service.p}  {init by prebuilt}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init context}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-user}  {login}  {id:"cmogzn2620001ytqnylkf4tgh", name:Nowshin Fabiha}  {04/05/2026 09:03:14}  {INFO}
E/PLogger ( 7504): {uikit-user}  {login}  {user is same}  {04/05/2026 09:03:14}  {WARNING}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {enableSyncDeviceStatusByStreamExtraInfo}  {value: true}  {04/05/2026 09:03:14}  {INFO}
E/PLogger ( 7504): {uikit-service-core(618137614)}  {init}  {had init}  {04/05/2026 09:03:14}  {WARNING}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {isEnabled:false, express engineState:ValueNotifier<ZegoUIKitExpressEngineState>#0577a(ZegoUIKitExpressEngineState.stop), roomState:ZegoUIKitRoomState:{reason:ZegoRoomStateChangedReason.Logout, error code:0, extended data:{}, }, isPreviewing:false, isPublishingStream:false, isPlayingStream:false, }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {state is same, ignore}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {enableCustomVideoProcessing}  {disable custom video processing, buffer type:ZegoVideoBufferType.GLTexture2D, express engineState:ZegoUIKitExpressEngineState.stop, }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initContext done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {mobile system version:Instance of 'ZegoMobileSystemVersion'}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {callkit service init}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit internal instance}  {register, pageManager:Instance of 'ZegoCallInvitationPageManager'}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {offline callkit call id: null}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {set callkit variables:{CallKitInnerVariable.callIDVisibility: true, CallKitInnerVariable.showFullLockedScreen: true, CallKitInnerVariable.ringtonePath: , CallKitInnerVariable.backgroundUrl: }}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {request permission}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {register callkit incoming event listener}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initCallKit done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {init}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {install plugins}  {plugin type:ZegoUIKitPluginType.signaling install (967941468)}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {init data.}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {init}  {04/05/2026 09:03:14}  {INFO}
D/PushIDGenerateTools( 7504): device token:dvqnZZQNT3KgwpWo95Cpln:APA91bF3JT9rFNKFkhDsEhWqjGzFxsRIFCrwTTZwY2J_lcc61f8aL6e_JcWuQ0YFsf5AjTPl9B3FlJrBs_vx_pyNvIDNeGcl_usbaCkiYf41hGfepu0avaw
D/PushIDGenerateTools( 7504): payload:2
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {init}  {04/05/2026 09:03:14}  {INFO}
D/ZPNs native( 7504): onRegistered: pushid:rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ==
I/PLogger ( 7504): {uikit-plugin-signaling}  {notification data}  {init notification data}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.whiteboard, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.callkit, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins init}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {user attributes}  {user in-room init}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {signaling}  {test}  {test zim types begin}  {04/05/2026 09:03:14}  {INFO}
E/PLogger ( 7504): {signaling}  {test}  {ZegoSignalingPluginConnectionAction != ZIMConnectionEvent, ZegoSignalingPluginConnectionAction:[ZegoSignalingPluginConnectionAction.unknown, ZegoSignalingPluginConnectionAction.success, ZegoSignalingPluginConnectionAction.activeLogin, ZegoSignalingPluginConnectionAction.loginTimeout, ZegoSignalingPluginConnectionAction.interrupted, ZegoSignalingPluginConnectionAction.kickedOut, ZegoSignalingPluginConnectionAction.tokenExpired, ZegoSignalingPluginConnectionAction.unregistered], ZIMConnectionEvent:[ZIMConnectionEvent.success, ZIMConnectionEvent.activeLogin, ZIMConnectionEvent.loginTimeout, ZIMConnectionEvent.interrupted, ZIMConnectionEvent.kickedOut, ZIMConnectionEvent.tokenExpired, ZIMConnectionEvent.unregistered], }  {04/05/2026 09:03:14}  {ERROR}
I/PLogger ( 7504): {signaling}  {test}  {test zim types done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {signaling}  {init}  {create ZIM}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {signaling}  {init}  {ZIM is create before}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {create, appID:1683382177}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {try enable notification, iOSNotificationConfig:ZegoCallIOSNotificationConfig:{appName:Protiva502, certificateIndex:ZegoSignalingPluginMultiCertificate.firstCertificate, isSandboxEnvironment:false, systemCallingIconName:, }, enableIOSVoIP:false }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {setPreferenceString, key:handler_info, value:{"aid":"1683382177","tkn":"","uid":"cmogzn2620001ytqnylkf4tgh","un":"Nowshin Fabiha","isse":false,"eiv":false,"ci":1,"an":"Protiva502","ciic":false,"aci":"zego_call","acn":"Call Notifications","ai":"","as":"","av":true,"amci":"zimkit_message","amcn":"Chat Message","ams":"","ami":"","amv":false,"amdce":false,"amdcci":"missed_call","amdccn":"Missed Call","amdcs":"","amdci":"","amdcv":false,"amdnt":"Missed Call","amdncgv":"Group Video Call","amdncga":"Group Audio Call","amdncv":"Video Call","amdnca":"Audio Call"}.}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {notification data}  {enable notify when app is in the background or quit: true}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {signaling}  {notification}  {enable Notify When App Running In Background Or Quit, is iOS Sandbox Environment:false, enable iOS VoIP:false, certificate index:ZegoSignalingPluginMultiCertificate.firstCertificate, appName: Protiva502, androidChannelID: zego_call, androidChannelName: Call Notifications, androidSound: }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins init done, login...}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {login request, user id:cmogzn2620001ytqnylkf4tgh, user name:Nowshin Fabiha,has token:false}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {ready to login.}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {connectUser, id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, has token:false}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {requestFullIntentPermission done, res:true}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugin-ZegoUIKitPluginType.signaling version: zego_uikit_signaling_plugin: 2.8.20; zim:2.23.0.3574; zpns:2.8.0;}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {signaling}  {notification}  {register push done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {enable notification result: {error: null}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, state:ZIMConnectionState.connecting, event:ZIMConnectionEvent.activeLogin, extendedData:{}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {[call invitation] onInvitationConnectionState, {state: ZegoSignalingPluginConnectionState.connecting, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {connection state changed, {state: ZegoSignalingPluginConnectionState.connecting, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zpns}  {onRegistered, registerMessage: { pushID:rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ==, errorCode:0, pushSourceType:ZPNsPushSourceType.FCM, errorMessage:, commandResult:rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ== }}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {notification registered, {pushID: rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ==, code: 0}}  {04/05/2026 09:03:14}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:14:286][Verbose][Callback] OnConnectionStateChanged: state: 2, event: 1, extended_data: {}
I/zego_jni( 7504): [2026-5-4 11:3:14:286][Verbose][Callback] OnLoggedIn: code: 0, msg: operation was successful, seq: 3
I/zego_jni( 7504): [2026-5-4 11:3:14:286][Verbose][Callback] OnConversationTotalUnreadMessageCountUpdated: unread count: 0
I/flutter ( 7504): ┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
I/flutter ( 7504): │ #0   AppLoggerHelper.info (package:protiva502/core/utils/logging/logger.dart:15:13)
I/flutter ( 7504): │ #1   CallService.initialize (package:protiva502/core/services/call_service.dart:104:21)
I/flutter ( 7504): ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
I/flutter ( 7504): │ 💡 Call service initialized for userId=cmogzn2620001ytqnylkf4tgh
I/flutter ( 7504): └───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
I/flutter ( 7504): ┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
I/flutter ( 7504): │ #0   AppLoggerHelper.info (package:protiva502/core/utils/logging/logger.dart:15:13)
I/flutter ( 7504): │ #1   CallService._fullReset (package:protiva502/core/services/call_service.dart:124:21)
I/flutter ( 7504): ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
I/flutter ( 7504): │ 💡 Call service fully reset and reinitialized
I/flutter ( 7504): └───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, state:ZIMConnectionState.connected, event:ZIMConnectionEvent.activeLogin, extendedData:{}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {[call invitation] onInvitationConnectionState, {state: ZegoSignalingPluginConnectionState.connected, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {connection state changed, {state: ZegoSignalingPluginConnectionState.connected, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {connectUser success.}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {login success}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins login done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {setPreferenceString, key:call_app_sign, value:8380eda4e1948ce090fc836985bd3bbf2a21b6875d3f5c95f5ad73cd3b62688a.}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins init done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {plugin init finished}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {listen stream, isAdvanceInvitationMode:false, }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {remove stream}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initPlugins done}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {protocols}  {ZegoCallInvitationOfflineCallKitCacheParameterProtocol, json:, }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {offline callkit params: {invitation_id: , inviter: {id: , name: }, type: 0, call_id: , data: , accept: false, timeout: 60, datetime: 0}}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/init, params:{error: 0, start_time: 1777863794085, source: service}, }  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {waitingEnterAcceptedOfflineCallWhenInitNotDone:false, autoEnterAcceptedOfflineCall: true}  {04/05/2026 09:03:14}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params done}  {04/05/2026 09:03:14}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:14:436][Verbose][Callback] OnConversationSyncStateChanged state: 0
I/zego_jni( 7504): [2026-5-4 11:3:14:439][Verbose][Callback] OnConversationSyncStateChanged state: 1
I/PLogger ( 7504): {call-invitation}  {page manager}  {enterAcceptedOfflineCall, not waiting enter}  {04/05/2026 09:03:15}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, waitForDisconnect timeout}  {04/05/2026 09:03:15}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:17:954][Verbose][API] callInvite. handle: 12970495528517775566, mode: 0, invitess count: 1, timeout: 60, extended data: {"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863797951\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, enable_not_received_check:falseoffline push: (title size: 13, content size: 29, extended_data size: 331, resources id:)
I/PLogger ( 7504): {call-invitation}  {service, send}  {send call invitation}  {04/05/2026 09:03:17}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service.p, send call invitation}  {callees:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}], isVideoCall:false, callID:cmomfeqzy000mj3qnrjz2x60e_1777863797951, customData:, resourceID:null, notificationTitle:Incoming call, notificationMessage:Nowshin Fabiha is calling you, timeoutSeconds:60}  {04/05/2026 09:03:17}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}]}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}], }  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation service, send invitation}  {time:2026-05-04 09:03:17.951901, network state:ZegoUIKitNetworkState.online, invitees:[cmntym2og00031wbgt2z0knsz], timeout:60, type:0, zimExtendedData:{"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863797951\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, notification config:title:Incoming call, message:Nowshin Fabiha is calling you, resource id:, voIPConfig:null, notify:true}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {signaling}  {invitation}  {send invitation, invitees:[cmntym2og00031wbgt2z0knsz], timeout:60, extendedData:{"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863797951\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, push config:{title: Incoming call, message: Nowshin Fabiha is calling you, payload: {"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863797951\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, resourceID: , voipConfig:{iOSVoIPHasVideo: false, }}}  {04/05/2026 09:03:18}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:18:107][Verbose][Callback] OnCallInvitationSent: call id: 8598850277969805705, code: 0, msg: operation was successful, seq: 4
I/zego_jni( 7504): [2026-5-4 11:3:18:107][Verbose][Callback] OnCallUserStateChanged: call id: 8598850277969805705,call user info list:2
I/zego_jni( 7504): [2026-5-4 11:3:18:107][Verbose][Callback] OnCallInvitationCreated: call id: 8598850277969805705,call user list size:2
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUIKitCallPlugin( 7504): onMethodCall: startMonitoringAudioRoute
D/ZegoUIKitCallPlugin( 7504): Audio route monitoring started (BroadcastReceiver)
I/PLogger ( 7504): {signaling}  {invitation}  {send invitation, done, invitation id:8598850277969805705, error user list:(), error invitees:()}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {send invitation done, invitationID:8598850277969805705}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {add invitation data id:8598850277969805705, type:0, inviter id:cmogzn2620001ytqnylkf4tgh, invitees:(userid :cmntym2og00031wbgt2z0knsz, state:InvitationState.waiting), data:{"call_id":"cmomfeqzy000mj3qnrjz2x60e_1777863797951","inviter_name":"Nowshin Fabiha","invitees":[{"user_id":"cmntym2og00031wbgt2z0knsz","user_name":"Service Provider"}],"timeout":60,"custom_data":"","v":"f1.0"}, resourceID:}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {invite success, invitationID:8598850277969805705}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:callInvite, params:{call_id: 8598850277969805705, invitees: [cmntym2og00031wbgt2z0knsz], count: 1, error_userlist: [], error_count: 0, extended_data: {"inviter_id":"cmogzn2620001ytqnylkf4tgh","inviter_name":"Nowshin Fabiha","type":0,"data":"{\"call_id\":\"cmomfeqzy000mj3qnrjz2x60e_1777863797951\",\"inviter_name\":\"Nowshin Fabiha\",\"invitees\":[{\"user_id\":\"cmntym2og00031wbgt2z0knsz\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}}, }  {04/05/2026 09:03:18}  {INFO}
D/ZegoUIKitCallPlugin( 7504): Audio route broadcast received: android.media.ACTION_SCO_AUDIO_STATE_UPDATED
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
D/ZegoUIKitCallPlugin( 7504): 🔊 Audio route changed
D/ZegoUIKitCallPlugin( 7504): Event: android.media.ACTION_SCO_AUDIO_STATE_UPDATED
D/ZegoUIKitCallPlugin( 7504): Speakerphone: false
D/ZegoUIKitCallPlugin( 7504): BluetoothSco: false
D/ZegoUIKitCallPlugin( 7504): WiredHeadset: false
D/ZegoUIKitCallPlugin( 7504): Mode: 0
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/invite, params:{call_id: 8598850277969805705, source: api}, }  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {local send invitation, call id:cmomfeqzy000mj3qnrjz2x60e_1777863797951, invitees:(cmntym2og00031wbgt2z0knsz), type:ZegoCallInvitationType.voiceCall, customData:, code:, message:, error invitees:[], invitation id:8598850277969805705, localConfig:ZegoCallInvitationLocalParameter:{resourceID:null, notificationTitle:Incoming call, notificationMessage:Nowshin Fabiha is calling you, timeoutSeconds:60, }, }  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {entry, page state:CallingState.kCallingWithVoice}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call}  {machine, Navigator}  {push from onCallingEntry, }  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from State[CallingState.kIdle] to State[CallingState.kCallingWithVoice]}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallUserStateChanged, callUserList:({userID:cmntym2og00031wbgt2z0knsz, state:ZIMCallUserState.inviting, extendedData:}, {userID:cmogzn2620001ytqnylkf4tgh, state:ZIMCallUserState.accepted, extendedData:}),invitationID:8598850277969805705}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onInvitationUserStateChanged, {invitationID:8598850277969805705, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.inviting, extended data:}, {userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:}]}}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {onAdvanceInvitationUserStateChanged, {invitationID:8598850277969805705, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.inviting, extended data:}, {userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:}]}}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmntym2og00031wbgt2z0knsz}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmogzn2620001ytqnylkf4tgh}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {invitation map: {}}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {on invitation user state changed, event:{invitationID:8598850277969805705, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.inviting, extended data:}, {userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:}]}}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}]}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[{id:cmntym2og00031wbgt2z0knsz, name:Service Provider}], }  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {set _isRingTimerRunning to true}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-channel}  {startMonitoringAudioRoute}  {startMonitoringAudioRoute}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {✅ Android audio route monitoring started}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-channel}  {handler}  {MethodCallHandler, method:onAudioRouteChanged, arguments:{mode: 0, event: android.media.ACTION_SCO_AUDIO_STATE_UPDATED, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}.}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): 🔊 Android Audio Route Changed
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): Event: android.media.ACTION_SCO_AUDIO_STATE_UPDATED
I/PLogger ( 7504): Speakerphone: ❌ OFF
I/PLogger ( 7504): Bluetooth: ❌ OFF
I/PLogger ( 7504): Wired Headset: ❌ Disconnected
I/PLogger ( 7504): Mode: NORMAL
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 Initial audio route state: {mode: 0, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(1012772360) start ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, isPlayByRingtone:false, testPlayRingtone:true, audioPlayerVolume:1.0, }  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Routing info: route=ZegoUIKitAudioRoute.receiver, isSpeaker=false}  {04/05/2026 09:03:18}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Setting audio context to earpiece on player instance (attempt 1/4)}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call}  {machine, Navigator}  {push from onCallingEntry, onInitState}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {onStateChanged, currentState:CallingState.kCallingWithVoice, }  {04/05/2026 09:03:18}  {INFO}
V/MediaPlayer( 7504): resetDrmState:  mDrmInfo=null mDrmProvisioningThread=null mPrepareDrmInProgress=false mActiveDrmScheme=false
V/MediaPlayer( 7504): cleanDrmObj: mDrmObj=null mDrmSessionId=null
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio context successfully set to earpiece on attempt 1}  {04/05/2026 09:03:18}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [muteMicrophone]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setAudioRouteToSpeaker]
I/PLogger ( 7504): {call-invitation}  {ringtone}  {local user audio route changed to ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:03:18}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: muteMicrophone, info: Execution successful.
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:18}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [mutePublishStreamAudio]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setAudioRouteToSpeaker, info: Execution successful.
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Attempting to play audio (attempt 1/4)}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [switchTo - BEFORE] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {switch to earpiece, update context}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio context is already set to earpiece, skipping switch}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-microphone}  {switch microphone}  {turn on local microphone, muteMode:false}  {04/05/2026 09:03:18}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: mutePublishStreamAudio, info: Execution successful.
I/PLogger ( 7504): {uikit-audio-output}  {switch audio output button}  {update audio route by default, target is speaker:false}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {target is speaker:false, current audio route is:ZegoUIKitAudioRoute.receiver, }  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {now audio route is:ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:03:18}  {INFO}
E/PLogger ( 7504): {uikit-stream}  {publish stream}  {room id is empty}  {04/05/2026 09:03:18}  {WARNING}
E/PLogger ( 7504): {uikit-stream}  {syncDeviceStatusByStreamExtraInfo}  {not publishing}  {04/05/2026 09:03:18}  {WARNING}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio playback started successfully on attempt 1}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {audioPlayer initial play completed}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.playing, isRingTimerRunning:true, isRingtoneRunning:false, }  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.playing}  {04/05/2026 09:03:18}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:18:363][Verbose][Callback] OnCallUserStateChanged: call id: 8598850277969805705,call user info list:1
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallUserStateChanged, callUserList:({userID:cmntym2og00031wbgt2z0knsz, state:ZIMCallUserState.received, extendedData:}),invitationID:8598850277969805705}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onInvitationUserStateChanged, {invitationID:8598850277969805705, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.received, extended data:}]}}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {onAdvanceInvitationUserStateChanged, {invitationID:8598850277969805705, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.received, extended data:}]}}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmntym2og00031wbgt2z0knsz}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {invitation map: {}}  {04/05/2026 09:03:18}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {on invitation user state changed, event:{invitationID:8598850277969805705, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.received, extended data:}]}}  {04/05/2026 09:03:18}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:21:645][Verbose][Callback] OnCallInvitationAccepted: call id: 8598850277969805705
I/zego_jni( 7504): [2026-5-4 11:3:21:645][Verbose][Callback] OnCallUserStateChanged: call id: 8598850277969805705,call user info list:1
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/ZegoUIKitCallPlugin( 7504): onMethodCall: stopMonitoringAudioRoute
D/ZegoUIKitCallPlugin( 7504): Audio route monitoring stopped
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallInvitationAccepted, info:Instance of 'ZIMCallInvitationAcceptedInfo', invitationID:8598850277969805705}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onOutgoingInvitationAccepted, {invitationID: 8598850277969805705, inviteeID: cmntym2og00031wbgt2z0knsz, extendedData: {"custom_data":"","v":"f1.0"}}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {remove invitation data, invitationID: 8598850277969805705, containsKey:truemap:{8598850277969805705: id:8598850277969805705, type:0, inviter id:cmogzn2620001ytqnylkf4tgh, invitees:(userid :cmntym2og00031wbgt2z0knsz, state:InvitationState.accept), data:{"call_id":"cmomfeqzy000mj3qnrjz2x60e_1777863797951","inviter_name":"Nowshin Fabiha","invitees":[{"user_id":"cmntym2og00031wbgt2z0knsz","user_name":"Service Provider"}],"timeout":60,"custom_data":"","v":"f1.0"}, resourceID:}, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, on invitation accepted}  {invitee:{id:cmntym2og00031wbgt2z0knsz, name:, in-room attributes:{}, camera:false, microphone:false, }, data:{"custom_data":"","v":"f1.0"}, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {check is in calling, state:CallingState.kCallingWithVoice, inCallingByIOSBackgroundLock:false, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {page had pushed}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from State[CallingState.kCallingWithVoice] to State[CallingState.kOnlineAudioVideo]}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {onStateChanged, currentState:CallingState.kOnlineAudioVideo, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallUserStateChanged, callUserList:({userID:cmntym2og00031wbgt2z0knsz, state:ZIMCallUserState.accepted, extendedData:{"custom_data":"","v":"f1.0"}}),invitationID:8598850277969805705}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onInvitationUserStateChanged, {invitationID:8598850277969805705, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:{"custom_data":"","v":"f1.0"}}]}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {onAdvanceInvitationUserStateChanged, {invitationID:8598850277969805705, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:{"custom_data":"","v":"f1.0"}}]}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmntym2og00031wbgt2z0knsz}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {invitation map: {}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {on invitation user state changed, event:{invitationID:8598850277969805705, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:{"custom_data":"","v":"f1.0"}}]}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, on invitation accepted}  {invitee:{id:cmntym2og00031wbgt2z0knsz, name:, in-room attributes:{}, camera:false, microphone:false, }, data:{"custom_data":"","v":"f1.0"}, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, on invitation accepted}  {invitee is not in list, invitee:cmntym2og00031wbgt2z0knsz, list:()}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[]}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[], }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(1012772360) stop ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-channel}  {stopMonitoringAudioRoute}  {stopMonitoringAudioRoute}  {04/05/2026 09:03:21}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: reporterUpdateCommonParams
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {⏹️ Android audio route monitoring stopped}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setEngineConfig]
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.stopped, isRingTimerRunning:true, isRingtoneRunning:false, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.stopped}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {create prebuilt call page, is group call:false, invitationData:ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, invitationID: 8598850277969805705, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, customData: .}}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setEngineConfig, info: Execution successful.
I/PLogger ( 7504): {call-invitation}  {calling page}  {create prebuilt call page}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {appID:1683382177, params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh}}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCustomVideoProcessing]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setEngineConfig]
I/PLogger ( 7504): {uikit-reporter}  {create}  {had created before}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {update common params}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {mini machine state is ZegoCallMiniOverlayPageState.idle}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {init duration}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, onLocalInvitingUsersUpdated}  {localInvitingUsers:[]}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, onLocalInvitingUsersUpdated}  {no wait inviting users now, currentInvitationID:8598850277969805705, remoteUserIsEmpty:true, localIsInitiator:false, hasWaitingInvitee:false, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.p}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.minimize.p}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {add listener:Closure: (ZegoCallMiniOverlayPageState) => void from Function 'onMiniOverlayMachineStateChanged':., size:2}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.pip.p android}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {live-streaming}  {controller.screenSharing.p}  {init by prebuilt}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {change state outside to ZegoCallMiniOverlayPageState.idle}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {mini overlay, from State[ZegoCallMiniOverlayPageState.idle] to State[ZegoCallMiniOverlayPageState.idle]}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {onAudioRouteChanged}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {audio route changed: speaker=false, earpiece=true}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {enabling proximity sensor for earpiece mode}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCustomVideoProcessing, info: Execution successful.
I/PLogger ( 7504): {call}  {prebuilt, checkRequiredParticipant}  {requiredUsers not enabled}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setEngineConfig, info: Execution successful.
I/PLogger ( 7504): {uikit-user}  {getLeaveUsers}  {get leave users, leave users:[]}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setMinVideoBitrateForTrafficControl]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setVideoMirrorMode]
I/PLogger ( 7504): {uikit-user}  {userCache}  {get leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setAudioRouteToSpeaker]
I/PLogger ( 7504): {call}  {prebuilt}  {no response end timer is disabled}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {updateCommonParams}  {{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterUpdateCommonParams}  {params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/init, params:{source: page, error: 0, start_time: 1777863801663}, }  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [loginRoom]
I/PLogger ( 7504): {call}  {prebuilt}  {version: zego_uikit_prebuilt_call:4.23.0; zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys,
I/PLogger ( 7504): appID:1683382177,
I/PLogger ( 7504): callID:cmomfeqzy000mj3qnrjz2x60e_1777863797951,
I/PLogger ( 7504): userID:cmogzn2620001ytqnylkf4tgh,
I/PLogger ( 7504): userName:Nowshin Fabiha,
I/PLogger ( 7504): config:ZegoUIKitPrebuiltCallConfig:{video:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }, audioVideoView:ZegoCallAudioVideoViewConfig:{containerBuilder:null, isVideoMirror:true, showMicrophoneStateOnView:true, showCameraStateOnView:false, showUserNameOnView:true, foregroundBuilder:null, backgroundBuilder:null, useVideoViewAspectFill:true, showAvatarInAudioMode:true, showSoundWavesInAudioMode:true, }, topMenuBar:ZegoCallTopMenuBarConfig:{isVisible:false, title:, hideAutomatically:true, hideByClick:true, buttons:[], extendButtons:[], style:ZegoCallMenuBarStyle.light, padding:null, margin:null, backgroundColor:null, height:null, }, bottomMenuBar:ZegoCallBottomMenuBarConfig:{hideAutomatically:true, hideByClick:true, buttons:[ZegoCallMenuBarButtonName.toggleMicrophoneButton, ZegoCallMenuBarButtonName.hangUpButton, ZegoCallMenuBarButtonName.switchAudioOutputButton], extendButtons:[], maxCount:5, style:ZegoCallMenuBarStyle.light, padding:null, margin:null, backgroundColor:null, height:null, }, memberList:ZegoCallMemberListConfig:{showMicrophoneState:true, showCameraState:true, itemBuilder:null, }, duration:ZegoCallDurationConfig:{isVisible:true, onDurationUpdate:null, }, chatView:ZegoCallInRoomChatViewConfig:{itemBuilder:null, }, user:Instance of 'ZegoCallUserConfig', device:{enableSyncDeviceStatusBySEI:true, }, layout:Instance of 'ZegoLayoutPictureInPictureConfig', pip:ZegoCallPIPConfig:{android:ZegoCallPIPAndroidConfig:{background:null, }, iOS:ZegoCallPIPIOSConfig:{support:true, }, aspectWidth:9, aspectHeight:16, enableWhenAppBackToDesktop:true, }, screenSharing:ZegoCallScreenSharingConfig:{autoStop:ZegoCallScreenSharingAutoStopConfig:{invalidCount:3, canEnd:false, }, defaultFullScreen:false, }, noResponseEnd:ZegoCallNoResponseEndConfig:{enabled:false, timeoutSeconds:3, }, turnOnCameraWhenJoining:false, useFrontCameraWhenJoining:true, turnOnMicrophoneWhenJoining:true, useSpeakerWhenJoining:false, rootNavigator:false, advanceConfigs:{}, enableAccidentalTouchPrevention:true, foreground:null, background:null, hangUpConfirmDialog:ZegoCallHangUpConfirmDialogConfig:{info:null, titleStyle:null, contentStyle:null, actionTextStyle:null, backgroundBrightness:null, }, avatarBuilder:null, },
I/PLogger ( 7504): events:ZegoUIKitPrebuiltCallEvents:{onCallEnd:Closure: (ZegoCallEndEvent, () => void) => Future<void>, onHangUpConfirmation:null, onError:null, user:null, room:null, audioVideo:null, beauty:null, },
I/PLogger ( 7504): }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951(key:zego_uikit_leave_users_cmomfeqzy000mj3qnrjz2x60e_1777863797951)}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {get deleted stream users for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached deleted stream users for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951(key:zego_uikit_deleted_stream_users_cmomfeqzy000mj3qnrjz2x60e_1777863797951)}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, checkInvitationParticipant}  {some other members are still in the room, otherMembersInCall:({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, }), leavedRoomUsers:(),
I/PLogger ( 7504): ---inviter:{id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, }, invitees:({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, }), localUser:{id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, }, leavedRoomUsersInMemory:(), leavedRoomUsersInCache:(), deletedStreamUsersInCache:(), }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {audioPlayer stop done}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {set _isRingTimerRunning to false}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit}  {permission}  {Permission.microphone status: PermissionStatus.granted}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-user}  {login}  {id:"cmogzn2620001ytqnylkf4tgh", name:Nowshin Fabiha}  {04/05/2026 09:03:21}  {INFO}
E/PLogger ( 7504): {uikit-user}  {login}  {user is same}  {04/05/2026 09:03:21}  {WARNING}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set advance configs}  {configs:{}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {proximity cleared, restoring screen brightness and touch}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {controller.pip.p android}  {onPIPStatusUpdated, PiPStatus.disabled, lifecycleState: AppLifecycleState.resumed}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {reset _pageManager.isCurrentInvitationFromAcceptedAndroidOffline}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {isFromAcceptedAndroidOfflineInvitation:false}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {enableSyncDeviceStatusByStreamExtraInfo}  {value: true}  {04/05/2026 09:03:21}  {INFO}
E/PLogger ( 7504): {uikit-service-core(618137614)}  {init}  {had init}  {04/05/2026 09:03:21}  {WARNING}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setMinVideoBitrateForTrafficControl, info: Execution successful.
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setMinVideoResolutionForTrafficControl]
I/PLogger ( 7504): {uikit-stream}  {enableCustomVideoProcessing}  {disable custom video processing, buffer type:ZegoVideoBufferType.GLTexture2D, express engineState:ZegoUIKitExpressEngineState.stop, }  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setVideoMirrorMode, info: Execution successful.
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set advance configs}  {configs:{}}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setAudioRouteToSpeaker, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onRoomStateUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, state: CONNECTING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStateChanged] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, reason: LOGINING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: loginRoom, info: Execution successful.
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {isEnabled:false, express engineState:ValueNotifier<ZegoUIKitExpressEngineState>#0577a(ZegoUIKitExpressEngineState.stop), roomState:ZegoUIKitRoomState:{reason:ZegoRoomStateChangedReason.Logout, error code:0, extended data:{}, }, isPreviewing:false, isPublishingStream:false, isPlayingStream:false, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {state is same, ignore}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {video config:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {traffic control}  {enable:true, properties:[ZegoUIKitTrafficControlProperty.adaptiveResolution, ZegoUIKitTrafficControlProperty.adaptiveFPS], minimizeVideoConfig:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }, isFocusOnRemote:true, bitmask:3}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setMinVideoResolutionForTrafficControl, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setMinVideoFpsForTrafficControl]
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {use front facing camera}  {Already front}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {update video view mode}  {mode is equal}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-microphone}  {switch microphone}  {turn on local microphone, muteMode:false, already on.}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {target is speaker:false, current audio route is:ZegoUIKitAudioRoute.receiver, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {now audio route is:ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-room}  {join room}  {room id:"cmomfeqzy000mj3qnrjz2x60e_1777863797951", has token:false, markAsLargeRoom:false, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit}  {core data}  {clear}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setMinVideoFpsForTrafficControl, info: Execution successful.
I/PLogger ( 7504): {uikit-stream}  {clearStream}  {clear stream}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-media}  {clear}  {clear}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setTrafficControlFocusOn]
I/PLogger ( 7504): {uikit-service-core}  {core room}  {clear}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-room}  {setRoom}  {set room:"cmomfeqzy000mj3qnrjz2x60e_1777863797951", markAsLargeRoom:false}}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-event}  {init}  {init}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-media}  {event}  {init}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-room}  {join room}  {try join room id:"cmomfeqzy000mj3qnrjz2x60e_1777863797951" by id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, isSimulated:false, }  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setTrafficControlFocusOn, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableTrafficControl]
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStateChanged roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, reason: ZegoRoomStateChangedReason.Logining, errorCode: 0, extendedData: {}}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableTrafficControl, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setVideoConfig]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setVideoConfig, info: Execution successful.
I/PLogger ( 7504): {uikit-stream}  {set video config}  {config:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }, streamType:ZegoStreamType.main, }  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onRoomStateUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, state: CONNECTED, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStateChanged] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, reason: LOGINED, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomOnlineUserCountUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, count: 1
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCamera]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCamera, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [muteMicrophone]
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStateChanged roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, reason: ZegoRoomStateChangedReason.Logined, errorCode: 0, extendedData: {room_session_id: 1271129602890153984}}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: muteMicrophone, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [startPublishingStream]
I/PLogger ( 7504): {uikit-room}  {join room}  {result:0,extendedData:{}}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onPublisherStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, state: PUBLISH_REQUESTING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: startPublishingStream, info: Execution successful.
I/PLogger ( 7504): {uikit-stream}  {start publish stream}  {updateConfigBeforeStartPublishingStream, view id:-1, }  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setStreamExtraInfo]
I/PLogger ( 7504): {uikit-stream}  {start publish stream}  {stream dict add ZegoStreamType.main cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main for cmogzn2620001ytqnylkf4tgh, now stream dict:{cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main: user id:cmogzn2620001ytqnylkf4tgh, player state:ZegoPlayerState.NoPlay, publisher state:ZegoPublisherState.NoPublish}}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setStreamExtraInfo, info: Execution successful.
I/PLogger ( 7504): {uikit-stream}  {start publish stream}  {start publish, cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {start publish stream}  {call express startPublishingStream, for trace enableCustomVideoRender, isEnableCustomVideoRender:false}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onPublisherStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, state:ZegoPublisherState.PublishRequesting, errorCode:0, extendedData:{}}  {04/05/2026 09:03:21}  {INFO}
D/ajbd.protiva502( 7504): PlayerBase::PlayerBase()
D/ajbd.protiva502( 7504): TrackPlayerBase::TrackPlayerBase()
I/libOpenSLES( 7504): Emulating old channel mask behavior (ignoring positional mask 0x3, using default mask 0x3 based on channel count of 2)
D/ZEGO    ( 7504): [Flutter] [onEngineStateUpdate] state: START
D/ZEGO    ( 7504): [Flutter] [onRecvExperimentalAPI] content: {"method":"liveroom.device.on_device_state_changed","params":{"channel":0,"devcie_type":"camera","reason":2,"state":"off"}}
D/ZEGO    ( 7504): [Flutter] [DartCall] [getAudioRouteType]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: getAudioRouteType, info: Execution successful.
I/PLogger ( 7504): {uikit-service-core}  {event}  {onEngineStateUpdate, state:ZegoEngineState.Start, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {update audio route by onEngineStateUpdate, state:ZegoEngineState.Start, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {local user}  {init default audio route:ZegoAudioRoute.Receiver}  {04/05/2026 09:03:21}  {INFO}
W/libOpenSLES( 7504): Conversion from OpenSL ES positional channel mask 0x4 to Android mask 0 loses channels
I/libOpenSLES( 7504): Emulating old channel mask behavior (ignoring positional mask 0x4, using default mask 0x10 based on channel count of 1)
D/MediaRouter( 7504): onRestoreRoute() : route=RouteInfo{ name=Phone, description=null, status=null, category=RouteCategory{ name=System types=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO  groupable=false }, supportedTypes=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO , presentationDisplay=null }
V/MediaRouter( 7504): Selecting route: RouteInfo{ name=Phone, description=null, status=null, category=RouteCategory{ name=System types=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO  groupable=false }, supportedTypes=ROUTE_TYPE_LIVE_AUDIO ROUTE_TYPE_LIVE_VIDEO , presentationDisplay=null }
D/ZEGO    ( 7504): [Flutter] [onRecvExperimentalAPI] content: {"method":"liveroom.device.on_device_state_changed","params":{"channel":0,"devcie_type":"speaker","reason":0,"state":"on"}}
D/ajbd.protiva502( 7504): TrackPlayerBase::~TrackPlayerBase()
D/ajbd.protiva502( 7504): PlayerBase::~PlayerBase()
D/ZEGO    ( 7504): [Flutter] [DartCall] [sendSEI]
D/ZEGO    ( 7504): [Flutter] [DartCall] [startSoundLevelMonitor]
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/FlutterJNI( 7504): Sending viewport metrics to the engine.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: startSoundLevelMonitor, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onPublisherCapturedAudioFirstFrame]
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:loginRoom, params:{room_id: cmomfeqzy000mj3qnrjz2x60e_1777863797951, token: , start_time: 1777863801684, error: 0, msg: {}}, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {initContext done}  {04/05/2026 09:03:21}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setAudioRouteToSpeaker]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setAudioRouteToSpeaker, info: Execution successful.
I/PLogger ( 7504): {uikit-component}  {audio video container}  {use pictureInPictureLayout, userList:({id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, ), }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh' build,}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's camera changed false,}  {04/05/2026 09:03:21}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's view is null}  {04/05/2026 09:03:21}  {ERROR}
I/PLogger ( 7504): {uikit-microphone}  {switch microphone}  {turn on local microphone, muteMode:false, already on.}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-audio-output}  {switch audio output button}  {update audio route by default, target is speaker:false}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {target is speaker:false, current audio route is:ZegoUIKitAudioRoute.receiver, }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {now audio route is:ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video container}  {use pictureInPictureLayout, userList:({id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, ), }  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh' build,}  {04/05/2026 09:03:21}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's camera changed false,}  {04/05/2026 09:03:21}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's view is null}  {04/05/2026 09:03:21}  {ERROR}
D/ZEGO    ( 7504): [Flutter] [onPublisherStreamEvent] eventID: PUBLISH_START, streamID: cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, extraInfo: {"resourceType":"rtc","streamProtocol":"avertp","url":"avertp://udp1683382177.coolzcloud.com/1683382177/cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main"}
D/ZEGO    ( 7504): [Flutter] [onRoomUserUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, updateType: ADD, userListCount: 1
D/ZEGO    ( 7504): [Flutter] [onRoomOnlineUserCountUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, count: 2
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomUserUpdate, room id:"cmomfeqzy000mj3qnrjz2x60e_1777863797951", update type:ZegoUpdateType.Adduser list:("cmntym2og00031wbgt2z0knsz":gruff P, )}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {get leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951(key:zego_uikit_leave_users_cmomfeqzy000mj3qnrjz2x60e_1777863797951)}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {onUserJoin:({id:cmntym2og00031wbgt2z0knsz, name:gruff P, }), cancelling no response end timer}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video container}  {use pictureInPictureLayout, userList:({id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:false, }, , {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, ), }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh' build,}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's camera changed false,}  {04/05/2026 09:03:22}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's view is null}  {04/05/2026 09:03:22}  {ERROR}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz' build,}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz's camera changed false,}  {04/05/2026 09:03:22}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmntym2og00031wbgt2z0knsz's view is null}  {04/05/2026 09:03:22}  {ERROR}
D/ZEGO    ( 7504): [Flutter] [onRecvExperimentalAPI] content: {"method":"liveroom.device.on_device_state_changed","params":{"channel":0,"devcie_type":"mic","reason":0,"state":"on"}}
D/ZEGO    ( 7504): [Flutter] [onRecvExperimentalAPI] content: {"method":"liveroom.device.on_device_state_changed","params":{"channel":0,"devcie_type":"camera","reason":2,"state":"off"}}
D/ZEGO    ( 7504): [Flutter] [onPublisherStreamEvent] eventID: PUBLISH_SUCCESS, streamID: cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, extraInfo: {"resourceType":"rtc","streamProtocol":"avertp","url":"avertp://udp1683382177.coolzcloud.com/1683382177/cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main"}
D/ZEGO    ( 7504): [Flutter] [onPublisherSendAudioFirstFrame] channel: MAIN
D/ZEGO    ( 7504): [Flutter] [onPublisherStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, state: PUBLISHING, errorCode: 0
I/PLogger ( 7504): {uikit-service-core}  {event}  {onPublisherStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, state:ZegoPublisherState.Publishing, errorCode:0, extendedData:{}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {ring timer ended}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.stopped, isRingTimerRunning:false, isRingtoneRunning:false, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.stopped}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {audioPlayer stop done}  {04/05/2026 09:03:22}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onRoomUserUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, updateType: DELETE, userListCount: 1
D/ZEGO    ( 7504): [Flutter] [onRoomOnlineUserCountUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, count: 1
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomUserUpdate, room id:"cmomfeqzy000mj3qnrjz2x60e_1777863797951", update type:ZegoUpdateType.Deleteuser list:("cmntym2og00031wbgt2z0knsz":gruff P, )}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {user cmntym2og00031wbgt2z0knsz added to leaveUsersList}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {set leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951, userIDs:[cmntym2og00031wbgt2z0knsz], }  {04/05/2026 09:03:22}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: activeAppToForeground
D/ZegoUikitPlugin( 7504): active app to foreground
I/PLogger ( 7504): {uikit-user}  {userCache}  {set leave users done for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951(key:zego_uikit_leave_users_cmomfeqzy000mj3qnrjz2x60e_1777863797951)}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay page}  {onUserLeave, not in minimizing}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {onUserLeave:({id:cmntym2og00031wbgt2z0knsz, name:gruff P, }), }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {only local user in call, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {activeAppToForeground}  {activeAppToForeground}  {04/05/2026 09:03:22}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
I/PLogger ( 7504): {call}  {prebuilt}  {default call end event, event:ZegoCallEndEvent{callID:cmomfeqzy000mj3qnrjz2x60e_1777863797951, kickerUserID:null, reason:ZegoCallEndReason.remoteHangUp, invitationData: ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, invitationID: 8598850277969805705, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, customData: .}, }}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, Navigator}  {pop from call end, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video container}  {use pictureInPictureLayout, userList:({id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, ), }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh' build,}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's camera changed false,}  {04/05/2026 09:03:22}  {INFO}
E/PLogger ( 7504): {uikit-component}  {audio video view}  {cmogzn2620001ytqnylkf4tgh's view is null}  {04/05/2026 09:03:22}  {ERROR}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.inactive}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.inactive to AppLifecycleState.inactive, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.inactive(from AppLifecycleState.inactive)}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.resumed}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.resumed to AppLifecycleState.resumed, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.resumed(from AppLifecycleState.resumed)}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.inactive, isAppInBackground:true, isScreenLockEnabled:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, didChangeAppLifecycleState}  {is app in background: previous:false, current: true, call machine page state:CallingState.kOnlineAudioVideo, invitation data:ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, invitationID: 8598850277969805705, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, customData: .}, in calling by ios background lock:false, current room info:ZegoUIKitRoom:{id:cmomfeqzy000mj3qnrjz2x60e_1777863797951, }}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:true}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.resumed, isAppInBackground:false, isScreenLockEnabled:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, didChangeAppLifecycleState}  {is app in background: previous:true, current: false, call machine page state:CallingState.kOnlineAudioVideo, invitation data:ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, invitationID: 8598850277969805705, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, customData: .}, in calling by ios background lock:false, current room info:ZegoUIKitRoom:{id:cmomfeqzy000mj3qnrjz2x60e_1777863797951, }}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {app active from background, try re-login}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, initialized:true, state:ZegoSignalingPluginConnectionState.connected}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, user state is not disconnected}  {04/05/2026 09:03:22}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: activeAppToForeground
D/ZegoUikitPlugin( 7504): active app to foreground
D/ZEGO    ( 7504): [Flutter] [DartCall] [setReverbPreset]
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopPreview]
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopSoundLevelMonitor]
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/ZEGO    ( 7504): [Flutter] [DartCall] [setVoiceChangerPreset]
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopPublishingStream]
D/ZEGO    ( 7504): [Flutter] [DartCall] [logoutRoom]
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/FlutterJNI( 7504): Sending viewport metrics to the engine.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setReverbPreset, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopPreview, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopSoundLevelMonitor, info: Execution successful.
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {call}  {prebuilt}  {disabling proximity sensor}  {04/05/2026 09:03:22}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setVoiceChangerPreset, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setEffectsBeautyParam]
D/ZEGO    ( 7504): [Flutter] [onPublisherStateUpdate] streamID: cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, state: NO_PUBLISH, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopPublishingStream, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onRoomStateUpdate] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, state: DISCONNECTED, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStateChanged] roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, reason: LOGOUT, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: logoutRoom, info: Execution successful.
D/ZegoUIKitCallPlugin( 7504): onMethodCall: dismissNotification
I/call plugin( 7504): dismissNotification, id: 1020110899
D/ajbd.protiva502( 7504): PlayerBase::stop() from IPlayer
D/AudioTrack( 7504): stop(46): called with 52232 frames delivered
I/PLogger ( 7504): {uikit-channel}  {activeAppToForeground}  {activeAppToForeground}  {04/05/2026 09:03:22}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
D/ZegoUIKitCallPlugin( 7504): onMethodCall: dismissNotification
I/call plugin( 7504): dismissNotification, id: 1020110899
I/zego_jni( 7504): [2026-5-4 11:3:22:874][Verbose][API] logout. handle: 12970495528517775566
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[]}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[], }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {clear advance invitation, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), cancel group call invitation}  {invitationData:ZegoCallInvitationData:{callID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, invitationID: 8598850277969805705, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmntym2og00031wbgt2z0knsz, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, in-room attributes:{}, camera:false, microphone:true, }, customData: .}, invitingInvitees:[], }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), cancel group call invitation}  {have already some one accept, not need to cancel}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {controller.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {controller.minimize.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {remove listener:Closure: (ZegoCallMiniOverlayPageState) => void from Function 'onMiniOverlayMachineStateChanged':., size:1}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {controller.pip.p android}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {live-streaming}  {controller.pip.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-room}  {leave room}  {current room is cmomfeqzy000mj3qnrjz2x60e_1777863797951, target room id:null, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit}  {core data}  {clear}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {clearStream}  {clear stream}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {stop publish stream}  {stop ZegoStreamType.main cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main}, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {stop publish stream}  {stream dict remove cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, now stream dict:{}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-media}  {clear}  {clear}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {clear}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, setPendingCallPageDisposeFlag}  {needWait:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {prebuilt call page dispose, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {needPop:false, needHideInvitationTopSheet:true, needClearCallKit:true}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/unInit, params:{source: page}, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call}  {machine, Navigator}  {push from onCallingEntry, onDispose}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), end/quit advance invitation,}  {is not advance mode}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {needPop:false, needHideInvitationTopSheet:true, needClearCallKit:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:22}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 1007022, funcName: setEffectsBeautyParam, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [onDebugError] errorCode: 1007022, funcName: setEffectsBeautyParam, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopEffectsEnv]
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableEffectsBeauty]
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCustomVideoProcessing]
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(1012772360) stop ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:22}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onEngineStateUpdate] state: STOP
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopEffectsEnv, info: Execution successful.
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(1012772360) stop ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:22}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 1007021, funcName: enableEffectsBeauty, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [onDebugError] errorCode: 1007021, funcName: enableEffectsBeauty, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCustomVideoProcessing, info: Execution successful.
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(891214147) stop ring, prefix:, source path:, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {cancelInvitationNotification}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelCallNotification}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-channel}  {dismissNotification}  {id:1020110899}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.inactive}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.inactive to AppLifecycleState.inactive, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.inactive(from AppLifecycleState.inactive)}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.resumed}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.resumed to AppLifecycleState.resumed, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.resumed(from AppLifecycleState.resumed)}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), uninit}  {service un-init}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {uninit private}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {unregister offline call isolate name server, port:130737561}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {unregister message handler:320449901}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {uninit}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelMissedCallNotification}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelCallNotification}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-channel}  {dismissNotification}  {id:1020110899}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {uninit}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {set hasCallkitIncomingCauseAppInBackground:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {set waitingCallInvitationReceivedAfterCallKitIncomingAccepted:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {set waitingCallInvitationReceivedAfterCallKitIncomingRejected:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {remove listener:Closure: (ZegoCallMiniOverlayPageState) => void from Function 'onMiniOverlayMachineStateChanged':., size:1}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {remove stream}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {internal instance}  {unregister}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service.p}  {un-init by prebuilt}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {callkit service uninit}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit id}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params done}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), uninit plugins}  {uninit plugins}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {user logout, currentUserID:cmogzn2620001ytqnylkf4tgh, currentUserName:Nowshin Fabiha, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, current id:cmogzn2620001ytqnylkf4tgh, current name:Nowshin Fabiha, connectionState:ZIMConnectionState.connected}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, waitForDisconnect...}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(891214147) stop ring, prefix:, source path:, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {cancelInvitationNotification}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, hideInvitationTopSheet}  {hideInvitationTopSheet}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {restore to idle, current state:CallingState.kOnlineAudioVideo, inCallPage:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling machine to be idle}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from State[CallingState.kOnlineAudioVideo] to State[CallingState.kIdle]}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {done}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-beauty}  {effects}  {stop effects env}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-beauty}  {effects}  {disable beauty}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onPublisherStateUpdate, stream id:cmomfeqzy000mj3qnrjz2x60e_1777863797951_cmogzn2620001ytqnylkf4tgh_main, state:ZegoPublisherState.NoPublish, errorCode:0, extendedData:{}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStateChanged roomID: cmomfeqzy000mj3qnrjz2x60e_1777863797951, reason: ZegoRoomStateChangedReason.Logout, errorCode: 0, extendedData: {}}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-room}  {leave room}  {success}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-event}  {uninit}  {uninit}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onEngineStateUpdate, state:ZegoEngineState.Stop, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-media}  {event}  {uninit}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:logoutRoom, params:{room_id: cmomfeqzy000mj3qnrjz2x60e_1777863797951, error: 0, msg: {}}, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear leave users for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear deleted stream users for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {enableCustomVideoProcessing}  {disable custom video processing, buffer type:ZegoVideoBufferType.GLTexture2D, express engineState:ZegoUIKitExpressEngineState.stop, }  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear leave users done for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear deleted stream users done for room:cmomfeqzy000mj3qnrjz2x60e_1777863797951}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {clear callkit infos}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit id}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear all callKit calls}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.inactive, isAppInBackground:true, isScreenLockEnabled:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:true}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.resumed, isAppInBackground:false, isScreenLockEnabled:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:false}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {app active from background, try re-login}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, initialized:true, state:ZegoSignalingPluginConnectionState.connected}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, user state is not disconnected}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {clear callkit infos done}  {04/05/2026 09:03:22}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, hideInvitationTopSheet}  {hideInvitationTopSheet}  {04/05/2026 09:03:22}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:23: 16][Verbose][Callback] OnConnectionStateChanged: state: 0, event: 0, extended_data: {}
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, state:ZIMConnectionState.disconnected, event:ZIMConnectionEvent.success, extendedData:{}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, disconnected, clear current user}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {[call invitation] onInvitationConnectionState, {state: ZegoSignalingPluginConnectionState.disconnected, action: ZegoSignalingPluginConnectionAction.unknown, extendedData: {}}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {connection state changed, {state: ZegoSignalingPluginConnectionState.disconnected, action: ZegoSignalingPluginConnectionAction.unknown, extendedData: {}}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {disconnected, auto logout}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {user logout, not login before.}  {04/05/2026 09:03:23}  {INFO}
I/flutter ( 7504): [core] user in-room private is not init
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, waitForDisconnect success}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {logout success}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {clear}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {logout done.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {uninit}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {removePreferenceValue, key:call_app_sign.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {removePreferenceValue, key:handler_info.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {user attributes}  {user in-room uninit}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {destroy.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {clear}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {uninit data.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {uninit}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {uninit}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {notification data}  {uninit notification data}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {uninstall plugins}  {plugin type:ZegoUIKitPluginType.signaling uninstalled}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/unInit, params:{source: service}, }  {04/05/2026 09:03:23}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: reporterUpdateCommonParams
D/permissions_handler( 7504): No permissions found in manifest for: []1
I/PLogger ( 7504): {uikit-reporter}  {create}  {appID:1683382177, params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {had created before}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {update common params}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {updateCommonParams}  {{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterUpdateCommonParams}  {params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}, }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {versions: zego_uikit_prebuilt_call:4.23.0; zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {service init, appID:1683382177, userID:cmogzn2620001ytqnylkf4tgh, userName:Nowshin Fabiha, plugins:[IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }], ringtoneConfig:null, config:null, uiConfig:null, notificationConfig:ZegoCallInvitationNotificationConfig:{androidNotificationConfig:ZegoCallAndroidNotificationConfig:{callIDVisibility:true, certificateIndex:ZegoSignalingPluginMultiCertificate.firstCertificate, showFullScreen:true, call channel config:ZegoCallAndroidNotificationChannelConfig:{channelID:zego_call, channelName:Call Notifications, icon:, sound:, vibrate:true, }, missed call channel config:ZegoCallAndroidNotificationChannelConfig:{channelID:missed_call, channelName:Missed Call, icon:, sound:, vibrate:false, }, message channel config:ZegoCallAndroidNotificationChannelConfig:{channelID:zimkit_message, channelName:Chat Message, icon:, sound:, vibrate:false, }, }, iOSNotificationConfig:ZegoCallIOSNotificationConfig:{appName:Protiva502, certificateIndex:ZegoSignalingPluginMultiCertificate.firstCertificate, isSandboxEnvironment:false, systemCallingIconName:, }, }, }  {04/05/2026 09:03:23}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: createNotificationChannel
I/call plugin( 7504): create channel, channelId:zego_call,channelName:Call Notifications,soundSource:, enableVibration:true
I/call plugin( 7504): channel exist
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init data, }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init permissions}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit}  {permission}  {Permission.camera status: PermissionStatus.denied}  {04/05/2026 09:03:23}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: createNotificationChannel
I/call plugin( 7504): create channel, channelId:missed_call,channelName:Missed Call,soundSource:, enableVibration:false
I/call plugin( 7504): channel exist
E/PLogger ( 7504): {uikit}  {permission}  {Permission.camera permission not granted, PermissionStatus.denied}  {04/05/2026 09:03:23}  {ERROR}
I/PLogger ( 7504): {uikit}  {permission}  {Permission.microphone status: PermissionStatus.granted}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initPermissions done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init private, }  {04/05/2026 09:03:23}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: createNotificationChannel
I/call plugin( 7504): create channel, channelId:zimkit_message,channelName:Chat Message,soundSource:, enableVibration:false
I/call plugin( 7504): channel exist
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {Close The lookupIsolate or not, needClose:false, hash(null), isMainIsolatePort:false}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {register, _backgroundPort(156088951), _backgroundPort!.sendPort(302816199)}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {add port:Instance of '_ReceivePortImpl', name:bg_msg_isolate_port}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {register offline call isolate name server, port:156088951}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {register message handler:320449901}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {update contextQuery in call invitation config}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {init, context:Navigator-[LabeledGlobalKey<NavigatorState>#90875](dependencies: [HeroControllerScope, InheritedCupertinoTheme, UnmanagedRestorationScope, _InheritedTheme, _LocalizationsScope-[GlobalKey#526ce]], state: NavigatorState#6ab75(tickers: tracking 2 tickers)), permissions:[ZegoCallInvitationPermission.camera, ZegoCallInvitationPermission.microphone], }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {start create channels}  {04/05/2026 09:03:23}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: dismissNotification
I/call plugin( 7504): dismissNotification, id: 737542978
E/flutter ( 7504): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: 'package:audioplayers_platform_interface/src/api/audio_context.dart': Failed assertion: line 178 pos 13: 'category == AVAudioSessionCategory.playback ||
E/flutter ( 7504):                 category == AVAudioSessionCategory.playAndRecord ||
E/flutter ( 7504):                 category == AVAudioSessionCategory.multiRoute ||
E/flutter ( 7504):                 !options.contains(AVAudioSessionOptions.mixWithOthers)': You can set the option `mixWithOthers` explicitly only if the audio session category is `playAndRecord`, `playback`, or `multiRoute`.
E/flutter ( 7504): #0      _AssertionError._doThrowNew (dart:core-patch/errors_patch.dart:67:4)
E/flutter ( 7504): #1      _AssertionError._throwNew (dart:core-patch/errors_patch.dart:49:5)
E/flutter ( 7504): #2      new AudioContextIOS (package:audioplayers_platform_interface/src/api/audio_context.dart:178:13)
E/flutter ( 7504): #3      ZegoRingtone.defaultAudioContext (package:zego_uikit_prebuilt_call/src/invitation/notification/notification_ring.dart:75:14)
E/flutter ( 7504): #4      ZegoRingtone.init (package:zego_uikit_prebuilt_call/src/invitation/notification/notification_ring.dart:617:28)
E/flutter ( 7504): #5      ZegoCallInvitationPageManager.initRing (package:zego_uikit_prebuilt_call/src/invitation/pages/page_manager.dart:297:23)
E/flutter ( 7504): #6      ZegoCallInvitationPageManager.init (package:zego_uikit_prebuilt_call/src/invitation/pages/page_manager.dart:230:5)
E/flutter ( 7504): #7      ZegoCallInvitationServicePrivateImpl._initPrivate (package:zego_uikit_prebuilt_call/src/invitation/mixins/private/private.dart:192:19)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #8      ZegoUIKitPrebuiltCallInvitationService.init.<anonymous closure> (package:zego_uikit_prebuilt_call/src/invitation/service.dart:427:15)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #9      ZegoUIKitPrebuiltCallInvitationService.init (package:zego_uikit_prebuilt_call/src/invitation/service.dart:409:5)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #10     CallService.initialize (package:protiva502/core/services/call_service.dart:61:5)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #11     CallService.initializeFromStorage (package:protiva502/core/services/call_service.dart:35:5)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #12     CallService._fullReset (package:protiva502/core/services/call_service.dart:118:7)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #13     CallService.initialize.<anonymous closure> (package:protiva502/core/services/call_service.dart:98:11)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504):
I/flutter ( 7504): [core] user in-room private init
I/PLogger ( 7504): {call-channel}  {createNotificationChannel}  {config:ZegoCallNotificationChannelConfig:{sound source:null, vibrate:true, channel id:zego_call, channel name:Call Notifications}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {createNotificationChannel of call done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-channel}  {createNotificationChannel}  {config:ZegoCallNotificationChannelConfig:{sound source:null, vibrate:false, channel id:missed_call, channel name:Missed Call}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {createNotificationChannel of missed call done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-channel}  {createNotificationChannel}  {config:ZegoCallNotificationChannelConfig:{sound source:null, vibrate:false, channel id:zimkit_message, channel name:Chat Message}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {createNotificationChannel of message done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {start request notification permission}  {04/05/2026 09:03:23}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCustomVideoProcessing]
I/zego_jni( 7504): [2026-5-4 11:3:23:374][Verbose][API] login. handle: 12970495528517775566, user id: cmogzn2620001ytqnylkf4tgh, user name: Nowshin Fabiha, is_offline: 0, token:
I/PLogger ( 7504): {uikit}  {permission}  {Permission.notification status: PermissionStatus.granted}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {request notification permission result:true}  {04/05/2026 09:03:23}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:23:376][Verbose][Callback] OnConnectionStateChanged: state: 1, event: 1, extended_data: {}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {requestPermission of notification done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {start request system alert window permission}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelCallNotification}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-channel}  {dismissNotification}  {id:737542978}  {04/05/2026 09:03:23}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCustomVideoProcessing, info: Execution successful.
I/PLogger ( 7504): {call-channel}  {setAudioRouteChangedCallback}  {setAudioRouteChangedCallback, callback: true}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-channel}  {setAudioRouteChangedCallback}  {setAudioRouteChangedCallback, callback: true}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {init}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling machine to be idle}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from null to State[CallingState.kIdle]}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {init: prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {internal instance}  {register, pageManager:Instance of 'ZegoCallInvitationPageManager', callInvitationData:Instance of 'ZegoUIKitPrebuiltCallInvitationData'}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initPrivate done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service.p}  {init by prebuilt}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init context}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-user}  {login}  {id:"cmogzn2620001ytqnylkf4tgh", name:Nowshin Fabiha}  {04/05/2026 09:03:23}  {INFO}
E/PLogger ( 7504): {uikit-user}  {login}  {user is same}  {04/05/2026 09:03:23}  {WARNING}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {enableSyncDeviceStatusByStreamExtraInfo}  {value: true}  {04/05/2026 09:03:23}  {INFO}
E/PLogger ( 7504): {uikit-service-core(618137614)}  {init}  {had init}  {04/05/2026 09:03:23}  {WARNING}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {isEnabled:false, express engineState:ValueNotifier<ZegoUIKitExpressEngineState>#0577a(ZegoUIKitExpressEngineState.stop), roomState:ZegoUIKitRoomState:{reason:ZegoRoomStateChangedReason.Logout, error code:0, extended data:{}, }, isPreviewing:false, isPublishingStream:false, isPlayingStream:false, }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {state is same, ignore}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {enableCustomVideoProcessing}  {disable custom video processing, buffer type:ZegoVideoBufferType.GLTexture2D, express engineState:ZegoUIKitExpressEngineState.stop, }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initContext done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {mobile system version:Instance of 'ZegoMobileSystemVersion'}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {callkit service init}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit internal instance}  {register, pageManager:Instance of 'ZegoCallInvitationPageManager'}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {offline callkit call id: null}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {set callkit variables:{CallKitInnerVariable.callIDVisibility: true, CallKitInnerVariable.showFullLockedScreen: true, CallKitInnerVariable.ringtonePath: , CallKitInnerVariable.backgroundUrl: }}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {request permission}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {register callkit incoming event listener}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initCallKit done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {init}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {install plugins}  {plugin type:ZegoUIKitPluginType.signaling install (967941468)}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {init data.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {init}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {init}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {notification data}  {init notification data}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.whiteboard, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
D/PushIDGenerateTools( 7504): device token:dvqnZZQNT3KgwpWo95Cpln:APA91bF3JT9rFNKFkhDsEhWqjGzFxsRIFCrwTTZwY2J_lcc61f8aL6e_JcWuQ0YFsf5AjTPl9B3FlJrBs_vx_pyNvIDNeGcl_usbaCkiYf41hGfepu0avaw
D/PushIDGenerateTools( 7504): payload:2
D/ZPNs native( 7504): onRegistered: pushid:rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ==
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.callkit, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins init}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {user attributes}  {user in-room init}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {test}  {test zim types begin}  {04/05/2026 09:03:23}  {INFO}
E/PLogger ( 7504): {signaling}  {test}  {ZegoSignalingPluginConnectionAction != ZIMConnectionEvent, ZegoSignalingPluginConnectionAction:[ZegoSignalingPluginConnectionAction.unknown, ZegoSignalingPluginConnectionAction.success, ZegoSignalingPluginConnectionAction.activeLogin, ZegoSignalingPluginConnectionAction.loginTimeout, ZegoSignalingPluginConnectionAction.interrupted, ZegoSignalingPluginConnectionAction.kickedOut, ZegoSignalingPluginConnectionAction.tokenExpired, ZegoSignalingPluginConnectionAction.unregistered], ZIMConnectionEvent:[ZIMConnectionEvent.success, ZIMConnectionEvent.activeLogin, ZIMConnectionEvent.loginTimeout, ZIMConnectionEvent.interrupted, ZIMConnectionEvent.kickedOut, ZIMConnectionEvent.tokenExpired, ZIMConnectionEvent.unregistered], }  {04/05/2026 09:03:23}  {ERROR}
I/PLogger ( 7504): {signaling}  {test}  {test zim types done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {init}  {create ZIM}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {init}  {ZIM is create before}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {create, appID:1683382177}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {try enable notification, iOSNotificationConfig:ZegoCallIOSNotificationConfig:{appName:Protiva502, certificateIndex:ZegoSignalingPluginMultiCertificate.firstCertificate, isSandboxEnvironment:false, systemCallingIconName:, }, enableIOSVoIP:false }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {setPreferenceString, key:handler_info, value:{"aid":"1683382177","tkn":"","uid":"cmogzn2620001ytqnylkf4tgh","un":"Nowshin Fabiha","isse":false,"eiv":false,"ci":1,"an":"Protiva502","ciic":false,"aci":"zego_call","acn":"Call Notifications","ai":"","as":"","av":true,"amci":"zimkit_message","amcn":"Chat Message","ams":"","ami":"","amv":false,"amdce":false,"amdcci":"missed_call","amdccn":"Missed Call","amdcs":"","amdci":"","amdcv":false,"amdnt":"Missed Call","amdncgv":"Group Video Call","amdncga":"Group Audio Call","amdncv":"Video Call","amdnca":"Audio Call"}.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {notification data}  {enable notify when app is in the background or quit: true}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {notification}  {enable Notify When App Running In Background Or Quit, is iOS Sandbox Environment:false, enable iOS VoIP:false, certificate index:ZegoSignalingPluginMultiCertificate.firstCertificate, appName: Protiva502, androidChannelID: zego_call, androidChannelName: Call Notifications, androidSound: }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins init done, login...}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {login request, user id:cmogzn2620001ytqnylkf4tgh, user name:Nowshin Fabiha,has token:false}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {ready to login.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {connectUser, id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, has token:false}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {requestFullIntentPermission done, res:true}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugin-ZegoUIKitPluginType.signaling version: zego_uikit_signaling_plugin: 2.8.20; zim:2.23.0.3574; zpns:2.8.0;}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {notification}  {register push done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {enable notification result: {error: null}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, state:ZIMConnectionState.connecting, event:ZIMConnectionEvent.activeLogin, extendedData:{}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {[call invitation] onInvitationConnectionState, {state: ZegoSignalingPluginConnectionState.connecting, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {connection state changed, {state: ZegoSignalingPluginConnectionState.connecting, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zpns}  {onRegistered, registerMessage: { pushID:rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ==, errorCode:0, pushSourceType:ZPNsPushSourceType.FCM, errorMessage:, commandResult:rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ== }}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {notification registered, {pushID: rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ==, code: 0}}  {04/05/2026 09:03:23}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:23:564][Verbose][Callback] OnConnectionStateChanged: state: 2, event: 1, extended_data: {}
I/zego_jni( 7504): [2026-5-4 11:3:23:564][Verbose][Callback] OnLoggedIn: code: 0, msg: operation was successful, seq: 5
I/zego_jni( 7504): [2026-5-4 11:3:23:564][Verbose][Callback] OnConversationTotalUnreadMessageCountUpdated: unread count: 0
I/flutter ( 7504): ┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
I/flutter ( 7504): │ #0   AppLoggerHelper.info (package:protiva502/core/utils/logging/logger.dart:15:13)
I/flutter ( 7504): │ #1   CallService.initialize (package:protiva502/core/services/call_service.dart:104:21)
I/flutter ( 7504): ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
I/flutter ( 7504): │ 💡 Call service initialized for userId=cmogzn2620001ytqnylkf4tgh
I/flutter ( 7504): └───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
I/flutter ( 7504): ┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
I/flutter ( 7504): │ #0   AppLoggerHelper.info (package:protiva502/core/utils/logging/logger.dart:15:13)
I/flutter ( 7504): │ #1   CallService._fullReset (package:protiva502/core/services/call_service.dart:124:21)
I/flutter ( 7504): ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
I/flutter ( 7504): │ 💡 Call service fully reset and reinitialized
I/flutter ( 7504): └───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, state:ZIMConnectionState.connected, event:ZIMConnectionEvent.activeLogin, extendedData:{}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {[call invitation] onInvitationConnectionState, {state: ZegoSignalingPluginConnectionState.connected, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {connection state changed, {state: ZegoSignalingPluginConnectionState.connected, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {connectUser success.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {login success}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins login done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {setPreferenceString, key:call_app_sign, value:8380eda4e1948ce090fc836985bd3bbf2a21b6875d3f5c95f5ad73cd3b62688a.}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins init done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {plugin init finished}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {listen stream, isAdvanceInvitationMode:false, }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {remove stream}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initPlugins done}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {protocols}  {ZegoCallInvitationOfflineCallKitCacheParameterProtocol, json:, }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {offline callkit params: {invitation_id: , inviter: {id: , name: }, type: 0, call_id: , data: , accept: false, timeout: 60, datetime: 0}}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/init, params:{error: 0, start_time: 1777863803339, source: service}, }  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {waitingEnterAcceptedOfflineCallWhenInitNotDone:false, autoEnterAcceptedOfflineCall: true}  {04/05/2026 09:03:23}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params done}  {04/05/2026 09:03:23}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:23:701][Verbose][Callback] OnConversationSyncStateChanged state: 0
I/zego_jni( 7504): [2026-5-4 11:3:23:703][Verbose][Callback] OnConversationSyncStateChanged state: 1
I/PLogger ( 7504): {call-invitation}  {page manager}  {enterAcceptedOfflineCall, not waiting enter}  {04/05/2026 09:03:24}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, waitForDisconnect timeout}  {04/05/2026 09:03:24}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:49:332][Verbose][Callback] OnCallInvitationReceived: call id: 5119987818931460900,inviter: cmntym2og00031wbgt2z0knsz
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUIKitCallPlugin( 7504): onMethodCall: startMonitoringAudioRoute
D/ZegoUIKitCallPlugin( 7504): Audio route monitoring started (BroadcastReceiver)
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUIKitCallPlugin( 7504): Audio route broadcast received: android.media.ACTION_SCO_AUDIO_STATE_UPDATED
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
D/ZegoUIKitCallPlugin( 7504): 🔊 Audio route changed
D/ZegoUIKitCallPlugin( 7504): Event: android.media.ACTION_SCO_AUDIO_STATE_UPDATED
D/ZegoUIKitCallPlugin( 7504): Speakerphone: false
D/ZegoUIKitCallPlugin( 7504): BluetoothSco: false
D/ZegoUIKitCallPlugin( 7504): WiredHeadset: false
D/ZegoUIKitCallPlugin( 7504): Mode: 0
D/ZegoUIKitCallPlugin( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallInvitationReceived, invitationID:5119987818931460900, info:ZIMCallInvitationReceivedInfo{timeout:60, inviter:cmntym2og00031wbgt2z0knsz, caller:cmntym2og00031wbgt2z0knsz, extendedData:{"inviter_id":"cmntym2og00031wbgt2z0knsz","inviter_name":"gruff P","type":0,"data":"{\"call_id\":\"cmonydmqe001cj3qnbogh4s20_1777863827928\",\"inviter_name\":\"gruff P\",\"invitees\":[{\"user_id\":\"cmogzn2620001ytqnylkf4tgh\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, createTime:1777863827417, mode:ZIMCallInvitationMode.general, callUserList:[ZIMCallUserInfo{userID:cmntym2og00031wbgt2z0knsz, state:ZIMCallUserState.accepted, extendedData:}, ZIMCallUserInfo{userID:cmogzn2620001ytqnylkf4tgh, state:ZIMCallUserState.inviting, extendedData:}] }  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onIncomingInvitationReceived, {invitationID: 5119987818931460900, mode:ZegoSignalingPluginInvitationMode.general, inviterID: cmntym2og00031wbgt2z0knsz, timeoutSecond: 60, createTime:1777863827417, callUserList:[{userID:cmntym2og00031wbgt2z0knsz, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:}, {userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.inviting, extended data:}], extendedData: {"inviter_id":"cmntym2og00031wbgt2z0knsz","inviter_name":"gruff P","type":0,"data":"{\"call_id\":\"cmonydmqe001cj3qnbogh4s20_1777863827928\",\"inviter_name\":\"gruff P\",\"invitees\":[{\"user_id\":\"cmogzn2620001ytqnylkf4tgh\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}}}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {add invitation data id:5119987818931460900, type:0, inviter id:cmntym2og00031wbgt2z0knsz, invitees:(userid :cmogzn2620001ytqnylkf4tgh, state:InvitationState.waiting), data:{"call_id":"cmonydmqe001cj3qnbogh4s20_1777863827928","inviter_name":"gruff P","invitees":[{"user_id":"cmogzn2620001ytqnylkf4tgh","user_name":"Service Provider"}],"timeout":60,"custom_data":"","v":"f1.0"}, resourceID:}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:invitationReceived, params:{call_id: 5119987818931460900, inviter: cmntym2og00031wbgt2z0knsz, extended_data: {"inviter_id":"cmntym2og00031wbgt2z0knsz","inviter_name":"gruff P","type":0,"data":"{\"call_id\":\"cmonydmqe001cj3qnbogh4s20_1777863827928\",\"inviter_name\":\"gruff P\",\"invitees\":[{\"user_id\":\"cmogzn2620001ytqnylkf4tgh\",\"user_name\":\"Service Provider\"}],\"timeout\":60,\"custom_data\":\"\",\"v\":\"f1.0\"}"}, app_state: active}, }  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {on invitation received, is init:true, network state:ZegoUIKitNetworkState.online, in background: false, state:AppLifecycleState.resumed, page state:CallingState.kIdle, current invitation call id:, local inviting users: [], params:{invitation_id: 5119987818931460900, data: {"call_id":"cmonydmqe001cj3qnbogh4s20_1777863827928","inviter_name":"gruff P","invitees":[{"user_id":"cmogzn2620001ytqnylkf4tgh","user_name":"Service Provider"}],"timeout":60,"custom_data":"","v":"f1.0"}, type: 0, inviter: {id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:false, }, create_timestamp_second: 1777863827, timeout_second: 60}}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/invitationReceived, params:{call_id: 5119987818931460900, inviter: cmntym2og00031wbgt2z0knsz, app_state: active, extended_data: {"call_id":"cmonydmqe001cj3qnbogh4s20_1777863827928","inviter_name":"gruff P","invitees":[{"user_id":"cmogzn2620001ytqnylkf4tgh","user_name":"Service Provider"}],"timeout":60,"custom_data":"","v":"f1.0"}}, }  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {update invitation data:ZegoCallInvitationData:{callID: cmonydmqe001cj3qnbogh4s20_1777863827928, invitationID: 5119987818931460900, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmogzn2620001ytqnylkf4tgh, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:false, }, customData: .}}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {_waitingCallInvitationReceivedAfterCallKitIncomingAccepted:false, callkit call id:null}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {set _isRingTimerRunning to true}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-channel}  {startMonitoringAudioRoute}  {startMonitoringAudioRoute}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, showInvitationTopSheet}  {contextQuery:Closure: () => BuildContext, }  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/displayNotification, params:{call_id: 5119987818931460900, app_state: active}, }  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {✅ Android audio route monitoring started}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-channel}  {handler}  {MethodCallHandler, method:onAudioRouteChanged, arguments:{mode: 0, event: android.media.ACTION_SCO_AUDIO_STATE_UPDATED, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}.}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): 🔊 Android Audio Route Changed
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
I/PLogger ( 7504): Event: android.media.ACTION_SCO_AUDIO_STATE_UPDATED
I/PLogger ( 7504): Speakerphone: ❌ OFF
I/PLogger ( 7504): Bluetooth: ❌ OFF
I/PLogger ( 7504): Wired Headset: ❌ Disconnected
I/PLogger ( 7504): Mode: NORMAL
I/PLogger ( 7504): ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━}  {04/05/2026 09:03:49}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/zego_jni( 7504): [2026-5-4 11:3:49:474][Verbose][Callback] OnCallUserStateChanged: call id: 5119987818931460900,call user info list:1
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 Initial audio route state: {mode: 0, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(862151667) start ring, prefix:, source path:, isPlayByRingtone:false, testPlayRingtone:false, audioPlayerVolume:1.0, }  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Routing info: route=ZegoUIKitAudioRoute.receiver, isSpeaker=false}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Setting audio context to earpiece on player instance (attempt 1/4)}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio context successfully set to earpiece on attempt 1}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {local user audio route changed to ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Attempting to play audio (attempt 1/4)}  {04/05/2026 09:03:49}  {INFO}
E/PLogger ( 7504): {call-invitation}  {ringtone}  {Non-MediaPlayer error during playback: Unable to load asset: "".
E/PLogger ( 7504): The asset does not exist or has empty data.}  {04/05/2026 09:03:49}  {ERROR}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Attempting to recover from playback error by restarting ring}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [switchTo - BEFORE] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {switch to earpiece, update context}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio context is already set to earpiece, skipping switch}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.stopped, isRingTimerRunning:true, isRingtoneRunning:false, }  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.stopped}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallUserStateChanged, callUserList:({userID:cmogzn2620001ytqnylkf4tgh, state:ZIMCallUserState.received, extendedData:}),invitationID:5119987818931460900}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onInvitationUserStateChanged, {invitationID:5119987818931460900, callUserList:[{userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.received, extended data:}]}}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {onAdvanceInvitationUserStateChanged, {invitationID:5119987818931460900, callUserList:[{userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.received, extended data:}]}}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmogzn2620001ytqnylkf4tgh}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {invitation map: {}}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {on invitation user state changed, event:{invitationID:5119987818931460900, callUserList:[{userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.received, extended data:}]}}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Setting audio context to earpiece on player instance (attempt 1/3)}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio context successfully set to earpiece on attempt 1}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Restarting playback after recovery (waiting for player ready)}  {04/05/2026 09:03:49}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Waiting for AudioPlayer to be ready after context change...}  {04/05/2026 09:03:49}  {INFO}
E/PLogger ( 7504): {call-invitation}  {ringtone}  {Timeout waiting for AudioPlayer ready, proceeding anyway: TimeoutException after 0:00:03.000000: Future not completed}  {04/05/2026 09:03:52}  {WARNING}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Attempting to play audio (attempt 1/3)}  {04/05/2026 09:03:52}  {INFO}
E/PLogger ( 7504): {call-invitation}  {ringtone}  {Non-MediaPlayer error during playback: Unable to load asset: "".
E/PLogger ( 7504): The asset does not exist or has empty data.}  {04/05/2026 09:03:52}  {ERROR}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Attempting to recover from playback error by restarting ring}  {04/05/2026 09:03:52}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.stopped, isRingTimerRunning:true, isRingtoneRunning:false, }  {04/05/2026 09:03:52}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.stopped}  {04/05/2026 09:03:52}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Setting audio context to earpiece on player instance (attempt 1/3)}  {04/05/2026 09:03:52}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Audio context successfully set to earpiece on attempt 1}  {04/05/2026 09:03:52}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Restarting playback after recovery (waiting for player ready)}  {04/05/2026 09:03:52}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Waiting for AudioPlayer to be ready after context change...}  {04/05/2026 09:03:52}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:53:874][Verbose][API] callAccept. handle: 12970495528517775566, call id: 5119987818931460900, extended data: {"custom_data":"","v":"f1.0"}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation service}  {accept invitation, network state:ZegoUIKitNetworkState.online, invitationID:5119987818931460900, inviter id:cmntym2og00031wbgt2z0knsz, data:{"custom_data":"","v":"f1.0"}}  {04/05/2026 09:03:53}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {remove invitation data, invitationID: 5119987818931460900, containsKey:truemap:{5119987818931460900: id:5119987818931460900, type:0, inviter id:cmntym2og00031wbgt2z0knsz, invitees:(userid :cmogzn2620001ytqnylkf4tgh, state:InvitationState.waiting), data:{"call_id":"cmonydmqe001cj3qnbogh4s20_1777863827928","inviter_name":"gruff P","invitees":[{"user_id":"cmogzn2620001ytqnylkf4tgh","user_name":"Service Provider"}],"timeout":60,"custom_data":"","v":"f1.0"}, resourceID:}, }  {04/05/2026 09:03:53}  {INFO}
I/PLogger ( 7504): {signaling}  {invitation}  {accept invitation, invitation id:5119987818931460900, extendedData:{"custom_data":"","v":"f1.0"}}  {04/05/2026 09:03:53}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:54: 29][Verbose][Callback] OnCallAcceptanceSent: call id: 5119987818931460900, code: 0, msg: operation was successful, seq: 6
I/zego_jni( 7504): [2026-5-4 11:3:54: 31][Verbose][Callback] OnCallUserStateChanged: call id: 5119987818931460900,call user info list:1
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/ZegoUIKitCallPlugin( 7504): onMethodCall: stopMonitoringAudioRoute
D/ZegoUIKitCallPlugin( 7504): Audio route monitoring stopped
I/PLogger ( 7504): {signaling}  {invitation}  {accept invitation, done, invitation id:5119987818931460900}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {accept invitation done, invitationID:5119987818931460900}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, hideInvitationTopSheet}  {hideInvitationTopSheet}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {page manager, hideInvitationTopSheet, Navigator}  {push from hideInvitationTopSheet, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {local accept invitation, code:, message:, app in background:false}  {04/05/2026 09:03:54}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: reporterUpdateCommonParams
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/callee/respondInvitation, params:{call_id: 5119987818931460900, action: accept, app_state: active}, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:54}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: activeAppToForeground
D/ZegoUikitPlugin( 7504): active app to foreground
I/PLogger ( 7504): {call-invitation}  {machine}  {entry, page state:CallingState.kOnlineAudioVideo}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {machine, Navigator}  {push from onCallingEntry, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from State[CallingState.kIdle] to State[CallingState.kOnlineAudioVideo]}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onCallUserStateChanged, callUserList:({userID:cmogzn2620001ytqnylkf4tgh, state:ZIMCallUserState.accepted, extendedData:{"custom_data":"","v":"f1.0"}}),invitationID:5119987818931460900}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {onInvitationUserStateChanged, {invitationID:5119987818931460900, callUserList:[{userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:{"custom_data":"","v":"f1.0"}}]}}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setEngineConfig]
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {onAdvanceInvitationUserStateChanged, {invitationID:5119987818931460900, callUserList:[{userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:{"custom_data":"","v":"f1.0"}}]}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {add user info, cmogzn2620001ytqnylkf4tgh}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {invitation map: {}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {on invitation user state changed, event:{invitationID:5119987818931460900, callUserList:[{userID:cmogzn2620001ytqnylkf4tgh, state:ZegoSignalingPluginInvitationUserState.accepted, extended data:{"custom_data":"","v":"f1.0"}}]}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[]}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[], }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {machine, Navigator}  {push from onCallingEntry, onInitState}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {onStateChanged, currentState:CallingState.kOnlineAudioVideo, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(862151667) stop ring, prefix:, source path:, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {stopMonitoringAudioRoute}  {stopMonitoringAudioRoute}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {create prebuilt call page, is group call:false, invitationData:ZegoCallInvitationData:{callID: cmonydmqe001cj3qnbogh4s20_1777863827928, invitationID: 5119987818931460900, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmogzn2620001ytqnylkf4tgh, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:false, }, customData: .}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {create prebuilt call page}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {calling page}  {requiredUsers.users set as ([{id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:false, }])}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setEngineConfig, info: Execution successful.
I/PLogger ( 7504): {uikit-reporter}  {create}  {appID:1683382177, params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {had created before}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {update common params}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCustomVideoProcessing]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setEngineConfig]
I/PLogger ( 7504): {call}  {prebuilt}  {mini machine state is ZegoCallMiniOverlayPageState.idle}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {init duration}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, onLocalInvitingUsersUpdated}  {localInvitingUsers:[]}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, onLocalInvitingUsersUpdated}  {no wait inviting users now, currentInvitationID:5119987818931460900, remoteUserIsEmpty:true, localIsInitiator:false, hasWaitingInvitee:false, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.p}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.minimize.p}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {add listener:Closure: (ZegoCallMiniOverlayPageState) => void from Function 'onMiniOverlayMachineStateChanged':., size:2}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
I/PLogger ( 7504): {call}  {controller.pip.p android}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {live-streaming}  {controller.screenSharing.p}  {init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {change state outside to ZegoCallMiniOverlayPageState.idle}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {mini overlay, from State[ZegoCallMiniOverlayPageState.idle] to State[ZegoCallMiniOverlayPageState.idle]}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {onAudioRouteChanged}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {audio route changed: speaker=false, earpiece=true}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {enabling proximity sensor for earpiece mode}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, checkRequiredParticipant}  {requiredUsers not enabled}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {getLeaveUsers}  {get leave users, leave users:[id:cmntym2og00031wbgt2z0knsz, name:gruff P]}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {get leave users for room:cmonydmqe001cj3qnbogh4s20_1777863827928}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {no response end timer is disabled}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {updateCommonParams}  {{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterUpdateCommonParams}  {params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/init, params:{source: page, error: 0, start_time: 1777863834060}, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {version: zego_uikit_prebuilt_call:4.23.0; zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys,
I/PLogger ( 7504): appID:1683382177,
I/PLogger ( 7504): callID:cmonydmqe001cj3qnbogh4s20_1777863827928,
I/PLogger ( 7504): userID:cmogzn2620001ytqnylkf4tgh,
I/PLogger ( 7504): userName:Nowshin Fabiha,
I/PLogger ( 7504): config:ZegoUIKitPrebuiltCallConfig:{video:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }, audioVideoView:ZegoCallAudioVideoViewConfig:{containerBuilder:null, isVideoMirror:true, showMicrophoneStateOnView:true, showCameraStateOnView:false, showUserNameOnView:true, foregroundBuilder:null, backgroundBuilder:null, useVideoViewAspectFill:true, showAvatarInAudioMode:true, showSoundWavesInAudioMode:true, }, topMenuBar:ZegoCallTopMenuBarConfig:{isVisible:false, title:, hideAutomatically:true, hideByClick:true, buttons:[], extendButtons:[], style:ZegoCallMenuBarStyle.light, padding:null, margin:null, backgroundColor:null, height:null, }, bottomMenuBar:ZegoCallBottomMenuBarConfig:{hideAutomatically:true, hideByClick:true, buttons:[ZegoCallMenuBarButtonName.toggleMicrophoneButton, ZegoCallMenuBarButtonName.hangUpButton, ZegoCallMenuBarButtonName.switchAudioOutputButton], extendButtons:[], maxCount:5, style:ZegoCallMenuBarStyle.light, padding:null, margin:null, backgroundColor:null, height:null, }, memberList:ZegoCallMemberListConfig:{showMicrophoneState:true, showCameraState:true, itemBuilder:null, }, duration:ZegoCallDurationConfig:{isVisible:true, onDurationUpdate:null, }, chatView:ZegoCallInRoomChatViewConfig:{itemBuilder:null, }, user:Instance of 'ZegoCallUserConfig', device:{enableSyncDeviceStatusBySEI:true, }, layout:Instance of 'ZegoLayoutPictureInPictureConfig', pip:ZegoCallPIPConfig:{android:ZegoCallPIPAndroidConfig:{background:null, }, iOS:ZegoCallPIPIOSConfig:{support:true, }, aspectWidth:9, aspectHeight:16, enableWhenAppBackToDesktop:true, }, screenSharing:ZegoCallScreenSharingConfig:{autoStop:ZegoCallScreenSharingAutoStopConfig:{invalidCount:3, canEnd:false, }, defaultFullScreen:false, }, noResponseEnd:ZegoCallNoResponseEndConfig:{enabled:false, timeoutSeconds:3, }, turnOnCameraWhenJoining:false, useFrontCameraWhenJoining:true, turnOnMicrophoneWhenJoining:true, useSpeakerWhenJoining:false, rootNavigator:false, advanceConfigs:{}, enableAccidentalTouchPrevention:true, foreground:null, background:null, hangUpConfirmDialog:ZegoCallHangUpConfirmDialogConfig:{info:null, titleStyle:null, contentStyle:null, actionTextStyle:null, backgroundBrightness:null, }, avatarBuilder:null, },
I/PLogger ( 7504): events:ZegoUIKitPrebuiltCallEvents:{onCallEnd:Closure: (ZegoCallEndEvent, () => void) => Future<void>, onHangUpConfirmation:null, onError:null, user:null, room:null, audioVideo:null, beauty:null, },
I/PLogger ( 7504): }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.pip.p android}  {onPIPStatusUpdated, PiPStatus.disabled, lifecycleState: AppLifecycleState.resumed}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached leave users for room:cmonydmqe001cj3qnbogh4s20_1777863827928(key:zego_uikit_leave_users_cmonydmqe001cj3qnbogh4s20_1777863827928)}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {get deleted stream users for room:cmonydmqe001cj3qnbogh4s20_1777863827928}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {no cached deleted stream users for room:cmonydmqe001cj3qnbogh4s20_1777863827928(key:zego_uikit_deleted_stream_users_cmonydmqe001cj3qnbogh4s20_1777863827928)}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, checkInvitationParticipant}  {all other members in call have left the room, ending call}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {only local user in call, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {activeAppToForeground}  {activeAppToForeground}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {default call end event, event:ZegoCallEndEvent{callID:cmonydmqe001cj3qnbogh4s20_1777863827928, kickerUserID:null, reason:ZegoCallEndReason.remoteHangUp, invitationData: ZegoCallInvitationData:{callID: cmonydmqe001cj3qnbogh4s20_1777863827928, invitationID: 5119987818931460900, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmogzn2620001ytqnylkf4tgh, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:false, }, customData: .}, }}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt, Navigator}  {pop from call end, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {⏹️ Android audio route monitoring stopped}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit}  {permission}  {Permission.microphone status: PermissionStatus.granted}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {login}  {id:"cmogzn2620001ytqnylkf4tgh", name:Nowshin Fabiha}  {04/05/2026 09:03:54}  {INFO}
E/PLogger ( 7504): {uikit-user}  {login}  {user is same}  {04/05/2026 09:03:54}  {WARNING}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCustomVideoProcessing, info: Execution successful.
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set advance configs}  {configs:{}}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setEngineConfig, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setMinVideoBitrateForTrafficControl]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setVideoMirrorMode]
D/ZEGO    ( 7504): [Flutter] [DartCall] [muteMicrophone]
D/ZEGO    ( 7504): [Flutter] [DartCall] [setAudioRouteToSpeaker]
D/ZEGO    ( 7504): [Flutter] [DartCall] [loginRoom]
I/PLogger ( 7504): {call}  {prebuilt}  {proximity cleared, restoring screen brightness and touch}  {04/05/2026 09:03:54}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: activeAppToForeground
D/ZegoUikitPlugin( 7504): active app to foreground
D/ZEGO    ( 7504): [Flutter] [DartCall] [setReverbPreset]
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopSoundLevelMonitor]
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.stopped, isRingTimerRunning:true, isRingtoneRunning:false, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.stopped}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {reset _pageManager.isCurrentInvitationFromAcceptedAndroidOffline}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {isFromAcceptedAndroidOfflineInvitation:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {enableSyncDeviceStatusByStreamExtraInfo}  {value: true}  {04/05/2026 09:03:54}  {INFO}
E/PLogger ( 7504): {uikit-service-core(618137614)}  {init}  {had init}  {04/05/2026 09:03:54}  {WARNING}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setMinVideoBitrateForTrafficControl, info: Execution successful.
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {enableCustomVideoProcessing}  {disable custom video processing, buffer type:ZegoVideoBufferType.GLTexture2D, express engineState:ZegoUIKitExpressEngineState.stop, }  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setMinVideoResolutionForTrafficControl]
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set advance configs}  {configs:{}}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setVideoMirrorMode, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: muteMicrophone, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [mutePublishStreamAudio]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setAudioRouteToSpeaker, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onRoomStateUpdate] roomID: cmonydmqe001cj3qnbogh4s20_1777863827928, state: CONNECTING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStateChanged] roomID: cmonydmqe001cj3qnbogh4s20_1777863827928, reason: LOGINING, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: loginRoom, info: Execution successful.
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.inactive}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.inactive to AppLifecycleState.inactive, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.inactive(from AppLifecycleState.inactive)}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:54}  {INFO}
D/FlutterJNI( 7504): Sending viewport metrics to the engine.
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.resumed}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.resumed to AppLifecycleState.resumed, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.resumed(from AppLifecycleState.resumed)}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setReverbPreset, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setVoiceChangerPreset]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopSoundLevelMonitor, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [logoutRoom]
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
D/ZegoUIKitCallPlugin( 7504): onMethodCall: getAudioRouteInfo
I/PLogger ( 7504): {call-invitation}  {ringtone}  {audioPlayer stop done}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {set _isRingTimerRunning to false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {isEnabled:false, express engineState:ValueNotifier<ZegoUIKitExpressEngineState>#0577a(ZegoUIKitExpressEngineState.stop), roomState:ZegoUIKitRoomState:{reason:ZegoRoomStateChangedReason.Logout, error code:0, extended data:{}, }, isPreviewing:false, isPublishingStream:false, isPlayingStream:false, }  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setMinVideoResolutionForTrafficControl, info: Execution successful.
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {state is same, ignore}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setMinVideoFpsForTrafficControl]
I/PLogger ( 7504): {call}  {prebuilt}  {video config:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {traffic control}  {enable:true, properties:[ZegoUIKitTrafficControlProperty.adaptiveResolution, ZegoUIKitTrafficControlProperty.adaptiveFPS], minimizeVideoConfig:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }, isFocusOnRemote:true, bitmask:3}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {use front facing camera}  {Already front}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {update video view mode}  {mode is equal}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-microphone}  {switch microphone}  {turn on local microphone, muteMode:false}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: mutePublishStreamAudio, info: Execution successful.
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {target is speaker:false, current audio route is:ZegoUIKitAudioRoute.receiver, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {set audio route to speaker:false}  {now audio route is:ZegoUIKitAudioRoute.receiver}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-room}  {join room}  {room id:"cmonydmqe001cj3qnbogh4s20_1777863827928", has token:false, markAsLargeRoom:false, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit}  {core data}  {clear}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {clearStream}  {clear stream}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-media}  {clear}  {clear}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {clear}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-room}  {setRoom}  {set room:"cmonydmqe001cj3qnbogh4s20_1777863827928", markAsLargeRoom:false}}  {04/05/2026 09:03:54}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
D/ZegoUikitPlugin( 7504): onMethodCall: isLockScreen
I/ZegoUikitPlugin( 7504): isLockScreen
I/PLogger ( 7504): {uikit-event}  {init}  {init}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-media}  {event}  {init}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-room}  {join room}  {try join room id:"cmonydmqe001cj3qnbogh4s20_1777863827928" by id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, isSimulated:false, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.inactive, isAppInBackground:true, isScreenLockEnabled:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, didChangeAppLifecycleState}  {is app in background: previous:false, current: true, call machine page state:CallingState.kOnlineAudioVideo, invitation data:ZegoCallInvitationData:{callID: cmonydmqe001cj3qnbogh4s20_1777863827928, invitationID: 5119987818931460900, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmogzn2620001ytqnylkf4tgh, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:false, }, customData: .}, in calling by ios background lock:false, current room info:ZegoUIKitRoom:{id:cmonydmqe001cj3qnbogh4s20_1777863827928, }}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:true}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.resumed, isAppInBackground:false, isScreenLockEnabled:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, didChangeAppLifecycleState}  {is app in background: previous:true, current: false, call machine page state:CallingState.kOnlineAudioVideo, invitation data:ZegoCallInvitationData:{callID: cmonydmqe001cj3qnbogh4s20_1777863827928, invitationID: 5119987818931460900, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmogzn2620001ytqnylkf4tgh, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:false, }, customData: .}, in calling by ios background lock:false, current room info:ZegoUIKitRoom:{id:cmonydmqe001cj3qnbogh4s20_1777863827928, }}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {app active from background, try re-login}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, initialized:true, state:ZegoSignalingPluginConnectionState.connected}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, user state is not disconnected}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {prebuilt}  {disabling proximity sensor}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {activeAppToForeground}  {activeAppToForeground}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {updateLocalInvitingUsers:[]}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {onLocalInvitingUsersUpdated, users:[], }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {clear advance invitation, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), cancel group call invitation}  {invitationData:ZegoCallInvitationData:{callID: cmonydmqe001cj3qnbogh4s20_1777863827928, invitationID: 5119987818931460900, type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: ({id:cmogzn2620001ytqnylkf4tgh, name:Service Provider, in-room attributes:{}, camera:false, microphone:false, }), inviter: {id:cmntym2og00031wbgt2z0knsz, name:gruff P, in-room attributes:{}, camera:false, microphone:false, }, customData: .}, invitingInvitees:[], }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), cancel group call invitation}  {have already some one accept, not need to cancel}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.audioVideo.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.minimize.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {remove listener:Closure: (ZegoCallMiniOverlayPageState) => void from Function 'onMiniOverlayMachineStateChanged':., size:1}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {controller.user.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setVoiceChangerPreset, info: Execution successful.
I/PLogger ( 7504): {call}  {controller.pip.p android}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [setEffectsBeautyParam]
I/PLogger ( 7504): {live-streaming}  {controller.pip.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onRoomStateUpdate] roomID: cmonydmqe001cj3qnbogh4s20_1777863827928, state: DISCONNECTED, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onRoomStateChanged] roomID: cmonydmqe001cj3qnbogh4s20_1777863827928, reason: LOGOUT, errorCode: 0
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: logoutRoom, info: Execution successful.
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-room}  {leave room}  {current room is cmonydmqe001cj3qnbogh4s20_1777863827928, target room id:null, network state:ZegoUIKitNetworkState.online, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit}  {core data}  {clear}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {clearStream}  {clear stream}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-media}  {clear}  {clear}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {core room}  {clear}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, setPendingCallPageDisposeFlag}  {needWait:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {prebuilt call page dispose, }  {04/05/2026 09:03:54}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: dismissNotification
I/call plugin( 7504): dismissNotification, id: 737542978
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {needPop:false, needHideInvitationTopSheet:true, needClearCallKit:true}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/unInit, params:{source: page}, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call}  {machine, Navigator}  {push from onCallingEntry, onDispose}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), end/quit advance invitation,}  {is not advance mode}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {needPop:false, needHideInvitationTopSheet:true, needClearCallKit:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:54}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: dismissNotification
I/call plugin( 7504): dismissNotification, id: 737542978
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setMinVideoFpsForTrafficControl, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setTrafficControlFocusOn]
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 1007022, funcName: setEffectsBeautyParam, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [onDebugError] errorCode: 1007022, funcName: setEffectsBeautyParam, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [DartCall] [stopEffectsEnv]
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableEffectsBeauty]
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCustomVideoProcessing]
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(104586380) stop ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(104586380) stop ring, prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {getAudioRouteInfo}  {getAudioRouteInfo}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setTrafficControlFocusOn, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableTrafficControl]
E/PLogger ( 7504): {uikit-stream}  {publish stream}  {room id is empty}  {04/05/2026 09:03:54}  {WARNING}
E/PLogger ( 7504): {uikit-stream}  {syncDeviceStatusByStreamExtraInfo}  {not publishing}  {04/05/2026 09:03:54}  {WARNING}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStateChanged roomID: cmonydmqe001cj3qnbogh4s20_1777863827928, reason: ZegoRoomStateChangedReason.Logining, errorCode: 0, extendedData: {}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.inactive}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.inactive to AppLifecycleState.inactive, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.inactive(from AppLifecycleState.inactive)}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.inactive}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {SystemChannels.lifecycle.MessageHandler, AppLifecycleState.resumed}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {_parseStateFromString from AppLifecycleState.resumed to AppLifecycleState.resumed, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {app lifecycle state:AppLifecycleState.resumed(from AppLifecycleState.resumed)}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {app life style:AppLifecycleState.resumed}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: stopEffectsEnv, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 1007021, funcName: enableEffectsBeauty, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [onDebugError] errorCode: 1007021, funcName: enableEffectsBeauty, info: Please refer to https://docs.zegocloud.com/article/5547 for details.
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCustomVideoProcessing, info: Execution successful.
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(862151667) stop ring, prefix:, source path:, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {cancelInvitationNotification}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelCallNotification}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {dismissNotification}  {id:737542978}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone-android-route}  {📊 [stopRing] Current audio route: {mode: 3, isSpeakerphoneOn: false, isBluetoothScoOn: false, isWiredHeadsetOn: false}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {(862151667) stop ring, prefix:, source path:, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {no ring is running, skip stop}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {cancelInvitationNotification}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelCallNotification}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {dismissNotification}  {id:737542978}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableTrafficControl, info: Execution successful.
D/ZEGO    ( 7504): [Flutter] [DartCall] [setVideoConfig]
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.inactive, isAppInBackground:true, isScreenLockEnabled:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, didChangeAppLifecycleState}  {is app in background: previous:false, current: true, call machine page state:CallingState.kOnlineAudioVideo, invitation data:ZegoCallInvitationData:{callID: , invitationID: , type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: (), inviter: null, customData: .}, in calling by ios background lock:false, current room info:ZegoUIKitRoom:{id:, }}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:true}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {AppLifecycleStateChanged, state:AppLifecycleState.resumed, isAppInBackground:false, isScreenLockEnabled:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, didChangeAppLifecycleState}  {is app in background: previous:true, current: false, call machine page state:CallingState.kOnlineAudioVideo, invitation data:ZegoCallInvitationData:{callID: , invitationID: , type: ZegoCallInvitationType.voiceCall, timeoutSeconds: 60, invitees: (), inviter: null, customData: .}, in calling by ios background lock:false, current room info:ZegoUIKitRoom:{id:, }}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {didChangeAppLifecycleState, isAppInBackground:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {app active from background, try re-login}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, initialized:true, state:ZegoSignalingPluginConnectionState.connected}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {tryReLogin, user state is not disconnected}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-beauty}  {effects}  {stop effects env}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-beauty}  {effects}  {disable beauty}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onRoomStateChanged roomID: cmonydmqe001cj3qnbogh4s20_1777863827928, reason: ZegoRoomStateChangedReason.Logout, errorCode: 0, extendedData: {}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-room}  {leave room}  {success}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-event}  {uninit}  {uninit}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-service-core}  {event}  {onEngineStateUpdate, state:ZegoEngineState.Stop, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-media}  {event}  {uninit}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:logoutRoom, params:{room_id: cmonydmqe001cj3qnbogh4s20_1777863827928, error: 0, msg: {}}, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear leave users for room:cmonydmqe001cj3qnbogh4s20_1777863827928}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear deleted stream users for room:cmonydmqe001cj3qnbogh4s20_1777863827928}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {enableCustomVideoProcessing}  {disable custom video processing, buffer type:ZegoVideoBufferType.GLTexture2D, express engineState:ZegoUIKitExpressEngineState.stop, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear leave users done for room:cmonydmqe001cj3qnbogh4s20_1777863827928}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-user}  {userCache}  {clear deleted stream users done for room:cmonydmqe001cj3qnbogh4s20_1777863827928}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {clear callkit infos}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit id}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear all callKit calls}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, hideInvitationTopSheet}  {hideInvitationTopSheet}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {restore to idle, current state:CallingState.kOnlineAudioVideo, inCallPage:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling machine to be idle}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from State[CallingState.kOnlineAudioVideo] to State[CallingState.kIdle]}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {done}  {04/05/2026 09:03:54}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: setVideoConfig, info: Execution successful.
I/PLogger ( 7504): {call-invitation}  {page manager, restore to idle}  {clear callkit infos done}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager, hideInvitationTopSheet}  {hideInvitationTopSheet}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {set video config}  {config:ZegoUIKitVideoConfig{fps:15, bitrate:600, width:360, height:640, }, streamType:ZegoStreamType.main, }  {04/05/2026 09:03:54}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: dismissNotification
I/call plugin( 7504): dismissNotification, id: 737542978
I/zego_jni( 7504): [2026-5-4 11:3:54:566][Verbose][API] logout. handle: 12970495528517775566
I/PLogger ( 7504): {call-invitation}  {service(96275378), uninit}  {service un-init}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {uninit private}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {unregister offline call isolate name server, port:156088951}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {unregister message handler:320449901}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {uninit}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelMissedCallNotification}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelCallNotification}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-channel}  {dismissNotification}  {id:737542978}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {uninit}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {set hasCallkitIncomingCauseAppInBackground:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {set waitingCallInvitationReceivedAfterCallKitIncomingAccepted:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {set waitingCallInvitationReceivedAfterCallKitIncomingRejected:false}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-minimize}  {overlay machine}  {remove listener:Closure: (ZegoCallMiniOverlayPageState) => void from Function 'onMiniOverlayMachineStateChanged':., size:1}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {remove stream}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {internal instance}  {unregister}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service.p}  {un-init by prebuilt}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {callkit service uninit}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit id}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params done}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), uninit plugins}  {uninit plugins}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {user logout, currentUserID:cmogzn2620001ytqnylkf4tgh, currentUserName:Nowshin Fabiha, }  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, current id:cmogzn2620001ytqnylkf4tgh, current name:Nowshin Fabiha, connectionState:ZIMConnectionState.connected}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, waitForDisconnect...}  {04/05/2026 09:03:54}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:54:710][Verbose][Callback] OnConnectionStateChanged: state: 0, event: 0, extended_data: {}
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, state:ZIMConnectionState.disconnected, event:ZIMConnectionEvent.success, extendedData:{}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, disconnected, clear current user}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {[call invitation] onInvitationConnectionState, {state: ZegoSignalingPluginConnectionState.disconnected, action: ZegoSignalingPluginConnectionAction.unknown, extendedData: {}}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {connection state changed, {state: ZegoSignalingPluginConnectionState.disconnected, action: ZegoSignalingPluginConnectionAction.unknown, extendedData: {}}}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {disconnected, auto logout}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {user logout, not login before.}  {04/05/2026 09:03:54}  {INFO}
I/flutter ( 7504): [core] user in-room private is not init
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, waitForDisconnect success}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {logout success}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {clear}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {logout done.}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {uninit}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {removePreferenceValue, key:call_app_sign.}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {removePreferenceValue, key:handler_info.}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {user attributes}  {user in-room uninit}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {destroy.}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {clear}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {uninit data.}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {uninit}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {uninit}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {notification data}  {uninit notification data}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {adapter}  {uninstall plugins}  {plugin type:ZegoUIKitPluginType.signaling uninstalled}  {04/05/2026 09:03:54}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/unInit, params:{source: service}, }  {04/05/2026 09:03:54}  {INFO}
D/ZegoUikitPlugin( 7504): onMethodCall: reporterUpdateCommonParams
D/permissions_handler( 7504): No permissions found in manifest for: []1
I/PLogger ( 7504): {uikit-reporter}  {create}  {appID:1683382177, params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {had created before}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {create}  {update common params}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-reporter}  {updateCommonParams}  {{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterUpdateCommonParams}  {params:{call_version: 4.23.0, user_id: cmogzn2620001ytqnylkf4tgh, platform: flutter, uikit_version: zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}, }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {versions: zego_uikit_prebuilt_call:4.23.0; zego_uikit: 2.28.46; zego_express:3.23.0.47729,mobile:platform:android, version:BE4B.251210.005 dev-keys}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {service init, appID:1683382177, userID:cmogzn2620001ytqnylkf4tgh, userName:Nowshin Fabiha, plugins:[IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }], ringtoneConfig:null, config:null, uiConfig:null, notificationConfig:ZegoCallInvitationNotificationConfig:{androidNotificationConfig:ZegoCallAndroidNotificationConfig:{callIDVisibility:true, certificateIndex:ZegoSignalingPluginMultiCertificate.firstCertificate, showFullScreen:true, call channel config:ZegoCallAndroidNotificationChannelConfig:{channelID:zego_call, channelName:Call Notifications, icon:, sound:, vibrate:true, }, missed call channel config:ZegoCallAndroidNotificationChannelConfig:{channelID:missed_call, channelName:Missed Call, icon:, sound:, vibrate:false, }, message channel config:ZegoCallAndroidNotificationChannelConfig:{channelID:zimkit_message, channelName:Chat Message, icon:, sound:, vibrate:false, }, }, iOSNotificationConfig:ZegoCallIOSNotificationConfig:{appName:Protiva502, certificateIndex:ZegoSignalingPluginMultiCertificate.firstCertificate, isSandboxEnvironment:false, systemCallingIconName:, }, }, }  {04/05/2026 09:03:55}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: createNotificationChannel
I/call plugin( 7504): create channel, channelId:zego_call,channelName:Call Notifications,soundSource:, enableVibration:true
I/call plugin( 7504): channel exist
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init data, }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init permissions}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit}  {permission}  {Permission.camera status: PermissionStatus.denied}  {04/05/2026 09:03:55}  {INFO}
E/PLogger ( 7504): {uikit}  {permission}  {Permission.camera permission not granted, PermissionStatus.denied}  {04/05/2026 09:03:55}  {ERROR}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: createNotificationChannel
I/call plugin( 7504): create channel, channelId:missed_call,channelName:Missed Call,soundSource:, enableVibration:false
I/call plugin( 7504): channel exist
I/PLogger ( 7504): {uikit}  {permission}  {Permission.microphone status: PermissionStatus.granted}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initPermissions done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init private, }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {Close The lookupIsolate or not, needClose:false, hash(null), isMainIsolatePort:false}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {register, _backgroundPort(760751303), _backgroundPort!.sendPort(84565304)}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {isolate guard}  {add port:Instance of '_ReceivePortImpl', name:bg_msg_isolate_port}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), isolate}  {register offline call isolate name server, port:760751303}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {system service}  {register message handler:320449901}  {04/05/2026 09:03:55}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: createNotificationChannel
I/call plugin( 7504): create channel, channelId:zimkit_message,channelName:Chat Message,soundSource:, enableVibration:false
I/call plugin( 7504): channel exist
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {update contextQuery in call invitation config}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {init, context:Navigator-[LabeledGlobalKey<NavigatorState>#90875](dependencies: [HeroControllerScope, InheritedCupertinoTheme, UnmanagedRestorationScope, _InheritedTheme, _LocalizationsScope-[GlobalKey#526ce]], state: NavigatorState#6ab75(tickers: tracking 2 tickers)), permissions:[ZegoCallInvitationPermission.camera, ZegoCallInvitationPermission.microphone], }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {start create channels}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-channel}  {createNotificationChannel}  {config:ZegoCallNotificationChannelConfig:{sound source:null, vibrate:true, channel id:zego_call, channel name:Call Notifications}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {createNotificationChannel of call done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-channel}  {createNotificationChannel}  {config:ZegoCallNotificationChannelConfig:{sound source:null, vibrate:false, channel id:missed_call, channel name:Missed Call}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {createNotificationChannel of missed call done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-channel}  {createNotificationChannel}  {config:ZegoCallNotificationChannelConfig:{sound source:null, vibrate:false, channel id:zimkit_message, channel name:Chat Message}}  {04/05/2026 09:03:55}  {INFO}
D/ZegoUIKitCallPlugin( 7504): onMethodCall: dismissNotification
I/call plugin( 7504): dismissNotification, id: 715191221
E/flutter ( 7504): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: 'package:audioplayers_platform_interface/src/api/audio_context.dart': Failed assertion: line 178 pos 13: 'category == AVAudioSessionCategory.playback ||
E/flutter ( 7504):                 category == AVAudioSessionCategory.playAndRecord ||
E/flutter ( 7504):                 category == AVAudioSessionCategory.multiRoute ||
E/flutter ( 7504):                 !options.contains(AVAudioSessionOptions.mixWithOthers)': You can set the option `mixWithOthers` explicitly only if the audio session category is `playAndRecord`, `playback`, or `multiRoute`.
E/flutter ( 7504): #0      _AssertionError._doThrowNew (dart:core-patch/errors_patch.dart:67:4)
E/flutter ( 7504): #1      _AssertionError._throwNew (dart:core-patch/errors_patch.dart:49:5)
E/flutter ( 7504): #2      new AudioContextIOS (package:audioplayers_platform_interface/src/api/audio_context.dart:178:13)
E/flutter ( 7504): #3      ZegoRingtone.defaultAudioContext (package:zego_uikit_prebuilt_call/src/invitation/notification/notification_ring.dart:75:14)
E/flutter ( 7504): #4      ZegoRingtone.init (package:zego_uikit_prebuilt_call/src/invitation/notification/notification_ring.dart:617:28)
E/flutter ( 7504): #5      ZegoCallInvitationPageManager.initRing (package:zego_uikit_prebuilt_call/src/invitation/pages/page_manager.dart:297:23)
E/flutter ( 7504): #6      ZegoCallInvitationPageManager.init (package:zego_uikit_prebuilt_call/src/invitation/pages/page_manager.dart:230:5)
E/flutter ( 7504): #7      ZegoCallInvitationServicePrivateImpl._initPrivate (package:zego_uikit_prebuilt_call/src/invitation/mixins/private/private.dart:192:19)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #8      ZegoUIKitPrebuiltCallInvitationService.init.<anonymous closure> (package:zego_uikit_prebuilt_call/src/invitation/service.dart:427:15)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #9      ZegoUIKitPrebuiltCallInvitationService.init (package:zego_uikit_prebuilt_call/src/invitation/service.dart:409:5)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #10     CallService.initialize (package:protiva502/core/services/call_service.dart:61:5)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #11     CallService.initializeFromStorage (package:protiva502/core/services/call_service.dart:35:5)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #12     CallService._fullReset (package:protiva502/core/services/call_service.dart:118:7)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504): #13     CallService.initialize.<anonymous closure> (package:protiva502/core/services/call_service.dart:98:11)
E/flutter ( 7504): <asynchronous suspension>
E/flutter ( 7504):
I/flutter ( 7504): [core] user in-room private init
I/PLogger ( 7504): {call-invitation}  {notification manager}  {createNotificationChannel of message done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {start request notification permission}  {04/05/2026 09:03:55}  {INFO}
D/ZEGO    ( 7504): [Flutter] [DartCall] [enableCustomVideoProcessing]
I/zego_jni( 7504): [2026-5-4 11:3:55:106][Verbose][API] login. handle: 12970495528517775566, user id: cmogzn2620001ytqnylkf4tgh, user name: Nowshin Fabiha, is_offline: 0, token:
I/PLogger ( 7504): {uikit}  {permission}  {Permission.notification status: PermissionStatus.granted}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {request notification permission result:true}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {requestPermission of notification done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {start request system alert window permission}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {notification manager}  {cancelCallNotification}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-channel}  {dismissNotification}  {id:715191221}  {04/05/2026 09:03:55}  {INFO}
D/ZEGO    ( 7504): [Flutter] [onApiCalledResult] errorCode: 0, funcName: enableCustomVideoProcessing, info: Execution successful.
I/zego_jni( 7504): [2026-5-4 11:3:55:108][Verbose][Callback] OnConnectionStateChanged: state: 1, event: 1, extended_data: {}
I/PLogger ( 7504): {call-channel}  {setAudioRouteChangedCallback}  {setAudioRouteChangedCallback, callback: true}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-channel}  {setAudioRouteChangedCallback}  {setAudioRouteChangedCallback, callback: true}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {init}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling machine to be idle}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {machine}  {calling, from null to State[CallingState.kIdle]}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {init: prefix:packages/zego_uikit_prebuilt_call/, source path:assets/invitation/audio/outgoing.mp3}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {internal instance}  {register, pageManager:Instance of 'ZegoCallInvitationPageManager', callInvitationData:Instance of 'ZegoUIKitPrebuiltCallInvitationData'}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initPrivate done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service.p}  {init by prebuilt}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313)}  {init context}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-user}  {login}  {id:"cmogzn2620001ytqnylkf4tgh", name:Nowshin Fabiha}  {04/05/2026 09:03:55}  {INFO}
E/PLogger ( 7504): {uikit-user}  {login}  {user is same}  {04/05/2026 09:03:55}  {WARNING}
I/PLogger ( 7504): {uikit-service-core(618137614)}  {enableSyncDeviceStatusByStreamExtraInfo}  {value: true}  {04/05/2026 09:03:55}  {INFO}
E/PLogger ( 7504): {uikit-service-core(618137614)}  {init}  {had init}  {04/05/2026 09:03:55}  {WARNING}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {isEnabled:false, express engineState:ValueNotifier<ZegoUIKitExpressEngineState>#0577a(ZegoUIKitExpressEngineState.stop), roomState:ZegoUIKitRoomState:{reason:ZegoRoomStateChangedReason.Logout, error code:0, extended data:{}, }, isPreviewing:false, isPublishingStream:false, isPlayingStream:false, }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {enableCustomVideoRender}  {state is same, ignore}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-stream}  {enableCustomVideoProcessing}  {disable custom video processing, buffer type:ZegoVideoBufferType.GLTexture2D, express engineState:ZegoUIKitExpressEngineState.stop, }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-camera}  {switch camera}  {turn off local camera, already off}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initContext done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {mobile system version:Instance of 'ZegoMobileSystemVersion'}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {callkit service init}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit internal instance}  {register, pageManager:Instance of 'ZegoCallInvitationPageManager'}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {offline callkit call id: null}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {set callkit variables:{CallKitInnerVariable.callIDVisibility: true, CallKitInnerVariable.showFullLockedScreen: true, CallKitInnerVariable.ringtonePath: , CallKitInnerVariable.backgroundUrl: }}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {request permission}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {register callkit incoming event listener}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initCallKit done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {init}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {install plugins}  {plugin type:ZegoUIKitPluginType.signaling install (967941468)}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
D/PushIDGenerateTools( 7504): device token:dvqnZZQNT3KgwpWo95Cpln:APA91bF3JT9rFNKFkhDsEhWqjGzFxsRIFCrwTTZwY2J_lcc61f8aL6e_JcWuQ0YFsf5AjTPl9B3FlJrBs_vx_pyNvIDNeGcl_usbaCkiYf41hGfepu0avaw
D/PushIDGenerateTools( 7504): payload:2
D/ZPNs native( 7504): onRegistered: pushid:rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ==
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {init data.}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {invitation data}  {init}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {advance invitation data}  {init}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {notification data}  {init notification data}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.beauty, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.whiteboard, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.callkit, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {adapter}  {get plugin}  {target:ZegoUIKitPluginType.signaling, current plugins:{ZegoUIKitPluginType.beauty: null, ZegoUIKitPluginType.whiteboard: null, ZegoUIKitPluginType.callkit: null, ZegoUIKitPluginType.signaling: IZegoUIKitPlugin:{type:ZegoUIKitPluginType.signaling, version:Instance of 'Future<String>', }}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins init}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {user attributes}  {user in-room init}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {signaling}  {test}  {test zim types begin}  {04/05/2026 09:03:55}  {INFO}
E/PLogger ( 7504): {signaling}  {test}  {ZegoSignalingPluginConnectionAction != ZIMConnectionEvent, ZegoSignalingPluginConnectionAction:[ZegoSignalingPluginConnectionAction.unknown, ZegoSignalingPluginConnectionAction.success, ZegoSignalingPluginConnectionAction.activeLogin, ZegoSignalingPluginConnectionAction.loginTimeout, ZegoSignalingPluginConnectionAction.interrupted, ZegoSignalingPluginConnectionAction.kickedOut, ZegoSignalingPluginConnectionAction.tokenExpired, ZegoSignalingPluginConnectionAction.unregistered], ZIMConnectionEvent:[ZIMConnectionEvent.success, ZIMConnectionEvent.activeLogin, ZIMConnectionEvent.loginTimeout, ZIMConnectionEvent.interrupted, ZIMConnectionEvent.kickedOut, ZIMConnectionEvent.tokenExpired, ZIMConnectionEvent.unregistered], }  {04/05/2026 09:03:55}  {ERROR}
I/PLogger ( 7504): {signaling}  {test}  {test zim types done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {signaling}  {init}  {create ZIM}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {signaling}  {init}  {ZIM is create before}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {create, appID:1683382177}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {try enable notification, iOSNotificationConfig:ZegoCallIOSNotificationConfig:{appName:Protiva502, certificateIndex:ZegoSignalingPluginMultiCertificate.firstCertificate, isSandboxEnvironment:false, systemCallingIconName:, }, enableIOSVoIP:false }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {setPreferenceString, key:handler_info, value:{"aid":"1683382177","tkn":"","uid":"cmogzn2620001ytqnylkf4tgh","un":"Nowshin Fabiha","isse":false,"eiv":false,"ci":1,"an":"Protiva502","ciic":false,"aci":"zego_call","acn":"Call Notifications","ai":"","as":"","av":true,"amci":"zimkit_message","amcn":"Chat Message","ams":"","ami":"","amv":false,"amdce":false,"amdcci":"missed_call","amdccn":"Missed Call","amdcs":"","amdci":"","amdcv":false,"amdnt":"Missed Call","amdncgv":"Group Video Call","amdncga":"Group Audio Call","amdncv":"Video Call","amdnca":"Audio Call"}.}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {notification data}  {enable notify when app is in the background or quit: true}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {signaling}  {notification}  {enable Notify When App Running In Background Or Quit, is iOS Sandbox Environment:false, enable iOS VoIP:false, certificate index:ZegoSignalingPluginMultiCertificate.firstCertificate, appName: Protiva502, androidChannelID: zego_call, androidChannelName: Call Notifications, androidSound: }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins init done, login...}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {login request, user id:cmogzn2620001ytqnylkf4tgh, user name:Nowshin Fabiha,has token:false}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {ready to login.}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {connectUser, id:cmogzn2620001ytqnylkf4tgh, name:Nowshin Fabiha, has token:false}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {requestFullIntentPermission done, res:true}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugin-ZegoUIKitPluginType.signaling version: zego_uikit_signaling_plugin: 2.8.20; zim:2.23.0.3574; zpns:2.8.0;}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {signaling}  {notification}  {register push done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {enable notification result: {error: null}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, state:ZIMConnectionState.connecting, event:ZIMConnectionEvent.activeLogin, extendedData:{}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {[call invitation] onInvitationConnectionState, {state: ZegoSignalingPluginConnectionState.connecting, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {connection state changed, {state: ZegoSignalingPluginConnectionState.connecting, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {signaling}  {event center zpns}  {onRegistered, registerMessage: { pushID:rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ==, errorCode:0, pushSourceType:ZPNsPushSourceType.FCM, errorMessage:, commandResult:rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ== }}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {notification registered, {pushID: rwABAQYCAwCOVVMxLjBkdnFuWlpRTlQzS2d3cFdvOTVDcGxuOkFQQTkxYkYzSlQ5ckZOS0ZraERzRWhXcWpHekZ4c1JJRkNyd1RUWndZMkpfbGNjNjFmOGFMNmVfSmNXdVEwWUZzZjVBalRQbDlCM0ZsSnJCc192eF9weU52SUROZUdjbF91c2JhQ2tpWWY0MWhHZmVwdTBhdmF3AAIQAQ==, code: 0}}  {04/05/2026 09:03:55}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:55:266][Verbose][Callback] OnConnectionStateChanged: state: 2, event: 1, extended_data: {}
I/zego_jni( 7504): [2026-5-4 11:3:55:266][Verbose][Callback] OnLoggedIn: code: 0, msg: operation was successful, seq: 7
I/zego_jni( 7504): [2026-5-4 11:3:55:266][Verbose][Callback] OnConversationTotalUnreadMessageCountUpdated: unread count: 0
I/flutter ( 7504): ┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
I/flutter ( 7504): │ #0   AppLoggerHelper.info (package:protiva502/core/utils/logging/logger.dart:15:13)
I/flutter ( 7504): │ #1   CallService.initialize (package:protiva502/core/services/call_service.dart:104:21)
I/flutter ( 7504): ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
I/flutter ( 7504): │ 💡 Call service initialized for userId=cmogzn2620001ytqnylkf4tgh
I/flutter ( 7504): └───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
I/flutter ( 7504): ┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
I/flutter ( 7504): │ #0   AppLoggerHelper.info (package:protiva502/core/utils/logging/logger.dart:15:13)
I/flutter ( 7504): │ #1   CallService._fullReset (package:protiva502/core/services/call_service.dart:124:21)
I/flutter ( 7504): ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
I/flutter ( 7504): │ 💡 Call service fully reset and reinitialized
I/flutter ( 7504): └───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
D/ZegoUikitPlugin( 7504): onMethodCall: reporterEvent
I/PLogger ( 7504): {signaling}  {event center zim}  {onConnectionStateChanged, state:ZIMConnectionState.connected, event:ZIMConnectionEvent.activeLogin, extendedData:{}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {[call invitation] onInvitationConnectionState, {state: ZegoSignalingPluginConnectionState.connected, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {connection state changed, {state: ZegoSignalingPluginConnectionState.connected, action: ZegoSignalingPluginConnectionAction.success, extendedData: {}}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {connectUser success.}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-plugin-signaling}  {core data}  {login success}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins login done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {call invitation service}  {setPreferenceString, key:call_app_sign, value:8380eda4e1948ce090fc836985bd3bbf2a21b6875d3f5c95f5ad73cd3b62688a.}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {plugin}  {plugins init done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {plugin init finished}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {listen stream, isAdvanceInvitationMode:false, }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {page manager}  {remove stream}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {initPlugins done}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {protocols}  {ZegoCallInvitationOfflineCallKitCacheParameterProtocol, json:, }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service private(431754313), init plugins}  {offline callkit params: {invitation_id: , inviter: {id: , name: }, type: 0, call_id: , data: , accept: false, timeout: 60, datetime: 0}}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {uikit-channel}  {reporterEvent}  {event:call/init, params:{error: 0, start_time: 1777863835069, source: service}, }  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {service(96275378), init}  {waitingEnterAcceptedOfflineCallWhenInitNotDone:false, autoEnterAcceptedOfflineCall: true}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {callkit}  {clear offline callkit params done}  {04/05/2026 09:03:55}  {INFO}
I/zego_jni( 7504): [2026-5-4 11:3:55:415][Verbose][Callback] OnConversationSyncStateChanged state: 0
I/zego_jni( 7504): [2026-5-4 11:3:55:418][Verbose][Callback] OnConversationSyncStateChanged state: 1
E/PLogger ( 7504): {call-invitation}  {ringtone}  {Timeout waiting for AudioPlayer ready, proceeding anyway: TimeoutException after 0:00:03.000000: Future not completed}  {04/05/2026 09:03:55}  {WARNING}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Attempting to play audio (attempt 1/3)}  {04/05/2026 09:03:55}  {INFO}
E/PLogger ( 7504): {call-invitation}  {ringtone}  {Non-MediaPlayer error during playback: Unable to load asset: "assets/".
E/PLogger ( 7504): The asset does not exist or has empty data.}  {04/05/2026 09:03:55}  {ERROR}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Skipping recovery: isRingTimerRunning=false, isRingtoneRunning=false}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Successfully recovered from playback error}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Successfully recovered from playback error}  {04/05/2026 09:03:55}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {audioPlayer initial play completed}  {04/05/2026 09:03:55}  {INFO}
E/PLogger ( 7504): {call-invitation}  {ringtone}  {has not vibrate capabilities}  {04/05/2026 09:03:55}  {WARNING}
I/PLogger ( 7504): {call-invitation}  {page manager}  {enterAcceptedOfflineCall, not waiting enter}  {04/05/2026 09:03:56}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {ring timer ended}  {04/05/2026 09:03:56}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {AudioPlayer state changed to: PlayerState.stopped, isRingTimerRunning:false, isRingtoneRunning:false, }  {04/05/2026 09:03:56}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {Player state changed to PlayerState.stopped}  {04/05/2026 09:03:56}  {INFO}
I/PLogger ( 7504): {call-invitation}  {ringtone}  {audioPlayer stop done}  {04/05/2026 09:03:56}  {INFO}
I/PLogger ( 7504): {signaling}  {user}  {disconnectUser, waitForDisconnect timeout}  {04/05/2026 09:03:56}  {INFO}
