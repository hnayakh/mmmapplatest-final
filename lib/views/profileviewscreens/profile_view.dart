import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class ProfileView extends StatelessWidget {
  final UserRepository userRepository;
  final ProfileDetails profileDetails;

  const ProfileView(
      {Key? key, required this.userRepository, required this.profileDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileViewScreen(
      profileDetails: profileDetails,
    );
  }
}

class ProfileViewScreen extends StatefulWidget {
  final ProfileDetails profileDetails;

  const ProfileViewScreen({Key? key, required this.profileDetails})
      : super(key: key);

  @override
  _ProfileViewScreenState createState() =>
      _ProfileViewScreenState(profileDetails);
}

class _ProfileViewScreenState extends State<ProfileViewScreen>
    with TickerProviderStateMixin {
  final ProfileDetails profileDetails;
  bool showAppBar = true;
  ScrollController _controller = ScrollController();
  int aboutState = 0;
  int careerState = 0;
  int interestState = 0;
  int religionState = 0;
  int familyState = 0;
  int lifestyleState = 0;

  late final AnimationController _appBarController = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> _appBarAnimation = CurvedAnimation(
    parent: _appBarController,
    curve: Curves.easeInCubic,
  );
  late final AnimationController _aboutController = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  late final Animation<double> _aboutAnimation = CurvedAnimation(
    parent: _aboutController,
    curve: Curves.fastOutSlowIn,
  )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed && aboutState == 2)
        setState(() {
          aboutState = 0;
        });
    });

  late final AnimationController _careerController = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> _careerAnimation = CurvedAnimation(
    parent: _careerController,
    curve: Curves.fastOutSlowIn,
  )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed && careerState == 2)
        setState(() {
          careerState = 0;
        });
    });

  late final AnimationController _interestController = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  late final Animation<double> _interestAnimation = CurvedAnimation(
    parent: _interestController,
    curve: Curves.fastOutSlowIn,
  )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed && interestState == 2)
        setState(() {
          interestState = 0;
        });
    });

  late final AnimationController _religionController = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  late final Animation<double> _religionAnimation = CurvedAnimation(
    parent: _religionController,
    curve: Curves.fastOutSlowIn,
  )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed && religionState == 2)
        setState(() {
          religionState = 0;
        });
    });

  late final AnimationController _lifestyleController = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  late final Animation<double> _lifestyleAnimation = CurvedAnimation(
    parent: _lifestyleController,
    curve: Curves.fastOutSlowIn,
  )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed && lifestyleState == 2)
        setState(() {
          lifestyleState = 0;
        });
    });

  late final AnimationController _familyController = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  late final Animation<double> _familyAnimation = CurvedAnimation(
    parent: _familyController,
    curve: Curves.fastOutSlowIn,
  )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed && familyState == 2)
        setState(() {
          familyState = 0;
        });
    });

  static var appBarState = 0;

  int selectedImagePos = 0;

  bool? exist = false;

  _ProfileViewScreenState(this.profileDetails);

  Future<bool> checkExist(String docID) async {
    try {
      await FirebaseFirestore.instance
          .doc("userStatus/$docID")
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      return exist!;
    } catch (e) {
      // If any error
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _aboutController.dispose();
    _careerController.dispose();
    _interestController.dispose();
    _religionController.dispose();
    _lifestyleController.dispose();
    _familyController.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkExist(profileDetails.id);
    _controller.addListener(() {
      if (_controller.position.pixels >=
          MediaQuery.of(context).size.height * 0.66) {
        setState(() {
          //showAppBar = true;
          if (_appBarController.isAnimating == false) {
            _appBarController..forward();
          }
        });
      }
      if (_controller.position.pixels <
          MediaQuery.of(context).size.height * 0.66) {
        setState(() {
          //showAppBar = false;
          if (_appBarController.isAnimating == false) {
            _appBarController..reverse();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: showAppBar
          ? PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.17),
              child: SizeTransition(
                  sizeFactor: _appBarAnimation,
                  axis: Axis.vertical,
                  //axisAlignment: -1,
                  child: MmmButtons.appBarCurvedProfile(profileDetails.name,
                      context, this.profileDetails.images[selectedImagePos])),
            )
          : null,
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            buildImages(context),
            Container(
              padding: kMargin16,
              child: Column(
                children: [
                  buildBasicInfo(),
                  SizedBox(
                    height: 33,
                  ),
                  buildAboutMe(),
                  SizedBox(
                    height: 16,
                  ),
                  buildHabits(context),
                  SizedBox(
                    height: 16,
                  ),
                  buildReligion(),
                  SizedBox(
                    height: 16,
                  ),
                  buildCarrer(),
                  SizedBox(
                    height: 16,
                  ),
                  buildFamilyButton(),
                  SizedBox(
                    height: 60,
                  ),
                  MmmButtons.checkMatchButton(54, 'Check Match Percentage',
                      action: () {}),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Blocked Profile',
                    style: MmmTextStyles.bodyRegular(textColor: kPrimary),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Stack buildFamilyButton() {
    return Stack(
      children: [
        MmmButtons.profileViewButtons("images/family.svg", 'Family'),
        familyState == 0
            ? MmmButtons.profileViewButtons("images/family.svg", 'Family',
                action: () {
                showFamilyData();
              })
            : SizeTransition(
                sizeFactor: _familyAnimation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: MmmButtons.familyProfileViewButtons(
                    profileDetails.familyAfluenceLevel,
                    profileDetails.familyValues,
                    profileDetails.familyType,
                    profileDetails.familyCity,
                    profileDetails.familyState,
                    profileDetails.familyCountry,
                    profileDetails.fatherOccupation,
                    profileDetails.motherOccupation,
                    profileDetails.noOfBrother,
                    profileDetails.brothersMarried,
                    profileDetails.noOfSister,
                    profileDetails.sistersMarried, action: () {
                  showFamilyData();
                })),
      ],
    );
  }

  Stack buildCarrer() {
    return Stack(
      children: [
        MmmButtons.profileViewButtons(
            "images/education.svg", 'Career & Education'),
        careerState == 0
            ? MmmButtons.profileViewButtons(
                "images/education.svg", 'Career & Education', action: () {
                showCareerData();
              })
            : SizeTransition(
                sizeFactor: _careerAnimation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: MmmButtons.carrerProfileView(
                    profileDetails.employedin,
                    profileDetails.occupation,
                    profileDetails.annualIncome,
                    profileDetails.city,
                    profileDetails.state,
                    profileDetails.country,
                    profileDetails.highiestEducation, action: () {
                  showCareerData();
                })),
      ],
    );
  }

  Stack buildReligion() {
    return Stack(
      children: [
        MmmButtons.profileViewButtons("images/religion.svg", 'Religion'),
        religionState == 0
            ? MmmButtons.profileViewButtons("images/religion.svg", 'Religion',
                action: () {
                showReligionData();
              })
            : SizeTransition(
                sizeFactor: _religionAnimation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: MmmButtons.religionProfileView(
                    profileDetails.religion,
                    profileDetails.cast,
                    profileDetails.gothra,
                    profileDetails.manglik,
                    profileDetails.motherTongue, action: () {
                  showReligionData();
                })),
      ],
    );
  }

  Stack buildHabits(BuildContext context) {
    return Stack(
      children: [
        MmmButtons.profileViewButtons("images/occasionally.svg", 'Lifestyle'),
        lifestyleState == 0
            ? MmmButtons.profileViewButtons(
                "images/occasionally.svg", 'Lifestyle', action: () {
                showLifestyleData();
              })
            : SizeTransition(
                sizeFactor: _lifestyleAnimation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: MmmButtons.interestsProfileViewButtons(
                    context,
                    profileDetails.eatingHabit,
                    profileDetails.drinkingHabit,
                    profileDetails.smokingHabit, action: () {
                  showLifestyleData();
                })),
      ],
    );
  }

  Stack buildAboutMe() {
    return Stack(
      children: [
        MmmButtons.profileViewButtons("images/Users1.svg", 'About'),
        aboutState == 0
            ? MmmButtons.profileViewButtons("images/Users1.svg", 'About',
                action: () {
                showAboutData();
              })
            : SizeTransition(
                sizeFactor: _aboutAnimation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: MmmButtons.aboutProfileViewButtons(
                    "images/Users1.svg",
                    'About',
                    profileDetails.aboutMe,
                    profileDetails.maritalStatus,
                    profileDetails.abilityStatus, action: () {
                  showAboutData();
                })),
      ],
    );
  }

  Container buildImages(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 475,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(23.3813)),
            child: Image.network(
              profileDetails.images[selectedImagePos],
              // height: 453.01,
              height: MediaQuery.of(context).size.height * 0.665,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right: MediaQuery.of(context).size.width * 0.05,
            child: Column(
              children: createImageThumbNails(),
            ),
          ),
          Column(
            children: [
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(flex: 20, child: SizedBox()),
                  MmmIcons.cancel(),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  MmmIcons.meet(),
                  Expanded(flex: 2, child: SizedBox()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showAboutData() {
    setState(() {
      if (aboutState == 0) {
        aboutState = 1;
        _aboutController..forward();
      } else if (aboutState == 1 && _aboutController.isCompleted) {
        _aboutController..reverse();
        aboutState = 2;
      }
    });
  }

  void showCareerData() {
    setState(() {
      if (careerState == 0) {
        careerState = 1;
        _careerController..forward();
      } else if (careerState == 1 && _careerController.isCompleted) {
        _careerController..reverse();
        careerState = 2;
      }
    });
  }

  void showInterestData() {
    setState(() {
      if (interestState == 0) {
        interestState = 1;
        _interestController..forward();
      } else if (interestState == 1 && _interestController.isCompleted) {
        _interestController..reverse();
        interestState = 2;
      }
    });
  }

  void showReligionData() {
    setState(() {
      if (religionState == 0) {
        religionState = 1;
        _religionController..forward();
      } else if (religionState == 1 && _religionController.isCompleted) {
        _religionController..reverse();
        religionState = 2;
      }
    });
  }

  void showLifestyleData() {
    setState(() {
      if (lifestyleState == 0) {
        lifestyleState = 1;
        _lifestyleController..forward();
      } else if (lifestyleState == 1 && _lifestyleController.isCompleted) {
        _lifestyleController..reverse();
        lifestyleState = 2;
      }
    });
  }

  void showFamilyData() {
    setState(() {
      if (familyState == 0) {
        familyState = 1;
        _familyController..forward();
      } else if (familyState == 1 && _familyController.isCompleted) {
        _familyController..reverse();
        familyState = 2;
      }
    });
  }

  List<Widget> createImageThumbNails() {
    List<Widget> list = [];
    for (var image in profileDetails.images) {
      list.add(Column(
        children: [
          MmmButtons.smallprofilePicButton(image, () {
            setState(() {
              this.selectedImagePos = profileDetails.images.indexOf(image);
            });
          }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.012,
          ),
        ],
      ));
    }
    return list;
  }

  String getProfileManagedBy() {
    switch (profileDetails.relationship) {
      case Relationship.Self:
        return "Self";
      case Relationship.Son:
      case Relationship.Daughter:
        return "Father";
      case Relationship.Sister:

      case Relationship.Brother:
        return "Brother";

      case Relationship.Friend:
        return "Friend";
      case Relationship.Relative:
        return "Relative";
    }
  }

  Widget buildBasicInfo() {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.03,
            child: Row(
              children: [
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                      style: MmmTextStyles.heading5(textColor: kPrimary),
                      text: profileDetails.name,
                    ),
                  ),
                ),
                exist!
                    ? StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('userStatus')
                            .doc(profileDetails.id)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Expanded(
                              // child:
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: snapshot.data!['status'] == 'Online'
                                        ? kGreen
                                        : kError),
                              ),
                              // ),
                              Expanded(child: SizedBox())
                            ],
                          );
                        })
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Expanded(
                          // child:
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: kGray),
                          ),
                          // ),
                          Expanded(child: SizedBox())
                        ],
                      ),
                profileDetails.activationStatus ==
                        ProfileActivationStatus.Verified
                    ? SvgPicture.asset(
                        'images/Verified.svg',
                        height: 20.51,
                        color: kPrimary,
                      )
                    : Container()
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          MmmWidgets.rowWidget("images/Users1.svg",
              ' Profile managed by ${getProfileManagedBy()}'),
          MmmWidgets.rowWidget("images/Calendar.svg",
              ' ${AppHelper.getAgeFromDob(profileDetails.dateOfBirth)}yrs, ${AppHelper.getReadableDob(profileDetails.dateOfBirth)}'),
          MmmWidgets.rowWidget("images/office.svg", profileDetails.occupation),
          MmmWidgets.rowWidget(
              "images/height.svg", '${profileDetails.height}"" height'),
        ],
      ),
    );
  }
}
