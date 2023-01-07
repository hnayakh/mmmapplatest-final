import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profile_loader/profile_loader.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/bloc/family_details_bloc.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/bloc/family_details_events.dart';
import 'package:makemymarry/views/profilescreens/occupation/views/education_bottom_sheet.dart';
import 'package:makemymarry/views/profilescreens/occupation/views/occupation_bottom_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/annual_income_preference.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/annual_max_income_preference.dart';

import 'package:makemymarry/views/profilescreens/profile_preference/city_preference_bottom_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/country_preference_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/drinking_habit.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/education_preference_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/marital_status_preference.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/mother_tongue_preference_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/occupation_preference_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference_bloc.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference_events.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference_state.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/religion_preference_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/state_preference_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/subcast_preference_sheet.dart';
import 'package:makemymarry/views/profilescreens/religion/views/mother_tongue_bottom_sheet.dart';

import 'eating_prefs.dart';
import 'smoking_prefs.dart';

class ProfilePreference extends StatelessWidget {
  final UserRepository userRepository;

  const ProfilePreference({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePreferenceBloc(userRepository),
      child: ProfilePreferenceScreen(),
    );
  }
}

class ProfilePreferenceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePreferenceScreenState();
  }
}

class ProfilePreferenceScreenState extends State<ProfilePreferenceScreen> {
  late double minAge, maxAge, minSliderAge;
  late double minHeight, maxHeight;
  late List<MaritalStatus> maritalStatus;
  late CountryModel countryModel;
  late List<StateModel?> myState, city;
  late List<SimpleMasterData> religion;
  late List<dynamic> subCaste;
  late List<SimpleMasterData> motherTongue;
  late List<String?> occupation;
  late List<Education> education;
  late List<AnualIncome> annualIncome;
  late List<AnualIncome> annualIncomeMax;
  int minimumSelectedIndex = 0;
  String titleRedOcc = '';
  TextEditingController annIncomeController = TextEditingController();
  late List<EatingHabit> eatingHabit;
  late List<SmokingHabit> smokingHabit;
  late List<DrinkingHabit> drinkingHabit;
  late AbilityStatus abilityStatus;
  late Gender gender;
  late UserDetails userData;
  List<String> incomes = [
    'No Income',
    '1 lakh',
    '2 lakh',
    '3 lakh',
    '4 lakh',
    '5 lakh',
    '7.5 lakh',
    '10 lakh',
    '15 lakh',
    '20 lakh',
    '25 lakh',
    '35 lakh',
    '50 lakh',
    '75 lakh',
    '1 crore',
    '1 crore and above'
  ];
  String currentIncomes = "";
  String currentMaxIncomes = "";

  void initData(BuildContext context) {
    this.userData = BlocProvider.of<ProfilePreferenceBloc>(context)
        .userRepository
        .useDetails!;
    this.gender = BlocProvider.of<ProfilePreferenceBloc>(context).gender;
    this.minAge = BlocProvider.of<ProfilePreferenceBloc>(context).minAge;
    this.minSliderAge =
        BlocProvider.of<ProfilePreferenceBloc>(context).minSliderAge;
    this.maxAge = BlocProvider.of<ProfilePreferenceBloc>(context).maxAge;
    this.minHeight = BlocProvider.of<ProfilePreferenceBloc>(context).minHeight;
    this.maxHeight = BlocProvider.of<ProfilePreferenceBloc>(context).maxHeight;
    this.maritalStatus =
        BlocProvider.of<ProfilePreferenceBloc>(context).maritalStatus;

    this.countryModel =
        BlocProvider.of<ProfilePreferenceBloc>(context).countryModel;
    this.myState = BlocProvider.of<ProfilePreferenceBloc>(context).myState;
    this.religion = BlocProvider.of<ProfilePreferenceBloc>(context).religion;
    this.subCaste = BlocProvider.of<ProfilePreferenceBloc>(context).subCaste;
    this.occupation =
        BlocProvider.of<ProfilePreferenceBloc>(context).occupation;
    this.education = BlocProvider.of<ProfilePreferenceBloc>(context).education;
    this.motherTongue =
        BlocProvider.of<ProfilePreferenceBloc>(context).motherTongue;
    this.city = BlocProvider.of<ProfilePreferenceBloc>(context).city;
    this.drinkingHabit =
        BlocProvider.of<ProfilePreferenceBloc>(context).drinkingHabit;
    this.eatingHabit =
        BlocProvider.of<ProfilePreferenceBloc>(context).eatingHabit;
    this.smokingHabit =
        BlocProvider.of<ProfilePreferenceBloc>(context).smokingHabit;
    this.annualIncome =
        BlocProvider.of<ProfilePreferenceBloc>(context).annualIncome;
    this.annualIncomeMax =
        BlocProvider.of<ProfilePreferenceBloc>(context).annualIncomeMax;
    this.abilityStatus =
        BlocProvider.of<ProfilePreferenceBloc>(context).abilityStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfilePreferenceBloc, ProfilePreferenceState>(
        builder: (context, state) {
          initData(context);
          return Stack(
            children: [
              Container(
                child: SafeArea(
                    child: Column(
                  children: [
                    MmmButtons.appBarCurved('Profile Preference',
                        context: context),
                    Expanded(
                        child: Container(
                      padding: kMargin16,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildAgePreference(),
                            SizedBox(
                              height: 24,
                            ),

                            // det height
                            buildHeight(),
                            SizedBox(
                              height: 24,
                            ),

                            // marital status
                            buildMaritalStatus(),
                            SizedBox(
                              height: 24,
                            ),

                            // set country
                            buildCountry(),
                            SizedBox(
                              height: 24,
                            ),
                            buildSelectedState(),
                            SizedBox(
                              height: 24,
                            ),
                            buildSelectCity(),
                            SizedBox(
                              height: 24,
                            ),
                            buildReligion(),
                            SizedBox(
                              height: 24,
                            ),
                            buildCaste(),
                            SizedBox(
                              height: 24,
                            ),
                            buildMotherTongue(),
                            SizedBox(
                              height: 24,
                            ),
                            buildOccupation(),
                            SizedBox(
                              height: 24,
                            ),
                            buildEducation(),
                            // SizedBox(
                            //   height: 24,
                            // ),
                            // buildAnnualIncome(),
                            // SizedBox(
                            //   height: 24,
                            // ),
                            // buildAnnualIncomeNew(),
                            SizedBox(
                              height: 24,
                            ),
                            buildAnnualIncomeNewDemo(),
                            SizedBox(
                              height: 24,
                            ),
                            buildDietryHabiits(),
                            SizedBox(
                              height: 24,
                            ),
                            buildDrinkingHabits(),
                            SizedBox(
                              height: 24,
                            ),
                            buildSmokingHabit(),
                            SizedBox(
                              height: 24,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                'Disability',
                                style: MmmTextStyles.bodyRegular(
                                    textColor: kDark5),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Transform.scale(
                                    scale: 1.1,
                                    child: Radio(
                                        activeColor: kPrimary,
                                        value: AbilityStatus.Normal,
                                        groupValue: abilityStatus,
                                        onChanged: (val) {
                                          BlocProvider.of<
                                                      ProfilePreferenceBloc>(
                                                  context)
                                              .add(AbilityStatusChanged(
                                                  AbilityStatus.Normal));
                                        }),
                                  ),
                                  //SizedBox(
                                  // width: 8,
                                  //  ),
                                  Text(
                                    'Normal',
                                    style:
                                        TextStyle(fontSize: 15, color: kDark5),
                                  ),

                                  Transform.scale(
                                    scale: 1.1,
                                    child: Radio(
                                        activeColor: kPrimary,
                                        value:
                                            AbilityStatus.PhysicallyChallenged,
                                        groupValue: abilityStatus,
                                        onChanged: (val) {
                                          BlocProvider.of<
                                                      ProfilePreferenceBloc>(
                                                  context)
                                              .add(AbilityStatusChanged(
                                                  AbilityStatus
                                                      .PhysicallyChallenged));
                                        }),
                                  ),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  Text(
                                    'Physically Challenged',
                                    style:
                                        TextStyle(fontSize: 15, color: kDark5),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                        // width: 22,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            MmmButtons.primaryButton("Complete", () {
                              BlocProvider.of<ProfilePreferenceBloc>(context)
                                  .add(CompletePreference());
                            }),
                          ],
                        ),
                      ),
                    ))
                  ],
                )),
              ),
              state is OnLoading
                  ? MmmWidgets.buildLoader(context)
                  : Container(),
              state is ProfilePreferenceComplete
                  ? MmmWidgets.profileCompletedWidget(userData, action: () {
                      navigateToFetchProfile();
                    })
                  : Container(),
            ],
          );
        },
        listener: (context, state) {
          if (state is OnGotCounties) {
            selectCountry(context, state.list);
          }
          if (state is OnGotStates) {
            selectState(context, state.list, "State");
          }
          if (state is OnGotCities) {
            selectCity(context, state.list, "City");
          }
          if (state is OnGotCasteList) {
            selectSubCast(state.caste);
          }
          // if (state is ProfilePreferenceComplete) {
          //   navigateToFetchProfile();
          // }
          if (state is OnError) {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: Text(state.message),
              backgroundColor: kError,
            ));
          }
        },
      ),
    );
  }

  Widget buildAgePreference() {
    var maxValue = maxAge > 0 ? maxAge : 0.0;
    //var progress = RangeValues(minAge, maxAge);
//maxValue>progress?progress:maxValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Age Preference',
          style: MmmTextStyles.bodyMediumSmall(textColor: kDark5),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          padding: kMargin24,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 1, color: kLight4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   ' ${minAge.round()} Yrs <---> ${maxAge.round()} Yrs',
              //   style: MmmTextStyles.bodyRegular(textColor: kDark5),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        color: kLight4, borderRadius: BorderRadius.circular(8)),
                    child: FittedBox(
                      child: Text(
                        '${minAge.round()}',
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        color: kLight4, borderRadius: BorderRadius.circular(8)),
                    child: FittedBox(
                      child: Text(
                        '${maxAge.round()}',
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
                      ),
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                    showValueIndicator: ShowValueIndicator.always,
                    valueIndicatorColor: kPrimary.withOpacity(0.7)),
                child: RangeSlider(
                  values: RangeValues(minAge, maxValue),
                  min: this.gender == Gender.Female ? 18 : 21,
                  max: 50,
                  inactiveColor: kGray,
                  activeColor: kPrimary,
                  // divisions: 30,
                  labels: RangeLabels(
                    minAge.round().toString(),
                    maxAge.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    print(values.end);
                    BlocProvider.of<ProfilePreferenceBloc>(context)
                        .add(OnAgeRangeChanged(values.start, values.end));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHeight() {
    var maxValue = maxHeight == 0 ? 7.0 : maxHeight;
    var minValue = minHeight == 0 ? 4.0 : minHeight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Height Preference',
          style: MmmTextStyles.bodyMediumSmall(textColor: kDark5),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          padding: kMargin24,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 1, color: kLight4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   ' ${minHeight.toStringAsFixed(1)}"" <---> ${maxHeight.toStringAsFixed(1)}""',
              //   style: MmmTextStyles.bodyRegular(textColor: kDark5),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        color: kLight4, borderRadius: BorderRadius.circular(8)),
                    child: FittedBox(
                      child: Text(
                        '${AppHelper.getFormtedHeight(minHeight)}',
                        //'${minHeight.toStringAsFixed(1)}',
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        color: kLight4, borderRadius: BorderRadius.circular(8)),
                    child: FittedBox(
                      child: Text(
                        '${AppHelper.getFormtedHeight(maxHeight)}',
                        // '${maxHeight.toStringAsFixed(1)}',
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
                      ),
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                    showValueIndicator: ShowValueIndicator.always,
                    valueIndicatorColor: kPrimary.withOpacity(0.7)),
                child: RangeSlider(
                  values: RangeValues(minValue, maxValue),
                  min: 4.0,
                  max: 7.2,
                  inactiveColor: kGray,
                  activeColor: kPrimary,
                  // divisions: 30,
                  labels: RangeLabels(
                    AppHelper.getFormtedHeight(minValue),
                    AppHelper.getFormtedHeight(maxValue),
                    // minValue.toString(),
                    // maxValue.toString(),
                  ),
                  onChanged: (RangeValues values) {
                    print(values.end);
                    BlocProvider.of<ProfilePreferenceBloc>(context)
                        .add(OnHeightRangeChanged(values.start, values.end));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMaritalStatus() {
    return MmmButtons.categoryButtonsNotRequired(
        'Marital Status',
        this.maritalStatus != []
            ? getStringFrom(this.maritalStatus)
            : 'Select your marital status',
        'Select your marital status',
        'images/rightArrow.svg', action: () {
      showMaritalStatusBottomSheet();
    });
  }

  void showMaritalStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) => MaritalStatusPreference(
              list: this.maritalStatus,
            ));
    if (result != null && result is List<MaritalStatus>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(OnMaritalStatusSelected(result));
    }
  }

  Widget buildCountry() {
    return MmmButtons.categoryButtonsNotRequired(
        'Country',
        this.countryModel.name.length != 0
            ? '${countryModel.name}'
            : 'Select Country',
        'Select Country',
        'images/rightArrow.svg', action: () {
      FocusScope.of(context).requestFocus(FocusNode());

      BlocProvider.of<ProfilePreferenceBloc>(context).add(GetAllCountries());
    });
  }

  void selectCountry(BuildContext context, List<CountryModel> list) async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SelectCountryPreferenceSheet(
              list: list,
              countryModel: this.countryModel,
            ));
    if (result != null && result is CountryModel) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(OnCountrySelected(result));
    }
  }

  Widget buildSelectedState() {
    return MmmButtons.categoryButtonsNotRequired(
        'State',
        myState.length > 0 ? getStateNames(this.myState) : 'Does not matter',
        'Select State',
        'images/rightArrow.svg',
        action: () {
          FocusScope.of(context).requestFocus(FocusNode());

          BlocProvider.of<ProfilePreferenceBloc>(context).add(GetAllStates());
        },
        showCancel: this.myState.length > 0,
        cancelAction: () {
          BlocProvider.of<ProfilePreferenceBloc>(context).add(RemoveState());
        });
  }

  void selectState(
      BuildContext context, List<StateModel> list, String title) async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SelectStatePreferenceSheet(
              list: list,
              stateModel: this.myState,
              title: '  ',
            ));
    if (result != null && result is List<StateModel?>) {
      if (title == "State")
        BlocProvider.of<ProfilePreferenceBloc>(context)
            .add(OnStateSelected(result));
      //else
      //   BlocProvider.of<ProfilePreferenceBloc>(context)
      //     .add(OnCitySelected(result));
    }
  }

  void selectCity(
      BuildContext context, List<List<StateModel>> list, String title) async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SelectCityPreferenceSheet(
              list: list,
              stateModel: this.city,
              title: '',
              states: this.myState,
            ));
    if (result != null && result is List<StateModel?>) {
      // if (title == "State")
      //    BlocProvider.of<ProfilePreferenceBloc>(context)
      //       .add(OnStateSelected(result));
      //else
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(OnCitySelected(result));
    }
  }

  Widget buildSelectCity() {
    return MmmButtons.categoryButtonsNotRequired(
        'City',
        this.city.length > 0 ? getStateNames(city) : 'Does not matter',
        'Select City',
        'images/rightArrow.svg',
        action: () {
          FocusScope.of(context).requestFocus(FocusNode());

          BlocProvider.of<ProfilePreferenceBloc>(context).add(GetMyCities());
        },
        showCancel: this.city.length > 0,
        cancelAction: () {
          BlocProvider.of<ProfilePreferenceBloc>(context).add(RemoveCity());
        });
  }

  Widget buildReligion() {
    return MmmButtons.categoryButtonsNotRequired(
        'Religion',
        this.religion.length > 0
            ? getReligionText(this.religion)
            : 'Does not Matter',
        'Select your religion',
        'images/rightArrow.svg',
        action: () {
          selectReligion(context);
        },
        showCancel: this.religion.length > 0,
        cancelAction: () {
          BlocProvider.of<ProfilePreferenceBloc>(context).add(RemoveReligion());
        });
  }

  void selectReligion(BuildContext context) async {
    var list = BlocProvider.of<ProfilePreferenceBloc>(context)
        .userRepository
        .masterData
        .listReligion;
    SimpleMasterData doesntMatter =
        SimpleMasterData("Doesnot Matter", "Doesnot Matter");
    doesntMatter.id = 'Doesnot Matter';
    doesntMatter.title = 'Doesnot Matter';
    list.insert(0, doesntMatter);
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => ReligionPreferenceSheet(
              list: list,
              religionModel: this.religion,
            ));
    list.removeAt(0);
    if (result != null && result is List<SimpleMasterData>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(OnReligionSelected(result));
    }
  }

  Widget buildCaste() {
    return //BlocProvider.of<ProfilePreferenceBloc>(context).checkCaste()?
        Container(
            child: MmmButtons.categoryButtonsNotRequired(
                'Caste',
                subCaste.length > 0
                    ? getSubCasteText(subCaste)
                    : 'Does not matter',
                'Select your caste',
                'images/rightArrow.svg',
                action: () {
                  BlocProvider.of<ProfilePreferenceBloc>(context)
                      .add(GetCasteList());
                },
                showCancel: subCaste.length > 0,
                cancelAction: () {
                  BlocProvider.of<ProfilePreferenceBloc>(context)
                      .add(RemoveCaste());
                }));
    // : Container();
  }

  void selectSubCast(List<CastSubCast> castList) async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SubCastPreferenceSheet(
              list: castList,
              selected: this.subCaste,
            ));
    if (result != null) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(OnSubCastSelected(result));
    }
  }

  Widget buildMotherTongue() {
    return MmmButtons.categoryButtonsNotRequired(
        'Mother Tongue',
        motherTongue.length > 0
            ? getReligionText(motherTongue)
            : 'Does not matter',
        'Select your mother tongue',
        'images/rightArrow.svg',
        action: () {
          selectMotherToungue(context);
        },
        showCancel: this.motherTongue.length > 0,
        cancelAction: () {
          BlocProvider.of<ProfilePreferenceBloc>(context)
              .add(RemoveMotherTongue());
        });
  }

  void selectMotherToungue(BuildContext context) async {
    var list = BlocProvider.of<ProfilePreferenceBloc>(context)
        .userRepository
        .masterData
        .listMotherTongue;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => MotherTonguePreferenceSheet(
              list: list,
              mtModel: this.motherTongue,
            ));
    if (result != null && result is List<SimpleMasterData>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(OnMotherTongueSelected(result));
    }
  }

  Widget buildOccupation() {
    return MmmButtons.categoryButtonsNotRequired(
        'Occupation',
        occupation.length > 0
            ? getOccupationText(occupation)
            : 'Does not matter',
        'Select your occupation',
        'images/rightArrow.svg',
        action: () {
          selectOccupation(context);
        },
        showCancel: occupation.length > 0,
        cancelAction: () {
          BlocProvider.of<ProfilePreferenceBloc>(context)
              .add(RemoveOccupation());
        });
  }

  Widget buildEducation() {
    return MmmButtons.categoryButtonsNotRequired(
        'Highest Education',
        education.length > 0 ? getEducationText(education) : 'Does not matter',
        'Select your highest education',
        'images/rightArrow.svg',
        action: () {
          selectEducation(context);
        },
        showCancel: education.length > 0,
        cancelAction: () {
          BlocProvider.of<ProfilePreferenceBloc>(context)
              .add(RemoveEducation());
        });
  }

  void selectOccupation(BuildContext context) async {
    var list = BlocProvider.of<ProfilePreferenceBloc>(context)
        .userRepository
        .masterData
        .listOccupation;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => OccupationPreferenceSheet(
              list: list,
              selected: this.occupation,
            ));

    if (result != null && result is List<String>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(OnOccupationSelected(result));
    }
  }

  void selectEducation(BuildContext context) async {
    var list = BlocProvider.of<ProfilePreferenceBloc>(context)
        .userRepository
        .masterData
        .listEducation;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => EducationPreferenceSheet(
              list: list,
              eduModel: this.education,
            ));
    if (result != null && result is List<Education>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(OnEducationSelected(result));
    }
  }

  String getStringFrom(List<dynamic> maritalStatus) {
    String value = "";
    for (var i = 0; i < maritalStatus.length; i++) {
      value = value + AppHelper.getStringFromEnum(maritalStatus[i]);
      if (i < maritalStatus.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }

  String getStringIncome(List<String> incomeList) {
    String value = "";
    for (var i = 0; i < incomeList.length; i++) {
      value = value + incomeList[i];
      if (i < incomeList.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }

  String getStateNames(List<StateModel?> myState) {
    String value = "";
    for (var i = 0; i < myState.length; i++) {
      value = value + myState[i]!.name;
      if (i < maritalStatus.length) {
        value = value + ", ";
      }
    }
    return value;
  }

  String getReligionText(List<SimpleMasterData> religion) {
    String value = "";
    for (var i = 0; i < religion.length; i++) {
      value = value + religion[i].title;
      if (i < religion.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }

  String getSubCasteText(List<dynamic> subCaste) {
    String value = "";
    for (var i = 0; i < subCaste.length; i++) {
      value = value + subCaste[i];
      if (i < subCaste.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }

  String getOccupationText(List<String?> occupation) {
    String value = "";
    for (var i = 0; i < occupation.length; i++) {
      value = value + occupation[i]!;
      if (i < subCaste.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }

  String getEducationText(List<Education> education) {
    String value = "";
    for (var i = 0; i < education.length; i++) {
      value = value + education[i].title;
      if (i < education.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }

  Widget buildAnnualIncomeNewDemo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Annual Income',
              style: MmmTextStyles.bodyMedium(textColor: kDark5),
            ),
          ],
        ),
        Row(children: [
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: MmmButtons.categoryButtonsNotRequired(
                'Minimum',
                this.annualIncome.length > 0
                    ? currentIncomes
                    : 'Does not matter',
                'Select Annual Income',
                'images/rightArrow.svg',
                action: () {
                  selectMinimumAnnualIncome();
                },
                showCancel: this.annualIncome.length > 0,
                cancelAction: () {
                  this.currentIncomes = "";
                  BlocProvider.of<ProfilePreferenceBloc>(context)
                      .add(RemoveIncome());
                }),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
              child: MmmButtons.categoryButtonsNotRequired(
                  'Maximum',
                  this.annualIncomeMax.length > 0
                      ? currentMaxIncomes
                      : 'Does not matter',
                  'Select Maximum Annual Income',
                  'images/rightArrow.svg',
                  action: () {
                    selectMaximumAnnualIncome();
                  },
                  showCancel: this.annualIncomeMax.length > 0,
                  cancelAction: () {
                    this.currentMaxIncomes = "";
                    BlocProvider.of<ProfilePreferenceBloc>(context)
                        .add(RemoveMaxIncome());
                  }))
        ])
      ],
    );
  }

  Widget buildAnnualIncomeNew() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Annual Income(in lakhs)',
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
                  'Minimum',
                  textScaleFactor: 1.0,
                  style: MmmTextStyles.bodySmall(textColor: kDark5),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  '*',
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
                  'Maximum',
                  textScaleFactor: 1.0,
                  style: MmmTextStyles.bodySmall(textColor: kDark5),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  '*',
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
                      "2",
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.bodyRegular(textColor: kDark5),
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
                      "5",
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.bodyRegular(textColor: kDark5),
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
    );
  }

  Widget buildAnnualIncome() {
    return MmmButtons.categoryButtonsNotRequired(
        'Annual Income',
        this.annualIncome.length > 0 ? currentIncomes : 'Does not matter',
        'Select Annual Income',
        'images/rightArrow.svg',
        action: () {
          selectMinimumAnnualIncome();
        },
        showCancel: this.annualIncome.length > 0,
        cancelAction: () {
          this.currentIncomes = "";
          BlocProvider.of<ProfilePreferenceBloc>(context).add(RemoveIncome());
        });
  }

  void selectMinimumAnnualIncome() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) =>
            AnnualIncomePreference(list: annualIncome, listMax: annualIncomeMax
                // minimumSelectedIndex: minimumSelectedIndex,
                ));
    if (result != null && result is List<AnualIncome>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(IncomeSelected(result));
      for (int i = 0; i < result.length; i++) {
        currentIncomes = incomes[result[i].index];
        minimumSelectedIndex = result[i].index + 1;
      }
    }
  }

  void selectMaximumAnnualIncome() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => AnnualMaxIncomePreference(
              list: annualIncome,
              listMax: annualIncomeMax,
              minimumSelectedIndex: minimumSelectedIndex,
            ));
    if (result != null && result is List<AnualIncome>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(IncomeSelectedMax(result));
      for (int i = 0; i < result.length; i++) {
        currentMaxIncomes = incomes[result[i].index];
      }
    }
  }

  Widget buildDietryHabiits() {
    return MmmButtons.categoryButtonsNotRequired(
        'Dietary Habit',
        this.eatingHabit.length > 0
            ? getStringFrom(eatingHabit)
            : 'Does not matter',
        'Select Dietary Habit',
        'images/rightArrow.svg',
        action: () {
          selectEatingHabit();
        },
        showCancel: this.eatingHabit.length > 0,
        cancelAction: () {
          BlocProvider.of<ProfilePreferenceBloc>(context).add(RemoveEating());
        });
  }

  void selectEatingHabit() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => EatingPrefs(
              list: this.eatingHabit,
            ));
    if (result != null && result is List<EatingHabit>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(DietrySelected(result));
    }
  }

  Widget buildDrinkingHabits() {
    return MmmButtons.categoryButtonsNotRequired(
        'Drinking Habit',
        this.drinkingHabit.length > 0
            ? getStringFrom(drinkingHabit)
            : 'Does not matter',
        'Select Drinking Habit',
        'images/rightArrow.svg',
        action: () {
          selectDrinkingHabit();
        },
        showCancel: this.drinkingHabit.length > 0,
        cancelAction: () {
          BlocProvider.of<ProfilePreferenceBloc>(context).add(RemoveDrinking());
        });
  }

  void selectDrinkingHabit() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => DrinkingPrefs(
              list: this.drinkingHabit,
            ));
    if (result != null && result is List<DrinkingHabit>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(DrinkingSelected(result));
    }
  }

  Widget buildSmokingHabit() {
    return MmmButtons.categoryButtonsNotRequired(
        'Smoking Habit',
        this.smokingHabit.length > 0
            ? getStringFrom(smokingHabit)
            : 'Does not matter',
        'Select Smoking Habit',
        'images/rightArrow.svg',
        action: () {
          selectSmokingHabit();
        },
        showCancel: this.smokingHabit.length > 0,
        cancelAction: () {
          BlocProvider.of<ProfilePreferenceBloc>(context).add(RemoveSmoking());
        });
  }

  void selectSmokingHabit() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SmokingPrefs(
              list: this.smokingHabit,
            ));
    if (result != null && result is List<SmokingHabit>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(SmokingSelected(result));
    }
  }

  void navigateToFetchProfile() {
    var userRepo =
        BlocProvider.of<ProfilePreferenceBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileLoader(
              userRepository: userRepo,
            )));
    // break;
  }
}
