import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makemymarry/utils/text_styles.dart';

import '../utils/buttons.dart';
import 'hexcolor.dart';

class RechargeHistory extends StatefulWidget {
  const RechargeHistory({Key? key}) : super(key: key);

  @override
  State<RechargeHistory> createState() => _RechargeHistoryState();
}

class _RechargeHistoryState extends State<RechargeHistory> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var primaryColor = HexColor('C9184A');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: Colors.yellow,
        appBar: MmmButtons.appBarCurved('Recharge History', context: context),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: AppBar(
                  backgroundColor: Colors.white,
                  bottom: TabBar(
                    labelColor: primaryColor,
                    unselectedLabelColor: Colors.black,
                    labelStyle: MmmTextStyles.cardNumber(),
                    unselectedLabelStyle: MmmTextStyles.cardNumber(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: primaryColor,
                    indicatorWeight: 3,
                    tabs: [
                      Tab(
                        child: Text(
                          "Transaction History",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Connect History",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    transHistory(),

                    // second tab bar viiew widget
                    connectHistory()
                  ],
                ),
              )
              // TabBarView(
              //   children: [
              //     Text("1"),
              //     Text("2"),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //

  transHistory() {
    var primaryColor = HexColor('C9184A');
    // images\icons\transaction-icon.png
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Flexible(
        child: ListView(
          shrinkWrap: true,
          children: List.generate(
              20,
              (index) => Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300))),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'images/icons/transaction-icon.png',
                                  height: 20,
                                  width: 20,
                                ),
                                Text(
                                  "10 coonects",
                                  style: MmmTextStyles.heading6(),
                                ),
                              ],
                            ),
                            Text(
                              "#123456",
                              style: MmmTextStyles.caption(),
                            ),
                            Row(
                              children: [
                                Text(
                                  "₹ 200 paid using",
                                  style: MmmTextStyles.captionBold(
                                      textColor: primaryColor),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset('images/icons/g-pay.png')
                              ],
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "₹ 100",
                              style: MmmTextStyles.heading6(),
                            ),
                            // Spacer(),
                            Text(
                              "Repeat",
                              style: MmmTextStyles.captionBold(
                                  textColor: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }

  connectHistory() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Flexible(
        child: ListView(
          shrinkWrap: true,
          children: List.generate(
              20,
              (index) => Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.orange,
                            child: CircleAvatar(
                              radius: 20,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kayla Gale",
                                style: MmmTextStyles.heading6(),
                              ),
                              Text(
                                "31 JUne, 2022 16:54",
                                style: MmmTextStyles.caption(),
                              )
                            ],
                          )
                        ]),
                        Text(
                          "Refund",
                          style: MmmTextStyles.captionBold(
                              textColor: Colors.green),
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
