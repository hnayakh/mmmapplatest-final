import 'package:flutter/material.dart';
import 'package:makemymarry/utils/colors.dart';

class MmmText extends Text {
  MmmText(String data, TextStyle style, {TextAlign textAlign: TextAlign.left})
      : super(data, textScaleFactor: 1.0, style: style, textAlign: textAlign);
}

class MmmTextStyles {
  static TextStyle heading1({Color textColor: kTextColor}) {
    return TextStyle(
        fontFamily: "MakeMyMarrySemiBold",
        fontSize: 32,
        height: 1.175,
        color: textColor);
  }

  static TextStyle heading2({Color textColor: kTextColor}) {
    return TextStyle(
      fontFamily: "MakeMyMarrySemiBold",
      color: kTextColor,
      fontSize: 28,
      height: 1.571,
    );
  }

  static TextStyle heading3({Color textColor: kTextColor}) {
    return TextStyle(
        fontFamily: "MakeMyMarryMedium",
        fontSize: 24,
        height: 1.583,
        color: textColor);
  }

  static TextStyle heading4({Color textColor: kTextColor}) {
    return TextStyle(
      fontFamily: "MakeMyMarrySemiBold",
      fontSize: 20,
      color: textColor,
      height: 1.6,
    );
  }

  static TextStyle heading5({Color textColor: kTextColor}) {
    return TextStyle(
        fontFamily: "MakeMyMarrySemiBold",
        fontSize: 16,
        height: 1.625,
        color: textColor);
  }

  static TextStyle heading6({Color textColor: kTextColor}) {
    return TextStyle(
        fontFamily: "MakeMyMarrySemiBold",
        fontSize: 14,
        height: 1.285,
        color: textColor);
  }

  static TextStyle bodyMedium({Color textColor: kTextColor}) {
    return TextStyle(
        fontFamily: "MakeMyMarryMedium",
        fontSize: 16,
        height: 1.625,
        color: textColor);
  }

  static TextStyle bodyRegular({Color textColor: kTextColor}) {
    return TextStyle(
      fontFamily: "MakeMyMarry",
      fontSize: 16,
      color: textColor,
      height: 1.625,
    );
  }

  static TextStyle bodySmall({Color textColor: kTextColor}) {
    return TextStyle(
        fontFamily: "MakeMyMarry",
        fontSize: 14,
        height: 1.57,
        color: textColor);
  }

  static TextStyle bodyMediumSmall({Color textColor: kTextColor}) {
    return TextStyle(
      color: textColor,
      fontFamily: "MakeMyMarryMedium",
      fontSize: 14,
      height: 1.57,
    );
  }

  static TextStyle captionBold({Color textColor: kTextColor}) {
    return TextStyle(
        fontFamily: "MakeMyMarrySemiBold",
        fontSize: 12,
        height: 1.666,
        color: textColor);
  }

  static TextStyle caption({Color textColor: kTextColor}) {
    return TextStyle(
        fontFamily: "MakeMyMarry",
        fontSize: 12,
        height: 1.666,
        color: textColor);
  }

  static TextStyle footer({Color textColor: kTextColor}) {
    return TextStyle(
      fontFamily: "MakeMyMarryMedium",
      fontSize: 10,
      color: textColor,
      height: 1.6,
    );
  }
}
