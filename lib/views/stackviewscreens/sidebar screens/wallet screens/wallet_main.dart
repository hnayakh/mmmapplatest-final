import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/wallet%20screens/select_connects_bottom_sheet.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Wallet'),
      body: SingleChildScrollView(
        child: Container(
          padding: kMargin16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 16,
              ),
              Text(
                'Unlock your happiness \n           per connects',
                style: MmmTextStyles.heading4(textColor: kDark5),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: MmmDecorations.primaryGradient(),
                ),
                child: SvgPicture.asset(
                  'images/Gift.svg',
                  color: kLight4,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  SvgPicture.asset('images/Check.svg'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Unlimited calls per connect',
                    style: MmmTextStyles.bodySmall(textColor: gray3),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  SvgPicture.asset('images/Check.svg'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Unlimited messages per connect',
                    style: MmmTextStyles.bodySmall(textColor: gray3),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  SvgPicture.asset('images/Check.svg'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Unlimited meets per connect',
                    style: MmmTextStyles.bodySmall(textColor: gray3),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 170,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: MmmDecorations.primaryGradient(),
                  boxShadow: [MmmShadow.elevation3()],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Number of connects available',
                      style: MmmTextStyles.bodyMedium(textColor: kLight2),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '05 Connects',
                      style: MmmTextStyles.heading3(textColor: kLight2),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '*you can connect with 5 people',
                      style: MmmTextStyles.bodySmall(textColor: kLight2),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MmmButtons.walletButtons('Buy Connects', action: () {
                selectConnectsBottomSheet(context);
              })
            ],
          ),
        ),
      ),
    );
  }

  void selectConnectsBottomSheet(BuildContext context) async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => SelectConnectsBottomSheet());
  }
}
