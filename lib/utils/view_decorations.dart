import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';

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

  static LinearGradient primaryGradientOpacity() {
    return LinearGradient(
        colors: [kPrimary.withOpacity(0.5), kSecondary.withOpacity(0.5)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight);
  }

  static InputDecoration textfieldDecoration(String hintText) {
    return InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: kDark2, width: 1),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: kInputBorder, width: 1)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintText: hintText,
        isDense: true,
        filled: true,
        fillColor: kLight4,
        hintStyle: MmmTextStyles.bodyRegular(textColor: kDark2));
  }

  static BoxDecoration whiteBgBottomShadow() {
    return BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 22,
              spreadRadius: 0,
              color: Color(0X3D4B5C1F)
                  .withOpacity(0.12),
              offset: Offset(0, 12)),
          BoxShadow(
              blurRadius: 12,
              spreadRadius: 0,
              color: Colors.white,
              offset: Offset(2, -12)),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16)));
  }
}
