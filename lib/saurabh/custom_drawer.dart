import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/bloc/about/about_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/hexcolor.dart';
import 'package:makemymarry/saurabh/partner_preference.dart';
import 'package:makemymarry/saurabh/refer_friend.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/interests/interest_status_screen.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/home/menu/account_menu_event.dart';
import 'package:makemymarry/views/home/menu/account_menu_state.dart';
import 'package:makemymarry/views/home/menu/wallet/wallet_main.dart';
import 'package:makemymarry/views/profilescreens/about/about.dart';
import 'package:makemymarry/views/signinscreens/signin_screen1.dart';
import 'package:makemymarry/views/stackviewscreens/meet%20status/meet_status_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/setting_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_contactsupport_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/buttons.dart';
import '../utils/text_styles.dart';

class AppDrawer extends StatelessWidget {
  final UserRepository userRepository;

  AppDrawer({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AccountMenuBloc(userRepository),
        ),
        BlocProvider(
          create: (context) => AboutBloc(userRepository),
        ),
      ],
      child: AppDrawerScreen(),
    );
  }
}

class AppDrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppDrawerScreenState();
  }
}

class AppDrawerScreenState extends State<AppDrawerScreen> {
  ProfileDetails? profileDetails;

  var primaryColor = HexColor('C9184A');

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BlocConsumer<AccountMenuBloc, AccountMenuState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userRepo = BlocProvider.of<AccountMenuBloc>(context).userRepository;
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
              body: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                Container(
                  // height: 200,
                  padding: EdgeInsets.symmetric(vertical: 40),
                  alignment: Alignment.center,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                      // color: HexColor('C9184A'),
                      gradient: LinearGradient(
                          colors: [
                            HexColor('FF758F'),
                            HexColor('FF758F'),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 1.0]),
                      // FF758F
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(40))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              this.profileDetails != null
                                  ? profileDetails!.images[1]
                                  : "")),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                this.profileDetails != null
                                    ? profileDetails!.name
                                    : "",
                                style: MmmTextStyles.heading4(
                                    textColor: Colors.white),
                              ),
                              Icon(
                                Icons.verified_user,
                                size: 22,
                                color: Colors.white,
                              )
                            ],
                          ),
                          Text(
                            this.profileDetails != null
                                ? profileDetails!.mmId.toUpperCase()
                                : "",
                            style: MmmTextStyles.bodyMedium(
                                textColor: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Hello");

                              onEdit();
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Edit Profile",
                                  style: MmmTextStyles.bodyMediumSmall(
                                      textColor: Colors.white),
                                ),
                                Icon(
                                  Icons.edit_outlined,
                                  size: 22,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyprofileScreen(userRepository: userRepo)),
                          );
                          // showModalBottomSheet(
                          //     shape: const RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(30.0),
                          //         topRight: Radius.circular(30.0),
                          //       ),
                          //     ),
                          //     // isScrollControlled: true,
                          //     // backgroundColor: Colors.transparent,
                          //     context: context,
                          //     builder: (context) {
                          //       return Container(
                          //         height: 300,
                          //         decoration: BoxDecoration(
                          //             borderRadius:
                          //                 BorderRadius.only(
                          //                     topLeft:
                          //                         Radius.circular(
                          //                             30),
                          //                     topRight:
                          //                         Radius.circular(
                          //                             30))),
                          //         child: Container(
                          //             child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             SizedBox(
                          //               height: 10,
                          //             ),
                          //             IconButton(
                          //                 onPressed: () {
                          //                   Navigator.pop(context);
                          //                 },
                          //                 icon: Icon(
                          //                   Icons.arrow_back,
                          //                   color: primaryColor,
                          //                 )),
                          //             SizedBox(
                          //               height: 20,
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets
                          //                       .symmetric(
                          //                   horizontal: 20,
                          //                   vertical: 10),
                          //               child: Container(
                          //                 height: 55,
                          //                 child: TextField(
                          //                   decoration:
                          //                       InputDecoration(
                          //                     hintText:
                          //                         "Enter coupon code",
                          //                     border:
                          //                         OutlineInputBorder(
                          //                             borderSide:
                          //                                 // BorderSide.none,
                          //                                 //
                          //                                 BorderSide(
                          //                                     width:
                          //                                         2,
                          //                                     color: Colors
                          //                                         .blueGrey),
                          //                             borderRadius:
                          //                                 BorderRadius
                          //                                     .circular(
                          //                                         10)),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets
                          //                       .symmetric(
                          //                   horizontal: 20,
                          //                   vertical: 0),
                          //               child: Text(
                          //                 "Promo code MMM20 is invalid. Please try another code",
                          //                 style:
                          //                     MmmTextStyles.caption(
                          //                         textColor: Colors
                          //                             .redAccent),
                          //               ),
                          //             ),
                          //             SizedBox(
                          //               height: 30,
                          //             ),
                          //             MmmButtons.primaryButton(
                          //                 "Apply", () {})
                          //           ],
                          //         )),
                          //       );
                          //     });
                        },
                        child: customListTile(
                          leading:
                              SvgPicture.asset("images/clarityavatarsolid.svg"),
                          text: "My Profile",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PartnerPrefsScreen(
                                      userRepository: userRepo,
                                    )),
                          );
                        },
                        child: customListTile(
                          leading: SvgPicture.asset(
                            'images/Group22.svg',
                          ),
                          text: "Partner Preferrence",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Wallet(
                                    userRepository: userRepo,
                                  )));
                        },
                        child: customListTile(
                          leading: SvgPicture.asset(
                            'images/fluentwallet24filled.svg',
                          ),
                          text: "Wallet ",
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => MeetStatusScreen()),
                          );
                        }),
                        child: customListTile(
                          leading: SvgPicture.asset("images/Group3764.svg"),
                          text: "Meet",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Interests(
                                      userRepository: userRepo,
                                    )),
                          );
                        },
                        child: customListTile(
                          leading: SvgPicture.asset("images/Group3761.svg"),
                          text: "Interest",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ContactSupportScreen(
                                  userRepository: userRepo)));
                        },
                        child: customListTile(
                          leading: SvgPicture.asset("images/Group3756.svg"),
                          text: "Contact Support",
                        ),
                      ),
                      //   InkWell(
                      //     onTap: () {

                      //     },
                      //  child: customListTile(
                      //     leading: Icon(
                      //       Icons.person,
                      //       color: primaryColor,
                      //     ),
                      //     text: "Search by ID",
                      //   ),
                      //   ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReferFriendScreen()));
                        },
                        child: customListTile(
                          leading: SvgPicture.asset("images/Group3833.svg"),
                          text: "Refer & earn",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SettingScreen(userRepository: userRepo)));
                        },
                        child: customListTile(
                          leading:
                              SvgPicture.asset("images/cisettingsfilled.svg"),
                          text: "Setting",
                        ),
                      ),
                      customListTile(
                        leading:
                            SvgPicture.asset("images/iconoir_headset-help.svg"),
                        text: "Help",
                      ),
                      customListTile(
                        leading:
                            SvgPicture.asset("images/clarity_avatar-solid.svg"),
                        text: "Blocked Profile",
                      ),
                      InkWell(
                        onTap: () {
                          _deleteAppDir().then(
                              (value) => Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => SignIn(
                                              userRepository: userRepo,
                                            )),
                                  ));
                        },
                        child: customListTile(
                          leading: SvgPicture.asset("images/logout.svg"),
                          text: "Sign out",
                        ),
                      )
                    ],
                  ),
                )
              ])));
        } else
          return Container();
      },
    );
  }

  customListTile({leading, String? text}) {
    return ListTile(
        leading: leading,
        title: Text(
          text!,
          style: MmmTextStyles.cardNumber(),
        ),
        trailing: Icon(Icons.arrow_forward_ios));
  }

  Future<void> _deleteAppDir() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  void onEdit() {
    var userRepo = BlocProvider.of<AccountMenuBloc>(context).userRepository;
    print("hekllo222");
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => MyprofileScreen(userRepository: userRepo)),
    );
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => AboutScreen()));
    //var userRepository = BlocProvider.of<AboutBloc>(context).userRepository;
    print("hekllo333");
    // Navigator.of(context).push(
    //   MaterialPageRoute<AboutBloc>(
    //     builder: (context) => BlocProvider<AboutBloc>(
    //       create: (context) => AboutBloc(UserRepository()),
    //       child: AboutScreen(),
    //     ),
    //   ),
    // );
  }
}
