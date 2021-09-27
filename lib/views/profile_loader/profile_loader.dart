import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/home.dart';
import 'package:makemymarry/views/profile_loader/profile_loader_bloc.dart';
import 'package:makemymarry/views/profile_loader/profile_loader_state.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view.dart';

import 'profile_loader_event.dart';

class ProfileLoader extends StatelessWidget {
  final UserRepository userRepository;

  const ProfileLoader({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileLoaderBloc(userRepository),
      child: ProfileLoaderScreen(),
    );
  }
}

class ProfileLoaderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileLoaderScreenState();
  }
}

class ProfileLoaderScreenState extends State<ProfileLoaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<ProfileLoaderBloc, ProfileLoaderState>(
        builder: (context, state) {
          if (state is ProfileLoaderInitialState) {
            BlocProvider.of<ProfileLoaderBloc>(context).add(GetProfiles());
          }
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "images/app_loader4.gif",
                      width: 96,
                      height: 96,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  child: Text(
                    "Please Wait while we are matching your profile.",
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                    style: MmmTextStyles.heading4(textColor: kPrimary),
                  ),
                  padding: kMargin16,
                )
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is OnGotProfiles) {
            navigateToViewProfiles(state.list);
          }
        },
      )),
    );
  }

  void navigateToViewProfiles(List<MatchingProfile> list) {
    var userRepo = BlocProvider.of<ProfileLoaderBloc>(context).userRepository;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  userRepository: userRepo,
                  list: list,
                )),
        (route) => false);
  }
}
