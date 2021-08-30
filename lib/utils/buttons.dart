import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';

class MmmButtons {
  static Widget showphotoButton(String photo, BuildContext context,
      {Function()? action}) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      //width: 180,
      decoration: BoxDecoration(
          border: Border.all(color: kBio),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              photo,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,

              // width: 180,
              //height: 100,
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kPrimary, kSecondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: action,
                    child: Container(
                      height: 20,
                      // width: 18,
                      //padding: EdgeInsets.fromLTRB(14, 13, 12, 13),
                      child: SvgPicture.asset(
                        "images/Cross.svg",
                        color: gray7,
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
  }

  static Widget uploadPhotoButton({Function()? action}) {
    return Container(
      height: 100,
      // width: 180,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            child: InkWell(
              onTap: action,
              child: Container(
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1.5, color: kBioSecondary)),
                child: SvgPicture.asset(
                  'images/plus.svg',
                  color: kBioSecondary,
                  height: 24,
                  // width: 22.88,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget categoryButtons(
      String labelText, String hintText, String newhintText, String icon,
      {Function()? action}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              labelText,
              textScaleFactor: 1.0,
              style: MmmTextStyles.bodySmall(textColor: kDark5),
            ),
            //SizedBox(
            //  width: 2,
            // ),
            Text(
              ' *',
              style: MmmTextStyles.bodySmall(textColor: kredStar),
            )
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: kLight4,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: kDark2),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: action,
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox(
                    //  width: 16,
                    // ),
                    Container(
                      //width: 216,
                      child: Text(
                        hintText,
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.start,
                        style: newhintText == hintText
                            ? MmmTextStyles.bodyRegular(textColor: kDark2)
                            : MmmTextStyles.bodyRegular(textColor: kDark5),
                      ),
                    ),
                    // SizedBox(
                    //width: 110,
                    //  ),
                    SvgPicture.asset(
                      icon,
                      width: 24,
                      height: 24,
                      color: Color(0xff878D96),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget categoryButton(String labelText, String hintText, String icon) {
    String newhintText = hintText;
    return Column(
      children: [
        Row(
          children: [
            Text(
              labelText,
              textScaleFactor: 1.0,
              style: MmmTextStyles.bodySmall(textColor: kDark5),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              '*',
              style: MmmTextStyles.bodySmall(textColor: kredStar),
            )
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: kLight4,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: kDark2),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox(
                    //  width: 16,
                    // ),
                    Container(
                      //width: 216,
                      child: Text(
                        newhintText,
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.start,
                        style: newhintText == hintText
                            ? MmmTextStyles.bodyRegular(textColor: kDark2)
                            : MmmTextStyles.bodyRegular(textColor: kDark5),
                      ),
                    ),
                    // SizedBox(
                    //width: 110,
                    //  ),
                    SvgPicture.asset(
                      icon,
                      width: 24,
                      height: 24,
                      color: Color(0xff878D96),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static PreferredSize appBarCurved(String title) {
    return PreferredSize(
      preferredSize: Size.fromHeight(74.0),
      child: Container(
        child: AppBar(
          leading: Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
            decoration: BoxDecoration(
                color: kLight2.withOpacity(0.60),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  MmmShadow.elevationbBackButton(
                      shadowColor: kShadowColorForWhite)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'images/arrowLeft.svg',
                        height: 17.45,
                        width: 17.45,
                        color: gray3,
                      )),
                ),
              ),
            ),
          ),
          toolbarHeight: 74.0,
          title: Text(
            title,
            style: MmmTextStyles.heading4(textColor: kLight2),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
          gradient: LinearGradient(
              colors: [kPrimary, kSecondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }

  static PreferredSize appbarThin() {
    return PreferredSize(
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
    );
  }

  static Widget cameraimportButton({Function()? action}) {
    return Container(
      height: 50,
      child: Container(
        decoration: MmmDecorations.primaryButtonDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  SvgPicture.asset(
                    "images/camera.svg",
                    color: Color(0xffFCFCFD),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 26,
                    width: 260,
                    child: Text(
                      'Click via camera',
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.heading5(textColor: gray7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget facebookImportbutton({Function()? action}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xff878D96),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/social/facebook.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 26,
                width: 260,
                child: Text(
                  'Import from Facebook',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading5(textColor: kDark5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget importGalleryButton({Function()? action}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xff878D96),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/gallery.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 26,
                width: 260,
                child: Text(
                  'Import from Gallery',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading5(textColor: kDark5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget profileSelectButton(
      double containerHeight, String text, Function ontap) {
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: kLight4,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: kDark2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => ontap,
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                child: Text(
                  text,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                  style: MmmTextStyles.bodyRegular(textColor: kDark2),
                ),
              ),
              SizedBox(
                width: 130,
              ),
              SvgPicture.asset(
                "images/rightArrow.svg",
                width: 24,
                height: 24,
                color: Color(0xff878D96),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget primaryButton(String title, Function onTap) {
    return Container(
      child: InkWell(
        child: Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            title,
            textScaleFactor: 1.0,
            style: MmmTextStyles.heading6(textColor: Colors.white),
            textAlign: TextAlign.center,
          ),
          decoration: MmmDecorations.primaryButtonDecoration(),
        ),
      ),
      margin: kMargin24,
    );
  }

  static Container enabledRedButton328x50bodyMedium(String title) {
    return Container(
      // margin: kMargin24,

      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            alignment: Alignment.center,
            height: 50,
            child: Text(
              title,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.bodyMedium(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  static Container enabledRedButton328x50heading5(String text) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            alignment: Alignment.center,
            height: 50,
            width: 328,
            child: Text(
              text,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading5(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  static Container enabledRedButton50bodyMedium(String text,
      {Function()? action}) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            alignment: Alignment.center,
            height: 44,
            child: Text(
              text,
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: MmmTextStyles.bodyMedium(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  static Container enabledRedButtonbodyMedium(double height, String text,
      {Function()? action}) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              alignment: Alignment.center,
              height: height,
              child: Text(
                text,
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodyMedium(textColor: gray7),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container enabledRedButton280x42heading6(String text) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
            alignment: Alignment.center,
            height: 42,
            width: 280,
            child: Text(
              text,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading6(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  static Container disabledGreyButton(double containerHeight, String text,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffDDE1E6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            alignment: Alignment.center,
            height: containerHeight,
            child: Text(
              text,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.bodyMedium(textColor: gray4),
            ),
          ),
        ),
      ),
    );
  }

  static Container facebookSigninButton() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kLight2,
        border: Border.all(
          color: gray6,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/social/facebook.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Facebook',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodyMedium(textColor: kDark5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Container googleSigninButton() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/social/google.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Gmail',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodyMedium(textColor: kDark5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // signup screen==============================================================

  static Container facebookSignupButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xff878D96),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/social/facebook.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 26,
                width: 260,
                child: Text(
                  'Facebook',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading5(textColor: kDark5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Container googleSignupButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xff878D96),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/social/google.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 26,
                width: 260,
                child: Text(
                  'Gmail',
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading5(textColor: kDark5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Container emailButton() {
    return Container(
      height: 50,
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
                    width: 16,
                  ),
                  SvgPicture.asset(
                    "images/email.svg",
                    color: Color(0xffFCFCFD),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 26,
                    width: 260,
                    child: Text(
                      'Email',
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.heading5(textColor: gray7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //forgot password==========================================================
  static Container cancelButtonForgotPassword() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xffDDE1E6),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 136,
              child: Text(
                'Cancel',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.heading6(textColor: gray4),
              ),
            )),
      ),
    );
  }

  static Container confirmButtonForgotPassword() {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 42,
            width: 136,
            alignment: Alignment.center,
            child: Text(
              'Confirm',
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: MmmTextStyles.heading6(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  //profile setup screen=====================================================
  static Container habitsEnabled(
      double containerheight, double containerwidth, String icon, String text) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFF4D6D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xffF0EFF5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xffFF4D6D).withOpacity(0.24),
              blurRadius: 14.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 4.0),
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: containerheight,
            //width: containerwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //SizedBox(
                //   width: 12,
                // ),
                SvgPicture.asset(
                  icon,
                  color: Color(0xffFCFCFD),
                  fit: BoxFit.cover,
                ),
                // SizedBox(
                //   width: 8,
                // ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                  style: MmmTextStyles.bodyRegular(textColor: gray7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container habitsDisabled(
      double containerheight, double containerwidth, String icon, String text,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF0EFF5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            height: containerheight,
            // width: containerwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //SizedBox(
                //   width: 12,
                //  ),
                SvgPicture.asset(
                  icon,
                  color: Color(0xff121619),
                  fit: BoxFit.cover,
                ),
                // SizedBox(
                //   width: 8,
                // ),
                Text(
                  text,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //sidebar navigation=======================================================
  static Container changePasswordSidebarNavigation() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 58,
            width: 342,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    "images/passwordChange.svg",
                    color: Color(0xff121619),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 26,
                  width: 147,
                  child: Text(
                    'Change Password',
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.start,
                    style: MmmTextStyles.bodyMedium(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  width: 107,
                ),
                Container(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(
                    "images/rightArrow.svg",
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container logoutSidebarNavigation() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 58,
            width: 342,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    "images/lock.svg",
                    color: Color(0xff121619),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 26,
                  width: 139,
                  child: Text(
                    'Logout',
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.start,
                    style: MmmTextStyles.bodyMedium(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  width: 115,
                ),
                Container(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    "images/rightArrow.svg",
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container deleteAccountSidebarNavigation() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 58,
            width: 342,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    "images/userDelete.svg",
                    color: Color(0xff121619),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 26,
                  width: 139,
                  child: Text(
                    'Delete Account',
                    textAlign: TextAlign.start,
                    textScaleFactor: 1.0,
                    style: MmmTextStyles.bodyMedium(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  width: 115,
                ),
                Container(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    "images/rightArrow.svg",
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //search screen=============================================================

  static Container searchScreenButtons(String icon, String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            child: Container(
              height: 58,
              width: 328,
              padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    color: Color(0xff343A3F),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 26,
                    width: 184,
                    child: Text(
                      text,
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.start,
                      style: MmmTextStyles.bodyRegular(textColor: kDark5),
                    ),
                  ),
                  SizedBox(
                    width: 58,
                  ),
                  SvgPicture.asset(
                    "images/rightArrow.svg",
                    height: 20,
                    width: 20,
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  //meet screen==============================================================
  static Container virtualDateMeetScreen() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: Color(0xff121619),
          )),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 328,
            child: Text(
              'Virtual Date',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading5(textColor: kDark5),
            ),
          ),
        ),
      ),
    );
  }

  static Container cancelButtonBookYourDate() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff878D96),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 136,
              child: Text(
                'Cancel',
                textAlign: TextAlign.center,
                style: MmmTextStyles.heading5(textColor: Color(0xffF9F9FB)),
              ),
            )),
      ),
    );
  }

  static Container cancelButtonMeet() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffDDE1E6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 28,
            width: 76,
            child: Text(
              'Cancel',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.captionBold(textColor: kDark5),
            ),
          ),
        ),
      ),
    );
  }

  static Container cancelButtonBookyourlocation() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffDDE1E6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 38,
            width: 136,
            child: Text(
              'Cancel',
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading6(textColor: kDark5),
            ),
          ),
        ),
      ),
    );
  }

  static Container rescheduleButtonMeet() {
    return Container(
      height: 28,
      width: 127,
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
                    width: 16,
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      "images/Calendar.svg",
                      color: Color(0xffFCFCFD),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 71,
                    child: Text(
                      'Reschedule',
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.captionBold(textColor: gray7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //fliter screen=============================================================
  static Container preferenceFliterScreen(String text) {
    return Container(
      height: 48,
      width: 327,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xffF0EFF5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 26,
                width: 145,
                child: Text(
                  text,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                  style: MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ),
              SizedBox(
                width: 130,
              ),
              SvgPicture.asset(
                "images/rightArrow.svg",
                width: 24,
                height: 24,
                color: Color(0xff878D96),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Container acceptInterestScreen() {
    return Container(
      height: 28,
      width: 91,
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
                    width: 12,
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      "images/heart.svg",
                      color: Color(0xffFCFCFD),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 43,
                    child: Text(
                      'Accept',
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.caption(textColor: gray7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container cancelButtonInterestScreen() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffF0EFF5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 28,
            width: 67,
            child: Text(
              'Cancel',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.caption(textColor: kDark5),
            ),
          ),
        ),
      ),
    );
  }

  static Container rejectButtonInterestScreen() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffF0EFF5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 28,
            width: 61,
            child: Text(
              'Reject',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.caption(textColor: kDark5),
            ),
          ),
        ),
      ),
    );
  }

  //fliter screen===========================================================
  static Container verifyAccountFliterScreen() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF0EFF5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffDDE1E6),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 87,
            width: 343,
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                ),
                Container(
                  height: 39,
                  width: 41.1,
                  child: SvgPicture.asset(
                    "images/verifiedCheck.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 190.9,
                  height: 26,
                  child: Text(
                    'Verify your account',
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: MmmTextStyles.heading5(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(left: 15),
                  child: SvgPicture.asset(
                    "assets/icons/rightArrow.svg",
                    color: Color(0xff343A3F),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container interestSelected() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xffF0EFF5),
            width: 1,
          ),
          color: kShadowColorForPink,
          boxShadow: [
            BoxShadow(
              color: kShadowColorForPink.withOpacity(0.12),
              blurRadius: 22.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 12.0),
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 74,
            width: 156,
            padding: EdgeInsets.fromLTRB(40, 24, 40, 24),
            child: Row(
              children: [
                SvgPicture.asset(
                  'images/interests/games.svg',
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Sports',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.bodyMediumSmall(textColor: gray7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget backButton(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
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
    );
  }

  static Widget buildOptionSelectWidget(
      String hint, String iconName, String? text,
      {Function()? action}) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          color: kLight4,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: kDark2),
        ),
        child: InkWell(
          onTap: action,
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  text != null ? text : hint,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                  style: text != null
                      ? MmmTextStyles.bodyRegular(textColor: kDark2)
                      : MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              SvgPicture.asset(
                "images/$iconName.svg",
                width: 24,
                height: 24,
                color: Color(0xff878D96),
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ));
  }
}
