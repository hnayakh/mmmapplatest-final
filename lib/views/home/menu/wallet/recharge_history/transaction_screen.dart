import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/recharge.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge_history/recharge_history_bloc.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge_history/recharge_history_state.dart';

import 'RechargeHistoryEvent.dart';

class Transaction extends StatelessWidget {
  final UserRepository userRepository;

  const Transaction({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RechargeHistoryBloc(userRepository),
      child: TransactionScreen(),
    );
  }
}

class TransactionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransactionScreenState();
  }
}

class TransactionScreenState extends State<TransactionScreen> {
  List<RechargeHistoryItem> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocConsumer<RechargeHistoryBloc, RechargeHistoryState>(
          builder: (context, state) {
            if (state is RechargeHistoryInitialState) {
              BlocProvider.of<RechargeHistoryBloc>(context)
                  .add(GetTransactionHistory());
            }
            this.list = BlocProvider.of<RechargeHistoryBloc>(context).list;
            return Container(
              child: Stack(
                children: [
                  buildList(),
                  state is OnLoading
                      ? MmmWidgets.buildLoader2(context)
                      : Container()
                ],
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            "images/link_4.png",
                            width: 14,
                            height: 14,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: list[index].connectCount.toString(),
                                style: MmmTextStyles.bodyMedium(
                                    textColor: Colors.black)),
                            TextSpan(
                                text: " Connects",
                                style: MmmTextStyles.bodyRegular(
                                    textColor: Colors.black)),
                          ]))
                        ],
                      ),
                    ),
                    Text(
                      "\u{20B9}${list[index].amount.toStringAsFixed(2)}",
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.heading6(textColor: kCoffee),
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${list[index].transactionId}",
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.bodyRegular(textColor: kCoffee),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  AppHelper.getReadableDateTIme(list[index].date),
                  // list[index].date,
                  textScaleFactor: 1.0,
                  style: MmmTextStyles.bodyRegular(textColor: gray1),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}
