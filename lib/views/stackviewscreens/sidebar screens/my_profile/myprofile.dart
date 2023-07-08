import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/myprofile/profile_photo_video.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/about/views/about.dart';
import 'package:makemymarry/views/profilescreens/bio/views/bio.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';
import 'package:makemymarry/views/profilescreens/hobbies/hobby_details_view.dart';
import 'package:makemymarry/views/profilescreens/occupation/views/occupation.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile_state.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_account.dart';

import '../../../../utils/widgets_large.dart';
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
                      height: MediaQuery.of(context).size.width * 0.294,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: MediaQuery.of(context).size.width * 0.327,
                            left: MediaQuery.of(context).size.width * 0.327,
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.122,
                              child: ClipOval(
                                  // clipper: Cu,

                                  child: profileDetails.images.length > 0 &&
                                          !profileDetails.images[0]
                                              .contains("addImage")
                                      ?
                                      // child: Container(
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: InkWell(
                                              onTap: () async {
                                                print("enlarge photo");
                                                final imageProvider =
                                                    Image.network(profileDetails
                                                            .images[0])
                                                        .image;
                                                showImageViewer(
                                                    context, imageProvider,
                                                    onViewerDismissed: () {
                                                  print("dismissed");
                                                });
                                              },
                                              child: Image.network(
                                                  profileDetails.images[0],
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                  height: double.infinity,
                                                  errorBuilder: (context, obj,
                                                          str) =>
                                                      Container(
                                                          color: Colors.grey,
                                                          child: Icon(
                                                              Icons.error)))),
                                        )
                                      //)
                                      : Image.asset('images/human.jpg')),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 25,
                            left: MediaQuery.of(context).size.width * 0.066,
                            child: InkWell(
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => MmmPhotovideos(
                                              userRepository:
                                                  getIt<UserRepository>(),
                                            )));
                                BlocProvider.of<MyProfileBloc>(context)
                                    .loadMyData();
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
                        ],
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            profileDetails.name,
                            textAlign: TextAlign.center,
                            style: MmmTextStyles.heading4(textColor: kDark5),
                          ),
                          Text(
                            profileDetails!.mmId.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: MmmTextStyles.bodyRegular(textColor: gray3),
                          )
                        ],
                      ),
                    )
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
                  LifestyleInfoCard(profileDetails: profileDetails),
                ],
              ),
            ),
          );
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
    required this.profileDetails,
  }) : super(key: key);

  final ProfileDetails profileDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 18, 0),
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
                            fontFamily: 'MakeMyMarry',
                            color: Color.fromRGBO(164, 19, 60, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.625),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await context.navigate.push(MaterialPageRoute(
                        builder: (context) => LifeStyleView()));
                    BlocProvider.of<MyProfileBloc>(context).loadMyData();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'images/pen.png',
                      color: kPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            children: <Widget>[
              ...(profileDetails.lifeStyle
                      ?.map(
                        (e) => LifeStyleTile(
                            lifestyle: LifeStyleType.values
                                .where((element) => element.name == e)
                                .first),
                      )
                      .toList() ??
                  <Widget>[]),
            ],
          ),
          SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}

class LifeStyleTile extends StatelessWidget {
  const LifeStyleTile({
    Key? key,
    required this.lifestyle,
  }) : super(key: key);

  final LifeStyleType lifestyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 8, 8, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
          SvgPicture.asset(
            lifestyle.asset,
            color: Colors.black,
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Row(
              children: <Widget>[
                Text(
                  lifestyle.label,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(18, 22, 25, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1.625),
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
    print(profileDetails.hobbies);
    print(profileDetails.hobbies.isNotNullEmpty);
    print("========================================>>>");
    return Container(
      margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
      width: 350,
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
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 18, 0),
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
                            'Habits',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'MakeMyMarry',
                                color: Color.fromRGBO(164, 19, 60, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.625),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => Habit(
                              userRepository: getIt<UserRepository>(),
                              toUpdate: true,
                            ),
                          ),
                        );
                        BlocProvider.of<MyProfileBloc>(context).loadMyData();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'images/pen.png',
                          color: kPrimary,
                        ),
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
                          fontFamily: 'MakeMyMarry',
                          color: Color.fromARGB(212, 0, 0, 0),
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
                          SvgPicture.asset(
                            profileDetails != null
                                ? profileDetails!.eatingHabit.name ==
                                        "Vegetarrian"
                                    ? 'images/Veg2.svg'
                                    : profileDetails!.eatingHabit.name ==
                                            "Nonvegetarrian"
                                        ? 'images/non veg.svg'
                                        : profileDetails!.eatingHabit.name ==
                                                "Eggitarrian"
                                            ? 'images/egg.svg'
                                            : "images/egg.svg"
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
                                      fontFamily: 'MakeMyMarry',
                                      color: Color.fromRGBO(18, 22, 25, 1),
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
                          fontFamily: 'MakeMyMarry',
                          color: Color.fromARGB(212, 0, 0, 0),
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
                          SvgPicture.asset(
                              profileDetails != null
                                  ? profileDetails!.smokingHabit.name ==
                                          "Smoker"
                                      ? 'images/smoke.svg'
                                      : profileDetails!.smokingHabit.name ==
                                              "NonSmoker"
                                          ? 'images/noSmoke.svg'
                                          : profileDetails!.smokingHabit.name ==
                                                  "Occasionally"
                                              ? 'images/smoke.svg'
                                              : "images/smoke.svg"
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
                                      fontFamily: 'MakeMyMarry',
                                      color: Color.fromRGBO(18, 22, 25, 1),
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
                child: Stack(
                  children: <Widget>[
                    Text(
                      'Alcoholic',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'MakeMyMarry',
                          color: Color.fromARGB(212, 0, 0, 0),
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
                          SvgPicture.asset(
                              profileDetails != null
                                  ? profileDetails!.drinkingHabit.name ==
                                          "Alcoholic"
                                      ? 'images/alcoholic.svg'
                                      : profileDetails!.drinkingHabit.name ==
                                              "Nonalcoholic"
                                          ? 'images/non_alcoholic.svg'
                                          : profileDetails!
                                                      .drinkingHabit.name ==
                                                  "Occasionally"
                                              ? 'images/occasionally.svg'
                                              : "images/occasionally.svg"
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
                                      fontFamily: 'MakeMyMarry',
                                      color: Color.fromRGBO(18, 22, 25, 1),
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
              ),
            ],
          ),
          if (profileDetails.hobbies.isNotNullEmpty)
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hobbies',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromARGB(212, 0, 0, 0),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 1.6666666666666667),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    alignment: WrapAlignment.start,
                    children: <Widget>[
                      ...(profileDetails.hobbies
                              ?.where(
                                  (element) => element.trim().isNotNullEmpty)
                              .map(
                            (e) {
                              print(e);
                              print("========================>>>>>>>.");
                              return ProfileHobbyTile(
                                  hobby: HobbyType.values
                                      .where((element) => element.name == e)
                                      .first);
                            },
                          ).toList() ??
                          <Widget>[]),
                    ],
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 18,
          )
        ],
      ),
    );
  }
}

class ProfileHobbyTile extends StatelessWidget {
  const ProfileHobbyTile({
    Key? key,
    required this.hobby,
  }) : super(key: key);

  final HobbyType hobby;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
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
          SvgPicture.asset(
            hobby.asset,
          ),
          SizedBox(width: 8),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  hobby.label,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(18, 22, 25, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1.625),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                  margin: EdgeInsets.fromLTRB(10, 10, 18, 0),
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
                                  fontFamily: 'MakeMyMarry',
                                  color: Color.fromRGBO(164, 19, 60, 1),
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
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            'images/pen.png',
                            color: kPrimary,
                          ),
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
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
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
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
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
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
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
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontSize: 12,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    profileDetails.gothra.isNotNullEmpty
                        ? profileDetails.gothra
                        : "Not Applicable",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontSize: 12,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    profileDetails.manglik.label,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      // width: 350,
      // height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 4, 0),
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
                            fontFamily: 'MakeMyMarry',
                            color: Color.fromRGBO(164, 19, 60, 1),
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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'images/pen.png',
                      color: kPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: Stack(children: <Widget>[
            Text(
              'Occupation',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'MakeMyMarry',
                  color: Color.fromRGBO(135, 141, 150, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  height: 1.6666666666666667),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Text(
                profileDetails != null ? profileDetails!.occupation : "",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'MakeMyMarry',
                  color: Color.fromRGBO(18, 22, 25, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                ),
              ),
            ),
          ])),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Text(
                  'Annual Income',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontSize: 12,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    AppHelper.getStringFromEnum(profileDetails.annualIncome),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 1.5714285714285714),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Text(
                  'Highest Education',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontSize: 12,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    profileDetails.highiestEducation,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
          SizedBox(
            height: 12,
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Text(
                  'Current Location',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontSize: 12,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "${profileDetails.country}, ${profileDetails.state}${profileDetails.city.isNotEmpty ? "," : ""} ${profileDetails.city}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 1.5714285714285714),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
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
                  margin: EdgeInsets.fromLTRB(10, 10, 18, 0),
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
                                  fontFamily: 'MakeMyMarry',
                                  color: Color.fromRGBO(164, 19, 60, 1),
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
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'images/pen.png',
                            color: kPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(top: 22, left: 310, child: Text('')),
              ])),
          Container(
              margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
              // width: 84,
              height: 46,
              child: Stack(children: <Widget>[
                Text(
                  'Status',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    AppHelper.getStringFromEnum(
                        profileDetails.familyAfluenceLevel),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontSize: 12,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    AppHelper.getStringFromEnum(profileDetails.familyType),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontSize: 12,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    AppHelper.getStringFromEnum(profileDetails.familyValues),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
              height: 46,
              child: Stack(children: <Widget>[
                Text(
                  'Location',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'MakeMyMarry',
                      color: Color.fromRGBO(135, 141, 150, 1),
                      fontSize: 12,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.6666666666666667),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    (profileDetails.familyCountry +
                                profileDetails.familyCity +
                                profileDetails.familyState)
                            .isNotEmpty
                        ? "${profileDetails.familyCountry}, ${profileDetails.familyState}, ${profileDetails.familyCity}"
                        : "Not Mentioned",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(18, 22, 25, 1),
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
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(135, 141, 150, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        height: 1.6666666666666667),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      AppHelper.getStringFromEnum(
                          profileDetails.fatherOccupation),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'MakeMyMarry',
                          color: Color.fromRGBO(18, 22, 25, 1),
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
                        fontFamily: 'MakeMyMarry',
                        color: Color.fromRGBO(135, 141, 150, 1),
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1.6666666666666667),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      AppHelper.getStringFromEnum(
                          profileDetails.motherOccupation),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'MakeMyMarry',
                          color: Color.fromRGBO(18, 22, 25, 1),
                          fontSize: 14,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.5714285714285714),
                    ),
                  ),
                ])),
            Container(
                margin: EdgeInsets.fromLTRB(12, 5, 0, 0),
                height: 46,
                child: Stack(children: <Widget>[
                  Container(
                    child: Text(
                      'No. of Brother’s/Married',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'MakeMyMarry',
                          color: Color.fromRGBO(135, 141, 150, 1),
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
                          fontFamily: 'MakeMyMarry',
                          color: Color.fromRGBO(18, 22, 25, 1),
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
                          fontFamily: 'MakeMyMarry',
                          color: Color.fromRGBO(135, 141, 150, 1),
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
                          fontFamily: 'MakeMyMarry',
                          color: Color.fromRGBO(18, 22, 25, 1),
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
            margin: EdgeInsets.fromLTRB(10, 10, 18, 0),
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
                            fontFamily: 'MakeMyMarry',
                            color: Color.fromRGBO(164, 19, 60, 1),
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
                              toUpdate: true,
                            )));
                    BlocProvider.of<MyProfileBloc>(context).loadMyData();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'images/pen.png',
                      color: kPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(14, 40, 30, 12),
            child: Text(
              profileDetails.aboutmeMsg,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'MakeMyMarry',
                  color: Color.fromRGBO(18, 22, 25, 1),
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
      margin: EdgeInsets.only(left: 1),
      width: double.infinity,
      // height: 190,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        Image.asset(
                          'images/Users1.png',
                          color: kPrimary,
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            profileDetails != null ? profileDetails!.name : "",
                            textAlign: TextAlign.left,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                                fontFamily: 'MakeMyMarry',
                                color: Color.fromRGBO(164, 19, 60, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.625),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => About(
                          userRepository: getIt<UserRepository>(),
                          toUpdate: true,
                        ),
                      ),
                    );
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
          Container(
            margin: EdgeInsets.fromLTRB(10, 4, 10, 0),
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
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${AppHelper.getAgeFromDob(profileDetails.dateOfBirth)} yrs, ${AppHelper.getReadableDob(profileDetails.dateOfBirth)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'MakeMyMarry',
                            color: Color.fromRGBO(18, 22, 25, 1),
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
            margin: EdgeInsets.fromLTRB(8, 4, 10, 0),
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
                            fontFamily: 'MakeMyMarry',
                            color: Color.fromRGBO(18, 22, 25, 1),
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
            margin: EdgeInsets.fromLTRB(5, 4, 10, 0),
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
                        AppHelper.heightString(profileDetails.height) +
                            ' inches',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'MakeMyMarry',
                            color: Color.fromRGBO(18, 22, 25, 1),
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
            margin: EdgeInsets.fromLTRB(8, 4, 10, 0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/Users1.png',
                  color: Color.fromARGB(192, 0, 0, 0),
                ),
                SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        profileDetails != null
                            ? 'Profile managed by ${getProfileManagedBy(profileDetails!.relationship)}'
                            : "",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'MakeMyMarry',
                            color: Color.fromRGBO(18, 22, 25, 1),
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
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  String getProfileManagedBy(Relationship relationship) {
    switch (relationship) {
      case Relationship.Self:
        return "Self";
      case Relationship.Son:
      case Relationship.Daughter:
        return "Parents";
      case Relationship.Sister:
      case Relationship.Brother:
        return "Siblings";
      case Relationship.Friend:
        return "Friend";
      case Relationship.Relative:
        return "Relative";
    }
  }
}

void OnNavigateToReligion(BuildContext context) async {
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Religion(
        userRepository: getIt<UserRepository>(),
        toUpdate: true,
      ),
    ),
  );
  BlocProvider.of<MyProfileBloc>(context).loadMyData();
}

void navigateToCareer(BuildContext context) async {
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Occupations(
        userRepository: getIt<UserRepository>(),
        toUpdate: true,
      ),
    ),
  );
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
            toUpdate: true,
          )));
  BlocProvider.of<MyProfileBloc>(context).loadMyData();
}
