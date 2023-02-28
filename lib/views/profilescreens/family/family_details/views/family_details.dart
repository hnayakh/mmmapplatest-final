import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/views/profilescreens/about/bloc/about_bloc.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/bloc/family_details_bloc.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/bloc/family_details_events.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/bloc/family_details_state.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/views/mother_occupation.dart';
import 'package:makemymarry/views/profilescreens/habbit/habits.dart';
import 'package:makemymarry/views/profilescreens/occupation/bloc/occupation_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile.dart';

import '../../../bio/views/bio.dart';
import 'father_occupation.dart';

class FamilyDetails extends StatelessWidget {
  final UserRepository userRepository;
  final Function onComplete;

  const FamilyDetails({
    Key? key,
    required this.userRepository,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FamilyDetailsScreen(
          onComplete: onComplete, userRepository: userRepository);
  }
}

class FamilyDetailsScreen extends StatefulWidget {
  final Function onComplete;
  final UserRepository userRepository;

  const FamilyDetailsScreen(
      {Key? key, required this.onComplete, required this.userRepository})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FamilyDetailsScreenState();
  }
}

class FamilyDetailsScreenState extends State<FamilyDetailsScreen> {
  int brothers = 0;
  int marriedBrothers = 0;
  int sisters = 0;
  int marriedSisters = 0;
  FatherOccupation? fatherOccupation;
  MotherOccupation? motherOccupation;
  late UserDetails userDetails;

  late int noOfBrothers, noOfSister, brotherMarried, sistersMarried;
  String fatherOcctext = 'Select father’s occupation';

  String motherOcctext = 'Select mother’s occupation';

  @override
  Widget build(BuildContext context) {
    this.userDetails =
        BlocProvider.of<FamilyDetailsBloc>(context).userRepository.useDetails!;

    if (this.userDetails.registrationStep > 6) {
      BlocProvider.of<FamilyDetailsBloc>(context)
          .add(onFamilyDetailDataLoad(userDetails.id));
    }
    return BlocConsumer<FamilyDetailsBloc, FamilyDetailState>(
        builder: (context, state) {
      initData();
      return Container(
          child: Stack(
        children: [
          buildUi(context),
          Positioned(
              bottom: 24,
              right: 24,
              child: this.userDetails.registrationStep > 6
                  ? InkWell(
                      onTap: () {
                        BlocProvider.of<FamilyDetailsBloc>(context).add(
                            UpdateFamilyDetails(
                                this.fatherOccupation,
                                this.motherOccupation,
                                this.noOfBrothers,
                                this.noOfSister,
                                this.brotherMarried,
                                this.sistersMarried,
                                this.userDetails.registrationStep > 6));
                      },
                      child: MmmIcons.saveIcon(),
                    )
                  : InkWell(
                      onTap: () {
                        BlocProvider.of<FamilyDetailsBloc>(context).add(
                            UpdateFamilyDetails(
                                this.fatherOccupation,
                                this.motherOccupation,
                                this.noOfBrothers,
                                this.noOfSister,
                                this.brotherMarried,
                                this.sistersMarried,
                                this.userDetails.registrationStep > 6));
                      },
                      child: MmmIcons.rightArrowEnabled(),
                    )),
          this.userDetails.registrationStep > 5
              ? SizedBox()
              : Positioned(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) =>
                                Habit(userRepository: widget.userRepository),
                          ),
                        );
                      },
                      // child: MmmIcons.rightArrowEnabled(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '(This section is optional)',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text('Skip >',
                                style:
                                    TextStyle(color: kPrimary, fontSize: 15)),
                          ],
                        ),
                      ))),
          state is OnLoading ? MmmWidgets.buildLoader(context) : Container(),
        ],
      ));
    }, listener: (context, state) {
      if (state is OnError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
          backgroundColor: kError,
        ));
      }
      if (state is OnFamilyDetailsUpdated) {
        widget.onComplete();
      }
      if (state is OnNavigationToMyProfiles) {
        navigateToMyProfile();
        // navigateToHabits();
      }
    });
  }

  Widget buildUi(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: kMargin16,
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            MmmButtons.categoryButtonsNotRequired(
                "Father's Occupation",
                fatherOccupation != null
                    ? AppHelper.getStringFromEnum(fatherOccupation!)
                    : fatherOcctext,
                fatherOcctext,
                "images/rightArrow.svg", action: () {
              showFatherOccupationStatusSheet();
            }),
            SizedBox(
              height: 24,
            ),
            MmmButtons.categoryButtonsNotRequired(
                "Mother's Occpation",
                motherOccupation != null
                    ? AppHelper.getStringFromEnum(motherOccupation!)
                    : motherOcctext,
                motherOcctext,
                "images/rightArrow.svg", action: () {
              showMotherOccupationStatusSheet();
            }),
            SizedBox(
              height: 24,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(border: Border.all(width: 1, color: kLight4)),
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Brother’s details of groom’s',
                      style: MmmTextStyles.bodyMedium(textColor: kDark5),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Text(
                          'No of Brother’s',
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.bodySmall(textColor: kDark5),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '',
                          style: MmmTextStyles.bodySmall(textColor: kredStar),
                        )
                      ],
                    )),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Text(
                          'Married',
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.bodySmall(textColor: kDark5),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '',
                          style: MmmTextStyles.bodySmall(textColor: kredStar),
                        )
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      height: 44,
                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      decoration: BoxDecoration(
                          color: kLight4,
                          border: Border.all(color: kBioSecondary, width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<FamilyDetailsBloc>(context)
                                    .add(ChangeNoOfBrothers(-1));
                              },
                              child: SvgPicture.asset(
                                'images/minus.svg',
                                height: 24,
                                width: 24,
                                color: kDark2,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "$noOfBrothers",
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style:
                                  MmmTextStyles.bodyRegular(textColor: kDark5),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<FamilyDetailsBloc>(context)
                                    .add(ChangeNoOfBrothers(1));
                              },
                              child: SvgPicture.asset(
                                'images/plus.svg',
                                height: 24,
                                width: 24,
                                color: kDark2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Container(
                      height: 44,
                      width: (MediaQuery.of(context).size.width / 2) - 48,
                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      decoration: BoxDecoration(
                          color: kLight4,
                          border: Border.all(color: kBioSecondary, width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<FamilyDetailsBloc>(context)
                                    .add(ChangeNoOfBrothersMarried(-1));
                              },
                              child: SvgPicture.asset(
                                'images/minus.svg',
                                height: 24,
                                width: 24,
                                color: kDark2,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "$brotherMarried",
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style:
                                  MmmTextStyles.bodyRegular(textColor: kDark5),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<FamilyDetailsBloc>(context)
                                    .add(ChangeNoOfBrothersMarried(1));
                              },
                              child: SvgPicture.asset(
                                'images/plus.svg',
                                height: 24,
                                width: 24,
                                color: kDark2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: 360,
              decoration:
                  BoxDecoration(border: Border.all(width: 1, color: kLight4)),
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sister’s details of groom’s',
                      style: MmmTextStyles.bodyMedium(textColor: kDark5),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'No of Sister’s',
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.bodySmall(textColor: kDark5),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '',
                          style: MmmTextStyles.bodySmall(textColor: kredStar),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Row(
                      children: [
                        Text(
                          'Married',
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.bodySmall(textColor: kDark5),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '',
                          style: MmmTextStyles.bodySmall(textColor: kredStar),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      height: 44,
                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      decoration: BoxDecoration(
                          color: kLight4,
                          border: Border.all(color: kBioSecondary, width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<FamilyDetailsBloc>(context)
                                    .add(ChangeNoOfSisters(-1));
                              },
                              child: SvgPicture.asset(
                                'images/minus.svg',
                                height: 24,
                                width: 24,
                                color: kDark2,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "$noOfSister",
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style:
                                  MmmTextStyles.bodyRegular(textColor: kDark5),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<FamilyDetailsBloc>(context)
                                    .add(ChangeNoOfSisters(1));
                              },
                              child: SvgPicture.asset(
                                'images/plus.svg',
                                height: 24,
                                width: 24,
                                color: kDark2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Container(
                      height: 44,
                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      decoration: BoxDecoration(
                          color: kLight4,
                          border: Border.all(color: kBioSecondary, width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<FamilyDetailsBloc>(context)
                                    .add(ChangeNoOfSistersMarried(-1));
                              },
                              child: SvgPicture.asset(
                                'images/minus.svg',
                                height: 24,
                                width: 24,
                                color: kDark2,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "$sistersMarried",
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style:
                                  MmmTextStyles.bodyRegular(textColor: kDark5),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<FamilyDetailsBloc>(context)
                                    .add(ChangeNoOfSistersMarried(1));
                              },
                              child: SvgPicture.asset(
                                'images/plus.svg',
                                height: 24,
                                width: 24,
                                color: kDark2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }

  void showFatherOccupationStatusSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => FatherOccupationBottomSheet(
              occupation: fatherOccupation,
            ));
    if (result != null && result is FatherOccupation) {
      BlocProvider.of<FamilyDetailsBloc>(context)
          .add(OnFathersOccupationSelected(result));
    }
  }

  void showMotherOccupationStatusSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => MotherOccupationBottomSheet(
              occupation: motherOccupation,
            ));
    if (result != null && result is MotherOccupation) {
      BlocProvider.of<FamilyDetailsBloc>(context)
          .add(OnMothersOccupationSelected(result));
    }
  }

  void initData() {
    this.fatherOccupation =
        BlocProvider.of<FamilyDetailsBloc>(context).fatherOccupation;
    this.motherOccupation =
        BlocProvider.of<FamilyDetailsBloc>(context).motherOccupation;
    this.noOfBrothers =
        BlocProvider.of<FamilyDetailsBloc>(context).noOfBrothers;
    this.noOfSister = BlocProvider.of<FamilyDetailsBloc>(context).noOfSister;
    this.brotherMarried =
        BlocProvider.of<FamilyDetailsBloc>(context).brotherMarried;
    this.sistersMarried =
        BlocProvider.of<FamilyDetailsBloc>(context).sistersMarried;

    if (BlocProvider.of<FamilyDetailsBloc>(context).profileDetails != null) {
      if (this.fatherOccupation == null)
        this.fatherOccupation = BlocProvider.of<FamilyDetailsBloc>(context)
            .profileDetails!
            .fatherOccupation;

      if (this.motherOccupation == null)
        this.motherOccupation = BlocProvider.of<FamilyDetailsBloc>(context)
            .profileDetails!
            .motherOccupation;

      if (this.noOfBrothers == 0)
        this.noOfBrothers = BlocProvider.of<FamilyDetailsBloc>(context)
            .profileDetails!
            .noOfBrother;

      if (this.noOfSister == 0)
        this.noOfSister = BlocProvider.of<FamilyDetailsBloc>(context)
            .profileDetails!
            .noOfSister;
      if (this.brotherMarried == 0)
        this.brotherMarried = BlocProvider.of<FamilyDetailsBloc>(context)
            .profileDetails!
            .brothersMarried;
      if (this.sistersMarried == 0)
        this.sistersMarried = BlocProvider.of<FamilyDetailsBloc>(context)
            .profileDetails!
            .sistersMarried;
    }
  }

  void navigateToMyProfile() {
    var userRepo = BlocProvider.of<FamilyDetailsBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => AboutBloc(userRepo),
              ),
              BlocProvider(
                create: (context) => OccupationBloc(userRepo),
              ),
              BlocProvider(
                create: (context) => AccountMenuBloc(userRepo),
              ),
            ], child: MyProfileScreen())));
  }
}
