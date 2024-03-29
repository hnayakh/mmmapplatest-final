import 'package:flutter/material.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/matching_profile/views/matching_profile.dart';
import 'package:makemymarry/views/home/menu/sidebar_account_screen.dart';
import 'package:makemymarry/views/home/notifications/notification_list.dart';
import 'package:makemymarry/views/stackviewscreens/search_screen.dart';

import '../home/interests/views/interest_status_screen.dart';

class PremiumMembersScreen extends StatefulWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  final List<MatchingProfile> premiumList;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile> recentViewList;
  final List<MatchingProfile> profileVisitorList;
  final List<MatchingProfile> onlineMembersList;
  final String? screenName;
  final String? searchText;
  PremiumMembersScreen(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.premiumList,
      required this.searchList,
      required this.screenName,
      required this.recentViewList,
      required this.profileVisitorList,
      required this.onlineMembersList,
      this.searchText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PremiumMembersScreenState();
  }

  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) =>
  //         MatchingProfileBloc(userRepository, list, searchList),
  //     child: PremiumMembersScreen(
  //       userRepository: userRepository,
  //       list: list,
  //       searchList: searchList,
  //     ),
  //   );
  // }
}

class PremiumMembersScreenState extends State<PremiumMembersScreen> {
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
              MmmWidgets.bottomBarUnits(
                  'images/filter2.svg', 'Filter', index == 1 ? kPrimary : gray3,
                  action: () {
                setState(() {
                  this.index = 1;
                });
              }),
              MmmWidgets.bottomBarUnits('images/Frame.svg', 'Interests',
                  index == 2 ? kPrimary : gray3, action: () {
                setState(() {
                  this.index = 2;
                });
              }),
              // MmmWidgets.bottomBarUnits('images/connect.svg', 'Connects',
              //     index == 2 ? kPrimary : gray3, action: () {
              //   setState(() {
              //     this.index = 3;
              //   });
              // }),
              MmmWidgets.bottomBarUnits('images/noti.svg', 'Notifications',
                  index == 3 ? kPrimary : gray3, action: () {
                setState(() {
                  this.index = 3;
                });
              }),
              MmmWidgets.bottomBarUnits(
                  'images/menu.svg', 'Menu', index == 4 ? kPrimary : gray3,
                  action: () {
                setState(() {
                  this.index = 4;
                });
              })
              // MmmWidgets.bottomBarUnits(
              //     'images/home.svg', 'Home', index == 0 ? kPrimary : gray3,
              //     action: () {
              //   setState(() {
              //     this.index = 0;
              //   });
              // }),
              // MmmWidgets.bottomBarUnits('images/filter2.svg', 'Interests',
              //     index == 1 ? kPrimary : gray3, action: () {
              //   setState(() {
              //     this.index = 1;
              //   });
              // }),
              // MmmWidgets.bottomBarUnits('images/connect.svg', 'Connects',
              //     index == 2 ? kPrimary : gray3, action: () {
              //   setState(() {
              //     this.index = 2;
              //   });
              // }),
              // MmmWidgets.bottomBarUnits('images/filter2.svg', 'Notifications',
              //     index == 3 ? kPrimary : gray3, action: () {
              //   setState(() {
              //     this.index = 3;
              //   });
              // }),
              // MmmWidgets.bottomBarUnits(
              //     'images/menu.svg', 'More', index == 4 ? kPrimary : gray3,
              //     action: () {
              //   setState(() {
              //     this.index = 4;
              //   });
              // })
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
        return MatchingProfileScreen(list: widget.list,);
      case 1:
        return
            // ScheduleMeetingTime();
            SearchScreen(
          userRepository: widget.userRepository,
          list: widget.list,
          searchList: widget.searchList,
          premiumList: widget.premiumList,
          recentViewList: widget.recentViewList,
          profileVisitorList: widget.profileVisitorList,
          onlineMembersList: widget.onlineMembersList,
        );
      case 2:
        return
            // ScheduleMeetingTime();
            Interests(
          userRepository: widget.userRepository,
        );
      // case 3:
      //   return MyConnects(userRepository: widget.userRepository);
      case 3:
        return Notifications(userRepository: widget.userRepository);
      //return MeetStatusScreen();
      // return ProfileDetailsScreen();

      case 4:
        return SidebarAccount(
          userRepository: widget.userRepository,
          list: widget.list,
          searchList: widget.searchList,
          premiumList: widget.premiumList,
          recentViewList: widget.recentViewList,
          profileVisitorList: widget.profileVisitorList,
          onlineMembersList: widget.onlineMembersList,
        );
      // case 1:
      //   return Interests(
      //     userRepository: widget.userRepository,
      //   );
      // case 2:
      //   return MyConnects(userRepository: widget.userRepository);
      // case 3:
      //   return Notifications(userRepository: widget.userRepository);
      // case 4:
      //   return SidebarAccount(
      //     userRepository: widget.userRepository,
      //     list: widget.list,
      //     searchList: widget.searchList,
      //     premiumList: widget.premiumList,
      //   );
    }
    return Container();
  }
}
