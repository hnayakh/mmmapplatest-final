import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:makemymarry/bloc/splash/splash_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/hexcolor.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/signinscreens/signin_screen1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  final UserRepository userRepository;
  const Account({Key? key, required this.userRepository}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var index;
  bool status = false;
  var primaryColor = HexColor('C9184A');

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
        appBar: MmmButtons.appBarCurved('Delete Account', context: context),
        body: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(children: [
            // MmmButtons.changePasswordSidebarNavigation(),
            // SizedBox(height: 20),
            // MmmButtons.logoutSidebarNavigation(
            //   action: () {
            //     print("object");
            //     _deleteAppDir()
            //         .then((value) => Navigator.of(context).pushReplacement(
            //               MaterialPageRoute(
            //                   builder: (context) => SignIn(
            //                         userRepository: UserRepository(),
            //                       )),
            //             ));
            //   },
            // ),
            SizedBox(height: 20),
            MmmButtons.deleteAccountSidebarNavigation(action: () {
              deleteDilogue();
            })
          ]),
        ));
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }

  void deleteDilogue() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Colors.white,
            title: const Text("Delete Account ",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                  children: <TextSpan>[
                    new TextSpan(text: 'Are you want to Delete your account?'),
                  ],
                )),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MmmButtons.primaryButtonMeetGray("Cancel", () {
                    Navigator.of(context).pop();
                    // navigateToHome(state);
                  }),
                  SizedBox(width: 10.0),
                  MmmButtons.primaryButtonMeet("Delete", () {
                    Navigator.of(context).pop();
                    // navigateToHome(state);
                  })
                ],
              ),
              SizedBox(height: 15)
            ],
          );
        });
  }

  Future<void> _deleteAppDir() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
