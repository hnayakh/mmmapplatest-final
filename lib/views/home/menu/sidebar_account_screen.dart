import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/home/menu/account_menu_event.dart';
import 'package:makemymarry/views/home/menu/account_menu_state.dart';

import 'wallet/wallet_main.dart';

class SidebarAccount extends StatelessWidget {
  final UserRepository userRepository;

  const SidebarAccount({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountMenuBloc(userRepository),
      child: SidebarAccountScreen(),
    );
  }
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
    "Sign out"
  ];

  void navigateTo(int index) {
    var userRepo = BlocProvider.of<AccountMenuBloc>(context).userRepository;
    switch (index) {
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Wallet(
                  userRepository: userRepo,
                )));
        break;
      default:
        print(index);
    }
  }
}
