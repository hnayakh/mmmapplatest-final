import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/app/bloc/app_bloc.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/view_decorations.dart';

import '../views/chat_room/chat_page.dart';

class MmmIcons {
  static Container heart(Color color, {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimaryHeart, kSecondary],
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
            onTap: action,
            child: Container(
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset(
                "images/heart.svg",
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container meet(context, {Function()? action}) {
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
            onTap: action,
            child: Container(
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset(
                "images/meet.svg",
                width: 29,
                color: gray7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget largeConnect({Function()? action, bool isHalf = false}) {
    return InkWell(
      onTap: () {
        action?.call();
      },
      child: Container(
        height: isHalf ? 56 : 64,
        width: isHalf ? 56 : 64,
        child: Center(
          child: SvgPicture.asset(
            "images/connect.svg",
            color: Colors.white,
            height: 32,
            width: 32,
          ),
        ),
        foregroundDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimary.withAlpha(50),
            border: Border.all(color: Colors.white, width: 1.2)),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: MmmDecorations.primaryGradient(),
            border: Border.all(color: Colors.white, width: 1.2)),
      ),
    );
  }

  static Container cancel({
    Function()? action,
    Function()? longAction,
  }) {
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
            onTap: action,
            onLongPress: longAction,
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

  static Widget largeCancel({required Function() action, bool isHalf = false}) {
    return InkWell(
      onTap: () {
        action.call();
      },
      child: Container(
        height: isHalf ? 56 : 64,
        width: isHalf ? 56 : 64,
        child: Center(
          child: SvgPicture.asset(
            "images/cancel.svg",
            color: Colors.white,
            height: 32,
            width: 32,
          ),
        ),
        foregroundDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimary.withAlpha(50),
            border: Border.all(color: Colors.white, width: 1.2)),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: MmmDecorations.primaryGradient(),
            border: Border.all(color: Colors.white, width: 1.2)),
      ),
    );
  }

  static Widget largeAccept({required Function() action, bool isHalf = false}) {
    return InkWell(
      onTap: () {
        action.call();
      },
      child: Container(
        height: isHalf ? 56 : 64,
        width: isHalf ? 56 : 64,
        child: Center(
          child: SvgPicture.asset(
            "images/Check.svg",
            color: Colors.white,
            height: 32,
            width: 32,
          ),
        ),
        foregroundDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimary.withAlpha(50),
            border: Border.all(color: Colors.white, width: 1.2)),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimary,
            border: Border.all(color: Colors.white, width: 1.2)),
      ),
    );
  }

  static Widget largeReject({required Function() action, bool isHalf = false}) {
    return InkWell(
      onTap: () {
        action.call();
      },
      child: Container(
        height: isHalf ? 56 : 64,
        width: isHalf ? 56 : 64,
        child: Center(
          child: SvgPicture.asset(
            "images/Cross.svg",
            color: Colors.white,
            height: 32,
            width: 32,
          ),
        ),
        foregroundDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kGray.withAlpha(50),
            border: Border.all(color: Colors.white, width: 1.2)),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kGray,
            // gradient: MmmDecorations.primaryGradient(),
            border: Border.all(color: Colors.white, width: 1.2)),
      ),
    );
  }

  static Widget largeHeart({required Function() action, bool isHalf = false}) {
    return InkWell(
      onTap: () {
        action.call();
      },
      child: Container(
        height: isHalf ? 32 : 64,
        width: isHalf ? 32 : 64,
        child: Center(
          child: SvgPicture.asset(
            "images/heart.svg",
            color: Colors.white,
            height: 32,
            width: 32,
          ),
        ),
        foregroundDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimary.withAlpha(50),
            border: Border.all(color: Colors.white, width: 1.2)),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: MmmDecorations.primaryGradient(),
            border: Border.all(color: Colors.white, width: 1.2)),
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

  static Container video(Future<void> Function() onPress) {
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
            onTap: () async {
              await onPress.call();
            },
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

  static Container chat(BuildContext context, String userId,
      Future<void> Function() onTap, dynamic profileDetails) {
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
            onTap: () async {
              await onTap.call();
              context.read<AppBloc>().connectNow(
                  otherUserId: userId,
                  onDone: () async {
                    navigatorKey.currentState?.push((await ChatPage.getRoute(
                        navigatorKey.currentContext!, userId)));
                  },
                  onError: () async {},
                  profileDetails: profileDetails,
                  context: context);
            },
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

  static Widget largeChat(
      BuildContext context, String userId, Future<void> Function() onTap,
      {bool isHalf = false}) {
    return InkWell(
        onTap: () async {
          await onTap.call();
          // navigatorKey.currentState?.push((await ChatPage.getRoute(context, userId)));
        },
        child: Container(
          height: isHalf ? 56 : 64,
          width: isHalf ? 56 : 64,
          child: Center(
            child: SvgPicture.asset(
              "images/chat.svg",
              color: Colors.white,
              height: 32,
              width: 32,
            ),
          ),
          foregroundDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimary.withAlpha(50),
              border: Border.all(color: Colors.white, width: 1.2)),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: MmmDecorations.primaryGradient(),
              border: Border.all(color: Colors.white, width: 1.2)),
        ));
  }

  static Container call(Future<void> Function() onPress) {
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
            onTap: () async {
              await onPress.call();
            },
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
        color: gray5,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 48,
            width: 48,
            padding: EdgeInsets.fromLTRB(14, 13, 12, 13),
            child: SvgPicture.asset(
              "images/rightArrow.svg",
              color: gray7,
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
          child: Container(
            height: 54,
            width: 54,
            padding: EdgeInsets.fromLTRB(14, 13, 12, 13),
            child: SvgPicture.asset(
              "images/rightArrow.svg",
              color: gray7,
            ),
          ),
        ),
      ),
    );
  }

  //Save Icons

  static Container saveIcon() {
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
          child: Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Center(
                child: Icon(
              Icons.save,
              color: gray5,
            )),
          ),
        ),
      ),
    );
  }

//Edit icon
  static Container editIcon() {
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
          child: Container(
            height: 27,
            width: 27,
            // padding: EdgeInsets.fromLTRB(14, 13, 12, 13),
            child: SvgPicture.asset(
              "images/pencil.svg",
              color: gray7,
            ),
          ),
        ),
      ),
    );
  }
}
