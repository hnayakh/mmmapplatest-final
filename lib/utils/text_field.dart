import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/text_styles.dart';

import 'colors.dart';

class MmmTextFileds {
  static Widget textFiledWithLabel(
      String label, String hintText, TextEditingController controller,
      {TextInputType inputType: TextInputType.text, bool isPassword: false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            //padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              label,
              textScaleFactor: 1.0,
              style: MmmTextStyles.bodySmall(textColor: kDark5),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          TextField(
            controller: controller,
            keyboardType: inputType,
            style: MmmTextStyles.bodyRegular(textColor: kDark5),
            cursorColor: kDark5,
            obscureText: isPassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: kDark2, width: 1),
                    borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: kInputBorder, width: 1)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                hintText: hintText,
                isDense: true,
                filled: true,
                fillColor: kLight4,
                hintStyle: MmmTextStyles.bodyRegular(textColor: kDark2)),
          )
        ],
      ),
    );
  }

  static Widget textFiledWithLabelStar(
      String label, String hintText, TextEditingController controller,
      {TextInputType inputType: TextInputType.text, bool isPassword: false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            //padding: const EdgeInsets.only(top: 4, left: 4),
            child: Row(
              children: [
                Text(
                  label,
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
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 50,
            child: TextField(
              controller: controller,
              keyboardType: inputType,
              style: MmmTextStyles.bodyRegular(textColor: kDark5),
              cursorColor: kDark5,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: kDark2, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: kInputBorder, width: 1)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  hintText: hintText,
                  isDense: true,
                  filled: true,
                  fillColor: kLight4,
                  hintStyle: MmmTextStyles.bodyRegular(textColor: kDark2)),
            ),
          ),
        ],
      ),
    );
  }
}
