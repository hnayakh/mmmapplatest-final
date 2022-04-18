import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_screen.dart';

class Wallet extends StatelessWidget {
  final UserRepository userRepository;

  const Wallet({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WalletScreen(
      userRepository: userRepository,
    );
  }
}

class WalletScreen extends StatefulWidget {
  final UserRepository userRepository;

  const WalletScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Wallet', context: context),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
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
                    textScaleFactor: 1.0,
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
                        textScaleFactor: 1.0,
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
                        textScaleFactor: 1.0,
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
                        textScaleFactor: 1.0,
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
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.bodyMedium(textColor: kLight2),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          '05 Connects',
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.heading3(textColor: kLight2),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '*you can connect with 5 people',
                          textScaleFactor: 1.0,
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
          )),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: TextButton(
              child: Text(
                'Recharge History',
                textScaleFactor: 1.0,
                style: MmmTextStyles.bodyRegular(textColor: kPrimary),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  void selectConnectsBottomSheet(BuildContext context) async {
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => RechargeConnect(
    //           userRepository: widget.userRepository,
    //         )));
    // var result = await showModalBottomSheet(
    //     isScrollControlled: true,
    //     backgroundColor: Colors.transparent,
    //     context: context,
    //     builder: (context) => SelectConnectsBottomSheet());
  }
}
