import 'package:flutter/cupertino.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';

class MmmDecorations {
  static BoxDecoration primaryButtonDecoration() {
    return BoxDecoration(
        boxShadow: [MmmShadow.elevation3()],
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
            colors: [kPrimary, kSecondary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight));
  }
}
