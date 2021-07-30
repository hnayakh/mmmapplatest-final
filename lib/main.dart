import 'package:flutter/material.dart';

import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/widget_views.dart';

void main() {
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
        fontFamily: "MakeMyMarry",
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(),
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
