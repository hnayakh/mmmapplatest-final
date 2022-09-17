import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/saurabh/myprofile/about_profile.dart';
import 'package:makemymarry/saurabh/myprofile/add_interest.dart';
import 'package:makemymarry/saurabh/paertner_prefs.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/splash_screen.dart';
import 'package:makemymarry/views/stackviewscreens/connect/message_screen.dart';
import 'package:makemymarry/views/widget_views.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = SimpleObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[400],
      // navigation bar color
      statusBarColor: kSecondary,
      statusBarBrightness: Brightness.dark // status bar colorr
      ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  List<String> buttons = [
    'Primary Button',
    'enabledRedButton328x50bodyMedium',
    'enabledRedButton328x50heading5',
    'enabledRedButton327x50bodyMedium',
    'enabledRedButton326x50bodyMedium',
    'enabledRedButton280x42heading6',
    'disabledGreyButton328x50',
    'facebookSigninButton',
    'googleSigninButton',
    'facebookSignupButton',
    'googleSignupButton',
    'emailButton',
    'cancelButtonForgotPassword',
    'confirmButtonForgotPassword',
    'habitsEnabled',
    'habitsDisabled',
    'changePasswordSidebarNavigation',
    'logoutSidebarNavigation',
    'deleteAccountSidebarNavigation',
    'searchScreenButtons',
    'virtualDateMeetScreen',
    'cancelButtonBookYourDate',
    'cancelButtonMeet',
    'cancelButtonBookyourlocation',
    'rescheduleButtonMeet',
    'preferenceFliterScreen',
    'acceptInterestScreen',
    'cancelButtonInterestScreen',
    'rejectButtonInterestScreen',
    'verifyAccountFliterScreen',
    'interestSelected',
    'Heart Icon',
    'Meet Icon',
    'Cancel Icon',
    'Connect Icon',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Widget List',
          style: MmmTextStyles.heading5(textColor: Colors.white),
        ),
      ),
      body: Container(
        padding: kMargin16,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(buttons[index], style: MmmTextStyles.heading6()),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WidgetView(
                          pos: index,
                          title: buttons[index],
                        )));
              },
            );
          },
          itemCount: 35,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.orange,
            );
          },
        ),
      ),
    );
  }
}
