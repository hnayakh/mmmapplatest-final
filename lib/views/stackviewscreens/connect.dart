import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/bio.dart';

import 'chat_screen.dart';
import 'connect_screen.dart';

class ConnectMainScreen extends StatefulWidget {
  ConnectMainScreen({Key? key}) : super(key: key);

  @override
  _ConnectMainScreenState createState() => _ConnectMainScreenState();
}

class _ConnectMainScreenState extends State<ConnectMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: PreferredSize(
                  preferredSize: Size.fromHeight(120.0),
                  child: Container(
                      child: AppBar(
                    leading: Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      decoration: BoxDecoration(
                          color: kLight2.withOpacity(0.60),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            MmmShadow.elevationbBackButton(
                                shadowColor: kShadowColorForWhite)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                height: 32,
                                width: 32,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'images/arrowLeft.svg',
                                  height: 17.45,
                                  width: 17.45,
                                  color: gray3,
                                )),
                          ),
                        ),
                      ),
                    ),
                    toolbarHeight: 74.0,
                    title: Text(
                      "Connects",
                      style: MmmTextStyles.heading4(textColor: kLight2),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ))),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
                gradient: LinearGradient(
                    colors: [kPrimary, kSecondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
              ),
            ),
            IgnorePointer(
                child: TabBar(
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
                      'Chats',
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Connects',
                    ),
                  ),
                )
              ],
            )),
            Expanded(
                child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ChatScreen(),
                ConnectScreen(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
