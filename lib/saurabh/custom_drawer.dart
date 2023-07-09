import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/app/bloc/app_bloc.dart';
import 'package:makemymarry/app/bloc/app_event.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/hexcolor.dart';
import 'package:makemymarry/saurabh/partner_preference.dart';
import 'package:makemymarry/saurabh/refer_friend.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/blocked_users/blocked_users_list.dart';
import 'package:makemymarry/views/home/interests/views/interest_status_screen.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/home/menu/account_menu_event.dart';
import 'package:makemymarry/views/home/menu/account_menu_state.dart';
import 'package:makemymarry/views/home/menu/wallet/wallet_main.dart';
import 'package:makemymarry/views/signinscreens/signin_page.dart';
import 'package:makemymarry/views/stackviewscreens/connect/connect.dart';
import 'package:makemymarry/views/meet/views/meet_status_screen.dart';
import 'package:makemymarry/views/stackviewscreens/search_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/setting_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_contactsupport_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/text_styles.dart';
import '../views/profile_detail_view/profile_view_bloc.dart';

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
  String? basicUserId;

  var primaryColor = HexColor('C9184A');

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            basicUserId = prefValue.getString(AppConstants.USERID);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BlocConsumer<AccountMenuBloc, AccountMenuState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userRepo = BlocProvider.of<AccountMenuBloc>(context).userRepository;
        if (state is AccountMenuInitialState) {
          BlocProvider.of<AccountMenuBloc>(context).add(FetchMyProfile());
        }
        if (state is OnLoading) {
          return Material(
            child: MmmWidgets.buildLoader2(context),
          );
        } else if (state is OnGotProfile) {
          this.profileDetails =
              BlocProvider.of<AccountMenuBloc>(context).profileData;

          return Drawer(

              width: 350,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  // height: 200,
                  padding: const EdgeInsets.only(top: 50.0, bottom: 40),
                  alignment: Alignment.center,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                      // color: HexColor('C9184A'),
                      gradient: LinearGradient(
                          colors: [

                            kSecondary,
                            kPrimary,
                            // HexColor('FF758F'),
                            // HexColor('FF758F'),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 1.0]),
                      // FF758F
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: ((this.profileDetails != null &&
                                profileDetails!.images.isNotNullEmpty)
                            ? NetworkImage(profileDetails!.images.first)
                            : AssetImage(
                                'images/app_icon.png',
                              )) as ImageProvider,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    this.profileDetails != null
                                        ? profileDetails!.name
                                        : "",
                                    // overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 1,
                                    style: MmmTextStyles.heading4(
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ),
                                this.profileDetails != null &&

                                        this
                                                .profileDetails
                                                ?.activationStatus ==
                                            ProfileActivationStatus.Verified
                                    ? Icon(
                                        Icons.verified_user,
                                        size: 22,
                                        color: Colors.white,
                                      )
                                    : SizedBox()
                              ],
                            ),
                            Text(
                              this.profileDetails != null
                                  ? profileDetails!.mmId.toUpperCase()
                                  : "",
                              style: MmmTextStyles.bodyMedium(
                                  textColor: Colors.white70),
                            ),
                            GestureDetector(
                              onTap: () {

                                onEdit(this.basicUserId);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Edit Profile",
                                    style: MmmTextStyles.bodyMediumSmall(
                                        textColor: Colors.white70),
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
                        ),
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      InkWell(
                        onTap: () {
                          context.navigate.pop();
                          onEdit(this.basicUserId);
                        },
                        child: customListTile(
                          leading: SvgPicture.asset(
                              "images/clarity_avatar-solid.svg"),
                          text: "My Profile",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.navigate.pop();

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
                          context.navigate.pop();

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
                        onTap: () {
                          context.navigate.pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => MeetStatusScreen()),
                          );
                        },
                        child: customListTile(
                          leading: SvgPicture.asset("images/Group3764.svg"),
                          text: "Meet",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.navigate.pop();
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
                          context.navigate.pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ConnectMainScreen()));
                        },
                        child: customListTile(
                          leading: SvgPicture.asset("images/Group3756.svg"),
                          text: "Contacts",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.navigate.pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => ProfileViewBloc(
                                    UserRepository(), ProfileDetails()),
                                child: SearchScreen(
                                  list: [],
                                  onlineMembersList: [],
                                  premiumList: [],
                                  profileVisitorList: [],
                                  recentViewList: [],
                                  searchList: [],
                                  userRepository: userRepo,
                                  // key: Key,
                                ),
                              )));
                        },
                        child: customListTile(
                          leading: Icon(Icons.search, color: kShadowColorForPink,),
                          // Icon(
                          //   Icons.person,
                          //   color: primaryColor,
                          // ),
                          text: "Search by ID",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.navigate.pop();
                          Navigator.of(context).push(
                              BlockedUsers.getRoute(userRepository: userRepo));
                        },
                        child: customListTile(
                          leading: SvgPicture.asset(
                              'images/blocked_profile_icon.svg'),
                          text: "Blocked Profile",
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          context.navigate.pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReferFriendScreen()));
                        },
                        child: customListTile(
                          leading: SvgPicture.asset("images/Group3833.svg"),
                          text: "Refer & earn",
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //
                      //   },
                      //   child: customListTile(
                      //     leading: SvgPicture.asset("images/success_stories_icon.svg"),
                      //     text: "Success Stories",
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          context.navigate.pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SettingScreen(userRepository: userRepo)));
                        },
                        child: customListTile(
                          leading:
                          SvgPicture.asset("images/cisettingsfilled.svg"),
                          text: "Account & Settings",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.navigate.pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ContactSupportScreen(
                                  userRepository: userRepo)));
                        },
                        child: customListTile(
                          leading: SvgPicture.asset("images/iconoir_headset-help.svg"),
                          text: "Help and Support",
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     context.navigate.pop();
                      //     FirebaseMessaging.instance.deleteToken();
                      //     BlocProvider.of<AppBloc>(context)
                      //         .updateOnlineStatus(false);
                      //     BlocProvider.of<AppBloc>(context).add(SignOutEvent());
                      //     _deleteAppDir().then((value) => Navigator.of(context)
                      //         .pushReplacement(SignInPage.getRoute()));
                      //   },
                      //   child: customListTile(
                      //     leading: SvgPicture.asset("images/logout.svg"),
                      //     text: "Sign out",
                      //   ),
                      // )
                    ],
                  ),
                )
              ],
            ),
          );

        } else
          return Container();
      },
    );
  }

  customListTile({leading, String? text}) {
    return ListTile(
        visualDensity: VisualDensity(horizontal: -4, vertical: -2.2),
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

  void onEdit(basicUserId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyProfileScreen(),
      ),
    );
    context.read<AccountMenuBloc>().add(FetchMyProfile());
  }
}
