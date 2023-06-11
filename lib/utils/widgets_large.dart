import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_bloc.dart';
import 'package:makemymarry/views/meet/views/meet_location.dart';

import '../views/meet/views/meet_timing/schedule_meeting_date.dart';
import 'colors.dart';

class MmmWidgets {
  static Widget messageReceived(String msg, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 253, maxHeight: double.infinity, minHeight: 58),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                    color: kMessage),
                child: Text(
                  msg,
                  style: MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              time,
              style: MmmTextStyles.caption(textColor: gray4),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ],
    );
  }

  static Widget messageSent(String msg, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 253, maxHeight: double.infinity, minHeight: 58),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16)),
                    color: kLight4),
                child: Text(
                  msg,
                  style: MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              time,
              style: MmmTextStyles.caption(textColor: gray4),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ],
    );
  }

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

  static Container buildLoader(BuildContext context, {Color? color}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: color ?? Colors.black.withOpacity(0.55),
      child: Center(
        child: Image.asset(
          "images/app_loader4.gif",
          width: 96,
          height: 96,
        ),
      ),
    );
  }

  static Container buildLoader2(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.55),
      child: Center(
        child: Card(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 64),
            child: Image.asset(
              "images/app_loader4.gif",
              width: 128,
              height: 96,
            ),
          ),
        ),
      ),
    );
  }

  static Widget resetPasswordWidget() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: 192,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFCFCFD),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Container(
              child: Text(
                'Password Reset',
                style: MmmTextStyles.heading4(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Text(
                'Are you want to reset your account?',
                style: MmmTextStyles.bodySmall(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffDDE1E6))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
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
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        height: 42,
                        decoration: MmmDecorations.primaryButtonDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  'Confirm',
                                  style:
                                      MmmTextStyles.heading6(textColor: gray7),
                                ),
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget profileCompletedWidget(UserDetails user, {Function()? action}) {
    var date = DateFormat("dd MMM,yyyy").format(DateTime.now());
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white.withOpacity(0.5),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
          //width: 328,
          height: 380,
          padding: kMargin12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xffFFFFFF),
              boxShadow: [
                MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Container(
                width: double.infinity,
                height: 173,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'images/profile_completion.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Profile setup completed',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading4(textColor: kDark5),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                  height: 70,
                  // child: Text(
                  //   'your profile is created successfully on $date with  ${user.displayId.toUpperCase()}  id',
                  //   textAlign: TextAlign.center,
                  //   style: MmmTextStyles.bodySmall(textColor: kDark5),
                  // )
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle( fontFamily: 'MakeMyMarry', 
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                'Your profile is created successfully on  $date with'),
                        new TextSpan(
                            text: ' ${user.displayId.toUpperCase()} ',
                            style: new TextStyle( fontFamily: 'MakeMyMarry', 
                                color: kPrimary, fontWeight: FontWeight.bold)),
                        new TextSpan(text: 'id'),
                      ],
                    ),
                  )),
              // SizedBox(
              //   height: 18,
              // ),
              Container(
                height: 32,
                child: Container(
                  decoration: MmmDecorations.primaryButtonDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: action,
                        child: Center(
                          child: Text(
                            'Continue',
                            style: MmmTextStyles.heading6(textColor: gray7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget accountCreatedWidget() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        //width: 328,
        height: 393,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFFFF),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Container(
              width: double.infinity,
              height: 163,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/stackviewImage.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Text(
                'Account created',
                textAlign: TextAlign.center,
                style: MmmTextStyles.heading4(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
                height: 60,
                child: Text(
                  'your account is created with mmy \nsuccessfully with id mmy12345',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.bodySmall(textColor: kDark5),
                )),
            Container(
              height: 42,
              child: Container(
                decoration: MmmDecorations.primaryButtonDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
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
            ),
          ],
        ),
      ),
    );
  }

  static Widget connectsAddedWidget(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Builder(
        builder: (context) {
          return Container(
            height: 214,
            width: double.infinity,
            padding: kMargin12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xffFFFFFF),
                boxShadow: [
                  MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 12,
                ),
                Text(
                  '2 connects added',
                  style: MmmTextStyles.heading4(textColor: kDark5),
                ),
                SizedBox(
                  height: 24,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(
                    'You have total 5 connects in your wallet.',
                    style: MmmTextStyles.bodySmall(textColor: gray3),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 42,
                  child: Container(
                    decoration: MmmDecorations.primaryButtonDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget verificationStatusWidget(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Builder(
        builder: (context) {
          return Container(
            height: 225,
            width: double.infinity,
            padding: kMargin12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xffFFFFFF),
                boxShadow: [
                  MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 12,
                ),
                Text(
                  'Verification Status',
                  style: MmmTextStyles.heading4(textColor: kDark5),
                ),
                SizedBox(
                  height: 24,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(
                    'Your document has been sent for verification. We’ll notify you once verification is done.',
                    style: MmmTextStyles.bodySmall(textColor: gray3),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 42,
                  child: Container(
                    decoration: MmmDecorations.primaryButtonDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget userNotFoundWidget(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Builder(
        builder: (context) {
          return Container(
            height: 214,
            width: double.infinity,
            padding: kMargin12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xffFFFFFF),
                boxShadow: [
                  MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 12,
                ),
                Text(
                  'User doesn’t exist',
                  style: MmmTextStyles.heading4(textColor: kDark5),
                ),
                SizedBox(
                  height: 24,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(
                    'Please enter correct mmy id to find your perfect match.',
                    style: MmmTextStyles.bodySmall(textColor: gray3),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 42,
                  child: Container(
                    decoration: MmmDecorations.primaryButtonDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget confirmpasswordWidget(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Builder(
        builder: (context) {
          return Container(
            height: 260,
            width: double.infinity,
            padding: kMargin12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xffFFFFFF),
                boxShadow: [
                  MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 24,
                ),
                Text(
                  'Password doesn’t match',
                  style: MmmTextStyles.heading4(textColor: kDark5),
                ),
                SizedBox(
                  height: 24,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(
                    'The entered password and confirm password doesn’t match. Please enter same password.',
                    style: MmmTextStyles.bodySmall(textColor: gray3),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 42,
                  child: Container(
                    decoration: MmmDecorations.primaryButtonDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
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
                  ),
                ),
              ],
            ),
          );
        },
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

  static Widget deleteAccountWidget() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: 192,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFCFCFD),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Container(
              child: Text(
                'Delete Account',
                style: MmmTextStyles.heading4(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Text(
                'Are you sure you want to delete your account?',
                style: MmmTextStyles.bodySmall(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffDDE1E6))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
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
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        height: 42,
                        decoration: MmmDecorations.primaryButtonDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  'Delete',
                                  style:
                                      MmmTextStyles.heading6(textColor: gray7),
                                ),
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget requestCancelWidget() {
    return Column(
      children: [
        AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(0),
          content: Container(
            height: 192,
            padding: kMargin12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xffFCFCFD),
                boxShadow: [
                  MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                Container(
                  child: Text(
                    'Request Cancel',
                    style: MmmTextStyles.heading4(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: Text(
                    'Are you sure you want to cancel his/her request?',
                    style: MmmTextStyles.bodySmall(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xffDDE1E6))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: MmmTextStyles.heading6(
                                        textColor: gray4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            height: 42,
                            decoration:
                                MmmDecorations.primaryButtonDecoration(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      'Confirm',
                                      style: MmmTextStyles.heading6(
                                          textColor: gray7),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget requestConnectWidget(
      {required String name,
      required String imageUrl,
      required bool isVerified,
      required Function onConfirm}) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Wrap(
        children: [
          Container(
            padding: kMargin24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xffFCFCFD),
              boxShadow: [
                MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          name.split(" ").first,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: MmmTextStyles.heading4(textColor: kDark5),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      isVerified
                          ? SvgPicture.asset(
                              'images/Verified.svg',
                              color: kPrimary,
                            )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(imageUrl,
                      height: 72,
                      width: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (context, obj, str) => Container(
                          color: Colors.grey, child: Icon(Icons.error))),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: Text(
                    'To make unlimited calls & messages with $name, your 1 connect will be deducted from your MMM wallet.',
                    textAlign: TextAlign.center,
                    style: MmmTextStyles.bodySmall(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                    height: 42,
                    decoration: MmmDecorations.primaryButtonDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            onConfirm.call();
                          },
                          child: Center(
                            child: Text(
                              'Confirm',
                              style: MmmTextStyles.heading6(textColor: gray7),
                            ),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xffDDE1E6))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          navigatorKey.currentState?.pop();
                        },
                        child: Center(
                          child: Text(
                            'Decline',
                            style: MmmTextStyles.heading6(textColor: gray4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget lowBalanceWidget(
      {required Function onConfirm, String? message}) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: 450,
        padding: kMargin24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffFCFCFD),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/low_balance_image.png'),
            Text(
              "Low Balance",
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading4(textColor: kDark5),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Text(
                message ??
                    "You don't have enough Connect in your wallet, Please buy some  Connect to make this call.",
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodySmall(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 42,
              decoration: MmmDecorations.primaryButtonDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      onConfirm.call();
                    },
                    child: Center(
                      child: Text(
                        'Buy Connect',
                        style: MmmTextStyles.heading6(textColor: gray7),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xffDDE1E6))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      navigatorKey.currentState?.pop();
                    },
                    child: Center(
                      child: Text(
                        'Later',
                        style: MmmTextStyles.heading6(textColor: gray4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget requestRejectWidget() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: 192,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFCFCFD),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Container(
              child: Text(
                'Request Reject',
                style: MmmTextStyles.heading4(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Text(
                'Are you sure you want to reject his/her request?',
                style: MmmTextStyles.bodySmall(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffDDE1E6))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
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
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        height: 42,
                        decoration: MmmDecorations.primaryButtonDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  'Confirm',
                                  style:
                                      MmmTextStyles.heading6(textColor: gray7),
                                ),
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget selectMeetWidget(
      BuildContext context, ProfileDetails profileDetails) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 5),
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      )),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),

          ClipRRect(
            child: Padding(
              padding: const EdgeInsets.only(right: 330),
              child: MmmButtons.backButton(context),
            ),
          ),

          // Choose Your Type
          const SizedBox(
            width: 340,
            child: Text(
              'Choose your type of meet',
              // textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontFamily: "MakeMyMarrySemiBold",
                //fontStyle: FontStyle.normal,
                height: 3.5,
              ),
            ),
          ),
          SizedBox(height: 30),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  width: 340,
                  child: MmmButtons.primaryButtonMeetGray('Virtual Meet', () {
                    context.navigate.pop();
                    context.navigate.push(BookYourDate.getRoute(
                      meetType: MeetType.virtual,
                      profileDetails: profileDetails,
                    ));
                  })),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 340,
                child: MmmButtons.primaryButtonMeet(
                  'Meet in Person',
                  () {
                    context.navigate.pop();
                    context.navigate.push(MeetLocationView.getRoute(
                      profileDetails: profileDetails,
                    ));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static Widget selectStatusWidget(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: 372,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFFFF),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 24,
            ),
            Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08,
                      ),
                      Text(
                        'Select your Status',
                        style: MmmTextStyles.heading4(textColor: kDark5),
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
                  'images/scar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Abhishek Sharma',
              style: MmmTextStyles.heading5(textColor: kDark5),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MMY23456',
                  style: MmmTextStyles.bodySmall(textColor: gray4),
                ),
                SizedBox(
                  width: 5,
                ),
                SvgPicture.asset(
                  "images/Verified.svg",
                  height: 16,
                  width: 16,
                  color: Color(0xffC9184A),
                  fit: BoxFit.cover,
                ),
              ],
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
              child: Container(
                decoration: MmmDecorations.primaryButtonDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Keep me Online',
                          style: MmmTextStyles.bodyMedium(textColor: gray7),
                        ),
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xffDDE1E6))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        'Keep me Offline',
                        style: MmmTextStyles.bodyMedium(textColor: gray3),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget acceptRequestWidget(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        height: 368,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFFFF),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 24,
            ),
            Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08,
                      ),
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
                  'images/scar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
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
              child: Container(
                decoration: MmmDecorations.primaryButtonDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
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
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xffDDE1E6))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget addCalendarWidget(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 404,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFFFF),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                  'images/scar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
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
              child: Container(
                decoration: MmmDecorations.primaryButtonDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.11,
                            0,
                            MediaQuery.of(context).size.width * 0.11,
                            0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "images/Calendar.svg",
                              color: Color(0xffFCFCFD),
                              fit: BoxFit.cover,
                            ),
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
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 0,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Color(0xffF0EFF5),
                width: 0.5,
              )),
            ),
            SizedBox(height: 16),
            Container(
              child: Text(
                'We ll notify you if Abhiskhek  confirms \nyour request',
                style: MmmTextStyles.caption(textColor: kDark5),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
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
