import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class AppPaymentBottomSheet extends StatefulWidget {
  const AppPaymentBottomSheet({Key? key}) : super(key: key);

  @override
  _AppPaymentBottomSheetState createState() => _AppPaymentBottomSheetState();
}

class _AppPaymentBottomSheetState extends State<AppPaymentBottomSheet> {
  List<String> appNames = ['Phone Pe', 'Google Pay', 'Paytm', 'Amazon Pay'];
  List<String> icons = [
    'images/phone pe.svg',
    'images/Gpay.svg',
    'images/paytm.svg',
    'images/amazon pay.svg'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kMargin12,
        height: 440,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MmmButtons.backButton(context),
          SizedBox(
            height: 24,
          ),
          Text(
            'Select your app:',
            style: MmmTextStyles.bodyMedium(textColor: kDark5),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: kLight4,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MmmButtons.walletApps(appNames[0], icons[0]),
                  MmmButtons.walletApps(appNames[1], icons[1]),
                  MmmButtons.walletApps(appNames[2], icons[2]),
                  MmmButtons.walletApps(appNames[3], icons[3]),
                  SizedBox(
                    height: 20,
                  ),
                  MmmButtons.enabledRedButtonbodyMedium(50, 'Buy Connects',
                      action: () {}),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        'images/lock.svg',
                        height: 30,
                        color: gray3,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        child: Text(
                          'We only securely save card & expiry details for \nfuture use.',
                          style: MmmTextStyles.captionBold(
                              textColor: kBioSecondary),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
