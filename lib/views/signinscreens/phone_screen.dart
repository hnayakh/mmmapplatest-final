import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/signinscreens/otp_screen.dart';
import 'package:makemymarry/views/signupscreens/create_account_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SinginWithPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SigninWithPhoneScreen();
  }
}

class SigninWithPhoneScreen extends StatefulWidget {
  @override
  _SigninWithPhoneScreenState createState() => _SigninWithPhoneScreenState();
}

class _SigninWithPhoneScreenState extends State<SigninWithPhoneScreen> {
  final phoneController = TextEditingController();

  String currentText = '';

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
      body: SingleChildScrollView(
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
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: kInputBorder, width: 1)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        hintText: '   Phone Number',
                        isDense: true,
                        filled: true,
                        fillColor: kLight4,
                        hintStyle: MmmTextStyles.bodyRegular(textColor: kDark2),
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
                                width: 22,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '+91',
                                style: MmmTextStyles.bodyRegular(
                                    textColor: kDark5),
                              ),
                              SizedBox(
                                width: 4,
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
                                      width: 16,
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
                      navigateToOtp();
                    }),
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
            ],
          ),
        ),
      ),
    );
  }

  navigateToRegister() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreateAccount()));
  }

  void navigateToOtp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => OtpScreen()));
  }
}
