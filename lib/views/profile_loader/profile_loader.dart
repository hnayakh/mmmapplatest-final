import 'package:cloud_firestore/cloud_firestore.dart';
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
      child: ProfileLoaderScreen(
        repo: userRepository,
      ),
    );
  }
}

class ProfileLoaderScreen extends StatefulWidget {
  final UserRepository repo;

  const ProfileLoaderScreen({Key? key, required this.repo}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ProfileLoaderScreenState();
  }
}

class ProfileLoaderScreenState extends State<ProfileLoaderScreen>
    with WidgetsBindingObserver {
  String? userId;

  @override
  void initState() {
    userId = widget.repo.useDetails!.id;
    WidgetsBinding.instance?.addObserver(this);
    setStatus('Online');
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('userid=' + userId!);
    if (userId != null || userId != '') {
      print('ProfileLoad Applifecycle userid not null');
      if (state == AppLifecycleState.resumed) {
        setStatus('Online');
      } else {
        setStatus('Offline');
      }
    }

    super.didChangeAppLifecycleState(state);
  }

  void setStatus(String status) async {
    print(status);
    // await FirebaseFirestore.instance
    //     .collection('userStatus')
    //     .doc(userId)
    //     .set({'status': status}, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<ProfileLoaderBloc, ProfileLoaderState>(
        builder: (context, state) {
          print('checkprofileloader$state');
          if (state is ProfileLoaderInitialState) {
            BlocProvider.of<ProfileLoaderBloc>(context).add(GetProfiles());
            // BlocProvider.of<ProfileLoaderBloc>(context)
            //     .add(GetPremiumMembers());
          }
          return Column(
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
          );
        },
        listener: (context, state) {
          if (state is OnGotProfiles) {
            navigateToViewProfiles(
                state.list,
                state.searchList,
                state.premiumList,
                state.recentViewList,
                state.profileVisitorList,
                state.onlineMembersList);
          }
          // if (state is OnGotPremium) {
          //   navigateFor(state.list);
          // }
        },
      )),
    );
  }

  void navigateToViewProfiles(
      List<MatchingProfile> list,
      List<MatchingProfile> seachList,
      List<MatchingProfile> premiumList,
      List<MatchingProfile> recentViewList,
      List<MatchingProfile> profileVisitorList,
      List<MatchingProfile> onlineMembersList) {
    var userRepo = BlocProvider.of<ProfileLoaderBloc>(context).userRepository;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  userRepository: userRepo,
                  list: list,
                  searchList: seachList,
                  recentViewList: recentViewList,
                  premiumList: premiumList,
                  profileVisitorList: profileVisitorList,
                  onlineMembersList: onlineMembersList,
                  screenName: "",
                )),
        (route) => false);
  }

  // void navigateFor(List<PremiumMembers> list) {
  //   var userRepo = BlocProvider.of<ProfileLoaderBloc>(context).userRepository;
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(
  //           builder: (context) => HomeScreen(
  //                 userRepository: userRepo,
  //                 list: list,
  //                 searchList: [],
  //               )),
  //       (route) => false);
  // }
}
