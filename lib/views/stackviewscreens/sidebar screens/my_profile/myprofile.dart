import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makemymarry/bloc/about/about_bloc.dart';
import 'package:makemymarry/bloc/about/about_state.dart';
import 'package:makemymarry/bloc/sign_in/signin_bloc.dart';
import 'package:makemymarry/matching_percentage/matching_percentage.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/myprofile/add_interest.dart';
import 'package:makemymarry/saurabh/filter_preference.dart';
import 'package:makemymarry/saurabh/partner_preference.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/profilescreens/about/about.dart';
import 'package:makemymarry/views/profilescreens/bio/bio.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_about_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/status_screen.dart';

import '../../../../datamodels/martching_profile.dart';
import '../../../../saurabh/myprofile/about_profile.dart';
import '../../../../utils/widgets_large.dart';
import '../../../home/menu/account_menu_event.dart';
import '../../../home/menu/account_menu_state.dart' as Menu;
import '../../../profilescreens/bio/bio_bloc.dart';
import '../../../profilescreens/bio/bio_event.dart';
import '../../../profilescreens/bio/image_picker_dialog.dart';

class MyprofileScreen extends StatelessWidget {
  final UserRepository userRepository;
  const MyprofileScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BioBloc(userRepository),
      child: MyProfile(userRepository: userRepository),
    );
  }
}

class MyProfile extends StatefulWidget {
  final UserRepository userRepository;
  const MyProfile({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // UserRepository userRepository = UserRepository();
  ProfileDetails? profileDetails;

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
              BlocProvider(
                create: (context) => AccountMenuBloc(widget.userRepository),
                child: BlocConsumer<AccountMenuBloc, Menu.AccountMenuState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    print("Akash");
                    print('checkimagestatus$state');
                    if (state is Menu.AccountMenuInitialState) {
                      BlocProvider.of<AccountMenuBloc>(context)
                          .add(FetchMyProfile());
                    }
                    if (state is OnLoading) {
                      return Scaffold(
                        body: MmmWidgets.buildLoader2(context),
                      );
                    } else if (state is Menu.OnGotProfile) {
                      this.profileDetails =
                          BlocProvider.of<AccountMenuBloc>(context).profileData;
                      print('saurabh12345 ${profileDetails!.images}');
                      // print('Aaurabh12345 ${profileDetails!.aboutMe}');
                      return Stack(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 0.244,
                          //color: Colors.orangeAccent,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.122,
                            child: ClipOval(
                              child: Image.network(
                                profileDetails!.images[1],
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 55,
                          right: 25,
                          left: MediaQuery.of(context).size.width * 0.066,
                          child: InkWell(
                            onTap: () {
                              showImagePickerDialog();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width * 0.1,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: kWhite, shape: BoxShape.circle),
                              child: SvgPicture.asset(
                                'images/camera.svg',
                                color: kDark2,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: MediaQuery.of(context).size.width * 0.36,
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 130),
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            profileDetails!.name,
                            style: MmmTextStyles.heading4(textColor: kDark5),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 150),
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileDetails!.mmId.toUpperCase(),
                                  style: MmmTextStyles.bodyRegular(
                                      textColor: gray3),
                                ),
                                // BlocProvider(
                                //   create: (context) =>
                                //       AboutBloc(widget.userRepository),
                                //   child: BlocConsumer<AboutBloc, AboutState>(
                                //     listener: (context, state) {},
                                //     builder: (context, state) {
                                // TextButton(
                                //   child: Text("Edit",
                                //       style: MmmTextStyles.bodyRegular(
                                //           textColor: kPrimary)),
                                //   onPressed: () {
                                //     onEdit();
                                //   },
                                // )
                                //     },
                                //   ),
                                // )
                              ],
                            ))
                      ]);
                    } else
                      return Container(
                          // child: Text(
                          //   'else',
                          //   style: MmmTextStyles.heading4(textColor: kDark5),
                          // ),
                          );
                  },
                ),
              ),

              SizedBox(
                height: 30,
              ),
              MmmButtons.verifyAccountFliterScreen(context),

              SizedBox(
                height: 20,
              ),

              Container(
                  width: 370,
                  height: 194,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 370,
                            height: 190,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(53, 61, 75, 92),
                                    offset: Offset(0, 4),
                                    blurRadius: 14)
                              ],
                              color: Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: Color.fromRGBO(240, 239, 245, 1),
                                width: 1,
                              ),
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 87,
                                  left: 17,
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/calendar.png',
                                          color: Color.fromARGB(141, 0, 0, 0),
                                          height: 20,
                                          // width: 10,
                                        ),
                                        SizedBox(width: 7),
                                        Container(
                                          decoration: BoxDecoration(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                '25yrs, 12th Nov,1996 June',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        18, 22, 25, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    letterSpacing:
                                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                                    // fontWeight: FontWeight.bold,
                                                    height: 1.5714285714285714),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 115,
                                  left: 15,
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/office.png',
                                          height: 25,
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          decoration: BoxDecoration(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Software Engineer',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        18, 22, 25, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    letterSpacing:
                                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                                    // fontWeight: FontWeight.bold,
                                                    height: 1.5714285714285714),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 143,
                                  left: 13,
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/height'.png",
                                          height: 30,
                                        ),
                                        SizedBox(width: 2),
                                        Container(
                                          decoration: BoxDecoration(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                '5’5’’ height',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        18, 22, 25, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    // fontWeight: FontWeight.bold,
                                                    height: 1.5714285714285714),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 59,
                                  left: 15,
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/Users1.png',
                                          color: Color.fromARGB(192, 0, 0, 0),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          decoration: BoxDecoration(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Profile managed by Father',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        18, 22, 25, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    // fontWeight: FontWeight.bold,
                                                    height: 1.5714285714285714),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ]))),
                    Positioned(
                        top: 20,
                        left: 16,
                        child: Container(
                          decoration: BoxDecoration(),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset(
                                'images/Users1.png',
                                color: kPrimary,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Abhishek Sharma',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(164, 19, 60, 1),
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1.625),
                              ),
                              SizedBox(width: 140),
                              Image.asset(
                                'images/pen.png',
                                color: kPrimary,
                                height: 20,
                                // width: 10,
                              ),
                            ],
                          ),
                        )),
                  ])),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 370,
                  height: 190,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 370,
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(45, 61, 75, 92),
                                    offset: Offset(0, 4),
                                    blurRadius: 14)
                              ],
                              color: Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: Color.fromRGBO(240, 239, 245, 1),
                                width: 1,
                              ),
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 20,
                                  left: 15,
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/Users1.png',
                                          color: kPrimary,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'About',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  164, 19, 60, 1),
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.bold,
                                              height: 1.625),
                                        ),
                                        SizedBox(width: 240),
                                        Image.asset(
                                          'images/pen.png',
                                          color: kPrimary,
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 60,
                                  left: 20,
                                  right: 20,
                                  child: Text(
                                    "I come from an upper middle class family. The most important thing in my life is religion believes, moral values and respect for elders. I’m modern thinker",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        letterSpacing:
                                            1 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                              Positioned(
                                  top: 174,
                                  left: 18,
                                  child: Text(
                                    ' ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                              Positioned(
                                  top: 174,
                                  left: 133,
                                  child: Text(
                                    '  ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                            ]))),
                  ])),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 370,
                  height: 566,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 370,
                            height: 566,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(
                                        61, 75, 92, 0.11999999731779099),
                                    offset: Offset(0, 4),
                                    blurRadius: 14)
                              ],
                              color: Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: Color.fromRGBO(240, 239, 245, 1),
                                width: 1,
                              ),
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 20,
                                  left: 15,
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          'images/family.png',
                                          color: kPrimary,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Family',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  164, 19, 60, 1),
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.bold,
                                              height: 1.625),
                                        ),
                                        SizedBox(width: 230),
                                        Image.asset(
                                          'images/pen.png',
                                          color: kPrimary,
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(top: 22, left: 310, child: Text('')),
                            ]))),
                    Positioned(
                        top: 66,
                        left: 16,
                        child: Container(
                            width: 84,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 15,
                                  child: Text(
                                    'Status',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  )),
                              Positioned(
                                  top: 24,
                                  left: 15,
                                  child: Text(
                                    'Kurukshetra',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                            ]))),
                    Positioned(
                        top: 128,
                        left: 16,
                        child: Container(
                            width: 149,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 15,
                                  child: Text(
                                    'Type',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  )),
                              Positioned(
                                  top: 24,
                                  left: 15,
                                  child: Text(
                                    'Kurukshetra Iniversity',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                            ]))),
                    Positioned(
                        top: 438,
                        left: 16,
                        child: Container(
                            width: 141,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 15,
                                  child: Text(
                                    'No. of Brother’s/Married',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  )),
                              Positioned(
                                  top: 24,
                                  left: 15,
                                  child: Text(
                                    '1 out of 2 Married',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                            ]))),
                    Positioned(
                        top: 500,
                        left: 15,
                        child: Container(
                            width: 130,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 15,
                                  child: Text(
                                    'No. of Sister’s/Married',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  )),
                              Positioned(
                                  top: 24,
                                  left: 15,
                                  child: Text(
                                    '1 out of 2 Married',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                            ]))),
                    Positioned(
                        top: 190,
                        left: 15,
                        child: Container(
                            width: 149,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 15,
                                  child: Text(
                                    'Values',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  )),
                              Positioned(
                                  top: 24,
                                  left: 15,
                                  child: Text(
                                    'Kurukshetra Iniversity',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                            ]))),
                    Positioned(
                        top: 252,
                        left: 15,
                        child: Container(
                            width: 150,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 15,
                                  child: Text(
                                    'Location',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  )),
                              Positioned(
                                  top: 24,
                                  left: 15,
                                  child: Text(
                                    'Kurukshetra Iniversity',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                            ]))),
                    Positioned(
                        top: 314,
                        left: 15,
                        child: Container(
                            width: 149,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 15,
                                  child: Text(
                                    'Father’s Occupation',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  )),
                              Positioned(
                                  top: 24,
                                  left: 15,
                                  child: Text(
                                    'Kurukshetra Iniversity',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                            ]))),
                    Positioned(
                        top: 376,
                        left: 15,
                        child: Container(
                            width: 149,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 16,
                                  child: Text(
                                    'Mother’s Occupation',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  )),
                              Positioned(
                                  top: 24,
                                  left: 15,
                                  child: Text(
                                    'Kurukshetra University',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  )),
                            ]))),
                  ])),

              SizedBox(
                height: 20,
              ),
              Container(
                  width: 370,
                  height: 660,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 370,
                            height: 660,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(45, 61, 75, 92),
                                    offset: Offset(0, 4),
                                    blurRadius: 14)
                              ],
                              color: Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: Color.fromRGBO(240, 239, 245, 1),
                                width: 1,
                              ),
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 20,
                                  left: 15,
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // Icon(Icons),
                                        Icon(
                                          Icons.favorite_border_outlined,
                                          color: kPrimary,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Interests',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  164, 19, 60, 1),
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.bold,
                                              height: 1.625),
                                        ),
                                        SizedBox(width: 200),
                                        Image.asset(
                                          'images/pen.png',
                                          color: kPrimary,
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 60,
                                  left: 16,
                                  child: Container(
                                      width: 250,
                                      height: 100,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 15,
                                            child: Text(
                                              'Eating',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      212, 0, 0, 0),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.6666666666666667),
                                            )),
                                        Positioned(
                                            top: 35,
                                            left: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          13, 255, 77, 110),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 14)
                                                ],
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      193, 199, 205, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/LeafyGreen.png',

                                                    // color: kPrimary,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Vegetarrian',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      18,
                                                                      22,
                                                                      25,
                                                                      1),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.625),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ]))),
                              Positioned(
                                  top: 160,
                                  left: 16,
                                  child: Container(
                                      width: 250,
                                      height: 100,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 15,
                                            child: Text(
                                              'Smoking',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      212, 0, 0, 0),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.6666666666666667),
                                            )),
                                        Positioned(
                                            top: 35,
                                            left: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          13, 255, 77, 110),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 14)
                                                ],
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      193, 199, 205, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/cigarette.png',

                                                    // color: kPrimary,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Regular',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      18,
                                                                      22,
                                                                      25,
                                                                      1),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.625),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ]))),
                              Positioned(
                                  top: 260,
                                  left: 16,
                                  child: Container(
                                      width: 250,
                                      height: 100,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 15,
                                            child: Text(
                                              'Alcoholic',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      212, 0, 0, 0),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.6666666666666667),
                                            )),
                                        Positioned(
                                            top: 35,
                                            left: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          13, 255, 77, 110),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 14)
                                                ],
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      193, 199, 205, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/Beer.png',

                                                    // color: kPrimary,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Regular',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      18,
                                                                      22,
                                                                      25,
                                                                      1),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.625),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ]))),
                              Positioned(
                                  top: 360,
                                  left: 16,
                                  child: Container(
                                      width: 400,
                                      height: 300,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 15,
                                            child: Text(
                                              'Hobbies',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      212, 0, 0, 0),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.6666666666666667),
                                            )),
                                        Positioned(
                                            top: 35,
                                            left: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          13, 255, 77, 110),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 14)
                                                ],
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      193, 199, 205, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/paint.png',

                                                    // color: kPrimary,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Painting',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      18,
                                                                      22,
                                                                      25,
                                                                      1),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.625),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Positioned(
                                            top: 35,
                                            left: 160,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          13, 255, 77, 110),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 14)
                                                ],
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      193, 199, 205, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/Camera.png',

                                                    // color: kPrimary,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Photography',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      18,
                                                                      22,
                                                                      25,
                                                                      1),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.625),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Positioned(
                                            top: 100,
                                            left: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          13, 255, 77, 110),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 14)
                                                ],
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      193, 199, 205, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/Mountain.png',

                                                    // color: kPrimary,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Mountain Hiking',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      18,
                                                                      22,
                                                                      25,
                                                                      1),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.625),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Positioned(
                                            top: 165,
                                            left: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          13, 255, 77, 110),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 14)
                                                ],
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      193, 199, 205, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/cook.png',

                                                    // color: kPrimary,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Cooking',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      18,
                                                                      22,
                                                                      25,
                                                                      1),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.625),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Positioned(
                                            top: 230,
                                            left: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          13, 255, 77, 110),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 14)
                                                ],
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      193, 199, 205, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/Book.png',

                                                    // color: kPrimary,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Reading Books',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      18,
                                                                      22,
                                                                      25,
                                                                      1),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.625),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ]))),
                            ]))),
                  ])),
              SizedBox(
                height: 20,
              ),

              Container(
                  width: 370,
                  height: 500,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 370,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(45, 61, 75, 92),
                                    offset: Offset(0, 4),
                                    blurRadius: 14)
                              ],
                              color: Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: Color.fromRGBO(240, 239, 245, 1),
                                width: 1,
                              ),
                            ),
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 20,
                                  left: 15,
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // Icon(Icons),
                                        Image.asset(
                                          'images/occasionally.png',

                                          // color: kPrimary,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'LifeStyle',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  164, 19, 60, 1),
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.bold,
                                              height: 1.625),
                                        ),
                                        SizedBox(width: 195),
                                        Image.asset(
                                          'images/pen.png',
                                          color: kPrimary,
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 75,
                                  left: 35,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                13, 255, 77, 110),
                                            offset: Offset(0, 4),
                                            blurRadius: 14)
                                      ],
                                      border: Border.all(
                                        color: Color.fromRGBO(193, 199, 205, 1),
                                        width: 1,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/House.png',

                                          // color: kPrimary,
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          decoration: BoxDecoration(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'House',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        18, 22, 25, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    letterSpacing:
                                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.625),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 75,
                                  left: 170,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                13, 255, 77, 110),
                                            offset: Offset(0, 4),
                                            blurRadius: 14)
                                      ],
                                      border: Border.all(
                                        color: Color.fromRGBO(193, 199, 205, 1),
                                        width: 1,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/Factory.png',

                                          // color: kPrimary,
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          decoration: BoxDecoration(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Business',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        18, 22, 25, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    letterSpacing:
                                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.625),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 140,
                                  left: 35,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                13, 255, 77, 110),
                                            offset: Offset(0, 4),
                                            blurRadius: 14)
                                      ],
                                      border: Border.all(
                                        color: Color.fromRGBO(193, 199, 205, 1),
                                        width: 1,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/car.png',

                                          // color: kPrimary,
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          decoration: BoxDecoration(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Car',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        18, 22, 25, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    letterSpacing:
                                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.625),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ]))),
                  ])),

              // MmmButtons.myProfileButtons('Matching Percentage', action: () {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //         builder: (context) => MatchingPercentageScreen(
              //             userRepository: userRepository)),
              //   );
              // })
            ],
          ),
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  Future pickImages(
    ImageSource source,
  ) async {
    var file = await _picker.pickImage(
      source: source,
      imageQuality: 60,
    );
    // if (file != null) {
    // print("saurabh uplaod${file!.path}");
    print("saurabh uplaod${file!.path}");
    if (file != null) {
      print("saurabh uplaod 1${file!.path}");

      BlocProvider.of<BioBloc>(context).add(AddImage(file.path));
      print("saurabh uplaod 3${file.path}");
    }
    // }
  }

  void onEdit() {
    print("hekllo222");
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => AboutScreen()));
    //var userRepository = BlocProvider.of<AboutBloc>(context).userRepository;
    print("hekllo333");
    Navigator.of(context).push(
      MaterialPageRoute<AboutBloc>(
        builder: (context) => BlocProvider<AboutBloc>(
          create: (context) => AboutBloc(widget.userRepository),
          child: AboutScreen(),
        ),
      ),
    );
  }

  void showImagePickerDialog() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => MmmImagePickerDialog());
    if (result != null && result is int) {
      switch (result) {
        case 1:
          break;
        case 2:
          pickImages(ImageSource.gallery);
          break;
        case 3:
          pickImages(ImageSource.camera);
      }
    }
  }

  void showStatusDilogue(BuildContext context) {
    MmmWidgets.selectStatusWidget(context);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            alignment: Alignment.center,
            height: 450,
            width: 370,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                Text(
                  "Select your Status",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(42), // Image radius
                    child: Image.asset('images/profile.png', fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Abhishek Sharma",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 130),
                    child: const Text(
                      "MMY23456",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    child: SvgPicture.asset(
                      'images/Verifiedred.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                const Divider(
                  color: Color.fromARGB(248, 233, 217, 217),
                  thickness: 1,
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                const SizedBox(height: 18),
                // ignore: unnecessary_new, sized_box_for_whitespace
                new Container(
                  width: 300,
                  height: 42,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 182, 40, 87),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                      // filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: .5,
                      ),
                      hintText: "Keep me Online",
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                // ignore: unnecessary_new, sized_box_for_whitespace
                new Container(
                  width: 300,
                  height: 42,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                      // filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        height: .5,
                      ),
                      hintText: "Keep me Offline",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        //  AlertDialog(
        //   title: new Text("Alert!!"),
        //   content: new Text("You are awesome!"),
        //   actions: <Widget>[
        //     GestureDetector(
        //       child: new Text("OK"),
        //       onTap: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // );
      },
    );
  }
}
