import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/agora_token_response.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/alert.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/utility_service.dart';
import 'package:permission_handler/permission_handler.dart';

/// JoinChannelAudio Example
class VideoCallView extends StatefulWidget {
  /// Construct the [VideoCallView]
  VideoCallView(
      {Key? key, required this.uid, required this.imageUrl, this.agoraToken})
      : super(key: key);

  AgoraToken? agoraToken;
  final String uid;
  final String imageUrl;
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<VideoCallView> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  String channelId = "test";
  bool isJoined = false,
      openMicrophone = false,
      switchCamera = true,
      switchRender = true;
  Set<int> remoteUid = {};

  bool _isUseFlutterTexture = false;
  bool _isUseAndroidSurfaceView = false;
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileCommunication;

  var _maxSeconds = 1800;
  var pageLeft = false;
  int timeLeft = 0;

  var timer;
  @override
  void initState() {
    super.initState();
    if (widget.agoraToken != null) {
      FirebaseFirestore.instance
          .collection('activeCalls')
          .doc(widget.agoraToken!.notificationId)
          .snapshots()
          .listen((event) {
        if (!event.data()?['status']) {
          _leaveChannel();
        }
      });
    }
    requestCameraPosition();
  }

  Future<void> requestCameraPosition() async {
    var permission = await Permission.camera.status;
    if (permission != PermissionStatus.granted) {
      permission = await Permission.camera.request();
      // while (permission != PermissionStatus.granted) {
        await Alert.message(
          navigatorKey.currentContext!,
          message: 'Please enable camera in settings of the app',
          popsAutomatically: false,
          barrierDismissible: false,
          onPressed: () async {
            permission = await Permission.camera.status;
            if (permission == PermissionStatus.granted) {
              context.navigate.pop();
              // navigatorKey.currentState?.pop();
            } else {
              await openAppSettings();
            }
          },
        );
      // }
    }
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    timer?.cancel();
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: '2408d5882f0445ec82566323785cfb66',
    ));

    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        UtilityService.cprint('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        UtilityService.cprint(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        UtilityService.cprint(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {
          startTimer();
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
        });
        if (reason == UserOfflineReasonType.userOfflineQuit ||
            reason == UserOfflineReasonType.userOfflineDropped) {
          _leaveChannel();
        }
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        UtilityService.cprint(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));

    await _engine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
        bitrate: 0,
      ),
    );

    await _engine.enableVideo();

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
    if (widget.agoraToken == null) {
      var res = getIt<UserRepository>()
          .generateAgoraToken(widget.uid, CallType.videoCall);
      res.then((value) async {
        if (value.status == AppConstants.SUCCESS) {
          channelId = value.token!.channelName;
          widget.agoraToken = value.token;
          if (value.token != null) {
            FirebaseFirestore.instance
                .collection('activeCalls')
                .doc(value.token!.notificationId)
                .snapshots()
                .listen((event) {
              if (!event.data()?['status']) {
                _leaveChannel();
              }
            });
          }
          _joinChannel(value.token!.agoraToken, value.token!.channelName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Something went wrong on our side. Please try again later."), backgroundColor: kError,));
          await Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pop();
        }
      }).onError((error, stackTrace) async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Something went wrong on our side. Please try again later."), backgroundColor: kError,));
        await Future.delayed(Duration(seconds: 2));
        Navigator.of(context).pop();
      });
    } else {
      channelId = widget.agoraToken!.channelName;
      _joinChannel(
          widget.agoraToken!.agoraToken, widget.agoraToken!.channelName);
    }
  }

  Future<void> _joinChannel(String token, String channelId) async {
    await _engine.joinChannel(
      token: token,
      channelId: channelId,
      uid: 0,
      options: ChannelMediaOptions(
        channelProfile: _channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    if(!pageLeft){
      context.navigate.pop();
      pageLeft = true;
    }
    await _engine.leaveChannel();
    setState(() {
      isJoined = false;
      openMicrophone = true;
      switchCamera = true;
    });
    await FirebaseFirestore.instance
        .collection('activeCalls')
        .doc(widget.agoraToken?.notificationId)
        .update({'status': false});

  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  startTimer() {
    timeLeft = _maxSeconds;
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        timeLeft--;
      });
      if (timeLeft < 0) {
        timer.cancel();
        await _engine.leaveChannel();
        context.navigate.pop();
      }
    });
  }

  _switchMicrophone() async {
    await _engine.muteLocalAudioStream(!openMicrophone);
    setState(() {
      openMicrophone = !openMicrophone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            remoteUid.length > 0
                ? AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: _engine,
                      canvas: VideoCanvas(uid: remoteUid.first),
                      connection: RtcConnection(channelId: channelId),
                      useFlutterTexture: _isUseFlutterTexture,
                      useAndroidSurfaceView: _isUseAndroidSurfaceView,
                    ),
                  )
                : Image(
                    height: MediaQuery.of(context).size.height,
                    image: NetworkImage(widget.imageUrl),
                    opacity: AlwaysStoppedAnimation<double>(0.4),
                    fit: BoxFit.cover),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    Spacer(),
                    !_isReadyPreview
                        ? Container()
                        : SizedBox(
                            width: 110,
                            height: 160,
                            child: AgoraVideoView(
                              controller: VideoViewController(
                                rtcEngine: _engine,
                                canvas: const VideoCanvas(uid: 0),
                                useFlutterTexture: _isUseFlutterTexture,
                                useAndroidSurfaceView: _isUseAndroidSurfaceView,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 24,
                    )
                  ],
                ),
                Spacer(
                  flex: 1,
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
                        icon: !openMicrophone
                            ? Icons.mic
                            : Icons.mic_off_rounded),
                    SizedBox(
                      width: 12,
                    ),
                    SvgPicture.asset('images/switch_camera_icon.svg',),
                    Spacer(),
                  ],
                ),
                Spacer(),
              ],
            ),
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
            BoxDecoration(shape: BoxShape.circle,gradient: LinearGradient(
              colors: [kPrimary,kSecondary]
            ) , boxShadow: [
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
}
