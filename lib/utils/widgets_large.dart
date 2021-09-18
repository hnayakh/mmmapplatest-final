import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';

import 'colors.dart';

class MmmWidgets {
  static Widget rowWidget(String icon, String info) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          color: kDark5,
        ),
        Expanded(flex: 1, child: SizedBox()),
        Text(
          info,
          style: MmmTextStyles.bodyRegular(textColor: kDark5),
        ),
        Expanded(flex: 12, child: SizedBox()),
      ],
    );
  }

  static Container buildLoader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.55),
      child: Center(
        child: Image.asset(
          "images/app_loader2.gif",
          width: 96,
          height: 96,
        ),
      ),
    );
  }

  static Container resetPasswordWidget() {
    return Container(
      width: 328,
      height: 192,
      padding: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffFCFCFD),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Column(
        children: [
          Container(
            height: 64,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              'Password Reset',
              style: MmmTextStyles.heading4(textColor: kDark5),
            ),
          ),
          Container(
            height: 38,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Text(
              'Are you want to reset your account?',
              style: MmmTextStyles.bodySmall(textColor: kDark5),
            ),
          ),
          Container(
            height: 82,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 136,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xffDDE1E6))),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: MmmTextStyles.heading6(textColor: gray4),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                    height: 42,
                    width: 136,
                    decoration: MmmDecorations.primaryButtonDecoration(),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: MmmTextStyles.heading6(textColor: gray7),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  static Container accountCreatedWidget() {
    return Container(
      width: 328,
      height: 393,
      padding: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffFFFFFF),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Column(
        children: [
          Container(
            height: 179,
            width: 328,
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              width: 296,
              height: 163,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/pic1.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            height: 64,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              'Account created',
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading4(textColor: kDark5),
            ),
          ),
          Container(
              height: 60,
              width: 328,
              padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Text(
                'your account is created with mmy \nsuccessfully with id mmy12345',
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodySmall(textColor: kDark5),
              )),
          Container(
            height: 82,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Container(
              decoration: MmmDecorations.primaryButtonDecoration(),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: MmmTextStyles.heading6(textColor: gray7),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Container confirmpasswordWidget() {
    return Container(
      width: 328,
      height: 236,
      padding: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffFFFFFF),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Column(
        children: [
          Container(
            height: 64,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Center(
              child: Text(
                'Password doesnot match',
                textAlign: TextAlign.center,
                style: MmmTextStyles.heading4(textColor: kDark5),
              ),
            ),
          ),
          Container(
            height: 82,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Center(
              child: Text(
                'The entered password and confirm \npassword doesnot match.Please enter \nsame password.',
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodySmall(textColor: kDark5),
              ),
            ),
          ),
          Container(
            height: 82,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Container(
              decoration: MmmDecorations.primaryButtonDecoration(),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      'OK',
                      style: MmmTextStyles.heading6(textColor: gray7),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Container confirmPasswordWithPictureWidget() {
    return Container(
      width: 328,
      height: 415,
      padding: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffFFFFFF),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Column(
        children: [
          Container(
            height: 179,
            width: 328,
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              width: 296,
              height: 163,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/pic1.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            height: 64,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              'Picture shared',
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading4(textColor: kDark5),
            ),
          ),
          Container(
              height: 82,
              width: 328,
              padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Text(
                'The entered password and confirm \npassword doesnot match.Please enter \nsame password.',
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodySmall(textColor: kDark5),
              )),
          Container(
            height: 82,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Container(
              decoration: MmmDecorations.primaryButtonDecoration(),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: MmmTextStyles.heading6(textColor: gray7),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Container accountDeletedWidget() {
    return Container(
      width: 328,
      height: 192,
      padding: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffFCFCFD),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Column(
        children: [
          Container(
            height: 64,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              'Account Deleted',
              style: MmmTextStyles.heading4(textColor: kDark5),
            ),
          ),
          Container(
            height: 38,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Text(
              'Are you want to delete your account?',
              style: MmmTextStyles.bodySmall(textColor: kDark5),
            ),
          ),
          Container(
            height: 82,
            width: 328,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 136,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xffDDE1E6))),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: MmmTextStyles.heading6(textColor: gray4),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                    height: 42,
                    width: 136,
                    decoration: MmmDecorations.primaryButtonDecoration(),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            'Got it',
                            style: MmmTextStyles.heading6(textColor: gray7),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  static Container acceptRequestWidget() {
    return Container(
      height: 368,
      width: 328,
      padding: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffFFFFFF),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 24,
          ),
          Row(
            children: [
              SizedBox(
                width: 24,
              ),
              Container(
                height: 32,
                width: 280,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Abhisekh Sharma',
                      style: MmmTextStyles.heading4(textColor: kDark5),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "images/Verified.svg",
                        height: 16,
                        width: 16,
                        color: Color(0xffC9184A),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/pic5.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: 280,
            height: 44,
            child: Text(
              'Please accept the request to \nread a message',
              style: MmmTextStyles.bodySmall(textColor: kDark5),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 0,
            width: 309.02,
            decoration: BoxDecoration(
                border: Border.all(
              color: Color(0xffF0EFF5),
              width: 0.5,
            )),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 42,
            width: 280,
            child: Container(
              decoration: MmmDecorations.primaryButtonDecoration(),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: MmmTextStyles.heading6(textColor: gray7),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 42,
            width: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xffDDE1E6))),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Text(
                    'Decline',
                    style: MmmTextStyles.heading6(textColor: gray4),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Container addCalendarWidget() {
    return Container(
      height: 404,
      width: 328,
      padding: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffFFFFFF),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 24,
          ),
          Row(
            children: [
              SizedBox(
                width: 24,
              ),
              Container(
                height: 32,
                width: 280,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Abhisekh Sharma',
                      style: MmmTextStyles.heading4(textColor: kDark5),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "images/Verified.svg",
                        height: 16,
                        width: 16,
                        color: Color(0xffC9184A),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/pic5.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: 280,
            height: 66,
            child: Text(
              'Your date is scheduled on 27 APR 2021 at \n11:00 PM IST \nPizza Royal,Dwarka,New Delhi',
              style: MmmTextStyles.bodySmall(textColor: kDark5),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 0,
            width: 309.02,
            decoration: BoxDecoration(
                border: Border.all(
              color: Color(0xffF0EFF5),
              width: 0.5,
            )),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 42,
            width: 280,
            child: Container(
              decoration: MmmDecorations.primaryButtonDecoration(),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 46.25,
                        ),
                        SvgPicture.asset(
                          "images/Calendar.svg",
                          color: Color(0xffFCFCFD),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16.25),
                        Text(
                          'Add to your calendar',
                          style: MmmTextStyles.heading6(textColor: gray7),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 0,
            width: 309.02,
            decoration: BoxDecoration(
                border: Border.all(
              color: Color(0xffF0EFF5),
              width: 0.5,
            )),
          ),
          SizedBox(height: 16),
          Container(
            height: 40,
            width: 232,
            child: Text(
              'We ll notify you if Abhiskhek  confirms \nyour request',
              style: MmmTextStyles.caption(textColor: kDark5),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  static Widget stackUserprofileWidget(
      {required BuildContext context,
      required String imageUrl,
      required String userCity,
      required String userState,
      required String name,
      required int age}) {
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xffC5C1D7),
                borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
            top: 10,
            right: 8,
            child: Row(
              children: [
                Container(
                  child: SvgPicture.asset(
                    "images/Verified.svg",
                    color: Color(0xffC9184A),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Expanded(flex: 2, child: SizedBox()),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              color: Color(0xff21272A).withOpacity(0.50),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff0F0D15).withAlpha(8),
                                  blurRadius: 30.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 15.0),
                                )
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 9,
                                    child: Container(
                                      child: Text('$name,$age',
                                          style: MmmTextStyles.heading6(
                                              textColor: gray7)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Container(
                                    child: SvgPicture.asset(
                                      "images/location.svg",
                                      color: Color(0xffFCFCFD),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '$userCity,$userState',
                                      style: MmmTextStyles.caption(
                                          textColor: gray7),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: double.infinity,
                      ))))
        ],
      ),
    );
  }

  static Container bottomNavigatiomBar() {
    return Container(
      height: 68,
      //width: 360,
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            //width: 68.8,
            height: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  //width: double.infinity,
                  height: 4,
                ),
                SvgPicture.asset(
                  'images/Search.svg',
                  color: gray3,
                  height: 24,
                  // width: 24,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 16,
                  //width: 36,
                  child: Text(
                    'Search',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarryMedium',
                        fontSize: 10,
                        height: 1.60,
                        color: gray3),
                  ),
                ),
                SizedBox(
                  height: 4,
                )
              ],
            ),
          ),
          //SizedBox(
          //   width: 4,
          // ),
          Container(
            //width: 68.8,
            height: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  // width: double.infinity,
                  height: 4,
                ),
                SvgPicture.asset(
                  'images/filter2.svg',
                  color: gray3,
                  height: 24,
                  //  width: 24,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 16,
                  //width: 25,
                  child: Text(
                    'Filter',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarryMedium',
                        fontSize: 10,
                        height: 1.60,
                        color: gray3),
                  ),
                ),
                SizedBox(
                  height: 4,
                )
              ],
            ),
          ),
          // SizedBox(
          //   width: 4,
          // ),
          Container(
            //width: 68.8,
            height: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  //width: double.infinity,
                  height: 4,
                ),
                SvgPicture.asset(
                  'images/connect.svg',
                  color: gray3,
                  height: 24,
                  //width: 24,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 16,
                  // width: 44,
                  child: Text(
                    'Connect',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarryMedium',
                        fontSize: 10,
                        height: 1.60,
                        color: gray3),
                  ),
                ),
                SizedBox(
                  height: 4,
                )
              ],
            ),
          ),
          //SizedBox(
          //   width: 4,
          // ),
          Container(
            // width: 68.8,
            height: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  // width: double.infinity,
                  height: 4,
                ),
                Container(
                  height: 24,
                  child: Icon(
                    Icons.notifications,
                    color: gray3,
                  ),
                ),
                // SvgPicture.asset(
                //   'images/connect.svg',
                //   color: gray3,
                //   height: 24,
                //   width: 24,
                //   fit: BoxFit.cover,
                //  ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 16,
                  // width: 64,
                  child: Text(
                    'Notifications',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarryMedium',
                        fontSize: 10,
                        height: 1.60,
                        color: gray3),
                  ),
                ),
                SizedBox(
                  height: 4,
                )
              ],
            ),
          ),
          // SizedBox(
          //   width: 4,
          // ),
          Container(
            // width: 68.8,
            height: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  // width: double.infinity,
                  height: 4,
                ),
                SvgPicture.asset(
                  'images/menu.svg',
                  color: gray3,
                  height: 24,
                  // width: 24,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 16,
                  // width: 26,
                  child: Text(
                    'More',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarryMedium',
                        fontSize: 10,
                        height: 1.60,
                        color: gray3),
                  ),
                ),
                SizedBox(
                  height: 4,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget bottomBarUnits(String icon, String label, Color iconColor,
      {Function()? action}) {
    return GestureDetector(
      onTap: action,
      child: Container(
        //width: 68.8,
        height: 52,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              //width: double.infinity,
              height: 4,
            ),
            SvgPicture.asset(
              icon,
              color: iconColor,
              height: 24,
              // width: 24,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 16,
              //width: 36,
              child: Text(
                label,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'MakeMyMarryMedium',
                    fontSize: 10,
                    height: 1.60,
                    color: iconColor),
              ),
            ),
            SizedBox(
              height: 4,
            )
          ],
        ),
      ),
    );
  }
}
