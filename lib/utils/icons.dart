import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';

class MmmIcons {
  static Container heart() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimary, kSecondary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        border: Border.all(
          color: Color(0xffFFFFFF),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff3D4B5C).withOpacity(0.10),
            blurRadius: 50.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 30.0),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset(
                "images/heart.svg",
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container meet() {
    return Container(
      //height: 48,
      //width: 48,

      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimary, kSecondary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        border: Border.all(
          color: Color(0xffFFFFFF),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff3D4B5C).withOpacity(0.10),
            blurRadius: 50.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 30.0),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset(
                "images/meet.svg",
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container cancel() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimary, kSecondary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        border: Border.all(
          color: Color(0xffFFFFFF),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff3D4B5C).withOpacity(0.10),
            blurRadius: 50.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 30.0),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset(
                "images/cancel.svg",
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container connect() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimary, kSecondary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        border: Border.all(
          color: Color(0xffFFFFFF),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff3D4B5C).withOpacity(0.10),
            blurRadius: 50.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 30.0),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset(
                "images/connect.svg",
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container video() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFF758F),
        border: Border.all(
          color: Color(0xffFFFFFF),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff3D4B5C).withOpacity(0.10),
            blurRadius: 50.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 30.0),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 34,
              width: 34,
              padding: EdgeInsets.all(9),
              child: SvgPicture.asset(
                "images/video.svg",
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container chat() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFF758F),
        border: Border.all(
          color: Color(0xffFFFFFF),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff3D4B5C).withOpacity(0.10),
            blurRadius: 50.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 30.0),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 34,
              width: 34,
              padding: EdgeInsets.all(9),
              child: SvgPicture.asset(
                "images/chat.svg",
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container call() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFF758F),
        border: Border.all(
          color: Color(0xffFFFFFF),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff3D4B5C).withOpacity(0.10),
            blurRadius: 50.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 30.0),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 34,
              width: 34,
              padding: EdgeInsets.all(9),
              child: SvgPicture.asset(
                "images/call.svg",
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container rightArrowDisabled() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffDDE1E6),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 45,
              width: 45,
              padding: EdgeInsets.fromLTRB(14, 13, 12, 13),
              child: SvgPicture.asset(
                "images/rightArrow.svg",
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container rightArrowEnabled() {
    return Container(
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
            onTap: () {},
            child: Container(
              height: 45,
              width: 45,
              padding: EdgeInsets.fromLTRB(14, 13, 12, 13),
              child: SvgPicture.asset(
                "images/rightArrow.svg",
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
