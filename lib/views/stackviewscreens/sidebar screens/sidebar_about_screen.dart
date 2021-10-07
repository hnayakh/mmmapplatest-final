import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class SidebarAboutScreen extends StatelessWidget {
  const SidebarAboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('About'),
      body: Container(
        padding: kMargin16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              'Website',
              style: MmmTextStyles.heading5(textColor: kDark5),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'www.makemymarry.com',
              style: MmmTextStyles.bodyRegular(textColor: kBlack1),
            ),
            SizedBox(
              height: 30,
            ),
            Text('Why MakeMyMarry?',
                style: MmmTextStyles.heading4(
                  textColor: kDark5,
                )),
            SizedBox(
              height: 8,
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 468, maxWidth: double.infinity),
              child: Text(
                'Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.',
                style: MmmTextStyles.bodyRegular(textColor: kBlack1),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: 468, maxWidth: double.infinity),
                child: Text(
                    'For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters.',
                    style: MmmTextStyles.bodyRegular(textColor: kBlack1))),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: 468, maxWidth: double.infinity),
                child: Text(
                    'Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races',
                    style: MmmTextStyles.bodyRegular(textColor: kBlack1)))
          ],
        ),
      ),
    );
  }
}
