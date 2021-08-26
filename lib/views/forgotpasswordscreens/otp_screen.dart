import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/forgotpasswordscreens/reset_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'otp_screen_bloc.dart';
import 'otp_screen_event.dart';
import 'otp_screen_state.dart';

class Otp extends StatelessWidget {
  final UserRepository userRepository;
  final String email;

  const Otp({Key? key, required this.userRepository, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpScreenBloc(userRepository),
      child: OtpScreen(
        email: email,
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String currentText = '';

  bool canResend = false;

  final TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appbarThin(),
      body: BlocConsumer<OtpScreenBloc, OtpScreenState>(
        listener: (context, state) {
          if (state is NavigateToReset) {
            navigateToResetPassword();
          }
          if (state is OnOtpGenerated) {
            this.canResend = false;
            timer = null;
            this.remaining = 60;
            pincodeController.text = '';
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 32,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: InkWell(
                      onTap: () {},
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
                      )),
                ),
                SizedBox(
                  height: 26,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.5),
                  child: Text(
                    'OTP Verification',
                    style: MmmTextStyles.heading2(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    'We have sent a 6 digit verification code on \nyour registered email id',
                    style: MmmTextStyles.bodySmall(textColor: gray3),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                PinCodeTextField(
                  controller: pincodeController,
                  textStyle:
                      MmmTextStyles.heading3(textColor: Colors.pinkAccent),
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    // fieldHeight: 60,
                    // fieldWidth: 60,
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
                            BlocProvider.of<OtpScreenBloc>(context)
                                .add(GenerateOtp(widget.email));
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
                          BlocProvider.of<OtpScreenBloc>(context)
                              .add(OnOtpverification(
                            widget.email,
                            pincodeController.text.trim(),
                          ));
                        }))
                //  TweenAnimationBuilder(
                //   tween: Tween(begin: 30.0, end: 0),
                //    duration: Duration(seconds: 30),
                //    builder: (context, value, child) => Column(
                //     children: [
                //    SizedBox(
                //    height: 82,
                // ),
                // Container(
                //   margin: EdgeInsets.only(left: 190),
                //   child: value! > 10
                //       ? GradientText(
                //           "0:",
                //           style: MmmTextStyles.bodyMedium(),
                //           colors: [kPrimary, kSecondary],
                //         )
                //       : GradientText(
                //           "0:0",
                //           style: MmmTextStyles.bodyMedium(),
                //           colors: [kPrimary, kSecondary],
                //         ),
                // ),
                //SizedBox(
                //    height: 24,
                // )
                //  ],
                //   )
                // : Column(
                //     children: [
                //       SizedBox(
                //         height: 66,
                //       ),
                //       Container(
                //         margin: EdgeInsets.only(left: 17, right: 16),
                //         child: MmmButtons.enabledRedButton50bodyMedium(
                //             'Resend OTP'),
                //       ),
                //       SizedBox(
                //         height: 16,
                //       )
                //     ],
                //   ),
                //    ),
                // currentText.length < 4
                //      ? Container(
                //           margin: EdgeInsets.only(left: 17, right: 16),
                //           child: MmmButtons.disabledGreyButton(50, 'Confirm'))
                //       : Container(
                //           margin: EdgeInsets.only(left: 17, right: 16),
                //           child: MmmButtons.enabledRedButton50bodyMedium('Confirm',
                //               action: () {
                //             navigateToResetPassword();
                //           }))
              ],
            ),
          );
        },
      ),
    );
  }

  void navigateToResetPassword() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ResetPassword()));
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
