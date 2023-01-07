import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/simple_observer.dart';
import 'package:makemymarry/views/connects/views/audio_call.dart';
import 'package:makemymarry/views/connects/views/video_call.dart';

import 'datamodels/agora_token_response.dart';

final getIt = GetIt.instance;

final logger = Logger();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> setUpDependency() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[400],
      // navigation bar color
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark // status bar colorr
      ));
  await setUpFirebase();

  /// Flutter service
  getIt
    ..registerSingleton<ChatRepo>(ChatRepo(
        firestore: FirebaseFirestore.instance,
        chatService: FirebaseChatCore.instance))
    ..registerSingleton<UserRepository>(UserRepository());
}

setUpFirebase() async {
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, sound: true, badge: true);
  FirebaseMessaging.onMessageOpenedApp.listen(handleNotificationData);
  FirebaseMessaging.onMessage.listen(handleNotificationData);
}

void handleNotificationData(RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
  var token = AgoraToken.fromJson(message.data);

  if (message.notification != null) {
    if (message.notification!.title != "Video call") {
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => AudioCallView(
            uid: '',
            imageUrl: token.profileImage,
            userRepo: getIt<UserRepository>(),
            agoraToken: token,
          ),
        ),
      );
    } else {
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => VideoCallView(
            uid: '',
            imageUrl: token.profileImage,
            agoraToken: token,
          ),
        ),
      );
    }
  }
}
