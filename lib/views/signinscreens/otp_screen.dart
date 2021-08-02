import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String currentText = '';

  final TextEditingController pincodeController = TextEditingController();

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
      body: SingleChildScrollView(
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
                'We have sent a 4 digit verification code on your \nregistered number +91-9856423565',
                style: MmmTextStyles.bodySmall(textColor: gray3),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            PinCodeTextField(
              controller: pincodeController,
              textStyle: MmmTextStyles.heading3(textColor: Colors.pinkAccent),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              length: 4,
              obscureText: false,
              pinTheme: PinTheme(
                activeFillColor: Color(0xffFFFFFF),
                selectedFillColor: Color(0xffFFFFFF),
                inactiveFillColor: Color(0xffFFFFFF),
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
              appContext: context,
              onChanged: (value) {
                print(value);
                setState(() {
                  currentText = value;
                });
              },
            ),
            TweenAnimationBuilder(
              tween: Tween(begin: 30.0, end: 0),
              duration: Duration(seconds: 30),
              builder: (context, value, child) => value > 0
                  ? Column(
                      children: [
                        SizedBox(
                          height: 82,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 190),
                          child: value > 10
                              ? GradientText(
                                  "0:${value.toInt()}",
                                  style: MmmTextStyles.bodyMedium(),
                                  colors: [kPrimary, kSecondary],
                                )
                              : GradientText(
                                  "0:0${value.toInt()}",
                                  style: MmmTextStyles.bodyMedium(),
                                  colors: [kPrimary, kSecondary],
                                ),
                        ),
                        SizedBox(
                          height: 24,
                        )
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 66,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 17, right: 16),
                          child: MmmButtons.enabledRedButton50bodyMedium(
                              'Resend OTP'),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
            ),
            currentText.length < 4
                ? Container(
                    margin: EdgeInsets.only(left: 17, right: 16),
                    child: MmmButtons.disabledGreyButton(50, 'Sign in'))
                : Container(
                    margin: EdgeInsets.only(left: 17, right: 16),
                    child: MmmButtons.enabledRedButton50bodyMedium('Sign in'))
          ],
        ),
      ),
    );
  }
}
