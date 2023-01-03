import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/agora_token_response.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/myprofile/about_profile.dart';
import 'package:makemymarry/saurabh/myprofile/add_interest.dart';
import 'package:makemymarry/saurabh/filter_preference.dart';
import 'package:makemymarry/socket_io/StreamSocket.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/connects/views/audio_call.dart';
import 'package:makemymarry/views/connects/views/video_call.dart';
import 'package:makemymarry/views/splash/splash_screen.dart';
import 'package:makemymarry/views/stackviewscreens/connect/message_screen.dart';
import 'package:makemymarry/views/widget_views.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

// @dart=2.9
class SimpleObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print(bloc.state);
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print(bloc.stream.toString());
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print(change.toString());
    super.onChange(bloc, change);
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpDependency();
  Bloc.observer = SimpleObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[400],
      // navigation bar color
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark // status bar colorr
      ));
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, sound: true, badge: true);
  FirebaseMessaging.onMessageOpenedApp.listen(handleNotificationData);
  FirebaseMessaging.onMessage.listen(handleNotificationData);
  runApp(MyApp());
}
void handleNotificationData(RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
  var token = AgoraToken.fromJson(message.data);

  if(message.notification != null) {
    if (message.notification!.title != "Video Call") {
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) =>
              AudioCallView(
                uid: '',
                imageUrl: token.profileImage,
                userRepo: getIt<UserRepository>(),
                agoraToken: token,
              ),
        ),
      );
    }
    else {
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) =>
              VideoCallView(
                uid: '',
                imageUrl: token.profileImage,
                agoraToken: token,
              ),
        ),
      );
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Make My Marry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "MakeMyMarry", backgroundColor: Colors.white,
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: Splash(),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return MyHomePageState();
//   }
// }
//
// class MyHomePageState extends State<MyHomePage> {
//   List<String> buttons = [
//     'Primary Button',
//     'enabledRedButton328x50bodyMedium',
//     'enabledRedButton328x50heading5',
//     'enabledRedButton327x50bodyMedium',
//     'enabledRedButton326x50bodyMedium',
//     'enabledRedButton280x42heading6',
//     'disabledGreyButton328x50',
//     'facebookSigninButton',
//     'googleSigninButton',
//     'facebookSignupButton',
//     'googleSignupButton',
//     'emailButton',
//     'cancelButtonForgotPassword',
//     'confirmButtonForgotPassword',
//     'habitsEnabled',
//     'habitsDisabled',
//     'changePasswordSidebarNavigation',
//     'logoutSidebarNavigation',
//     'deleteAccountSidebarNavigation',
//     'searchScreenButtons',
//     'virtualDateMeetScreen',
//     'cancelButtonBookYourDate',
//     'cancelButtonMeet',
//     'cancelButtonBookyourlocation',
//     'rescheduleButtonMeet',
//     'preferenceFliterScreen',
//     'acceptInterestScreen',
//     'cancelButtonInterestScreen',
//     'rejectButtonInterestScreen',
//     'verifyAccountFliterScreen',
//     'interestSelected',
//     'Heart Icon',
//     'Meet Icon',
//     'Cancel Icon',
//     'Connect Icon',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Widget List',
//           style: MmmTextStyles.heading5(textColor: Colors.white),
//         ),
//       ),
//       body: Container(
//         padding: kMargin16,
//         child: ListView.separated(
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(buttons[index], style: MmmTextStyles.heading6()),
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => WidgetView(
//                           pos: index,
//                           title: buttons[index],
//                         )));
//               },
//             );
//           },
//           itemCount: 35,
//           separatorBuilder: (BuildContext context, int index) {
//             return Divider(
//               color: Colors.orange,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
