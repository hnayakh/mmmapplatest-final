import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  bool showAppBar = false;
  ScrollController _controller = ScrollController();
  int aboutState = 0;
  int careerState = 0;
  int interestState = 0;
  int religionState = 0;
  int familyState = 0;
  int lifestyleState = 0;
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
  )..forward();
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
    _controller.addListener(() {
      if (_controller.position.pixels >= 460) {
        setState(() {
          showAppBar = true;
        });
      }
      if (_controller.position.pixels < 460) {
        setState(() {
          showAppBar = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: showAppBar
          ? MmmButtons.appBarCurvedProfile('Kristen Stewart', context)
          : null,
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 475,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(23.3813)),
                    child: Image.asset(
                      'images/stackviewImage.jpg',
                      height: 453.01,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: Column(
                      children: [
                        MmmButtons.smallprofilePicButton('images/bio.jpg'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                        ),
                        MmmButtons.smallprofilePicButton('images/bio.jpg'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                        ),
                        MmmButtons.smallprofilePicButton('images/bio.jpg'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                        ),
                        MmmButtons.smallprofilePicButton('images/bio.jpg'),
                      ],
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
            ),
            Container(
              padding: kMargin16,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: Row(
                      children: [
                        Text(
                          'Kristen Stewart ',
                          style: MmmTextStyles.heading5(textColor: kPrimary),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Expanded(
                            // child:
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: kGreen),
                            ),
                            // ),
                            Expanded(child: SizedBox())
                          ],
                        ),
                        SvgPicture.asset(
                          'images/Verified.svg',
                          height: 20.51,
                          color: kPrimary,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  MmmWidgets.rowWidget(
                      "images/Users1.svg", ' Profile managed by Father'),
                  MmmWidgets.rowWidget(
                      "images/Calendar.svg", ' 25yrs, 12th Nov,1996 June'),
                  MmmWidgets.rowWidget(
                      "images/office.svg", 'Software Engineer'),
                  MmmWidgets.rowWidget("images/height.svg", '5’5’’ height'),
                  SizedBox(
                    height: 33,
                  ),
                  Stack(
                    children: [
                      MmmButtons.profileViewButtons(
                          "images/Users1.svg", 'About'),
                      aboutState == 0
                          ? MmmButtons.profileViewButtons(
                              "images/Users1.svg", 'About', action: () {
                              showAboutData();
                            })
                          : SizeTransition(
                              sizeFactor: _aboutAnimation,
                              axis: Axis.vertical,
                              axisAlignment: -1,
                              child: MmmButtons.aboutProfileViewButtons(
                                  "images/Users1.svg",
                                  'About',
                                  'I come from an upper middle class family. The most important thing in my life is religious beliefs, moral values and respect for elders. I’m modern thinker.',
                                  action: () {
                                showAboutData();
                              })),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      MmmButtons.profileViewButtons(
                          "images/education.svg", 'Career & Education'),
                      careerState == 0
                          ? MmmButtons.profileViewButtons(
                              "images/education.svg", 'Career & Education',
                              action: () {
                              showCareerData();
                            })
                          : SizeTransition(
                              sizeFactor: _careerAnimation,
                              axis: Axis.vertical,
                              axisAlignment: -1,
                              child: MmmButtons.aboutProfileViewButtons(
                                  "images/education.svg",
                                  'Career & Education',
                                  'I come from an upper middle class family. The most important thing in my life is religious beliefs, moral values and respect for elders. I’m modern thinker.',
                                  action: () {
                                showCareerData();
                              })),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      MmmButtons.profileViewButtons(
                          "images/heart.svg", 'Interests'),
                      interestState == 0
                          ? MmmButtons.profileViewButtons(
                              "images/heart.svg", 'Interests', action: () {
                              showInterestData();
                            })
                          : SizeTransition(
                              sizeFactor: _interestAnimation,
                              axis: Axis.vertical,
                              axisAlignment: -1,
                              child: MmmButtons.interestsProfileViewButtons(
                                  context,
                                  "images/heart.svg",
                                  'Interests',
                                  'I come from an upper middle class family. The most important thing in my life is religious beliefs, moral values and respect for elders. I’m modern thinker.',
                                  action: () {
                                showInterestData();
                              })),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      MmmButtons.profileViewButtons(
                          "images/religion.svg", 'Religion Information'),
                      religionState == 0
                          ? MmmButtons.profileViewButtons(
                              "images/religion.svg", 'Religion Information',
                              action: () {
                              showReligionData();
                            })
                          : SizeTransition(
                              sizeFactor: _religionAnimation,
                              axis: Axis.vertical,
                              axisAlignment: -1,
                              child: MmmButtons.aboutProfileViewButtons(
                                  "images/religion.svg",
                                  'Religion Information',
                                  'I come from an upper middle class family. The most important thing in my life is religious beliefs, moral values and respect for elders. I’m modern thinker.',
                                  action: () {
                                showReligionData();
                              })),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      MmmButtons.profileViewButtons(
                          "images/occasionally.svg", 'Lifestyle'),
                      lifestyleState == 0
                          ? MmmButtons.profileViewButtons(
                              "images/occasionally.svg", 'Lifestyle',
                              action: () {
                              showLifestyleData();
                            })
                          : SizeTransition(
                              sizeFactor: _lifestyleAnimation,
                              axis: Axis.vertical,
                              axisAlignment: -1,
                              child: MmmButtons.interestsProfileViewButtons(
                                  context,
                                  "images/occasionally.svg",
                                  'Lifestyle',
                                  'I come from an upper middle class family. The most important thing in my life is religious beliefs, moral values and respect for elders. I’m modern thinker.',
                                  action: () {
                                showLifestyleData();
                              })),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      MmmButtons.profileViewButtons(
                          "images/family.svg", 'Family'),
                      familyState == 0
                          ? MmmButtons.profileViewButtons(
                              "images/family.svg", 'Family', action: () {
                              showFamilyData();
                            })
                          : SizeTransition(
                              sizeFactor: _familyAnimation,
                              axis: Axis.vertical,
                              axisAlignment: -1,
                              child: MmmButtons.familyProfileViewButtons(
                                  "images/family.svg",
                                  'Family',
                                  'I come from an upper middle class family. The most important thing in my life is religious beliefs, moral values and respect for elders. I’m modern thinker.',
                                  action: () {
                                showFamilyData();
                              })),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  MmmButtons.checkMatchButton(80, 'Check Match Percentage',
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
}
