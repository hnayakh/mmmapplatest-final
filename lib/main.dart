import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makemymarry/utils/dimens.dart';

import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/forgotpasswordscreens/forgot_password.dart';
import 'package:makemymarry/views/forgotpasswordscreens/reset_password.dart';
import 'package:makemymarry/views/profilescreens/about.dart';
import 'package:makemymarry/views/profilescreens/bio.dart';
import 'package:makemymarry/views/profilescreens/family.dart';
import 'package:makemymarry/views/profilescreens/habits.dart';
import 'package:makemymarry/views/profilescreens/occupation.dart';
import 'package:makemymarry/views/profilescreens/religion.dart';
import 'package:makemymarry/views/signinscreens/otp_screen.dart';
import 'package:makemymarry/views/signinscreens/phone_screen.dart';
import 'package:makemymarry/views/signinscreens/signin_screen1.dart';
import 'package:makemymarry/views/signupscreens/create_account_screen.dart';
import 'package:makemymarry/views/widget_views.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
// The following two lines set the android status bar to be transparent immersive. Written after component rendering, in order to assign a value after rendering, override the status bar, the MaterialApp component will override this value before rendering.
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Make My Marry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "MakeMyMarry",
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: FamilyScreen(),
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
