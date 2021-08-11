import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/sign_in/signin_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';

import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';

import 'package:makemymarry/views/forgotpasswordscreens/forgot_password.dart';
import 'package:makemymarry/views/profilescreens/about.dart';
import 'package:makemymarry/views/signinscreens/phone_screen.dart';
import 'package:makemymarry/views/signupscreens/create_account_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SignIn extends StatelessWidget {
  final UserRepository userRepository;

  const SignIn({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(userRepository),
      child: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _hint = 'Enter your email';
  String _hint2 = 'Enter your password';

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kSecondary, // navigation bar color
      statusBarColor: kSecondary, // status bar color
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MmmButtons.appbarThin(),
        body: Container(
          padding: kMargin16,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                'Sign in to find your\nperfect partner',
                style: MmmTextStyles.heading2(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MmmTextFileds.textFiledWithLabel(
                      "Email", _hint, emailController,
                      inputType: TextInputType.emailAddress),
                  SizedBox(
                    height: 16,
                  ),
                  MmmTextFileds.textFiledWithLabel(
                      "Password", _hint2, passwordController,
                      inputType: TextInputType.emailAddress, isPassword: true),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                      //padding: kMargin4,
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          navigateToForgotPassword();
                        },
                        child: GradientText(
                          'Forgot password?',
                          style: MmmTextStyles.bodySmall(),
                          colors: [kPrimary, kSecondary],
                        ),
                      )
                    ],
                  )),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                      child: MmmButtons.disabledGreyButton(50, 'Sign in',
                          action: () {
                    navigateToProfileSetup();
                  })),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        color: gray5,
                      )),
                      Container(
                        width: 27,
                        height: 22,
                        alignment: Alignment.center,
                        child: Text(
                          'OR',
                          textAlign: TextAlign.center,
                          style:
                              MmmTextStyles.bodyMediumSmall(textColor: kDark2),
                        ),
                      ),
                      Expanded(
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
                      Expanded(child: MmmButtons.facebookSigninButton()),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(child: MmmButtons.googleSigninButton())
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: MmmButtons.enabledRedButton50bodyMedium(
                        'Connect via OTP', action: () {
                      navigateToSigninWithMobile();
                    }),
                  ),
                  SizedBox(
                    height: 19,
                  )
                ],
              ),
            ),
            Container(
              //margin: const EdgeInsets.only(bottom: 44, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //padding: const EdgeInsets.only(top: 2),
                    child: Text('Dont have an account?',
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodySmall(textColor: kDark5)),
                  ),
                  InkWell(
                    onTap: () {
                      navigateToRegister();
                    },
                    child: GradientText(
                      ' Signup',
                      style: MmmTextStyles.bodyMedium(),
                      colors: [kPrimary, kSecondary],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void navigateToForgotPassword() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ForgotPassword()));
  }

  void navigateToSigninWithMobile() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SinginWithPhone()));
  }

  navigateToRegister() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreateAccount()));
  }

  void navigateToProfileSetup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AboutScreen()));
  }
}
