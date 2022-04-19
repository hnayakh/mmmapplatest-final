import 'package:flutter/material.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/menu/sidebar_account_screen.dart';

import 'filter_screens/filter_screen.dart';
import 'interests/interest_status_screen.dart';
import 'matching_profile/matching_profile.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;

  const HomeScreen({Key? key, required this.userRepository, required this.list})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getContent(),
      backgroundColor: gray5,
      bottomNavigationBar: BottomAppBar(
        elevation: 4.0,
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MmmWidgets.bottomBarUnits(
                  'images/home.svg', 'Home', index == 0 ? kPrimary : gray3,
                  action: () {
                setState(() {
                  this.index = 0;
                });
              }),
              MmmWidgets.bottomBarUnits('images/filter2.svg', 'Interests',
                  index == 1 ? kPrimary : gray3, action: () {
                setState(() {
                  this.index = 1;
                });
              }),
              MmmWidgets.bottomBarUnits('images/connect.svg', 'Connect',
                  index == 2 ? kPrimary : gray3, action: () {
                setState(() {
                  this.index = 2;
                });
              }),
              MmmWidgets.bottomBarUnits('images/filter2.svg', 'Notifications',
                  index == 3 ? kPrimary : gray3, action: () {
                setState(() {
                  this.index = 3;
                });
              }),
              MmmWidgets.bottomBarUnits(
                  'images/menu.svg', 'More', index == 4 ? kPrimary : gray3,
                  action: () {
                setState(() {
                  this.index = 4;
                });
              })
            ],
          ),
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
        ),
      ),
    );
  }

  Widget getContent() {
    switch (index) {
      case 0:
        return MatchingProfileScreen(
          userRepository: widget.userRepository,
          list: widget.list,
        );
      case 1:
        return Interests(
          userRepository: widget.userRepository,
        );
      case 4:
        return SidebarAccount(
          userRepository: widget.userRepository,
        );
    }
    return Container();
  }
}
