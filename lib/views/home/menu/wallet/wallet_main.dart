import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_screen.dart';
import 'package:makemymarry/views/home/menu/wallet/wallet_bloc.dart';
import 'package:makemymarry/views/home/menu/wallet/wallet_state.dart';

import 'recharge_history/RechargeHistoryScreen.dart';
import 'wallet_event.dart';

class Wallet extends StatelessWidget {
  final UserRepository userRepository;

  const Wallet({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletBloc(userRepository),
      child: WalletScreen(),
    );
  }
}

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late int balance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Wallet', context: context),
      body: BlocConsumer<WalletBloc, WalletState>(
        builder: (context, state) {
          this.balance = BlocProvider.of<WalletBloc>(context).currentBalance;
          if (state is WalletInitialState) {
            BlocProvider.of<WalletBloc>(context).add(FetchCurrentBalance());
          }
          return Stack(
            children: [
              buildUi(context),
              state is OnLoading
                  ? MmmWidgets.buildLoader2(context)
                  : Container()
            ],
          );
          return buildUi(context);
        },
        listener: (context, state) {},
      ),
    );
  }

  Column buildUi(BuildContext context) {
    return Column(
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
                  'Unlock your happiness\nper connects',
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
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
                    'images/wallet_icon.svg',
                    color: kLight4,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [

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

                    SvgPicture.asset('images/Check.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        'Easily arrange limitless virtual or in-person meetings.',
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodySmall(textColor: gray3),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [

                    SvgPicture.asset('images/Check.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        'Enjoy audio or video calls without the need for contact sharing.',
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodySmall(textColor: gray3),
                      ),
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
                    color: kLight2,
                    boxShadow: [MmmShadow.elevation3(shadowColor: Color(0xffFD0051))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No. of connects available',
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodyRegular(textColor: kTextColor),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${balance.toString().padLeft(2, '0')}',
                            textScaleFactor: 1.0,
                            style: MmmTextStyles.heading3(textColor: kPrimaryHeart),
                          ),
                          SizedBox(width: 4,),
                          SvgPicture.asset('images/connect_count_icon.svg')
                        ],
                      ),

                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        '*you can connect with $balance people',
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodySmall(textColor: kDark5),
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
            onPressed: () {
              var userRepo =
                  BlocProvider.of<WalletBloc>(context).userRepository;

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RechargeHistory(
                        userRepository: userRepo,
                      )));
            },
          ),
        )
      ],
    );
  }

  void selectConnectsBottomSheet(BuildContext context) async {
    var userRepo = BlocProvider.of<WalletBloc>(context).userRepository;
    var response = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RechargeConnect(
              userRepository: userRepo,
            )));

    if (response != null && response is int) {
      BlocProvider.of<WalletBloc>(context).add(AddNewConnects(response));
    }
    // var result = await showModalBottomSheet(
    //     isScrollControlled: true,
    //     backgroundColor: Colors.transparent,
    //     context: context,
    //     builder: (context) => SelectConnectsBottomSheet());
  }
}
