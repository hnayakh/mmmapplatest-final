import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/about/about.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import 'mobile_verification_bloc.dart';
import 'mobile_verification_event.dart';
import 'mobile_verification_state.dart';

class MobileVerification extends StatelessWidget {
  final UserRepository userRepository;
  final String phone;
  final String dialCode;

  const MobileVerification(
      {Key? key,
      required this.dialCode,
      required this.phone,
      required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MobileVerificationBloc(userRepository),
      child: MobileVerificationScreen(
        dialCode: dialCode,
        phone: phone,
      ),
    );
  }
}

class MobileVerificationScreen extends StatefulWidget {
  final String phone;
  final String dialCode;
  MobileVerificationScreen({
    Key? key,
    required this.dialCode,
    required this.phone,
  }) : super(key: key);

  @override
  _MobileVerificationScreenState createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  String currentText = '';

  _MobileVerificationScreenState({
    Key? key,
  }) : super();
  final TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appbarThin(),
      body: BlocConsumer<MobileVerificationBloc, MobileVerificationState>(
        listener: (context, state) {
          if (state is OnSignIn) {
            navigateToProfileSetup();
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
                    'Mobile Verification',
                    style: MmmTextStyles.heading2(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    'We have sent a 6 digit verification code on your \nregistered number +91-${widget.phone}',
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
                    borderRadius: BorderRadius.circular(6.67),
                    borderWidth: 1,
                    fieldHeight: 60,
                    fieldWidth: 60,
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
                TweenAnimationBuilder(
                    tween: Tween(begin: 30.0, end: 0),
                    duration: Duration(seconds: 30),
                    builder: (context, value, child) => Column(
                          children: [
                            SizedBox(
                              height: 82,
                            ),
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
                            SizedBox(
                              height: 24,
                            )
                          ],
                        )
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
                    ),
                currentText.length < 6
                    ? Container(
                        margin: EdgeInsets.only(left: 17, right: 16),
                        child: MmmButtons.disabledGreyButton(50, 'Sign in'))
                    : Container(
                        margin: EdgeInsets.only(left: 17, right: 16),
                        child: MmmButtons.enabledRedButton50bodyMedium(
                            'Sign in', action: () {
                          BlocProvider.of<MobileVerificationBloc>(context).add(
                              OnOtpverification(
                                  currentText, widget.dialCode, widget.phone));
                        }))
              ],
            ),
          );
        },
      ),
    );
  }

  void navigateToProfileSetup() {
    var userRepo =
        BlocProvider.of<MobileVerificationBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => About(
              userRepository: userRepo,
            )));
  }
}