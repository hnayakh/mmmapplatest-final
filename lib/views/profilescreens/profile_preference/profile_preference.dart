import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/occupation/education_bottom_sheet.dart';
import 'package:makemymarry/views/profilescreens/occupation/occupation_bottom_sheet.dart';

import 'package:makemymarry/views/profilescreens/profile_preference/city_preference_bottom_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/country_preference_sheet.dart';
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
import 'package:makemymarry/views/profilescreens/religion/mother_tongue_bottom_sheet.dart';

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
  String titleRedOcc = '';
  TextEditingController annIncomeController = TextEditingController();

  void initData(BuildContext context) {
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
                            buildHeight(),
                            SizedBox(
                              height: 24,
                            ),
                            buildMaritalStatus(),
                            SizedBox(
                              height: 24,
                            ),
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
                            SizedBox(
                              height: 24,
                            ),
                            MmmTextFileds.textFiledWithLabelStar(
                                'Annual Income',
                                'Enter your annual income',
                                annIncomeController,
                                inputType: TextInputType.number),
                            SizedBox(
                              height: 24,
                            ),
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
            //
            selectCity(context, state.list, "City");
          }
        },
      ),
    );
  }

  Widget buildAgePreference() {
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
              Text(
                ' ${minAge.round()} <---> ${maxAge.round()}',
                style: MmmTextStyles.bodyRegular(textColor: kDark5),
              ),
              RangeSlider(
                values: RangeValues(minAge, maxAge),
                min: minSliderAge,
                max: 70,
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
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHeight() {
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
              Text(
                ' ${minHeight.toStringAsFixed(1)} <---> ${maxHeight.toStringAsFixed(1)}',
                style: MmmTextStyles.bodyRegular(textColor: kDark5),
              ),
              RangeSlider(
                values: RangeValues(minHeight, maxHeight),
                min: minHeight - 1.0,
                max: 8.5,
                inactiveColor: kGray,
                activeColor: kPrimary,
                // divisions: 30,
                labels: RangeLabels(
                  minHeight.toStringAsFixed(1),
                  maxHeight.toStringAsFixed(1),
                ),
                onChanged: (RangeValues values) {
                  print(values.end);
                  BlocProvider.of<ProfilePreferenceBloc>(context)
                      .add(OnHeightRangeChanged(values.start, values.end));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMaritalStatus() {
    return MmmButtons.categoryButtons(
        'Marital Status',
        this.maritalStatus != []
            ? getStringFrom(this.maritalStatus)
            : 'Select your maritial status',
        'Select your maritial status',
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
    return MmmButtons.categoryButtons(
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
    return MmmButtons.categoryButtons(
        'State',
        // myState != null ? '${myState!.name}' :
        'Does not matter',
        'Select State',
        'images/rightArrow.svg', action: () {
      FocusScope.of(context).requestFocus(FocusNode());

      BlocProvider.of<ProfilePreferenceBloc>(context).add(GetAllStates());
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
              title: '',
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
    return MmmButtons.categoryButtons(
        'City',
        //city != null ? '${city!.name}' :
        'Does not matter',
        'Select City',
        'images/rightArrow.svg', action: () {
      FocusScope.of(context).requestFocus(FocusNode());

      BlocProvider.of<ProfilePreferenceBloc>(context).add(GetMyCities());
    });
  }

  Widget buildReligion() {
    return MmmButtons.categoryButtons(
        'Religion',
        //'${religion.title}',
        'Doesnot Matter',
        'Select your religion',
        'images/rightArrow.svg', action: () {
      selectReligion(context);
    });
  }

  void selectReligion(BuildContext context) async {
    var list = BlocProvider.of<ProfilePreferenceBloc>(context)
        .userRepository
        .masterData
        .listReligion;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => ReligionPreferenceSheet(
              list: list,
              religionModel: this.religion,
            ));
    if (result != null && result is List<SimpleMasterData>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(OnReligionSelected(result));
    }
  }

  Widget buildCaste() {
    return //BlocProvider.of<ProfilePreferenceBloc>(context).checkCaste()?
        Container(
            child: MmmButtons.categoryButtons(
                'Caste',
                // subCaste != null ? '${subCaste}' :
                'Does not matter',
                'Select your caste',
                'images/rightArrow.svg', action: () {
      selectSubCast(context);
    }));
    // : Container();
  }

  void selectSubCast(BuildContext context) async {
    List<CastSubCast> castList = [];
    for (int i = 0; i < this.religion.length; i++) {
      var cast = BlocProvider.of<ProfilePreferenceBloc>(context)
          .userRepository
          .masterData
          .listCastSubCast
          .firstWhere((element) =>
              element.cast.toLowerCase() ==
              this.religion[i].title.toLowerCase());
      castList.add(cast);
    }

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
    return MmmButtons.categoryButtons(
        'Mother Tongue',
        // motherTongue != null
        //   ? '${motherTongue!.title}':
        'Select your mother tongue',
        'Select your mother tongue',
        'images/rightArrow.svg', action: () {
      selectMotherToungue(context);
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
    return MmmButtons.categoryButtons(
        'Occupation',
        // occupation != null ? '${occupation!}' :
        'Does not matter',
        'Select your occupation',
        'images/rightArrow.svg', action: () {
      selectOccupation(context);
    });
  }

  Widget buildEducation() {
    return MmmButtons.categoryButtons(
        'Highest Education',
        //education != null ? '${education!}' :
        'Does not matter',
        'Select your highest education',
        'images/rightArrow.svg', action: () {
      selectEducation(context);
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

  String getStringFrom(List<MaritalStatus> maritalStatus) {
    String value = "";
    for (var i = 0; i < maritalStatus.length; i++) {}
    return value;
  }
}
