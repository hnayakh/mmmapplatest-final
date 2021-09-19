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
import 'profilescreens/about/about.dart';
import 'profilescreens/family/family.dart';
import 'profilescreens/habbit/habits.dart';
import 'profilescreens/occupation/occupation.dart';
import 'profilescreens/religion/religion.dart';
import 'stackviewscreens/stackview/stack_view.dart';

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
        } else if (state is MoveToHome) {
          var userRepo = BlocProvider.of<SplashBloc>(context).userRepository;
          var regStep = userRepo.useDetails!.registrationStep;
          if (regStep == 2) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => About(
                      userRepository: userRepo,
                    )));
          } else if (regStep == 3) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Habit(
                      userRepository: userRepo,
                    )));
          } else if (regStep == 4) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Religion(
                      userRepository: userRepo,
                    )));
          } else if (regStep == 5) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Occupations(
                      userRepository: userRepo,
                    )));
          } else if (regStep == 6) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FamilyScreen(userRepository: userRepo)));
          } else if (regStep == 7) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FamilyScreen(userRepository: userRepo)));
          } else if (regStep == 8) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Bio(
                      userRepository: userRepo,
                    )));
          } else if (regStep == 9) {
            var profileIndex = 0;
            var likeInfoList =
                List.filled(userRepo.listProfileDetails.length, 0);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StackView(
                      userRepository: userRepo,
                      likeInfoList: likeInfoList,
                      profileIndex: profileIndex,
                    )));
          }
        }
      }),
    );
  }

  void navigateToIntroScreen() {
    Timer(Duration(seconds: 3), () {
      var userRepo = BlocProvider.of<SplashBloc>(context).userRepository;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => IntroScreen(
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
