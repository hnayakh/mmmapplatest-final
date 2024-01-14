import 'package:flutter/material.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge_history/transaction_screen.dart';

import '../connect_history/connect_history_screen.dart';

class RechargeHistory extends StatefulWidget {
  final UserRepository userRepository;

  const RechargeHistory({Key? key, required this.userRepository})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RechargeHistoryState();
  }
}

class RechargeHistoryState extends State<RechargeHistory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Recharge history', context: context),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              onTap: (pos) {
                setState(() {});
              },
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 4.0,
                    color: kPrimary,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16.0)),
              automaticIndicatorColorAdjustment: true,
              labelColor: kPrimary,
              labelStyle: MmmTextStyles.heading6(),
              unselectedLabelColor: kDark5,
              unselectedLabelStyle: MmmTextStyles.heading6(),
              tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Transactions',
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Connect Details',
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Transaction(
                  userRepository: widget.userRepository,
                ),
                ConnectHistory(
                  userRepository: widget.userRepository,
                ),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
