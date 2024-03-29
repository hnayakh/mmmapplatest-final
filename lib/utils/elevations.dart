import 'package:flutter/material.dart';
import 'package:makemymarry/utils/colors.dart';

class MmmShadow {
  static BoxShadow elevation1({Color shadowColor: kShadowColorForWhite}) {
    return BoxShadow(
        color: shadowColor.withAlpha(12), offset: Offset(0, 4), blurRadius: 14);
  }

  static BoxShadow elevation2({Color shadowColor: kShadowColorForWhite}) {
    return BoxShadow(
        color: shadowColor.withAlpha(16), offset: Offset(0, 8), blurRadius: 18);
  }

  static BoxShadow elevation3({Color shadowColor: kShadowColorForWhite}) {
    return BoxShadow(
        color: shadowColor.withOpacity(0.12),
        offset: Offset(0, 12),
        blurRadius: 22);
  }

  static BoxShadow elevation4({Color shadowColor: kShadowColorForWhite}) {
    return BoxShadow(
        color: shadowColor.withAlpha(12),
        offset: Offset(0, 16),
        blurRadius: 16);
  }

  static BoxShadow elevationStack({Color shadowColor: kShadowColorForWhite}) {
    return BoxShadow(
        color: shadowColor.withAlpha(12),
        offset: Offset(0, -4),
        blurRadius: 22);
  }

  static BoxShadow elevationbBackButton(
      {Color shadowColor: kShadowColorForWhite}) {
    return BoxShadow(
        color: kShadowColorForWhite.withAlpha(7),
        offset: Offset(0, 10),
        blurRadius: 25,
        spreadRadius: 8);
  }

  static BoxShadow gridViewButton({Color shadowColor: kShadowColorForGrid}) {
    return BoxShadow(
        color: kShadowColorForWhite.withOpacity(0.08),
        offset: Offset(0, 15),
        blurRadius: 200,
        spreadRadius: 8);
  }

  static BoxShadow textFieldMessaging(
      {Color shadowColor: kShadowColorForGrid}) {
    return BoxShadow(
        color: kShadowColorForWhite.withOpacity(0.08),
        offset: Offset(0, 20),
        blurRadius: 40,
        spreadRadius: 0);
  }

  static BoxShadow filterButton({Color shadowColor: kShadowColorForGrid}) {
    return BoxShadow(
        color: kShadowColorForWhite.withOpacity(0.08),
        offset: Offset(0, 15),
        blurRadius: 30,
        spreadRadius: 0);
  }
}
