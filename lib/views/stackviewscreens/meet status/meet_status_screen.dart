import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/stackviewscreens/meet%20status/meet_accepted.dart';
import 'package:makemymarry/views/stackviewscreens/meet%20status/meet_received.dart';
import 'package:makemymarry/views/stackviewscreens/meet%20status/meet_sent.dart';

class MeetStatusScreen extends StatefulWidget {
  const MeetStatusScreen({Key? key}) : super(key: key);

  @override
  _MeetStatusScreenState createState() => _MeetStatusScreenState();
}

class _MeetStatusScreenState extends State<MeetStatusScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

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
                  preferredSize:
                      Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
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
                    toolbarHeight: MediaQuery.of(context).size.height * 0.108,
                    title: Text(
                      "Interests",
                      style: MmmTextStyles.heading4(textColor: kLight2),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ))),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kPrimary, kSecondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
              ),
            ),
            TabBar(
              controller: tabController,
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
                      'Sent',
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Received',
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Accepted',
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [MSentScreen(), MReceivedScreen(), MAcceptedScreen()],
            ))
          ],
        ),
      ),
    );
  }
}
