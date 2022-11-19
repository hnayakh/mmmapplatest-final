import 'package:flutter/material.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/success_stories.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/views/signinscreens/signin_screen1.dart';
import 'package:makemymarry/views/stackviewscreens/account.dart';
import 'package:makemymarry/views/stackviewscreens/notification.dart';
import 'package:makemymarry/views/stackviewscreens/privacy.dart';
import 'package:makemymarry/views/stackviewscreens/search_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/hide.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_about_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_change_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_contactsupport_screen.dart';

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
          // SizedBox(
          //   height: 20,
          // ),

          MmmButtons.searchScreenButton('Privacy Setting', action: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      Privacy(userRepository: userRepository)),
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
              MaterialPageRoute(
                  builder: (context) => Hide(userRepository: userRepository)),
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
              MaterialPageRoute(
                  builder: (context) =>
                      NotificationsSwitch(userRepository: userRepository)),
            );
          }),
          MmmButtons.searchScreenButton('Other Settings', action: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           Privacy(userRepository: userRepository)),
            // );
          }),
          MmmButtons.searchScreenButton('Log Out', action: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => SignIn(userRepository: userRepository)),
            );
          }),
          // MmmButtons.searchScreenButton('Account', action: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             Account(userRepository: userRepository)),
          //   );
          // }),
          // MmmButtons.searchScreenButton('Success Story', action: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => SuccessStories()),
          //   );
          // }),
          // // MmmButtons.searchScreenButton('Leave us a review', action: () {}),
          // // MmmButtons.searchScreenButton('FAQ', action: () {}),
          // // MmmButtons.searchScreenButton('Terms and Conditions', action: () {}),
          // MmmButtons.searchScreenButton('Contact Support', action: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             ContactSupportScreen(userRepository: userRepository)),
          //   );
          // }),
          // MmmButtons.searchScreenButton('About', action: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             SidebarAboutScreen(userRepository: userRepository)),
          //   );
          // }),
        ],
      ),
    );
  }
}
