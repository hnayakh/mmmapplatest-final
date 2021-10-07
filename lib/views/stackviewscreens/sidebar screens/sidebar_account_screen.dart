import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/dimens.dart';

class SidebarAccountScreen extends StatelessWidget {
  const SidebarAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Account'),
      body: Container(
        padding: kMargin16,
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            MmmButtons.searchButtons(
                'images/passwordChange.svg', 'Change Password'),
            SizedBox(
              height: 16,
            ),
            MmmButtons.searchButtons('images/lock.svg', 'Logout'),
            SizedBox(
              height: 16,
            ),
            MmmButtons.searchButtons('images/userDelete.svg', 'Delete Account'),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
