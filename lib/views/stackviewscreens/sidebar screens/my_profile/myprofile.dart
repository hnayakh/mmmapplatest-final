import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/views/profilescreens/about/bloc/about_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/myprofile/profile_photo_video.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/profilescreens/about/views/about.dart';
import 'package:makemymarry/views/profilescreens/bio/views/bio.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/bloc/family_details_bloc.dart';
import 'package:makemymarry/views/profilescreens/habbit/habit_bloc.dart';
import 'package:makemymarry/views/profilescreens/occupation/views/occupation.dart';
import 'package:makemymarry/views/profilescreens/occupation/bloc/occupation_bloc.dart';
import 'package:makemymarry/views/profilescreens/religion/bloc/religion_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile_event.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile_state.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_account.dart';
import '../../../../utils/widgets_large.dart';
import '../../../profilescreens/bio/bloc/bio_bloc.dart';
import '../../../profilescreens/family/family_background/bloc/family_background_bloc.dart';
import '../../../profilescreens/habbit/habits.dart';
import '../../../profilescreens/lifestyle/lifestyle_details_view.dart';
import '../../../profilescreens/religion/views/religion.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('My Profile', context: context),
      body: BlocProvider<MyProfileBloc>(
        create: (context) => MyProfileBloc(getIt<UserRepository>()),
        child: MyProfileBody(),
      ),
    );
  }
}

class MyProfileBody extends StatelessWidget {
  const MyProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileBloc, MyProfileState>(
      builder: (context, state) {
        if (state is MyProfileInitialState) {
          return MmmWidgets.buildLoader2(context);
        } else if (state is OnProfileFetched) {
          var profileDetails = state.userDetails;
          return SingleChildScrollView(
              child: Container(
            padding: kMargin16,
            child: Column(
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
                          // child: Image.network(
                          //   profileDetails!.images[1],
                          //   width: double.infinity,
                          //   fit: BoxFit.cover,
                          //   height: double.infinity,
                          // ),
                          //  )

                          child: profileDetails != null &&
                                  profileDetails!.images.length > 0 &&
                                  !profileDetails!.images[0]
                                      .contains("addImage")
                              ? Image.network(
                                  profileDetails!.images[0],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                )
                              : Image.asset('images/human.jpg')),
                    ),
                  ),
                  Positioned(
                    bottom: 55,
                    right: 25,
                    left: MediaQuery.of(context).size.width * 0.066,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MmmPhotovideos(
                                  userRepository: getIt<UserRepository>(),
                                )));
                        //showImagePickerDialog();
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
                            color: kSuccess,
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
                            style: MmmTextStyles.bodyRegular(textColor: gray3),
                          ),
                        ],
                      ))
                ]),
                SizedBox(
                  height: 30,
                ),
                MmmButtons.verifyAccountFliterScreen(
                  context,
                  action: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => VerifyAccount(
                                userRepository: getIt<UserRepository>(),
                              )),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                BasicInfoCard(profileDetails: profileDetails),
                SizedBox(height: 30),
                AboutCard(profileDetails: profileDetails),
                SizedBox(height: 20),
                FamilyInfoCard(profileDetails: profileDetails),
                SizedBox(height: 20),
                CareerInfoCard(profileDetails: profileDetails),
                SizedBox(height: 20),
                ReligionInfoCard(profileDetails: profileDetails),
                SizedBox(height: 20),
                InterestInfoCard(profileDetails: profileDetails),
                SizedBox(height: 20),
                LifestyleInfoCard(),
              ],
            ),
          ));
        } else {
          return Container();
        }
      },
    );
  }
}

class LifestyleInfoCard extends StatelessWidget {
  const LifestyleInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            color: Color.fromRGBO(164, 19, 60, 1),
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
                    context.navigate.push(MaterialPageRoute(
                        builder: (context) => LifeStyleView()));
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
                    color: Color.fromARGB(13, 255, 77, 110),
                    offset: Offset(0, 4),
                    blurRadius: 14)
              ],
              border: Border.all(
                color: Color.fromRGBO(193, 199, 205, 1),
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'images/House.png',
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'House',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(18, 22, 25, 1),
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
                    color: Color.fromARGB(13, 255, 77, 110),
                    offset: Offset(0, 4),
                    blurRadius: 14)
              ],
              border: Border.all(
                color: Color.fromRGBO(193, 199, 205, 1),
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'images/Factory.png',
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Business',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(18, 22, 25, 1),
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
                    color: Color.fromARGB(13, 255, 77, 110),
                    offset: Offset(0, 4),
                    blurRadius: 14)
              ],
              border: Border.all(
                color: Color.fromRGBO(193, 199, 205, 1),
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'images/car.png',
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Car',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(18, 22, 25, 1),
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
        ],
      ),
    );
  }
}

class InterestInfoCard extends StatelessWidget {
  const InterestInfoCard({
    Key? key,
    required this.profileDetails,
  }) : super(key: key);

  final ProfileDetails profileDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [
                          Image.asset('images/heartSpecialpng.png',
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
                                color: Color.fromRGBO(164, 19, 60, 1),
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
                            builder: (ctx) =>
                                Habit(userRepository: getIt<UserRepository>()),
                          ),
                        );
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
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  // width: 250,
                  // height: 100,
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
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(13, 255, 77, 110),
                              offset: Offset(0, 4),
                              blurRadius: 14)
                        ],
                        border: Border.all(
                          color: Color.fromRGBO(193, 199, 205, 1),
                          width: 1,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            profileDetails != null
                                ? profileDetails!.eatingHabit.name ==
                                        "Vegetarrian"
                                    ? 'images/LeafyGreen.png'
                                    : profileDetails!.eatingHabit.name ==
                                            "Nonvegetarrian"
                                        ? 'images/chicken.png'
                                        : profileDetails!.eatingHabit.name ==
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
                                  profileDetails != null
                                      ? profileDetails!.eatingHabit.name
                                      : "",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(18, 22, 25, 1),
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
              Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  // width: 250,
                  // height: 100,
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
                      margin: EdgeInsets.fromLTRB(0, 30, 20, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(13, 255, 77, 110),
                              offset: Offset(0, 4),
                              blurRadius: 14)
                        ],
                        border: Border.all(
                          color: Color.fromRGBO(193, 199, 205, 1),
                          width: 1,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                              profileDetails != null
                                  ? profileDetails!.smokingHabit.name ==
                                          "Smoker"
                                      ? 'images/cigarette.png'
                                      : profileDetails!.smokingHabit.name ==
                                              "NonSmoker"
                                          ? 'images/nonsmokerr.png'
                                          : profileDetails!.smokingHabit.name ==
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
                                  profileDetails != null
                                      ? profileDetails!.smokingHabit.name
                                      : "",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(18, 22, 25, 1),
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
              Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  // width: 250,
                  // height: 100,
                  child: Stack(children: <Widget>[
                    Text(
                      'Alcoholic',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromARGB(212, 0, 0, 0),
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.6666666666666667),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(13, 255, 77, 110),
                              offset: Offset(0, 4),
                              blurRadius: 14)
                        ],
                        border: Border.all(
                          color: Color.fromRGBO(193, 199, 205, 1),
                          width: 1,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                              profileDetails != null
                                  ? profileDetails!.drinkingHabit.name ==
                                          "Alcoholic"
                                      ? 'images/Beer.png'
                                      : profileDetails!.drinkingHabit.name ==
                                              "Nonalcoholic"
                                          ? 'images/nonalcoholiya.png'
                                          : profileDetails!
                                                      .drinkingHabit.name ==
                                                  "Occasionally"
                                              ? 'images/Beer.png'
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
                                  profileDetails != null
                                      ? profileDetails!.drinkingHabit.name
                                      : "",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(18, 22, 25, 1),
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
            ],
          ),
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
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(13, 255, 77, 110),
                          offset: Offset(0, 4),
                          blurRadius: 14)
                    ],
                    border: Border.all(
                      color: Color.fromRGBO(193, 199, 205, 1),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                                  color: Color.fromRGBO(18, 22, 25, 1),
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
                  margin: EdgeInsets.fromLTRB(140, 30, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(13, 255, 77, 110),
                          offset: Offset(0, 4),
                          blurRadius: 14)
                    ],
                    border: Border.all(
                      color: Color.fromRGBO(193, 199, 205, 1),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                                  color: Color.fromRGBO(18, 22, 25, 1),
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
                  margin: EdgeInsets.fromLTRB(0, 100, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(13, 255, 77, 110),
                          offset: Offset(0, 4),
                          blurRadius: 14)
                    ],
                    border: Border.all(
                      color: Color.fromRGBO(193, 199, 205, 1),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                                  color: Color.fromRGBO(18, 22, 25, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
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
                  margin: EdgeInsets.fromLTRB(0, 170, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(13, 255, 77, 110),
                          offset: Offset(0, 4),
                          blurRadius: 14)
                    ],
                    border: Border.all(
                      color: Color.fromRGBO(193, 199, 205, 1),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                                  color: Color.fromRGBO(18, 22, 25, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
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
                  margin: EdgeInsets.fromLTRB(0, 240, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(13, 255, 77, 110),
                          offset: Offset(0, 4),
                          blurRadius: 14)
                    ],
                    border: Border.all(
                      color: Color.fromRGBO(193, 199, 205, 1),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                                  color: Color.fromRGBO(18, 22, 25, 1),
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
        ]));
  }
}

class ReligionInfoCard extends StatelessWidget {
  const ReligionInfoCard({
    Key? key,
    required this.profileDetails,
  }) : super(key: key);

  final ProfileDetails profileDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 320,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              'Religion',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(164, 19, 60, 1),
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
                          OnNavigateToReligion(context);
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
                  'Religion',
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
                    profileDetails != null ? profileDetails!.religion : "",
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
                  'Caste',
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
                    profileDetails != null ? profileDetails!.cast : "",
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
                  'Mother Tongue',
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
                    profileDetails != null ? profileDetails!.motherTongue : "",
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
                  'Gothra',
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
                    profileDetails != null ? profileDetails!.gothra : "",
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
          SizedBox(
            height: 50,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 250, 0, 0),
              width: 150,
              height: 46,
              child: Stack(children: <Widget>[
                Text(
                  'Manglik',
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
                    profileDetails != null ? profileDetails!.manglik.name : "",
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
        ]));
  }
}

class CareerInfoCard extends StatelessWidget {
  const CareerInfoCard({
    Key? key,
    required this.profileDetails,
  }) : super(key: key);

  final ProfileDetails profileDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 300,
      child: Stack(
        children: <Widget>[
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              'Career',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(164, 19, 60, 1),
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
                          navigateToCareer(context);
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
              // width: 150,
              height: 70,
              child: Stack(children: <Widget>[
                Text(
                  'Occupation',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  width: 149,
                  height: 90,
                  margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                  child: Text(
                    profileDetails != null ? profileDetails!.occupation : "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(18, 22, 25, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                    ),
                  ),
                ),
              ])),
          Container(
            margin: EdgeInsets.fromLTRB(20, 100, 0, 0),
            width: 149,
            height: 46,
            child: Stack(
              children: <Widget>[
                Text(
                  'Annual Income',
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
                    profileDetails != null
                        ? profileDetails!.annualIncome.name
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
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 150, 0, 0),
              width: 149,
              height: 46,
              child: Stack(children: <Widget>[
                Text(
                  'Highest Education',
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
                    profileDetails != null
                        ? profileDetails!.highiestEducation
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
            child: Stack(
              children: <Widget>[
                Text(
                  'Current Location',
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
                    profileDetails != null
                        ? "${profileDetails!.city}, ${profileDetails!.state} "
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FamilyInfoCard extends StatelessWidget {
  const FamilyInfoCard({
    Key? key,
    required this.profileDetails,
  }) : super(key: key);

  final ProfileDetails profileDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 480,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  color: Color.fromRGBO(164, 19, 60, 1),
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
                    profileDetails != null
                        ? profileDetails!.familyAfluenceLevel.name
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
                    profileDetails != null
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
            child: Stack(
              children: <Widget>[
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
                    profileDetails != null
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
              ],
            ),
          ),
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
                    profileDetails != null
                        ? "${profileDetails!.familyCity}, ${profileDetails!.familyState} "
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
          Column(children: [
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
                margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
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
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
          ]),
        ]));
  }
}

class AboutCard extends StatelessWidget {
  const AboutCard({
    Key? key,
    required this.profileDetails,
  }) : super(key: key);

  final ProfileDetails profileDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            color: Color.fromRGBO(164, 19, 60, 1),
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.625),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Bio(
                              userRepository: getIt<UserRepository>(),
                            )));
                    BlocProvider.of<MyProfileBloc>(context).loadMyData();
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
              profileDetails.aboutmeMsg,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(18, 22, 25, 1),
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  height: 1.5714285714285714),
            ),
          ),
        ]));
  }
}

class BasicInfoCard extends StatelessWidget {
  const BasicInfoCard({
    Key? key,
    required this.profileDetails,
  }) : super(key: key);

  final ProfileDetails profileDetails;

  @override
  Widget build(BuildContext context) {
    print(profileDetails.occupation);
    return Container(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              profileDetails != null
                                  ? profileDetails!.dateOfBirth
                                  : "",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(18, 22, 25, 1),
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
                              profileDetails.occupation,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(18, 22, 25, 1),
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
                              profileDetails!.height + '"' + 'inches',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(18, 22, 25, 1),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              profileDetails != null
                                  ? 'Profile managed by ${profileDetails!.relationship.name}'
                                  : "",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(18, 22, 25, 1),
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
                        profileDetails != null ? profileDetails!.name : "",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(164, 19, 60, 1),
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.625),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => About(
                              userRepository: getIt<UserRepository>(),
                            )));
                    BlocProvider.of<MyProfileBloc>(context).loadMyData();
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
        ]));
  }
}

void OnNavigateToReligion(BuildContext context) async {
  await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Religion(
            userRepository: getIt<UserRepository>(),
          )));
  BlocProvider.of<MyProfileBloc>(context).loadMyData();
}

void navigateToCareer(BuildContext context) async {
  await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Occupations(
            userRepository: getIt<UserRepository>(),
          )));
  BlocProvider.of<MyProfileBloc>(context).loadMyData();
}

void navigateToFamily(BuildContext context) async {
  // print("NAVIGATE${BlocProvider.of<OccupationBloc>(context).myState!.name}");
  // var userRepo = BlocProvider.of<OccupationBloc>(context).userRepository;
  // var countryModel = BlocProvider.of<OccupationBloc>(context).countryModel;
  // var stateModel = BlocProvider.of<OccupationBloc>(context).myState;
  // var city = BlocProvider.of<OccupationBloc>(context).city;
  await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FamilyScreen(
            userRepository: getIt<UserRepository>(),
            countryModel: null,
            stateModel: null,
            city: null,
          )));
  BlocProvider.of<MyProfileBloc>(context).loadMyData();
}
