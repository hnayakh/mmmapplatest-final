import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Setting'),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          MmmButtons.searchScreenButton('Notifications', action: () {}),
          MmmButtons.searchScreenButton('Privacy', action: () {}),
          MmmButtons.searchScreenButton('Account', action: () {}),
          MmmButtons.searchScreenButton('Leave us a review', action: () {}),
          MmmButtons.searchScreenButton('FAQ', action: () {}),
          MmmButtons.searchScreenButton('Terms and Conditions', action: () {}),
          MmmButtons.searchScreenButton('Contact Support', action: () {}),
          MmmButtons.searchScreenButton('About', action: () {}),
        ],
      ),
    );
  }
}
