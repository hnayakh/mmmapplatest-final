import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:makemymarry/bloc/splash/splash_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class Account extends StatefulWidget {
  final UserRepository userRepository;
  const Account({Key? key, required this.userRepository}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
        appBar: MmmButtons.appBarCurved('Account', context: context),
        body: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(children: [
            MmmButtons.changePasswordSidebarNavigation(),
            SizedBox(height: 20),
            MmmButtons.logoutSidebarNavigation(),
            SizedBox(height: 20),
            MmmButtons.deleteAccountSidebarNavigation()
          ]),
        ));
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }
}