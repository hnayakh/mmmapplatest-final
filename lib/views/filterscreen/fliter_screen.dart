import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/filterscreen/religion_preference_filter_sheet.dart';
import 'package:makemymarry/views/filterscreen/smoke_preference_filter_sheet.dart';

import 'cast_preference_filter_sheet.dart';
import 'disability_preference_filter_sheet.dart';
import 'drink_preference_bottom_sheet.dart';
import 'education_preference_bottom_sheet.dart';
import 'employeedIn_preference_filter_sheet.dart';
import 'fliterscreen bloc/filter_bloc.dart';
import 'fliterscreen bloc/filter_event.dart';
import 'fliterscreen bloc/filter_state.dart';
import 'food_preference_filter_sheet.dart';
import 'gothra_preference_filter_sheet.dart';
import 'height_status_filter_sheet.dart';
import 'interest_preference_filter_sheet.dart';
import 'manglik_preference_filter_sheet.dart';
import 'marital_status_filter_sheet.dart';
import 'mother_tongue_filter_sheet.dart';
import 'occupation_preference_filter_sheet.dart';
import 'profile_preference_filter_sheet.dart';

class Filter extends StatelessWidget {
  final UserRepository userRepository;

  const Filter({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc(userRepository),
      child: FilterScreen(),
    );
  }
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    listReligion = BlocProvider.of<FilterBloc>(context)
        .userRepository
        .masterData
        .listReligion;
    SimpleMasterData? religionData = SimpleMasterData();
    religionData.id = 'Doesnot Matter';
    religionData.title = 'Doesnot Matter';
    listReligion.insert(0, religionData);

    super.initState();
  }

  List<SimpleMasterData> listReligion = [];
  CastSubCast? listCast;
  final List<String> profileby = [
    'Doesnot Matter',
    'Self',
    'Son',
    'Daughter',
    'Brother',
    'Sister',
  ];
  final List<String> disabilityType = [
    'Doesnot Matter',
    'Normal',
    'Physically Challenged',
  ];
  RangeValues _currentRangeValues = const RangeValues(20, 50);
  late UserDetails userDetails;
  SimpleMasterData? religion;

  String? motherTongue;

  dynamic heightStatus;
  int? initCaste;
  MaritalStatusFilter? maritalStatus;
  ManglikFilter? manglikStatus;
  EatingHabitFilter? foodStatus;
  DrinkingHabitFilter? drinkStatus;
  SmokingHabitFilter? smokeStatus;
  InterestFilter? interestStatus;
  EmployeedInFilter? employeedInStatus;
  String? occupation;
  //Education? education;
  String? education;
  String maritalStatusHintText = '';

  int? profilePreference;

  int? disabilityPreference;
  dynamic gothra;

  String? caste;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurvedFilter('Career'),
      body: BlocConsumer<FilterBloc, FilterState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData();
          return SingleChildScrollView(
            child: Container(
              padding: kMargin16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Age Preference',
                    style: MmmTextStyles.bodyMediumSmall(textColor: kDark5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 141,
                    padding: kMargin16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(width: 1, color: kLight4)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected age is in between ${_currentRangeValues.start.round()} and ${_currentRangeValues.end.round()}',
                          style: MmmTextStyles.bodyRegular(textColor: kDark5),
                        ),
                        RangeSlider(
                          values: _currentRangeValues,
                          min: 20,
                          max: 50,
                          //divisions: 30,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Profile Preference',
                    style: MmmTextStyles.bodyMediumSmall(textColor: kDark5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.profilePreference != null
                          ? profileby[profilePreference!]
                          : 'Profile created for', action: () {
                    showProfilePreferenceBottomSheet();
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Personal Preference',
                    style: MmmTextStyles.bodyMediumSmall(textColor: kDark5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.heightStatus != null && this.heightStatus != 0
                          ? '${AppHelper.getHeightsFilter()[heightStatus!].toStringAsFixed(1)} ft'
                          : this.heightStatus != null && this.heightStatus == 0
                              ? '${AppHelper.getHeightsFilter()[heightStatus!]}'
                              : 'Height', action: () {
                    showHeightStatusBottomSheet();
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.maritalStatus != null
                          ? describeEnum(maritalStatus!)
                          : 'Maritial Status', action: () {
                    showMaritalStatusBottomSheet();
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.disabilityPreference != null
                          ? disabilityType[disabilityPreference!]
                          : 'Disability', action: () {
                    showDisabilityBottomSheet();
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Religion Preference',
                    style: MmmTextStyles.bodyMediumSmall(textColor: kDark5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.religion != null ? religion!.title : 'Religion',
                      action: () {
                    selectReligion(context);
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  BlocProvider.of<FilterBloc>(context).checkCaste()
                      ? MmmButtons.filterButtons(
                          this.caste != null ? caste.toString() : 'Caste',
                          action: () {
                          if (this.religion != null) {
                            selectCast(context);
                          }
                        })
                      : Container(),
                  SizedBox(
                    height: 4,
                  ),
                  //MmmButtons.filterButtons('Sub-Cast', action: () {}),
                  //SizedBox(
                  //   height: 4,
                  // ),
                  MmmButtons.filterButtons(
                      this.motherTongue != null
                          ? motherTongue.toString()
                          : 'Mother Tongue', action: () {
                    selectMotherToungue(context);
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  this.religion != null &&
                          this.religion!.title.toLowerCase() == 'hindu'
                      ? Column(
                          children: [
                            MmmButtons.filterButtons(
                                this.gothra != null ? gothra : 'Gothra',
                                action: () {
                              selectGothra(context);
                            }),
                            SizedBox(
                              height: 4,
                            ),
                            MmmButtons.filterButtons(
                                this.manglikStatus != null
                                    ? describeEnum(manglikStatus!)
                                    : 'Manglik', action: () {
                              showManglikStatusBottomSheet();
                            }),
                          ],
                        )
                      : Container(),

                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Career Preference',
                    style: MmmTextStyles.bodyMediumSmall(textColor: kDark5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.employeedInStatus != null
                          ? describeEnum(employeedInStatus!)
                          : 'Employeed In', action: () {
                    showEmployeedInBottomSheet();
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.occupation != null
                          ? occupation.toString()
                          : 'Occupation', action: () {
                    selectOccupation();
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.education != null
                          ? education.toString()
                          : 'Highest Education', action: () {
                    selectEducation(context);
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons('Annual Income', action: () {}),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'LifeStyle Preference',
                    style: MmmTextStyles.bodyMediumSmall(textColor: kDark5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.foodStatus != null
                          ? describeEnum(foodStatus!)
                          : 'Food', action: () {
                    showFoodStatusBottomSheet();
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.smokeStatus != null
                          ? describeEnum(smokeStatus!)
                          : 'Smoke', action: () {
                    showSmokeStatusBottomSheet();
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.drinkStatus != null
                          ? describeEnum(drinkStatus!)
                          : 'Drink', action: () {
                    showDrinkStatusBottomSheet();
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  MmmButtons.filterButtons(
                      this.interestStatus != null
                          ? describeEnum(interestStatus!)
                          : 'Interests', action: () {
                    showInterestStatusBottomSheet();
                  }),
                  SizedBox(
                    height: 60,
                  ),
                  MmmButtons.enabledRedButtonbodyMedium(50, 'Apply Filter')
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showHeightStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => HeightStatusFilterSheet(
              selectedHeightStatus: heightStatus,
            ));

    if (result != null) {
      BlocProvider.of<FilterBloc>(context).add(OnHeightFilterSelected(result));
    }
  }

  void showProfilePreferenceBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => ProfilePreferenceFilterSheet(
              selectedProfilePreference: profilePreference,
            ));

    if (result != null && result is int) {
      BlocProvider.of<FilterBloc>(context).add(OnProfileFilterSelected(result));
    }
  }

  void showMaritalStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => MaritalStatusFilterSheet(
              selectedMaritalStatus: maritalStatus,
            ));

    if (result != null && result is MaritalStatusFilter) {
      this.maritalStatusHintText = describeEnum(result);
      BlocProvider.of<FilterBloc>(context).add(OnMaritalFilterSelected(result));
    }
  }

  void showManglikStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => ManglikStatusFilterSheet(
              selected: manglikStatus,
            ));

    if (result != null && result is ManglikFilter) {
      this.maritalStatusHintText = describeEnum(result);
      BlocProvider.of<FilterBloc>(context).add(OnManglikFilterSelected(result));
    }
  }

  void showEmployeedInBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => EmployeedInFilterSheet(
              selected: employeedInStatus,
            ));

    if (result != null && result is EmployeedInFilter) {
      this.maritalStatusHintText = describeEnum(result);
      BlocProvider.of<FilterBloc>(context)
          .add(OnEmployeedInFilterSelected(result));
    }
  }

  void showFoodStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => FoodStatusFilterSheet(
              selectedFoodStatus: foodStatus,
            ));

    if (result != null && result is EatingHabitFilter) {
      BlocProvider.of<FilterBloc>(context).add(OnFoodFilterSelected(result));
    }
  }

  void showDrinkStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => DrinkStatusFilterSheet(
              selectedDrinkStatus: drinkStatus,
            ));

    if (result != null && result is DrinkingHabitFilter) {
      BlocProvider.of<FilterBloc>(context).add(OnDrinkFilterSelected(result));
    }
  }

  void showSmokeStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => SmokeStatusFilterSheet(
              selectedSmokeStatus: smokeStatus,
            ));

    if (result != null && result is SmokingHabitFilter) {
      BlocProvider.of<FilterBloc>(context).add(OnSmokeFilterSelected(result));
    }
  }

  void showInterestStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => SmokeInterestFilterSheet(
              selectedInterestStatus: interestStatus,
            ));

    if (result != null && result is InterestFilter) {
      BlocProvider.of<FilterBloc>(context)
          .add(OnInterestFilterSelected(result));
    }
  }

  void showDisabilityBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => DisabilityPreferenceFilterSheet(
              selectedDisabilityPreference: disabilityPreference,
            ));

    if (result != null && result is int) {
      BlocProvider.of<FilterBloc>(context)
          .add(OnDisabilityFilterSelected(result));
    }
  }

  void selectReligion(BuildContext context) async {
    //  var list = BlocProvider.of<FilterBloc>(context)
    //   .userRepository
    //       .masterData
    //   .listReligion;
//  SimpleMasterData? castData = SimpleMasterData();
//  castData.id = 'Doesnot Matter';
//  castData.title = 'Doesnot Matter';
//   list.insert(0, castData);
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => ReligonFilterBottomSheet(
              list: listReligion,
              selected: religion,
            ));
    if (result != null && result is SimpleMasterData) {
      BlocProvider.of<FilterBloc>(context)
          .add(OnReligionFilterSelected(result));
      this.initCaste = 0;
    }
  }

  void selectCast(BuildContext context) async {
    listCast = BlocProvider.of<FilterBloc>(context)
        .userRepository
        .masterData
        .listCastSubCast
        .firstWhere((element) =>
            element.cast.toLowerCase() == this.religion!.title.toLowerCase());
    //CastSubCast? castData = CastSubCast();

    String castData = 'Doesnot Matter';
    listCast!.subCasts.insert(0, castData);

    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => CastFilterBottomSheet(
              list: listCast!.subCasts.cast<String>(),
              selected: caste,
            ));

    if (result != null && result is String) {
      BlocProvider.of<FilterBloc>(context).add(OnCastFilterSelected(result));
    }
    listCast!.subCasts.removeAt(0);
  }

  void selectMotherToungue(BuildContext context) async {
    var list = BlocProvider.of<FilterBloc>(context)
        .userRepository
        .masterData
        .listMotherTongue;
    List<String> mT = [];
    for (int i = 0; i < list.length; i++) {
      mT.add(list[i].title);
    }
    mT.insert(0, 'Doesnot Matter');

    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => MotherTongueFilterBottomSheet(
              list: mT,
              selected: motherTongue,
            ));
    if (result != null && result is String) {
      BlocProvider.of<FilterBloc>(context)
          .add(OnMotherTongueFilterSelected(result));
    }

    mT.remove(0);
  }

  void selectGothra(BuildContext context) async {
    var list = BlocProvider.of<FilterBloc>(context)
        .userRepository
        .masterData
        .listGothra;
    dynamic gothraData = 'Doesnot Matter';
    list.insert(0, gothraData);
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => GothraFilterBottomSheet(
              list: list,
              selected: this.gothra,
            ));
    if (result != null) {
      BlocProvider.of<FilterBloc>(context).add(OnGothraFilterSelected(result));
    }
    list.removeAt(0);
  }

  void selectOccupation() async {
    var list = BlocProvider.of<FilterBloc>(context)
        .userRepository
        .masterData
        .listOccupation;

    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => OccupationFilterBottomSheet(
              list: list,
              selected: this.occupation,
            ));

    if (result != null && result is String) {
      BlocProvider.of<FilterBloc>(context)
          .add(OnOccupationFilterSelected(result));
    }
  }

  void selectEducation(BuildContext context) async {
    var list = BlocProvider.of<FilterBloc>(context)
        .userRepository
        .masterData
        .listEducation;
    List<String> edU = [];
    for (int i = 0; i < list.length; i++) {
      edU.add(list[i].title);
    }
    edU.insert(0, 'Doesnot Matter');
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => EducationFilterBottomSheet(
              list: edU,
              selected: this.education,
            ));
    if (result != null && result is String) {
      BlocProvider.of<FilterBloc>(context)
          .add(OnEducationFilterSelected(result));
    }
    edU.remove(0);
  }

  void initData() {
    // this.userDetails =
    //      BlocProvider.of<FilterBloc>(context).userRepository.useDetails!;

    this.maritalStatus = BlocProvider.of<FilterBloc>(context).maritalStatus;
    this.heightStatus = BlocProvider.of<FilterBloc>(context).heightStatus;
    this.profilePreference = BlocProvider.of<FilterBloc>(context).profileby;
    this.disabilityPreference =
        BlocProvider.of<FilterBloc>(context).disabilityType;
    this.religion = BlocProvider.of<FilterBloc>(context).religion;
    this.caste = BlocProvider.of<FilterBloc>(context).caste;
    this.motherTongue = BlocProvider.of<FilterBloc>(context).motherTongue;
    this.gothra = BlocProvider.of<FilterBloc>(context).gothra;
    this.manglikStatus = BlocProvider.of<FilterBloc>(context).isManglik;
    this.employeedInStatus = BlocProvider.of<FilterBloc>(context).employeedIn;
    this.occupation = BlocProvider.of<FilterBloc>(context).occupation;
    this.education = BlocProvider.of<FilterBloc>(context).education;
    this.foodStatus = BlocProvider.of<FilterBloc>(context).foodStatus;
    this.drinkStatus = BlocProvider.of<FilterBloc>(context).drinkingStatus;
    this.smokeStatus = BlocProvider.of<FilterBloc>(context).smokeStatus;
    this.interestStatus = BlocProvider.of<FilterBloc>(context).interestStatus;
  }
}
