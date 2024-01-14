import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/agora_token_response.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/utility_service.dart';
import 'package:permission_handler/permission_handler.dart';

/// JoinChannelAudio Example
class AudioCallView extends StatefulWidget {
  /// Construct the [AudioCallView]
   AudioCallView(
      {Key? key,
      required this.uid,
      required this.imageUrl,
      required this.userRepo,
      this.agoraToken})
      : super(key: key);

  final String uid;
  final String imageUrl;
  final UserRepository userRepo;
  AgoraToken? agoraToken;
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AudioCallView> {
  late final RtcEngine _engine;
  String channelId = "test";
  bool isJoined = false, openMicrophone = false, enableSpeakerphone = false;

  var _maxSeconds = 1800;

  int timeLeft = 0;

  var timer;
  startTimer() {
    timeLeft = _maxSeconds;
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        timeLeft--;
      });
      if (timeLeft < 0) {
        await _engine.leaveChannel();
        context.navigate.pop();
        timer.cancel();
      }
    });
  }

  var pageLeft = false;
  @override
  void initState() {
    super.initState();
    if(widget.agoraToken != null) {
      FirebaseFirestore.instance.collection('activeCalls').doc(
          widget.agoraToken!.notificationId).snapshots().listen((event) {
        if (!event.data()?['status']) {
          _leaveChannel();
        }
      });
    }
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
    timer.cancel();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: '2408d5882f0445ec82566323785cfb66',
    ));

    _engine.registerEventHandler(
        RtcEngineEventHandler(onError: (ErrorCodeType err, String msg) {
      UtilityService.cprint(msg);
    }, onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
      UtilityService.cprint(
          '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');

      setState(() {
        isJoined = true;
      });
    }, onUserJoined: (RtcConnection connection, int elapsed, int a) {
      UtilityService.cprint(
          '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
      startTimer();
    }, onLeaveChannel: (RtcConnection connection, RtcStats stats) {
      UtilityService.cprint(
          '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');

      setState(() {
        isJoined = false;
      });
    }, onUserOffline: (connection, uid, reason) {
      if (reason == UserOfflineReasonType.userOfflineQuit ||
          reason == UserOfflineReasonType.userOfflineDropped) {
        _leaveChannel();
      }
    }));

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
    if (widget.agoraToken != null) {
      _joinChannel(
          widget.agoraToken!.agoraToken, widget.agoraToken!.channelName);
    } else {
      var res =
          widget.userRepo.generateAgoraToken(widget.uid, CallType.audioCall);
      res.then((value) async {
        if (value.status == AppConstants.SUCCESS) {
          widget.agoraToken = value.token;
          if(value.token!= null) {
            FirebaseFirestore.instance.collection('activeCalls').doc(
                value.token!.notificationId).snapshots().listen((event) {
              if (!event.data()?['status']) {
                _leaveChannel();
              }
            });
          }
          _joinChannel(value.token!.agoraToken, value.token!.channelName);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something went wrong on our side. Please try again later."), backgroundColor: kError,));

          await Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pop();
        }
      }).onError((error, stackTrace) async {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something went wrong on our side. Please try again later."), backgroundColor: kError,));

        await Future.delayed(Duration(seconds: 2));
        Navigator.of(context).pop();
      });
    }
  }

  _joinChannel(String token, String channelId) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine.joinChannel(
      token: token,
      channelId: channelId,
      uid: 0,
      options: ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  _leaveChannel() async {
    if(!pageLeft){
      context.navigate.pop();
      pageLeft = true;
    }
    await _engine.leaveChannel();
    setState(() {
      isJoined = false;
      openMicrophone = false;
      enableSpeakerphone = false;
    });
    await FirebaseFirestore.instance.collection('activeCalls').doc(
        widget.agoraToken?.notificationId).update({'status': false});

  }

  _switchMicrophone() async {
    await _engine.muteLocalAudioStream(!openMicrophone);
    setState(() {
      openMicrophone = !openMicrophone;
    });
  }

  _switchSpeakerphone() async {
    _engine.setEnableSpeakerphone(!enableSpeakerphone);
    await _engine.setDefaultAudioRouteToSpeakerphone(!enableSpeakerphone);
    setState(
      () {
        enableSpeakerphone = !enableSpeakerphone;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                opacity: 0.4,
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(
              flex: 2,
            ),
            Text(
              timeLeft <= 0
                  ? "Connecting ..."
                  : "${(timeLeft ~/ 60).toString().padLeft(2, "0")}:${(timeLeft % 60).toString().padLeft(2, "0")}",
              textAlign: TextAlign.center,
              style: TextStyle( fontFamily: 'MakeMyMarry', 
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(
              flex: 4,
            ),
            Row(
              children: [
                Spacer(),
                _buildIconButton(
                    onTap: _leaveChannel,
                    icon: Icons.call_end_rounded,
                    bgColor: Colors.red,
                    iconColor: Colors.white),
                SizedBox(
                  width: 12,
                ),
                _buildIconButton(
                    onTap: _switchMicrophone,
                    iconColor: Colors.white,
                    icon: !openMicrophone ? Icons.mic : Icons.mic_off_rounded),
                SizedBox(
                  width: 12,
                ),
                _buildIconButtonSvg(
                    onTap: _switchSpeakerphone,
                    icon: enableSpeakerphone
                        ? 'images/speaker_off.svg'
                        : 'images/speaker_on.svg'),
                Spacer(),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  _buildIconButton(
      {required void Function() onTap,
      required IconData icon,
      Color bgColor = Colors.white,
      Color iconColor = Colors.black87}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration:
            BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(
                colors: [kPrimary,kSecondary]
            ), boxShadow: [
          BoxShadow(color: Colors.black45, offset: Offset(4, 4), blurRadius: 12)
        ]),
        child: Icon(
          icon,
          color: iconColor,
          size: 36,
        ),
      ),
    );
  }
  _buildIconButtonSvg(
      {required void Function() onTap,
      required String icon,
      Color bgColor = Colors.white,
      Color iconColor = Colors.black87}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration:
            BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(
                colors: [kPrimary,kSecondary]
            ), boxShadow: [
          BoxShadow(color: Colors.black45, offset: Offset(4, 4), blurRadius: 12)
        ]),
        child: SvgPicture.asset(
          icon,
          height: 36,
          width: 36,
        ),
      ),
    );
  }
}
