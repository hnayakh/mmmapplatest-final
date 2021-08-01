import 'package:flutter/cupertino.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';

class MmmDecorations {
  static BoxDecoration primaryButtonDecoration() {
    return BoxDecoration(
        boxShadow: [MmmShadow.elevation3()],
        borderRadius: BorderRadius.circular(8),
        gradient: primaryGradient());
  }

  static BoxDecoration elevation2Decoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: primaryGradient(),
        boxShadow: [MmmShadow.elevation2(shadowColor: kShadowColorForPink)]);
  }

  static BoxDecoration elevation4Decoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: primaryGradient(),
        boxShadow: [MmmShadow.elevation4(shadowColor: kShadowColorForPink)]);
  }

  static LinearGradient primaryGradient() {
    return LinearGradient(
        colors: [kPrimary, kSecondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight);
  }
}
