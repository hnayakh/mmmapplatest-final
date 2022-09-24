import 'dart:io';
import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/profile_detail.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_screen.dart';
import 'package:makemymarry/views/signinscreens/signin_screen1.dart';
import 'package:makemymarry/views/stackviewscreens/search_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/setting_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/interests/interest_status_screen.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/home/menu/account_menu_event.dart';
import 'package:makemymarry/views/home/menu/account_menu_state.dart';
import 'package:makemymarry/views/profilescreens/bio/bio.dart';
import 'package:makemymarry/views/signinscreens/phone%20signin/phone_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'wallet/wallet_main.dart';

class SidebarAccount extends StatelessWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  final List<MatchingProfile> searchList;

  const SidebarAccount(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.searchList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AccountMenuBloc(userRepository),
        ),
        BlocProvider(
          create: (context) =>
              MatchingProfileBloc(userRepository, list, searchList),
        ),
      ],
      child: SidebarAccountScreen(),
    );
  }
}

Future<void> _deleteCacheDir() async {
  Directory tempDir = await getTemporaryDirectory();

  if (tempDir.existsSync()) {
    tempDir.deleteSync(recursive: true);
  }
}

// Future<void> _deleteAppDir() async {
//   var sharedPreferences = await SharedPreferences.getInstance();
//   // Directory appDocDir = await getApplicationDocumentsDirectory();
//   sharedPreferences.setString('secretToken', '');
//   var appDir = (await getTemporaryDirectory()).path;
//   new Directory(appDir).delete(recursive: true);

//   // if (appDocDir.existsSync()) {
//   //   appDocDir.deleteSync(recursive: true);
//   // }
// }
Future<void> _deleteAppDir() async {
  //var sharedPreferences = await SharedPreferences.getInstance();
  // Directory appDocDir = await getApplicationDocumentsDirectory();
  //sharedPreferences.setString('secretToken', '');
  //var appDir = (await getTemporaryDirectory()).path;
  //new Directory(appDir).delete(recursive: true);
  final pref = await SharedPreferences.getInstance();
  await pref.clear();

  // if (appDocDir.existsSync()) {
  //   appDocDir.deleteSync(recursive: true);
  // }
}

class SidebarAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SidebarAccountScreenState();
  }
}

class SidebarAccountScreenState extends State<SidebarAccountScreen> {
  ProfileDetails? profileDetails;

  @override
  Widget build(BuildContext context) {
    print('Profffile ddddd--$profileDetails');
    return BlocConsumer<AccountMenuBloc, AccountMenuState>(
      builder: (context, state) {
        if (state is AccountMenuInitialState) {
          BlocProvider.of<AccountMenuBloc>(context).add(FetchMyProfile());
        }
        if (state is OnLoading) {
          return Scaffold(
            body: MmmWidgets.buildLoader2(context),
          );
        } else if (state is OnGotProfile) {
          this.profileDetails =
              BlocProvider.of<AccountMenuBloc>(context).profileData;
          print("this.profileDetails");
          print(this.profileDetails);
          return Scaffold(
            appBar: MmmButtons.appBarAccountBar(profileDetails!.name,
                profileDetails!.images.first, profileDetails!.activationStatus,
                context: context),
            body: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    navigateTo(index);
                  },
                  title: Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          menuItems[index],
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.bodyMedium(),
                        )),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          child: SvgPicture.asset(
                            "images/rightArrow.svg",
                            color: Color(0xff878D96),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: menuItems.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          );
        } else
          return Container();
      },
      listener: (context, state) {},
    );
  }

  List<String> menuItems = [
    "My Profile",
    "Search",
    "Interest",
    "Connect",
    "Wallet",
    "Setting",
    "Sign Out"
  ];

  void navigateTo(int index) {
    var userRepo = BlocProvider.of<AccountMenuBloc>(context).userRepository;
    var list = BlocProvider.of<MatchingProfileBloc>(context).list;
    var searchList = BlocProvider.of<MatchingProfileBloc>(context).searchList;
    switch (index) {
      case 0:
        print("Profile ahead");
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => MyprofileScreen(userRepository: userRepo)),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SearchScreen(
                    userRepository: userRepo,
                    list: list,
                    searchList: searchList,
                  )),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => Interests(userRepository: userRepo)),
        );
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyConnects(userRepository: userRepo),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Wallet(
                  userRepository: userRepo,
                )));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SettingScreen(
                  userRepository: userRepo,
                )));
        break;
      case 6:
        _deleteCacheDir();

        _deleteAppDir().then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => SignIn(
                        userRepository: userRepo,
                      )),
            ));

        break;
      default:
    }
  }
}
