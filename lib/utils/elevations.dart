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
        color: shadowColor.withAlpha(12),
        offset: Offset(0, 12),
        blurRadius: 22);
  }

  static BoxShadow elevation4({Color shadowColor: kShadowColorForWhite}) {
    return BoxShadow(
        color: shadowColor.withAlpha(12),
        offset: Offset(0, 16),
        blurRadius: 16);
  }
}
