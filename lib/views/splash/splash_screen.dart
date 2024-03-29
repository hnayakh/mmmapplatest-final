import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/partner_preference.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profile_loader/profile_loader.dart';
import 'package:makemymarry/views/profilescreens/about/views/about.dart';
import 'package:makemymarry/views/profilescreens/bio/views/bio.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';
import 'package:makemymarry/views/profilescreens/habbit/habits.dart';
import 'package:makemymarry/views/signinscreens/signin_page.dart';
import 'package:makemymarry/views/splash/IntroductionScreen.dart';
import 'package:makemymarry/views/splash/splash_bloc.dart';
import 'package:makemymarry/views/splash/splash_event.dart';
import 'package:makemymarry/views/splash/splash_state.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../profilescreens/occupation/views/occupation.dart';
import '../profilescreens/religion/views/religion.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(userRepository: getIt<UserRepository>()),
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
          BlocProvider.of<SplashBloc>(context).add(GetUserEvent());
        }

        return Container(
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
        );
      }, listener: (context, state) {
        if (state is MoveToLogin) {
          navigateToLogin();
        } else if (state is MoveToInstructionScreen) {
          navigateToIntroScreen();
        }
        if (state is MoveToHome) {
          checkRegistrationStepAndNavigate();
        }
      }),
    );
  }

  void navigateToIntroScreen() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(SignInPage.getRoute());
    });
  }

  void navigateToLogin() {
    var userRepo = BlocProvider.of<SplashBloc>(context).userRepository;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OnBoardingPage(
          userRepository: userRepo,
        ),
      ),
    );
  }

  void checkRegistrationStepAndNavigate() {
    var userRepo = BlocProvider.of<SplashBloc>(context).userRepository;
    switch (userRepo.useDetails!.registrationStep) {
      case 10:
        {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ProfileLoader(userRepository: userRepo),
              ),
              (route) => false);
          break;
        }
      case 9:
        {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    PartnerPrefsScreen(userRepository: userRepo),
              ),
              (route) => false);
          break;
        }
      case 8:
        {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Bio(userRepository: userRepo),
              ),
              (route) => false);
          break;
        }
      case 7:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Habit(userRepository: userRepo)),
            (route) => false);
        break;
      case 6:
        {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => FamilyScreen(userRepository: userRepo)),
              (route) => false);
          break;
        }
      case 5:
        {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => FamilyScreen(userRepository: userRepo)),
              (route) => false);
          break;
        }
      case 4:
        {
          print(userRepo.useDetails!.registrationStep);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => Occupations(userRepository: userRepo)),
              (route) => false);
        }
        break;
      case 3:
        {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => Religion(userRepository: userRepo)),
              (route) => false);
          break;
        }
      case 2:
        {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => About(userRepository: userRepo)),
              (route) => false);
          break;
        }
      default:
        Navigator.of(context).pushAndRemoveUntil(
            SignInPage.getRoute(),
            (route) => false);
        break;
    }
  }
}
