import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/repo/user_repo.dart';

import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';

import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/signinscreens/phone%20signin/phone_bloc.dart';
import 'package:makemymarry/views/signinscreens/phone%20signin/phone_event.dart';
import 'package:makemymarry/views/signinscreens/phone%20signin/phone_state.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../mobile verification/mobile_verification.dart';

//class SinginWithPhone extends StatelessWidget {
// final UserRepository userRepository;

// const SinginWithPhone({Key? key, required this.userRepository})
//     : super(key: key);

// @override
// Widget build(BuildContext context) {
//   return SigninWithPhoneScreen(
//     userRepository: userRepository,
//    );
//  }
//}

class SigninWithPhone extends StatelessWidget {
  final UserRepository userRepository;

  const SigninWithPhone({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneSigninBloc(userRepository),
      child: SigninWithPhoneScreen(),
    );
  }
}

class SigninWithPhoneScreen extends StatefulWidget {
  const SigninWithPhoneScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SigninWithPhoneScreenState();
}

class _SigninWithPhoneScreenState extends State<SigninWithPhoneScreen> {
  final phoneController = TextEditingController();
  String dialCode = '+91';
  String currentText = '';
  //late UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appbarThin(),
      body: BlocConsumer<PhoneSigninBloc, PhoneSigninState>(
        listener: (context, state) {
          if (state is MoveToMobileVerification) {
            navigateToOtp();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: kMargin16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Sign in to find your\nperfect partner',
                      style: MmmTextStyles.heading2(textColor: kDark5),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      height: 46,
                      child: TextField(
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
                        cursorColor: kDark5,
                        obscureText: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kDark2, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                    BorderSide(color: kInputBorder, width: 1)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            hintText: '   Phone Number',
                            isDense: true,
                            filled: true,
                            fillColor: kLight4,
                            hintStyle:
                                MmmTextStyles.bodyRegular(textColor: kDark2),
                            prefixIcon: Container(
                              height: 26,
                              width: 85,
                              margin: EdgeInsets.only(left: 16),
                              child: Row(
                                //mainAxisSize: MainAxisSize.min,
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'images/flags/in.svg',
                                    height: 16,
                                    //width: 22,
                                  ),
                                  SizedBox(
                                      //width: 4,
                                      ),
                                  Text(
                                    '+91',
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: kDark5),
                                  ),
                                  SizedBox(
                                      // width: 4,
                                      ),
                                  Material(
                                    child: InkWell(
                                      // onTap: () => showModalBottomSheet(
                                      //     shape: RoundedRectangleBorder(
                                      //         borderRadius: BorderRadius.vertical(
                                      //             top: Radius.circular(16))),
                                      //     context: context,
                                      //     builder: (context) => buildSheet()),
                                      child: Container(
                                          height: 16,
                                          //width: 16,
                                          color: kLight4,
                                          child: SvgPicture.asset(
                                            'images/Chevron_Down.svg',
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      )),
                  SizedBox(
                    height: 24,
                  ),
                  currentText.length < 10
                      ? MmmButtons.disabledGreyButton(50, 'Send OTP')
                      : MmmButtons.enabledRedButton50bodyMedium('Send OTP',
                          action: () {
                          BlocProvider.of<PhoneSigninBloc>(context).add(
                              OnNavigateToMobileVerification(
                                  dialCode, phoneController.text.trim()));
                        }),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Container(
                            height: 1,
                            color: gray5,
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 27,
                          height: 22,
                          alignment: Alignment.center,
                          child: Text(
                            'OR',
                            textAlign: TextAlign.center,
                            style: MmmTextStyles.bodyMediumSmall(
                                textColor: kDark2),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                            height: 1,
                            color: gray5,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 12, child: MmmButtons.facebookSigninButton()),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                            // width: 16,
                            ),
                      ),
                      Expanded(flex: 12, child: MmmButtons.googleSigninButton())
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: MmmButtons.enabledRedButton50bodyMedium(
                        'Connect via Email'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 44, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text('Dont have an account?',
                              textScaleFactor: 1.0,
                              style:
                                  MmmTextStyles.bodySmall(textColor: kDark5)),
                        ),
                        InkWell(
                          onTap: () {},
                          child: GradientText(
                            ' Signup',
                            style: MmmTextStyles.bodyMedium(),
                            colors: [kPrimary, kSecondary],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  navigateToRegister() {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => CreateAccount()));
  }

  void navigateToOtp() {
    var userRepo = BlocProvider.of<PhoneSigninBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MobileVerification(
              dialCode: dialCode,
              phone: phoneController.text.trim(),
              userRepository: userRepo,
            )));
  }
}
