import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';

import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
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
              gradient: LinearGradient(
                  colors: [kPrimary, kSecondary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
          ),
          //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: double.infinity,
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Text(
              'Sign in to find your\nperfect partner',
              style: MmmTextStyles.heading2(textColor: gray2),
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Container(
            margin: EdgeInsets.only(left: 14),
            child: Text(
              'Email',
              style: MmmTextStyles.bodySmall(textColor: gray2),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            margin: EdgeInsets.only(left: 14),
            width: 329,
            height: 54,
            child: TextField(
              style: MmmTextStyles.bodyRegular(textColor: gray2),
              controller: emailController,
              cursorColor: Color(0xff423C5D),
              focusNode: emailFocusNode,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: _hint,
                  hintStyle: MmmTextStyles.bodyRegular(textColor: gray4),
                  contentPadding: //EdgeInsets.only(left: 20, top: 12),
                      EdgeInsets.fromLTRB(16, 10, 16, 10),
                  filled: true,
                  fillColor: Color(0xffF0EFF5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Color(0xff878D96), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: borderColor, width: 1))),
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Container(
            margin: EdgeInsets.only(left: 14),
            child: Text(
              'Password',
              style: MmmTextStyles.bodySmall(textColor: gray2),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            margin: EdgeInsets.only(left: 14),
            width: 329,
            height: 54,
            child: TextField(
              style: MmmTextStyles.bodyRegular(textColor: gray2),
              controller: passwordController,
              cursorColor: Color(0xff423C5D),
              focusNode: passwordFocusNode,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: _hint2,
                  hintStyle: MmmTextStyles.bodyRegular(textColor: gray4),
                  contentPadding: //EdgeInsets.only(left: 20, top: 12),
                      EdgeInsets.fromLTRB(16, 10, 16, 10),
                  filled: true,
                  fillColor: Color(0xffF0EFF5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Color(0xff878D96), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: borderColor, width: 1))),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
              margin: EdgeInsets.only(left: 217),
              child: InkWell(
                onTap: () {},
                child: GradientText(
                  'Forgot password?',
                  style: MmmTextStyles.bodySmall(),
                  colors: [kPrimary, kSecondary],
                ),
              )),
          SizedBox(
            height: 24,
          ),
          Container(
              margin: EdgeInsets.only(left: 14),
              child: MmmButtons.disabledGreyButton(50, 330, 'Sign in')),
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                width: 146.31,
                height: 0,
                decoration:
                    BoxDecoration(border: Border.all(width: 0.5, color: gray4)),
              ),
              SizedBox(
                width: 8.69,
              ),
              Container(
                width: 27,
                height: 22,
                child: Text(
                  'OR',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.bodyMediumSmall(textColor: gray4),
                ),
              ),
              Container(
                width: 146.31,
                height: 0,
                decoration:
                    BoxDecoration(border: Border.all(width: 0.5, color: gray4)),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              MmmButtons.facebookSigninButton(),
              SizedBox(
                width: 16,
              ),
              MmmButtons.googleSigninButton()
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child:
                MmmButtons.enabledRedButton328x50bodyMedium('Connect via OTP'),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 64),
                child: Text('Dont have an account?',
                    style: MmmTextStyles.bodySmall(textColor: gray2)),
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
        ]));
  }
}
