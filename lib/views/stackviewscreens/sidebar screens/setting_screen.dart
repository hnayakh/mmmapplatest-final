import 'package:flutter/material.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/views/signinscreens/signin_page.dart';
import 'package:makemymarry/views/stackviewscreens/account.dart';
import 'package:makemymarry/views/stackviewscreens/notification.dart';
import 'package:makemymarry/views/stackviewscreens/privacy.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/hide.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_change_screen.dart';

class SettingScreen extends StatelessWidget {
  final UserRepository userRepository;

  const SettingScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Setting', context: context),
      body: Column(
        children: [
          MmmButtons.searchScreenButton('Privacy Setting', action: () {
            Navigator.of(context).push(
              Privacy.getRoute(),
            );
          }),
          MmmButtons.searchScreenButton('Change Password', action: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      SidebarChangeScreen(userRepository: userRepository)),
            );
          }),
          MmmButtons.searchScreenButton('Hide/Deactive', action: () {
            Navigator.of(context).push(
              Hide.getRoute(),
            );
          }),
          MmmButtons.searchScreenButton('Delete Profile', action: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      Account(userRepository: userRepository)),
            );
          }),
          MmmButtons.searchScreenButton('Notifications Settings', action: () {
            Navigator.of(context).push(
              NotificationsSwitch.getRoute(),
            );
          }),
          MmmButtons.searchScreenButton('Other Settings', action: () {}),
          MmmButtons.searchScreenButton('Log Out', action: () {
            Navigator.of(context).push(SignInPage.getRoute());
          }),
        ],
      ),
    );
  }
}
