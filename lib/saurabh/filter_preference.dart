import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/annual_income_preference.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/annual_max_income_preference.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/drinking_habit.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/eating_prefs.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/education_preference_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/interest_prefs.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/occupation_preference_sheet.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/smoking_prefs.dart';
import '../datamodels/master_data.dart';
import '../datamodels/user_model.dart';
import '../repo/user_repo.dart';
import '../utils/app_helper.dart';
import '../utils/buttons.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/elevations.dart';
import '../utils/mmm_enums.dart';
import '../utils/text_styles.dart';
import '../utils/view_decorations.dart';
import '../views/profilescreens/occupation/views/anual_income_bottom_sheet.dart';
import '../views/profilescreens/occupation/bloc/occupation_bloc.dart';
import '../views/profilescreens/occupation/bloc/occupation_event.dart';
import '../views/profilescreens/profile_preference/marital_status_preference.dart';
import '../views/profilescreens/profile_preference/mother_tongue_preference_sheet.dart';
import '../views/profilescreens/profile_preference/profile_preference_bloc.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference_events.dart'
    as profilepreferenceEvent;
import '../views/profilescreens/profile_preference/profile_preference_events.dart';
import '../views/profilescreens/profile_preference/profile_preference_state.dart';
import '../views/profilescreens/profile_preference/religion_preference_sheet.dart';
import '../views/profilescreens/religion/views/gothra_bottom_sheet.dart';
import '../views/profilescreens/religion/bloc/religion_bloc.dart';
import '../views/profilescreens/religion/bloc/religion_event.dart';
import 'hexcolor.dart';

class FilterPrefsScreen extends StatelessWidget {
  final UserRepository userRepository;

  const FilterPrefsScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ProfilePreferenceBloc(userRepository, forFilters: true),
      ),
      BlocProvider(
        create: (context) => ReligionBloc(userRepository),
      ),
    ], child: FilterPrefs()
        // ProfilePreference(userRepository: userRepository),
        );
  }
}

class FilterPrefs extends StatefulWidget {
  const FilterPrefs({Key? key}) : super(key: key);

  @override
  State<FilterPrefs> createState() => _FilterPrefsState();
}

class _FilterPrefsState extends State<FilterPrefs> {
  RangeLabels labels = RangeLabels('1', "100");
  RangeValues values = RangeValues(1, 100);

  late double minAge, maxAge, minSliderAge,maxSliderAge;
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
  late List<InterestFilter> interestHabit;
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
  dynamic gothra;

  AnualIncome? anualIncome;

  void initData(BuildContext context) {
    this.userData = BlocProvider.of<ProfilePreferenceBloc>(context)
        .userRepository
        .useDetails!;
    this.gender = BlocProvider.of<ProfilePreferenceBloc>(context).gender;
    this.minAge = BlocProvider.of<ProfilePreferenceBloc>(context).minAge;
    this.minSliderAge =
        BlocProvider.of<ProfilePreferenceBloc>(context).minSliderAge;
    this.maxSliderAge =
        BlocProvider.of<ProfilePreferenceBloc>(context).maxSliderAge;
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

    this.interestHabit =
        BlocProvider.of<ProfilePreferenceBloc>(context).interestHabit;
    this.annualIncome =
        BlocProvider.of<ProfilePreferenceBloc>(context).annualIncome;
    this.annualIncomeMax =
        BlocProvider.of<ProfilePreferenceBloc>(context).annualIncomeMax;
    this.abilityStatus =
        BlocProvider.of<ProfilePreferenceBloc>(context).abilityStatus;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var primaryColor = HexColor('C9184A');
    return Scaffold(
        appBar: customAppBar('Filter', "Reset", (){context.read<ProfilePreferenceBloc>().add(ResetFilters());} ,context: context),
        body: BlocConsumer<ProfilePreferenceBloc, ProfilePreferenceState>(
            listener: (context, state) {
          if (state is OnGotCounties) {}
          if (state is OnGotStates) {}
          if (state is OnGotCities) {}
          if (state is OnGotCasteList) {}

          if (state is OnError) {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: Text(state.message),
              backgroundColor: kError,
            ));
          }
        }, builder: (context, state) {
          initData(context);
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(children: [
                SizedBox(height: 20),
                buildAgePreference(),
                SizedBox(height: 20),

                SizedBox(height: 20),
                Text(
                  "Personal Peference",
                  style:
                      MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                ),
                SizedBox(height: 10),
                buildHeight(),
                SizedBox(height: 10),
                buildMaritalStatus(),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Text(
                    'Disability',
                    style: MmmTextStyles.bodyRegular(textColor: kDark5),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Radio(
                            activeColor: kPrimary,
                            value: AbilityStatus.Normal,
                            groupValue: abilityStatus,
                            onChanged: (val) {
                              BlocProvider.of<ProfilePreferenceBloc>(context)
                                  .add(AbilityStatusChanged(
                                      AbilityStatus.Normal));
                            }),
                      ),
                      Text(
                        'Normal    ',
                        style: MmmTextStyles.bodySmall(textColor: kDark5),
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Radio(
                            activeColor: kPrimary,
                            value: AbilityStatus.PhysicallyChallenged,
                            groupValue: abilityStatus,
                            onChanged: (val) {
                              BlocProvider.of<ProfilePreferenceBloc>(context)
                                  .add(AbilityStatusChanged(
                                      AbilityStatus.PhysicallyChallenged));
                            }),
                      ),
                      Text(
                        'Physically Challenged',
                        style: MmmTextStyles.bodySmall(textColor: kDark5),
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
                SizedBox(height: 20),
                Text(
                  "Religion Peference",
                  style:
                      MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                ),
                SizedBox(height: 10),
                buildReligion(),
                SizedBox(height: 10),
                buildCaste(),
                SizedBox(height: 10),
                MmmButtons.myProfileButtons("Sub-Cast", action: () {}),
                SizedBox(height: 10),
                buildMotherTongue(),
                SizedBox(height: 10),
                SizedBox(height: 24),
                MmmButtons.categoryButtons(
                    'Gothra',
                    this.gothra != null ? gothra : 'Select your gothra',
                    'Select your gothra',
                    'images/rightArrow.svg', action: () {
                  selectGothra(context);
                }, required: false),
                SizedBox(height: 20),
                Text(
                  "Career Peference",
                  style:
                      MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                ),
                SizedBox(height: 10),
                buildOccupation(),
                SizedBox(height: 10),
                buildEducation(),
                SizedBox(height: 10),
                buildAnnualIncome(),
                SizedBox(height: 10),
                Text(
                  "Lifestyle Peference",
                  style:
                      MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                ),
                SizedBox(height: 10),
                buildEatingStatus(),
                SizedBox(height: 10),
                buildSmokingStatus(),
                SizedBox(height: 10),
                buildDrinkStatus(),
                SizedBox(height: 10),
                buildInterestStatus(),
                SizedBox(height: 30),
                MmmButtons.enabledRedButtonbodyMedium(50, 'Apply Filter',
                    action: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  context.read<ProfilePreferenceBloc>().add(CompleteFilter());
                }),
                SizedBox(height: 30),
              ]));
        }));
  }

  void selectGothra(BuildContext context) async {
    var list = BlocProvider.of<ReligionBloc>(context)
        .userRepository
        .masterData
        .listGothra;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => GothraBottomSheet(
              list: list,
              selected: this.gothra,
            ));
    if (result != null) {
      BlocProvider.of<ReligionBloc>(context).add(OnGothraSelected(result));
    }
  }

  void selectAnualIncome(BuildContext context) async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => AnnualIncomeBottomSheet(
              income: this.anualIncome,
            ));

    if (result != null && result is AnualIncome) {
      BlocProvider.of<OccupationBloc>(context)
          .add(OnAnnualIncomeSelected(result));
    }
  }

  Widget buildReligion() {
    return MmmButtons.categoryButtons(
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
    SimpleMasterData doesntMatter = SimpleMasterData("", "");
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
    if (result != null && result is SimpleMasterData) {
      //  BlocProvider.of<ReligionBloc>(context).add(OnReligionSelected(result));
      // BlocProvider.of<ProfilePreferenceBloc>(context)
      //     .add(OnReligionSelected(result));
    }
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

  Widget buildMotherTongue() {
    return MmmButtons.categoryButtons(
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
      // BlocProvider.of<ProfilePreferenceBloc>(context)
      //     .add(OnMotherTongueSelected(result));
    }
  }

  Widget buildCaste() {
    return Container(
        child: MmmButtons.categoryButtons(
            'Caste',
            subCaste.length > 0 ? getSubCasteText(subCaste) : 'Does not matter',
            'Select your caste',
            'images/rightArrow.svg',
            action: () {
              BlocProvider.of<ProfilePreferenceBloc>(context)
                  .add(profilepreferenceEvent.GetCasteList());
            },
            showCancel: subCaste.length > 0,
            cancelAction: () {
              BlocProvider.of<ProfilePreferenceBloc>(context)
                  .add(profilepreferenceEvent.RemoveCaste());
            }));
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

  Widget buildMaritalStatus() {
    return MmmButtons.categoryButtons(
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
                "Selected age is between ${minAge.round()} and ${maxAge.round()}",
                style: MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
              ),
              SizedBox(
                height: 6,
              ),
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
                        '${minSliderAge.toInt()}',
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
                        '${maxSliderAge.toInt()}',
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
                  values: RangeValues(minAge, maxAge),
                  min: minSliderAge,
                  max: maxSliderAge,
                  inactiveColor: kGray,
                  activeColor: kPrimary,
                  // divisions: 30,
                  labels: RangeLabels(
                    minAge.round().toString(),
                    maxAge.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    print(values.end);
                    BlocProvider.of<ProfilePreferenceBloc>(context).add(
                        profilepreferenceEvent.OnAgeRangeChanged(
                            values.start, values.end));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  static Widget verificationSttausAlert(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        //width: 328,
        height: 220,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFFFF),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),

            SizedBox(
              height: 24,
            ),
            Container(
              child: Text(
                'Verification Status',
                textAlign: TextAlign.center,
                style: MmmTextStyles.heading4(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
                height: 50,
                child: Text(
                  'Your document is sent for the verification. We’ll notify you once verification is done..',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.bodySmall(textColor: kDark5),
                )),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 42,
              child: Container(
                decoration: MmmDecorations.primaryButtonDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Ok',
                          style: MmmTextStyles.heading6(textColor: gray7),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static PreferredSize customAppBar(String title, String trailText,void Function() onTrailTap,
      {BuildContext? context}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(74.0),
      child: Container(
        child: AppBar(
          leading: Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
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
                    if (context != null) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'images/arrowLeft.svg',
                        height: 17.45,
                        width: 17.45,
                        color: gray3,
                      )),
                ),
              ),
            ),
          ),
          toolbarHeight: 74.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: MmmTextStyles.heading4(textColor: kLight2),
              ),
              InkWell(
                onTap: onTrailTap,
                child: Text(
                  trailText,
                  style: MmmTextStyles.bodySmall(textColor: kLight2),
                  // textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
          gradient: LinearGradient(
              colors: [kSecondary, kPrimary],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft),
        ),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }

  //  Height  Preference
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
              SizedBox(
                height: 50,
                child: Text(
                  "Selected height is between ${minHeight ~/ 12}'${(minHeight % 12).toInt()}'' and ${maxHeight ~/ 12}'${(maxHeight % 12).toInt()}''",
                  style:
                  MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                  maxLines: 2,
                ),
              ),
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
                        "4'0''",
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
                        "7'0''",
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
                  values:
                  RangeValues(minHeight.toDouble(), maxHeight.toDouble()),
                  min: 48,
                  max: 84,
                  // divisions: 36,
                  inactiveColor: kGray,
                  activeColor: kPrimary,
                  labels: RangeLabels(
                    "${minHeight ~/ 12}'${(minHeight % 12).toInt()}''",
                    "${maxHeight ~/ 12}'${(maxHeight % 12).toInt()}''",
                  ),
                  onChanged: (RangeValues values) {
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

  Widget buildOccupation() {
    return MmmButtons.categoryButtons(
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
          .add(profilepreferenceEvent.OnOccupationSelected(result));
    }
  }

  //Education
  Widget buildEducation() {
    return MmmButtons.categoryButtons(
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
          .add(profilepreferenceEvent.OnEducationSelected(result));
    }
  }

  //Annual Income

  Widget buildAnnualIncome() {
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
            child: MmmButtons.categoryButtons(
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
              child: MmmButtons.categoryButtons(
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

  Widget buildEatingStatus() {
    return MmmButtons.categoryButtons(
        'Eating Habit',
        this.eatingHabit.length > 0
            ? getStringFromEating(this.eatingHabit)
            : 'Select your Eating status',
        'Select your Eating status',
        'images/rightArrow.svg', action: () {
      eatingStatusBottomSheet();
    });
  }

  void eatingStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) => EatingPrefs(
              list: this.eatingHabit,
            ));
    if (result != null && result is List<EatingHabit>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(profilepreferenceEvent.DietarySelected(result));
    }
  }

  String getStringFromEating(List<dynamic> eatingStatus) {
    String value = "";
    print("Hello$eatingStatus");
    for (var i = 0; i < eatingStatus.length; i++) {
      value = AppHelper.getStringFromEnum(eatingStatus[i]);
      if (i < eatingStatus.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }

  Widget buildDrinkStatus() {
    return MmmButtons.categoryButtons(
        'Drinking Habit',
        this.drinkingHabit.length > 0
            ? getStringFromDrinking(this.drinkingHabit)
            : 'Select your drinking status',
        'Select your drinking status',
        'images/rightArrow.svg', action: () {
      drinkingtatusBottomSheet();
    });
  }

  void drinkingtatusBottomSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) => DrinkingPrefs(
              list: this.drinkingHabit,
            ));
    if (result != null && result is List<DrinkingHabit>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(profilepreferenceEvent.DrinkingSelected(result));
    }
  }

  String getStringFromDrinking(List<dynamic> smokingStatus) {
    String value = "";
    print("Hello$smokingStatus");
    for (var i = 0; i < smokingStatus.length; i++) {
      value = AppHelper.getStringFromEnum(smokingStatus[i]);
      if (i < smokingStatus.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }

  Widget buildSmokingStatus() {
    return MmmButtons.categoryButtons(
        'Smoking Habit',
        this.smokingHabit.length > 0
            ? getStringFromSmoking(this.smokingHabit)
            : 'Select your Smoking status',
        'Select your Smoking status',
        'images/rightArrow.svg', action: () {
      smokingtatusBottomSheet();
    });
  }

  void smokingtatusBottomSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) => SmokingPrefs(
              list: this.smokingHabit,
            ));
    if (result != null && result is List<SmokingHabit>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(profilepreferenceEvent.SmokingSelected(result));
    }
  }

  String getStringFromSmoking(List<dynamic> drinkingStatus) {
    String value = "";
    print("Hello$drinkingStatus");
    for (var i = 0; i < drinkingStatus.length; i++) {
      value = AppHelper.getStringFromEnum(drinkingStatus[i]);
      if (i < drinkingStatus.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }

  Widget buildInterestStatus() {
    return MmmButtons.categoryButtons(
        'Interest',
        this.interestHabit.length > 0
            ? getStringFromInterest(this.interestHabit)
            : 'Select your Interest status',
        'Select your Interest status',
        'images/rightArrow.svg', action: () {
      interestStatusBottomSheet();
    });
  }

  void interestStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) => InterestPrefs(
              list: this.interestHabit,
            ));
    if (result != null && result is List<InterestFilter>) {
      BlocProvider.of<ProfilePreferenceBloc>(context)
          .add(profilepreferenceEvent.InterestSelected(result));
    }
  }

  String getStringFromInterest(List<dynamic> interestFilter) {
    String value = "";
    print("Hello$interestFilter");
    for (var i = 0; i < interestFilter.length; i++) {
      value = AppHelper.getStringFromEnum(interestFilter[i]);
      if (i < interestFilter.length - 1) {
        value = value + ", ";
      }
    }
    return value;
  }
}
