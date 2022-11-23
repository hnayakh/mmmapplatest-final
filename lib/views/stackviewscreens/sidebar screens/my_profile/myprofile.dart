import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makemymarry/bloc/about/about_bloc.dart';
import 'package:makemymarry/bloc/about/about_event.dart';
import 'package:makemymarry/bloc/about/about_state.dart';
import 'package:makemymarry/bloc/sign_in/signin_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/matching_percentage/matching_percentage.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/myprofile/add_interest.dart';
import 'package:makemymarry/saurabh/filter_preference.dart';
import 'package:makemymarry/saurabh/partner_preference.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/home/menu/account_menu_state.dart'
    as accountMenuState;
import 'package:makemymarry/views/profilescreens/about/about.dart';
import 'package:makemymarry/views/profilescreens/bio/bio.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';
import 'package:makemymarry/views/profilescreens/habbit/habits.dart';
import 'package:makemymarry/views/profilescreens/occupation/occupation_bloc.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_about_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/status_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) => BioBloc(userRepository),
    //     ),
    //     BlocProvider(
    //       create: (context) => OccupationBloc(userRepository),
    //     ),
    //     BlocProvider(
    //       create: (context) => AccountMenuBloc(userRepository),
    //     ),
    //   ],
    //   child: MyProfile(userRepository: userRepository),
    // );
    return MyProfile(userRepository: userRepository);
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
  String? basicUserId;
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
    //  BlocProvider.of<AccountMenuBloc>(context).add(FetchMyProfile());

    return Scaffold(
      appBar: MmmButtons.appBarCurved('My Profile', context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: kMargin16,
          child: BlocConsumer<AboutBloc, AboutState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              // if (state is OnNavigationToMyProfiles) {
              //   this.profileDetails =
              //       BlocProvider.of<AboutBloc>(context).profileDetails;
              //   // BlocProvider.of<AboutBloc>(context)
              //   //     .add(onAboutDataLoad(this.profileDetails!.id));
              //   // print("DDDD${this.profileDetails!.drinkingHabit.name}");
              // }
              print("Akashj");
              print('checkimagestatus$state');

              if (state is OnNavigationToMyProfiles) {
                BlocProvider.of<AboutBloc>(context)
                    .add(onAboutDataLoad(basicUserId!));
              }
              if (state is OnLoading) {
                return Scaffold(
                  body: MmmWidgets.buildLoader2(context),
                );
              }
              if (this.profileDetails == null) {
                print("this.profileDetails == null block");
                BlocProvider.of<AboutBloc>(context)
                    .add(onAboutDataLoad(basicUserId!));
              }
              if (state is ProfileDetailsState) {
                print("ProfileDetailsState ................");
                this.profileDetails =
                    BlocProvider.of<AboutBloc>(context).profileDetails;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    Stack(children: [
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
                              profileDetails!.images[0],
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
                                style:
                                    MmmTextStyles.bodyRegular(textColor: gray3),
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
                    ]),
                    SizedBox(
                      height: 30,
                    ),
                    MmmButtons.verifyAccountFliterScreen(context),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 350,
                        height: 194,
                        child: Stack(children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 1),
                              width: 350,
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
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 80, 10, 0),
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
                                              profileDetails != null
                                                  ? profileDetails!.dateOfBirth
                                                  : "",
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
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(8, 110, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.asset(
                                        'images/office.png',
                                        height: 25,
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              profileDetails != null
                                                  ? profileDetails!.occupation
                                                  : "",
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
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 135, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/height'.png",
                                        height: 30,
                                      ),
                                      SizedBox(width: 2),
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              // '5’5’’ height',
                                              profileDetails != null
                                                  ? profileDetails!.height +
                                                      '"' +
                                                      'inches'
                                                  : "",
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
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(8, 50, 10, 0),
                                  child: Row(
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
                                              this.profileDetails != null
                                                  ? 'Profile managed by ${profileDetails!.relationship.name}'
                                                  : "",
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
                                ),
                              ])),
                          Container(
                            width: 360,
                            margin: EdgeInsets.fromLTRB(10, 10, 30, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'images/Users1.png',
                                        color: kPrimary,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        this.profileDetails != null
                                            ? profileDetails!.name
                                            : "",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(164, 19, 60, 1),
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            height: 1.625),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => About(
                                                userRepository:
                                                    widget.userRepository)));
                                  },
                                  child: Image.asset(
                                    'images/pen.png',
                                    color: kPrimary,
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])),
                    SizedBox(height: 30),
                    Container(
                        width: 350,
                        height: 190,
                        child: Stack(children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 1),
                              width: 350,
                              height: 180,
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
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 30, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: [
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
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.625),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print("...");
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) => Bio(
                                                        userRepository: widget
                                                            .userRepository,
                                                      )));
                                        },
                                        child: Image.asset(
                                          'images/pen.png',
                                          color: kPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(14, 40, 30, 0),
                                  child: Text(
                                    this.profileDetails != null
                                        ? profileDetails!.aboutmeMsg
                                        : "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  ),
                                ),
                              ])),
                        ])),
                    SizedBox(height: 20),
                    Container(
                        width: 350,
                        height: 500,
                        child: Stack(children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 1),
                              width: 350,
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
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 30, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: [
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
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.625),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //SizedBox(width: 230),
                                      InkWell(
                                        onTap: () {
                                          print("Akashs");
                                          navigateToFamily(context);
                                        },
                                        child: Image.asset(
                                          'images/pen.png',
                                          color: kPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(top: 22, left: 310, child: Text('')),
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
                              width: 84,
                              height: 46,
                              child: Stack(children: <Widget>[
                                Text(
                                  'Status',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(135, 141, 150, 1),
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      height: 1.6666666666666667),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    this.profileDetails != null
                                        ? profileDetails!
                                            .familyAfluenceLevel.name
                                        : "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  ),
                                ),
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 100, 0, 0),
                              width: 149,
                              height: 46,
                              child: Stack(children: <Widget>[
                                Text(
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
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    this.profileDetails != null
                                        ? profileDetails!.familyType.name
                                        : "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  ),
                                ),
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 150, 0, 0),
                              width: 149,
                              height: 46,
                              child: Stack(children: <Widget>[
                                Text(
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
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    this.profileDetails != null
                                        ? profileDetails!.familyValues.name
                                        : "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  ),
                                ),
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 200, 0, 0),
                              width: 150,
                              height: 46,
                              child: Stack(children: <Widget>[
                                Text(
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
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    this.profileDetails != null
                                        ? "${this.profileDetails!.familyCity}, ${this.profileDetails!.familyState} "
                                        : "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  ),
                                ),
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 250, 0, 0),
                              width: 149,
                              height: 46,
                              child: Stack(children: <Widget>[
                                Text(
                                  'Father’s Occupation',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(135, 141, 150, 1),
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      height: 1.6666666666666667),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    this.profileDetails != null
                                        ? profileDetails!.fatherOccupation.name
                                        : "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  ),
                                ),
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 300, 0, 0),
                              width: 149,
                              height: 46,
                              child: Stack(children: <Widget>[
                                Text(
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
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    this.profileDetails != null
                                        ? profileDetails!.motherOccupation.name
                                        : "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  ),
                                ),
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 350, 0, 0),
                              width: 130,
                              height: 46,
                              child: Stack(children: <Widget>[
                                Container(
                                  child: Text(
                                    'No. of Brother’s/Married',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    this.profileDetails != null
                                        ? "${profileDetails!.noOfBrother} Brother ${profileDetails!.brothersMarried} Married"
                                        : "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  ),
                                ),
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 400, 0, 0),
                              width: 130,
                              height: 46,
                              child: Stack(children: <Widget>[
                                Container(
                                  child: Text(
                                    'No. of Sister’s/Married',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(135, 141, 150, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        height: 1.6666666666666667),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    this.profileDetails != null
                                        ? "${profileDetails!.noOfSister} Sister ${profileDetails!.sistersMarried} Married"
                                        : "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 22, 25, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5714285714285714),
                                  ),
                                ),
                              ])),
                        ])),
                    SizedBox(height: 20),
                    Container(
                        width: 350,
                        height: 660,
                        child: Stack(children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                              width: 350,
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
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 30, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                'images/heartSpecialpng.png',
                                                color: kPrimary),
                                            // Icon(
                                            //   Icons.favorite_border_rounded,
                                            //   color: kPrimary,
                                            // ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Interests',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      164, 19, 60, 1),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.625),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) => Habit(
                                                        userRepository: widget
                                                            .userRepository,
                                                      )));
                                        },
                                        child: Image.asset(
                                          'images/pen.png',
                                          color: kPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(15, 50, 20, 0),
                                    width: 250,
                                    height: 100,
                                    child: Stack(children: <Widget>[
                                      Text(
                                        'Eating',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromARGB(212, 0, 0, 0),
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            height: 1.6666666666666667),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 30, 20, 0),
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
                                              this.profileDetails != null
                                                  ? profileDetails!.eatingHabit
                                                              .name ==
                                                          "Vegetarrian"
                                                      ? 'images/LeafyGreen.png'
                                                      : profileDetails!
                                                                  .eatingHabit
                                                                  .name ==
                                                              "Nonvegetarrian"
                                                          ? 'images/chicken.png'
                                                          : profileDetails!
                                                                      .eatingHabit
                                                                      .name ==
                                                                  "Eggitarrian"
                                                              ? 'images/egggg.png'
                                                              : ""
                                                  : "",
                                              height: 28,
                                              width: 28,
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    this.profileDetails != null
                                                        ? profileDetails!
                                                            .eatingHabit.name
                                                        : "",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 22, 25, 1),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1.625),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),
                                Container(
                                    margin: EdgeInsets.fromLTRB(15, 150, 20, 0),
                                    width: 250,
                                    height: 100,
                                    child: Stack(children: <Widget>[
                                      Text(
                                        'Smoking',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromARGB(212, 0, 0, 0),
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1.6666666666666667),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 30, 20, 0),
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
                                                this.profileDetails != null
                                                    ? profileDetails!
                                                                .smokingHabit
                                                                .name ==
                                                            "Smoker"
                                                        ? 'images/cigarette.png'
                                                        : profileDetails!
                                                                    .smokingHabit
                                                                    .name ==
                                                                "NonSmoker"
                                                            ? 'images/nonsmokerr.png'
                                                            : profileDetails!
                                                                        .smokingHabit
                                                                        .name ==
                                                                    "Occasionally"
                                                                ? 'images/cigarette.png'
                                                                : ""
                                                    : "",
                                                height: 28,
                                                width: 28),
                                            SizedBox(width: 8),
                                            Container(
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    this.profileDetails != null
                                                        ? profileDetails!
                                                            .smokingHabit.name
                                                        : "",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 22, 25, 1),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1.625),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),
                                Container(
                                    margin: EdgeInsets.fromLTRB(5, 250, 20, 0),
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
                                                fontWeight: FontWeight.normal,
                                                height: 1.6666666666666667),
                                          )),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 30, 20, 0),
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
                                                this.profileDetails != null
                                                    ? profileDetails!
                                                                .drinkingHabit
                                                                .name ==
                                                            "Alcoholic"
                                                        ? 'images/Beer.png'
                                                        : profileDetails!
                                                                    .smokingHabit
                                                                    .name ==
                                                                "Nonalcoholic"
                                                            ? 'images/nonalcoholiya.png'
                                                            : profileDetails!
                                                                        .smokingHabit
                                                                        .name ==
                                                                    "Occasionally"
                                                                ? 'images/cigarette.png'
                                                                : ""
                                                    : "",
                                                height: 28,
                                                width: 28),
                                            SizedBox(width: 8),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    this.profileDetails != null
                                                        ? profileDetails!
                                                            .drinkingHabit.name
                                                        : "",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 22, 25, 1),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1.625),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),
                                Container(
                                    margin: EdgeInsets.fromLTRB(15, 350, 0, 0),
                                    width: 400,
                                    height: 320,
                                    child: Stack(children: <Widget>[
                                      Text(
                                        'Hobbies',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromARGB(212, 0, 0, 0),
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            height: 1.6666666666666667),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    'Painting',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 22, 25, 1),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1.625),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(140, 30, 0, 0),
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
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    'Photography',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 22, 25, 1),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1.625),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 100, 20, 0),
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
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    'Mountain Hiking',
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
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 170, 0, 0),
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
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    'Cooking',
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
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 240, 20, 0),
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
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    'Reading Books',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 22, 25, 1),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1.625),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),
                              ])),
                        ])),
                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.only(left: 1),
                        width: 350,
                        height: 500,
                        child: Stack(children: <Widget>[
                          Container(
                              width: 350,
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
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 30, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'images/occasionally.png',
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
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.625),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Image.asset(
                                        'images/pen.png',
                                        color: kPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 60, 20, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(13, 255, 77, 110),
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
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        decoration: BoxDecoration(),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'House',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      18, 22, 25, 1),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.625),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(155, 60, 20, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(13, 255, 77, 110),
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
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        decoration: BoxDecoration(),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Business',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      18, 22, 25, 1),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.625),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 130, 20, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(13, 255, 77, 110),
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
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        decoration: BoxDecoration(),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Car',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      18, 22, 25, 1),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.625),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                        ])),
                  ],
                );
              } else {
                return Container();
              }
            },
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

  void navigateToFamily(BuildContext context) {
    // print("NAVIGATE${BlocProvider.of<OccupationBloc>(context).myState!.name}");
    var userRepo = BlocProvider.of<OccupationBloc>(context).userRepository;
    var countryModel = BlocProvider.of<OccupationBloc>(context).countryModel;
    var stateModel = BlocProvider.of<OccupationBloc>(context).myState;
    var city = BlocProvider.of<OccupationBloc>(context).city;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FamilyScreen(
              userRepository: userRepo,
              countryModel: countryModel,
              stateModel: stateModel,
              city: city,
            )));
    print(
        "objectCountry${BlocProvider.of<OccupationBloc>(context).countryModel!.name}");
    print(
        "objectState${BlocProvider.of<OccupationBloc>(context).myState!.name}");
    print("objectCity${BlocProvider.of<OccupationBloc>(context).city!.name}");
  }
}
