import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class ContactSupportScreen extends StatelessWidget {
  final UserRepository userRepository;
  const ContactSupportScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Contact support', context: context),
      body: Container(
        padding: kMargin16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text('Website',
                style: MmmTextStyles.heading5(
                  textColor: kDark5,
                )),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('images/web.svg'),
                SizedBox(
                  width: 5,
                ),
                Text('www.makemymarry.com')
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: gray6,
              thickness: 1,
            ),
            SizedBox(
              height: 16,
            ),
            Text('Email',
                style: MmmTextStyles.heading5(
                  textColor: kDark5,
                )),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('images/email.svg'),
                SizedBox(
                  width: 5,
                ),
                Text('help@makemymarry.com'),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: gray6,
              thickness: 1,
            ),
            SizedBox(
              height: 16,
            ),
            Text('Mobile',
                style: MmmTextStyles.heading5(
                  textColor: kDark5,
                )),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('images/call.svg'),
                SizedBox(
                  width: 5,
                ),
                Text('+91-9871743030'),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: gray6,
              thickness: 1,
            ),
            SizedBox(
              height: 24,
            ),
            MmmButtons.facebookSignupButton(),
            SizedBox(
              height: 16,
            ),
            MmmButtons.instagramButton()
          ],
        ),
      ),
    );
  }
}
