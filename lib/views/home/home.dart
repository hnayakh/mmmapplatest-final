import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/custom_drawer.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/notifications/notification_list.dart';
import 'package:makemymarry/views/stackviewscreens/search_screen.dart';

import '../../locator.dart';
import '../profile_detail_view/profile_view_bloc.dart';
import 'interests/views/interest_status_screen.dart';
import 'matching_profile/views/matching_profile.dart';
import 'menu/wallet/recharge/recharge_connect_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  final screenName;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile> premiumList;
  final List<MatchingProfile> recentViewList;
  final List<MatchingProfile> profileVisitorList;
  final List<MatchingProfile> onlineMembersList;
  final bool firstTime;

  const HomeScreen({
    Key? key,
    required this.userRepository,
    required this.list,
    required this.premiumList,
    required this.screenName,
    required this.searchList,
    required this.recentViewList,
    required this.profileVisitorList,
    required this.onlineMembersList,
    required this.firstTime,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  var index = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(widget.firstTime) {
        var response = await getIt<UserRepository>().fetchCurrentBalance();
        if (response.status == AppConstants.SUCCESS) {
          if (response.balance <= 0) {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return MmmWidgets.lowBalanceWidget(
                  message : 'Recharge Your Wallet to Connect Instantly',
                  onConfirm: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            RechargeConnect(
                              userRepository: getIt<UserRepository>(),
                            ),
                      ),
                    );
                  },
                );
              },
            );
          }
        }
      }
    });
    super.initState();
  }

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
              MmmWidgets.bottomBarUnits('images/home.svg', 'Home',
                  (index == 0 || index == -1) ? kPrimary : gray3, action: () {
                setState(() {
                  this.index = -1;
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
            ],
          ),
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
        ),
      ),
    );
  }

  Widget getContent() {
    switch (index) {
      case -1:
        return MatchingProfileScreen(
          list: widget.list,
        );

      case 0:
        return MatchingProfileScreen(
          list: widget.list,
        );
      case 1:
        return
            // ScheduleMeetingTime();
            BlocProvider(
          create: (context) =>
              ProfileViewBloc(widget.userRepository, ProfileDetails()),
          child: SearchScreen(
            userRepository: widget.userRepository,
            list: widget.list,
            searchList: widget.searchList,
            premiumList: widget.premiumList,
            recentViewList: widget.recentViewList,
            profileVisitorList: widget.profileVisitorList,
            onlineMembersList: widget.onlineMembersList,
          ),
        );
      //     PartnerPrefsScreen(
      //   userRepository: widget.userRepository,
      // );
      case 2:
        return Interests(
          userRepository: widget.userRepository,
        );

      case 3:
        return Notifications.getWidget(userRepository: widget.userRepository);
      case 4:
        return AppDrawer(userRepository: widget.userRepository);
    }
    return Container();
  }
}
