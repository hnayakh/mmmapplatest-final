import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';

import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/forgotpasswordscreens/forgot_password_event.dart';
import 'package:makemymarry/views/signinscreens/mobile%20verification/mobile_verification_state.dart';

import 'forgot_password_bloc.dart';
import 'forgot_password_state.dart';
import 'otp_screen.dart';

class ForgotPassword extends StatelessWidget {
  final UserRepository userRepository;

  const ForgotPassword({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(userRepository),
      child: ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  TextEditingController emailcontroller = TextEditingController();

  //var controller;

  String currentText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appbarThin(),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is MoveToOtpScreen) {
            navigateToOtp(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: kMargin16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 13,
                  ),
                  MmmButtons.backButton(context),
                  SizedBox(
                    height: 26,
                  ),
                  Text(
                    "Forgot Password",
                    style: MmmTextStyles.heading2(textColor: kDark5),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Enter your registered email. We will send a link \nto reset your password.',
                    style: MmmTextStyles.bodySmall(textColor: gray3),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'Email',
                                textScaleFactor: 1.0,
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '*',
                                style: MmmTextStyles.bodySmall(
                                    textColor: kredStar),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 50,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                currentText = value;
                              });
                            },
                            controller: emailcontroller,
                            style: MmmTextStyles.bodyRegular(textColor: kDark5),
                            cursorColor: kDark5,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kDark2, width: 1),
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: kInputBorder, width: 1)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                hintText: 'Enter email id',
                                isDense: true,
                                filled: true,
                                fillColor: kLight4,
                                hintStyle: MmmTextStyles.bodyRegular(
                                    textColor: kDark2)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  currentText.length < 10
                      ? MmmButtons.disabledGreyButton(50, 'Send OTP')
                      : MmmButtons.enabledRedButtonbodyMedium(50, 'Send OTP',
                          action: () {
                          BlocProvider.of<ForgotPasswordBloc>(context)
                              .add(SendOtpEvent(emailcontroller.text.trim()));
                        })
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToOtp(BuildContext context) {
    var userRepo = BlocProvider.of<ForgotPasswordBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Otp(
              userRepository: userRepo,
              email: emailcontroller.text.trim(),
            )));
  }
}
