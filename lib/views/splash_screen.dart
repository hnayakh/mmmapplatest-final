import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/splash/splash_bloc.dart';
import 'package:makemymarry/bloc/splash/splash_event.dart';
import 'package:makemymarry/bloc/splash/splash_state.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/bio/bio.dart';
import 'package:makemymarry/views/signinscreens/signin_screen1.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'intro.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
        if (state is SplashScreenInitialState) {
          BlocProvider.of<SplashBloc>(context).add(GetUserState());
        }
        return Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "images/app_loader2.gif",
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  GradientText("Make My Marry",
                      style: MmmTextStyles.heading1(),
                      textAlign: TextAlign.center,
                      colors: [kPrimary, kSecondary])
                ],
              ),
            ),
            // Center(
            //   child: Platform.isAndroid
            //       ? CircularProgressIndicator(
            //           valueColor: AlwaysStoppedAnimation(kPrimary),
            //         )
            //       : CupertinoActivityIndicator(
            //           animating: true,
            //         ),
            // )
          ],
        );
      }, listener: (context, state) {
        if (state is MoveToLogin) {
          navigateToLogin();
        } else if (state is MoveToInstructionScreen) {
          navigateToIntroScreen();
        }
      }),
    );
  }

  void navigateToIntroScreen() {
    Timer(Duration(seconds: 3), () {
      var userRepo = BlocProvider.of<SplashBloc>(context).userRepository;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Bio(
                userRepository: userRepo,
              )));

    });
  }

  void navigateToLogin() {
    var userRepo = BlocProvider.of<SplashBloc>(context).userRepository;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SignIn(
              userRepository: userRepo,
            )));
  }
}
