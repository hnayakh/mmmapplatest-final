import 'package:flutter/material.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';

class MmmButtons {
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
}
