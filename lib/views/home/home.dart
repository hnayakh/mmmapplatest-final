import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';
import 'package:makemymarry/views/home/menu/sidebar_account_screen.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_screen.dart';
import 'package:makemymarry/views/stackviewscreens/notification_list.dart';

import 'interests/interest_status_screen.dart';
import 'matching_profile/matching_profile.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  // final List<PremiumMembers> list;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile> premiumList;

  const HomeScreen(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.premiumList,
      required this.searchList})
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
              MmmWidgets.bottomBarUnits('images/connect.svg', 'Connects',
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
        return BlocProvider<MatchingProfileBloc>(
            create: (context) => MatchingProfileBloc(widget.userRepository,
                widget.list, widget.searchList, widget.premiumList),
            child: Builder(builder: (context) {
              return MatchingProfileScreen(
                userRepository: widget.userRepository,
                list: widget.list,
                searchList: widget.searchList,
                screenName: null,
              );
            }));
      case 1:
        return Interests(
          userRepository: widget.userRepository,
        );
      case 2:
        return MyConnects(userRepository: widget.userRepository);
      case 3:
        return Notifications(userRepository: widget.userRepository);
      case 4:
        return SidebarAccount(
          userRepository: widget.userRepository,
          list: widget.list,
          searchList: widget.searchList,
          premiumList: widget.premiumList,
        );
    }
    return Container();
  }
}
