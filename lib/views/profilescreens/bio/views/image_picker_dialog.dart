import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/dimens.dart';

class MmmImagePickerDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MmmImagePickerDialogScreen();
  }
}

class MmmImagePickerDialogScreen extends State<MmmImagePickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            SizedBox(
              height: 52,
            ),
            InkWell(
              child: MmmButtons.expandedButtonWithIcon(
                  "Import from Facebook", "images/social/facebook.svg"),
              onTap: () {
                Navigator.of(context).pop(1);
              },
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              child: MmmButtons.expandedButtonWithIcon(
                  "Import from Gallery", "images/gallery.svg"),
              onTap: () {
                Navigator.of(context).pop(2);
              },
            ),
            SizedBox(
              height: 16,
            ),
            MmmButtons.cameraimportButton(action: () {
              Navigator.of(context).pop(3);
            })
          ],
        ),
        height: 300,
        padding: kMargin16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ));
  }
}
