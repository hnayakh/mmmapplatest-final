import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';

import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SigninScreen1 extends StatefulWidget {
  const SigninScreen1({Key key}) : super(key: key);

  @override
  _SigninScreen1State createState() => _SigninScreen1State();
}

class _SigninScreen1State extends State<SigninScreen1> {
  Color iconColor = Color(0xff878D96);
  Color borderColor = Color(0xff423C5D);
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _hint = 'Enter your email';
  String _hint2 = 'Enter your password';

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        setState(() {
          _hint = '';

          iconColor = Color(0xff423C5D);
        });
      } else {
        setState(() {
          _hint = 'Enter your email';
        });
      }
    });
    emailController.addListener(() {
      if (emailController.text != '') {
        setState(() {
          borderColor = Color(0xffF178B6);
        });
      } else {
        setState(() {
          borderColor = Color(0xff423C5D);
        });
      }
    });
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          _hint = '';

          iconColor = Color(0xff423C5D);
        });
      } else {
        setState(() {
          _hint = 'Enter your password';
        });
      }
    });
    passwordController.addListener(() {
      if (passwordController.text != '') {
        setState(() {
          borderColor = Color(0xffF178B6);
        });
      } else {
        setState(() {
          borderColor = Color(0xff423C5D);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: Container(
          child: AppBar(
            toolbarHeight: 0.0,
            //title: Text(widget.title),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          decoration: BoxDecoration(
            gradient: MmmDecorations.primaryGradient(),
          ),
        ),
        //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
      ),
      body: Container(
        padding: kMargin16,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
          Expanded(
              child: Container(
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
                    padding: kMargin4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
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
                Container(child: MmmButtons.disabledGreyButton(50, 'Sign in')),
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
                        style: MmmTextStyles.bodyMediumSmall(textColor: kDark2),
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
                  margin: EdgeInsets.only(left: 16),
                  child: MmmButtons.enabledRedButton328x50bodyMedium(
                      'Connect via OTP'),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
          Container(
            margin: const EdgeInsets.only(bottom: 44, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text('Dont have an account?',
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.bodySmall(textColor: kDark5)),
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
        ]),
      ),
    );
  }
}
