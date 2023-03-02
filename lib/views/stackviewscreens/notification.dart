import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';

class NotificationsSwitch extends StatefulWidget {
  final UserRepository userRepository;
  const NotificationsSwitch({Key? key, required this.userRepository})
      : super(key: key);

  @override
  _NotificationsSwitchState createState() => _NotificationsSwitchState();
}

class _NotificationsSwitchState extends State<NotificationsSwitch> {
  var index;
  bool status = false;

  void navigateToNotification() {
    print('Hello');
    // var userRepo = BlocProvider.of<SplashBloc>(context).userRepository;
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (context) => Notifications(
    //           userRepository: userRepo,
    //         )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Notifications', context: context),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 62,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.symmetric(
                          horizontal: BorderSide(color: kBorder),
                          vertical: BorderSide(color: kBorder)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notification",
                          style: MmmTextStyles.bodyMediumNotification(
                              textColor: kDark5),
                        ),
                        Container(
                            child: FlutterSwitch(
                                width: 50.0,
                                height: 30.0,
                                activeColor: Colors.pink,
                                valueFontSize: 30.0,
                                toggleSize: 20.0,
                                value: status,
                                borderRadius: 30.0,
                                padding: 3.0,
                                //showOnOff: true,
                                onToggle: (val) {
                                  setState(() {
                                    status = val;
                                  });
                                }))
                      ],
                    ),
                  )))),
    );
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }
}
