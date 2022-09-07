import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/matching_percentage/matching_percentage.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/profilescreens/bio/bio.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_about_screen.dart';

class MyprofileScreen extends StatelessWidget {
  final UserRepository userRepository;
  const MyprofileScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('My Profile', context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: kMargin16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.244,
                    //color: Colors.orangeAccent,
                  ),
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.122,
                    child: ClipOval(
                      child: Image.asset(
                        'images/stackviewImage.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: MediaQuery.of(context).size.width * 0.077,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                      alignment: Alignment.center,
                      decoration:
                          BoxDecoration(color: kWhite, shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        'images/camera.svg',
                        color: kDark2,
                      ),
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.02,
                    child: Stack(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kWhite,
                          ),
                        ),
                        Positioned(
                          top: 3,
                          bottom: 3,
                          right: 3,
                          left: 3,
                          child: Container(
                              decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimary,
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Kristen Stewart',
                style: MmmTextStyles.heading4(textColor: kDark5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '#123456',
                    style: MmmTextStyles.bodyRegular(textColor: gray3),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Edit',
                        style: MmmTextStyles.heading6(textColor: kPrimary),
                      )),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              MmmButtons.verifyAccountFliterScreen(),
              SizedBox(
                height: 16,
              ),
              MmmButtons.myProfileButtons('About', action: () {
                // var userRepo =
                //     BlocProvider.of<AccountMenuBloc>(context).userRepository;
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          Bio(userRepository: userRepository)),
                );
              }),
              SizedBox(
                height: 16,
              ),
              MmmButtons.myProfileButtons('Edit partner preference',
                  action: () {}),
              SizedBox(
                height: 16,
              ),
              MmmButtons.myProfileButtons('Add interests ', action: () {}),
              SizedBox(
                height: 16,
              ),
              MmmButtons.myProfileButtons('Change Status', action: () {}),
              SizedBox(
                height: 16,
              ),
              MmmButtons.myProfileButtons('Matching Percentage', action: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => MatchingPercentageScreen(
                          userRepository: userRepository)),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
