import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:makemymarry/views/splash/splash_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class Hide extends StatefulWidget {
  final UserRepository userRepository;
  const Hide({Key? key, required this.userRepository}) : super(key: key);

  @override
  _HideState createState() => _HideState();
}

class _HideState extends State<Hide> {
  var index;
  bool status = false;

  void navigateToHide() {
    print('Hello');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Hide/Deactive', context: context),
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
                    "Hide/Deactive",
                    style:
                        MmmTextStyles.bodyMediumNotification(textColor: kDark5),
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
                          onToggle: (val) {
                            setState(() {
                              status = val;
                            });
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }
}
