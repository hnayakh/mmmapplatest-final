import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/connects/views/audio_call.dart';
import 'package:makemymarry/views/connects/views/video_call.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_bloc.dart';
import 'package:makemymarry/views/profile_detail_view/profile_view_bloc.dart';
import 'package:makemymarry/views/profile_detail_view/profile_view_event.dart';
import 'package:makemymarry/views/profile_detail_view/profile_view_state.dart';

class ProfileView extends StatelessWidget {
  final UserRepository userRepository;
  final ProfileDetails profileDetails;

  const ProfileView(
      {Key? key, required this.userRepository, required this.profileDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ProfileViewBloc>(
        create: (BuildContext context) => ProfileViewBloc(
          userRepository,
          profileDetails,
        ),
      ),
      BlocProvider<MatchingPercentageBloc>(
        create: (BuildContext context) =>
            MatchingPercentageBloc(userRepository, profileDetails),
      )
    ], child: ProfileViewScreen()); //return
  }
}

class ProfileViewScreen extends StatefulWidget {
  @override
  _ProfileViewScreenState createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen>
    with TickerProviderStateMixin {
  late ProfileDetails profileDetails;
  late String message;
  bool showAppBar = true;
  ScrollController _controller = ScrollController();
  int aboutState = 0;
  int careerState = 0;
  int interestState = 0;
  int hobbyState = 0;
  int religionState = 0;
  int familyState = 0;
  int lifestyleState = 0;

  late Animation<double> _animation;
  late AnimationController _animationController;

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

  late final AnimationController _hobbyController = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  late final Animation<double> _hobbyAnimation = CurvedAnimation(
    parent: _hobbyController,
    curve: Curves.fastOutSlowIn,
  )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed && hobbyState == 2)
        setState(() {
          hobbyState = 0;
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

  int selectedImagePos = 0;

  bool? exist = false;

  _ProfileViewScreenState();

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
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _controller.addListener(() {
      _animationController.reverse();
      if (_controller.position.pixels >=
          MediaQuery.of(context).size.height * 0.50) {
        setState(() {
          if (_appBarController.isAnimating == false) {
            _appBarController..forward();
          }
        });
      }
      if (_controller.position.pixels <
          MediaQuery.of(context).size.height * 0.66) {
        setState(() {
          if (_appBarController.isAnimating == false) {
            _appBarController..reverse();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewBloc, ProfileViewState>(
        builder: (context, state) {
          if (state is ProfileViewInitialState) {
            BlocProvider.of<ProfileViewBloc>(context).add(VisitProfile());
          }
          this.profileDetails =
              BlocProvider.of<ProfileViewBloc>(context).profileDetails;
          if (state is OnLoading) {
            return Scaffold(
              body: MmmWidgets.buildLoader2(context),
            );
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: showAppBar
                ? PreferredSize(
                    preferredSize: Size.fromHeight(
                        MediaQuery.of(context).size.height * 0.15),
                    child: SizeTransition(
                      sizeFactor: _appBarAnimation,
                      axis: Axis.vertical,
                      child: MmmButtons.appBarCurvedProfile(
                        profileDetails.name,
                        context,
                        this.profileDetails.images.isEmpty
                            ? "https://i.pravatar.cc/300"
                            : this.profileDetails.images[selectedImagePos],
                        profileDetails.id,
                        profileDetails.proposalStatus,
                        profileDetails,
                      ),
                    ),
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
                        if (profileDetails.familyType !=
                            FamilyType.Notmentioned) ...[
                          buildFamilyButton(),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                        buildReligion(),
                        SizedBox(
                          height: 16,
                        ),
                        buildCarrer(),
                        SizedBox(
                          height: 16,
                        ),
                        buildHabits(context),
                        SizedBox(
                          height: 16,
                        ),
                        if (profileDetails.hobbies.isNotNullEmpty) ...[
                          buildHobbies(context),
                          SizedBox(
                            height: 16,
                          )
                        ],
                        if (profileDetails.lifeStyle.isNotNullEmpty) ...[
                          buildLifeStyle(context),
                          SizedBox(
                            height: 16,
                          )
                        ],
                        BlocProvider<MatchingPercentageBloc>(
                          create: (context) => MatchingPercentageBloc(
                              UserRepository(), profileDetails),
                          child: MmmButtons.checkMatchButtonModified(
                              54, 'Check Match Percentage', action: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => MatchingPercentageBloc(
                                      UserRepository(), profileDetails),
                                  child: MatchingPercentageScreen(
                                    userRepository: UserRepository(),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        !profileDetails.isBlocked
                            ? InkWell(
                                onTap: () {
                                  context
                                      .read<ProfileViewBloc>()
                                      .add(BlockProfile());
                                },
                                child: Text(
                                  'Block Profile',
                                  style: MmmTextStyles.bodyRegular(
                                      textColor: kPrimary),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  context
                                      .read<ProfileViewBloc>()
                                      .add(UnBlockProfile());
                                },
                                child: Text(
                                  'Unblock Profile',
                                  style: MmmTextStyles.bodyRegular(
                                      textColor: kPrimary),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
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
                    // profileDetails.employedin,
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
            ? MmmButtons.profileViewButtons(
                "images/religion.svg",
                'Religion',
                action: () {
                  showReligionData();
                },
              )
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
        MmmButtons.profileViewButtons("images/occasionally.svg", 'Interests'),
        interestState == 0
            ? MmmButtons.profileViewButtons(
                "images/occasionally.svg",
                'Interests',
                action: () {
                  showInterestData();
                },
              )
            : SizeTransition(
                sizeFactor: _interestAnimation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: MmmButtons.interestsProfileViewButtons(
                  context,
                  profileDetails.eatingHabit,
                  profileDetails.drinkingHabit,
                  profileDetails.smokingHabit,
                  action: () {
                    showInterestData();
                  },
                ),
              ),
      ],
    );
  }

  Stack buildHobbies(BuildContext context) {
    return Stack(
      children: [
        MmmButtons.profileViewButtons("images/occasionally.svg", 'Hobbies'),
        hobbyState == 0
            ? MmmButtons.profileViewButtons(
                "images/occasionally.svg",
                'Hobbies',
                action: () {
                  showHobbiesData();
                },
              )
            : SizeTransition(
                sizeFactor: _hobbyAnimation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: MmmButtons.hoobiesProfileViewButtons(
                  context,
                  profileDetails.hobbies,
                  action: () {
                    showHobbiesData();
                  },
                ),
              ),
      ],
    );
  }

  Stack buildLifeStyle(BuildContext context) {
    return Stack(
      children: [
        MmmButtons.profileViewButtons("images/lifestyle.svg", 'LifeStyle'),
        lifestyleState == 0
            ? MmmButtons.profileViewButtons(
                "images/lifestyle.svg",
                'LifeStyle',
                action: () {
                  showLifestyleData();
                },
              )
            : SizeTransition(
                sizeFactor: _lifestyleAnimation,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: MmmButtons.lifestyleProfileViewButtons(
                  context,
                  profileDetails.lifeStyle,
                  action: () {
                    showLifestyleData();
                  },
                ),
              ),
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
                  profileDetails.aboutmeMsg,
                  profileDetails.maritalStatus,
                  profileDetails.abilityStatus,
                  action: () {
                    showAboutData();
                  },
                ),
              ),
      ],
    );
  }

  Container buildImages(BuildContext context) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(23.3813)),
            child: Image.network(
                profileDetails.images.isEmpty
                    ? "https://i.pravatar.cc/300"
                    : profileDetails.images[selectedImagePos],
                // height: 453.01,
                height: MediaQuery.of(context).size.height * 0.665,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, obj, str) =>
                    Container(color: Colors.grey, child: Icon(Icons.error))),
          ),
          Positioned(
            left: 24,
            top: 56,
            child: Container(
              width: 44,
              height: 44,
              margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
              decoration: BoxDecoration(
                  color: kLight2.withOpacity(0.60),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    MmmShadow.elevationbBackButton(
                        shadowColor: kShadowColorForWhite)
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      //if (context != null) {
                      Navigator.of(context).pop();
                      // }
                    },
                    child: Container(
                        height: 32,
                        width: 24,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'images/arrowLeft.svg',
                          height: 17.45,
                          color: gray3,
                        )),
                  ),
                ),
              ),
            ),
          ),

          if (profileDetails.proposalStatus == ProposalStatus.Accepted) ...[
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ConnectWidget(
                    isDialOpen: isDialOpen,
                    profileDetails: profileDetails,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  MmmIcons.meet(
                    context,
                    action: () {
                      navigateToSelectMeet();
                    },
                  ),
                ],
              ),
            ),
          ] else if (profileDetails.proposalStatus == ProposalStatus.Reverted ||
              profileDetails.proposalStatus == ProposalStatus.Rejected ||
              profileDetails.proposalStatus == null) ...[
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 0,
              child: MmmIcons.largeHeart(
                action: () {
                  BlocProvider.of<ProfileViewBloc>(context)
                      .add(SendLikeRequest());
                },
              ),
            ),
          ] else if (profileDetails.proposalStatus == ProposalStatus.Sent) ...[
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 0,
              child: Row(
                children: [
                  MmmIcons.largeCancel(
                    action: () {
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(CancelLikeRequest());
                    },
                  ),
                  SizedBox(width: 6),
                  MmmIcons.largeChat(
                    context,
                    profileDetails.id,
                    () async {
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(MakeConnectRequest());
                    },
                  ),
                ],
              ),
            ),
          ] else if (profileDetails.proposalStatus ==
              ProposalStatus.Received) ...[
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 0,
              child: Row(
                children: [
                  MmmIcons.largeReject(
                    action: () {
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(RejectLikeRequest());
                    },
                  ),
                  SizedBox(width: 6),
                  MmmIcons.largeAccept(
                    action: () {
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(AcceptLikeRequest());
                    },
                  ),
                ],
              ),
            ),
          ],
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right: MediaQuery.of(context).size.width * 0.05,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: 112,

                child: Wrap(
                  direction: Axis.vertical,
                  textDirection: TextDirection.rtl,
                  children: createImageThumbNails(),
                )),
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

  void showHobbiesData() {
    setState(() {
      if (hobbyState == 0) {
        hobbyState = 1;
        _hobbyController..forward();
      } else if (hobbyState == 1 && _hobbyController.isCompleted) {
        _hobbyController..reverse();
        hobbyState = 2;
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
      list.add(
        MmmButtons.smallprofilePicButton(
          image,
          () {
            setState(() {
              this.selectedImagePos = profileDetails.images.indexOf(image);
            });
          },
        ),
      );
    }
    return list;
  }

  String getProfileManagedBy() {
    switch (profileDetails.relationship) {
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
                StreamBuilder<bool>(
                  stream: getIt<ChatRepo>().getOnlineStatus(profileDetails.id),
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
                              color: snapshot.data == null
                                  ? kGray
                                  : snapshot.data!
                                      ? kGreen
                                      : kError),
                        ),
                        // ),
                        Expanded(child: SizedBox())
                      ],
                    );
                  },
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
              '${AppHelper.getAgeFromDob(profileDetails.dateOfBirth)} yrs, ${AppHelper.getReadableDob(profileDetails.dateOfBirth)}'),
          MmmWidgets.rowWidget("images/office.svg", profileDetails.occupation),
          MmmWidgets.rowWidget("images/height.svg",
              AppHelper.heightString(profileDetails.height) + 'inches'),
        ],
      ),
    );
  }

  void navigateToSelectMeet() async {
    var result = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        context: context,
        builder: (context) => MmmWidgets.selectMeetWidget(context));
  }
}

class ConnectWidget extends StatelessWidget {
  const ConnectWidget({
    Key? key,
    required this.isDialOpen,
    required this.profileDetails,
    this.direction = SpeedDialDirection.up,
  }) : super(key: key);

  final ValueNotifier<bool> isDialOpen;
  final dynamic profileDetails;
  final SpeedDialDirection direction;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      elevation: 0,
      overlayColor: Colors.transparent,
      overlayOpacity: 0.0,
      openCloseDial: isDialOpen,
      spaceBetweenChildren: 0,
      spacing: 0,
      buttonSize: Size(54.0, 54.0),
      childPadding: EdgeInsets.zero,
      childrenButtonSize: Size(54.0, 44.0),
      direction: direction,
      child: MmmIcons.largeConnect(
        action: () {
          isDialOpen.value = !isDialOpen.value;
        },
      ),
      children: [
        SpeedDialChild(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: MmmIcons.chat(context, profileDetails.id, () async {
            isDialOpen.value = !isDialOpen.value;
          }, profileDetails),
        ),
        SpeedDialChild(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: MmmIcons.call(
            () async {
              isDialOpen.value = !isDialOpen.value;
              context.navigate.push(
                MaterialPageRoute(
                  builder: (context) => AudioCallView(
                    uid: profileDetails.id,
                    imageUrl: (profileDetails is MatchingProfile)
                        ? profileDetails.imageUrl
                        : profileDetails.images.first,
                    userRepo: getIt<UserRepository>(),
                  ),
                ),
              );
            },
          ),
        ),
        SpeedDialChild(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: MmmIcons.video(() async {
            isDialOpen.value = !isDialOpen.value;
            context.navigate.push(
              MaterialPageRoute(
                builder: (context) => VideoCallView(
                  uid: profileDetails.id,
                  imageUrl: (profileDetails is MatchingProfile)
                      ? profileDetails.imageUrl
                      : profileDetails.images.first,
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
