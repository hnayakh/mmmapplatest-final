import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PhoneTextField extends StatefulWidget {
  PhoneTextField({Key key}) : super(key: key);

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
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
                                  onTap: () => showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16))),
                                      context: context,
                                      builder: (context) => buildSheet()),
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
                  : MmmButtons.enabledRedButton50bodyMedium('Send OTP'),
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
}

Widget buildSheet() => Container(
      child: Column(
        children: [
          Container(
            height: 130,
            padding: EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                InkWell(
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
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffE2E0EB),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                Text(
                  'Select your country name',
                  style: MmmTextStyles.bodyMedium(textColor: kDark5),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 0,
                  decoration: BoxDecoration(
                      border: Border.all(color: gray6, width: 0.5)),
                ),
                //ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
              ],
            ),
          )
        ],
      ),
    );
