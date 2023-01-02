import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/connect_pages/call/in_app_call_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/log_sink.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class InAppCall extends StatelessWidget {
  final String name, destinationUserId, image;
  final UserRepository userRepository;

  const InAppCall(
      {Key? key,
      required this.name,
      required this.destinationUserId,
      required this.image,
      required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InAppCallBloc(userRepository, name, destinationUserId, image),
      child: InAppCallScreen(),
    );
  }
}

class InAppCallScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InAppCallScreenState();
  }
}

class InAppCallScreenState extends State<InAppCallScreen> {
  bool    isJoined  = false;
  int? _remoteUid = 0;
  bool _switch = false;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  /// Define App ID and Token
  static const APP_ID = '2408d5882f0445ec82566323785cfb66';
  static const Token =
      '0062408d5882f0445ec82566323785cfb66IADSKk57dam4anYAXotbwqSqH6/lm0R0I9vjSu3fXpxymRw69csAAAAAEAA/6Ep2zt93YgEAAQDN33di';

  @override
  void initState() {
    super.initState();
    _initEngine();
  }


  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: APP_ID,
    ));

    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter example app'),
      ),
      body: Stack(
        children: [
          Center(
            // child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _switch = !_switch;
                  });
                },
                child: Center(
                  // child: _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // // Local preview
  // Widget _renderLocalPreview() {
  //   if (_joined) {
  //     return RtcLocalView.SurfaceView();
  //   } else {
  //     return Text(
  //       'Please join channel first',
  //       textAlign: TextAlign.center,
  //     );
  //   }
  // }
  //
  // // Remote preview
  // Widget _renderRemoteVideo() {
  //   if (_remoteUid != 0) {
  //     return SurfaceView(
  //       uid: _remoteUid!,
  //       channelId: "1234",
  //     );
  //   } else {
  //     return Text(
  //       'Please wait remote user join',
  //       textAlign: TextAlign.center,
  //     );
  //   }
  // }
}
