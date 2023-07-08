import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/partner_preference.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profile_loader/profile_loader.dart';
import 'package:makemymarry/views/profilescreens/about/views/about.dart';
import 'package:makemymarry/views/profilescreens/bio/views/bio.dart';
import 'package:makemymarry/views/profilescreens/habbit/habits.dart';
import 'package:makemymarry/views/profilescreens/occupation/views/occupation.dart';
import 'package:makemymarry/views/profilescreens/religion/views/religion.dart';
import 'package:makemymarry/views/signinscreens/signin_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/icons.dart';
import '../../profilescreens/family/family.dart';
import 'mobile_verification_bloc.dart';
import 'mobile_verification_event.dart';
import 'mobile_verification_state.dart';

class MobileVerification extends StatelessWidget {
  final UserRepository userRepository;
  final String phone;
  final String dialCode;
  final OtpType otpType;

  const MobileVerification(
      {Key? key,
      required this.dialCode,
      required this.phone,
      required this.userRepository,
      required this.otpType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MobileVerificationBloc(
          userRepository, this.dialCode, this.phone, this.otpType),
      child: MobileVerificationScreen(),
    );
  }
}

class MobileVerificationScreen extends StatefulWidget {
  @override
  _MobileVerificationScreenState createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  String currentText = '';
  bool canResend = false;
  late String phone;
  late String dialCode;
  final TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MmmButtons.appbarThin(),
      body: BlocConsumer<MobileVerificationBloc, MobileVerificationState>(
        listener: (context, state) {
          if (state is OnSignIn) {
            navigateToProfileSetup();
          }
          if (state is OnRegister) {
            navigateToProfileSetup();
          }
          if (state is OnError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: kError,
            ));
          }
          if (state is OnOtpGenerated) {
            this.canResend = false;
            timer = null;
            this.remaining = 60;
          }
        },
        builder: (context, state) {
          this.dialCode =
              BlocProvider.of<MobileVerificationBloc>(context).dialCode;
          this.phone = BlocProvider.of<MobileVerificationBloc>(context).mobile;
          return Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 32,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            child: ShaderMask(
                              shaderCallback: (bounds) => RadialGradient(
                                center: Alignment.center,
                                radius: 0.5,
                                colors: [kPrimary, kSecondary],
                                tileMode: TileMode.mirror,
                              ).createShader(bounds),
                              child: SvgPicture.asset(
                                'images/leftArrow.svg',
                                color: Colors.white,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.5),
                      child: Text(
                        'Mobile Verification',
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.heading2(textColor: kDark5),
                      ),
                    ),
                    // SizedBox(
                    //   height: 6,
                    // ),
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 1, 0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                    child: Text(
                              'We have sent a 6 digit verification code on your \nregistered number +$dialCode-${phone}',
                              style: TextStyle(
                                  fontFamily: 'MakeMyMarry', fontSize: 14),
                              textScaleFactor: 1.0,
                            ))),
                            Container(
                                margin: EdgeInsets.only(right: 25, top: 5),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: MmmIcons.editIcon(),
                                ))
                          ],
                        )),
                    SizedBox(
                      height: 32,
                    ),
                    PinCodeTextField(
                      controller: pincodeController,
                      textStyle:
                          MmmTextStyles.heading3(textColor: Colors.pinkAccent),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      length: 6,
                      obscureText: false,
                      pinTheme: PinTheme(
                        activeFillColor: kWhite,
                        selectedFillColor: kWhite,
                        inactiveFillColor: kWhite,
                        activeColor: gray3,
                        selectedColor: gray3,
                        inactiveColor: gray3,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(6),
                        borderWidth: 1,
                      ),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: this.canResend
                            ? MmmButtons.enabledRedButtonbodyMedium(
                                44, 'Resend OTP', action: () {
                                BlocProvider.of<MobileVerificationBloc>(context)
                                    .add(GenerateOtp());
                              })
                            : builTimer()),
                    SizedBox(
                      height: 16,
                    ),
                    currentText.length < 6
                        ? Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: MmmButtons.disabledGreyButton(44, 'Sign in'))
                        : Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: MmmButtons.enabledRedButton50bodyMedium(
                                'Sign in', action: () {
                              BlocProvider.of<MobileVerificationBloc>(context)
                                  .add(OnOtpverification(
                                currentText,
                              ));
                            }))
                  ],
                ),
              ),
              state is OnLoading ? MmmWidgets.buildLoader(context) : Container()
            ],
          );
        },
      ),
    );
  }

  void navigateToProfileSetup() {
    var userRepo = getIt<UserRepository>();
    switch (userRepo.useDetails!.registrationStep) {
      case 10:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => ProfileLoader(
                      userRepository: userRepo,
                      firstTime: true,
                    )),
            (route) => false);
        break;
      case 11:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => ProfileLoader(
                      userRepository: userRepo,
                      firstTime: true,
                    )),
            (route) => false);
        break;
      case 9:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => PartnerPrefsScreen(
                      userRepository: userRepo,
                    )),
            (route) => false);
        break;
      case 8:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Bio(userRepository: userRepo)),
            (route) => false);
        break;
      case 7:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Habit(userRepository: userRepo)),
            (route) => false);
        break;
      // case 6:
      //   break;
      case 5:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => FamilyScreen(userRepository: userRepo)),
            (route) => false);
        break;
      case 4:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Occupations(userRepository: userRepo)),
            (route) => false);

        break;
      case 3:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Religion(userRepository: userRepo)),
            (route) => false);
        break;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => About(userRepository: userRepo)),
            (route) => false);
        break;
      default:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInPage()),
            (route) => false);
        break;
    }
  }

  Timer? timer;
  int remaining = 60;

  Widget builTimer() {
    if (timer == null) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        // setState(() {
        //   remaining = timer.tick;
        // });
        if (remaining == 0) {
          timer.cancel();
          setState(() {
            this.canResend = true;
            remaining = 60;
          });
        } else {
          setState(() {
            remaining -= 1;
          });
        }
      });
    }
    return Container(
      height: 44,
      alignment: Alignment.center,
      child: Text(
        '0:${remaining < 10 ? "0$remaining" : remaining}',
        textScaleFactor: 1.0,
        textAlign: TextAlign.center,
        style: MmmTextStyles.bodyRegular(textColor: kPrimary),
      ),
    );
  }
}
