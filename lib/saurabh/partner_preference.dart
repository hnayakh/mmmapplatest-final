import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
import '../views/profilescreens/occupation/anual_income_bottom_sheet.dart';
import '../views/profilescreens/occupation/occupation_bloc.dart';
import '../views/profilescreens/occupation/occupation_event.dart';
import '../views/profilescreens/profile_preference/marital_status_preference.dart';
import '../views/profilescreens/profile_preference/mother_tongue_preference_sheet.dart';
import '../views/profilescreens/profile_preference/profile_preference.dart';
import '../views/profilescreens/profile_preference/profile_preference_bloc.dart';
import '../views/profilescreens/profile_preference/profile_preference_events.dart';
import '../views/profilescreens/profile_preference/profile_preference_state.dart';
import '../views/profilescreens/profile_preference/religion_preference_sheet.dart';
import '../views/profilescreens/religion/gothra_bottom_sheet.dart';
import '../views/profilescreens/religion/religion_bloc.dart';
import '../views/profilescreens/religion/religion_event.dart';
import 'hexcolor.dart';

class PartnerPrefsScreen extends StatelessWidget {
  final UserRepository userRepository;

  const PartnerPrefsScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ProfilePreferenceBloc(userRepository),
      ),
      BlocProvider(
        create: (context) => ReligionBloc(userRepository),
      ),
    ], child: PartnerPrefs()
        // ProfilePreference(userRepository: userRepository),
        );
  }
}

class PartnerPrefs extends StatefulWidget {
  const PartnerPrefs({Key? key}) : super(key: key);

  @override
  State<PartnerPrefs> createState() => _PartnerPrefsState();
}

class _PartnerPrefsState extends State<PartnerPrefs> {
  RangeLabels labels = RangeLabels('1', "100");
  // int values = 10;
  RangeValues values = RangeValues(1, 100);

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
  dynamic gothra;

  // String? occupation;
  AnualIncome? anualIncome;

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
    Size screenSize = MediaQuery.of(context).size;
    var primaryColor = HexColor('C9184A');
    return Scaffold(
        appBar: customAppBar('Partner Preference', "Reset", context: context),
        body: BlocConsumer<ProfilePreferenceBloc, ProfilePreferenceState>(
            listener: (context, state) {
          if (state is OnGotCounties) {
            // selectCountry(context, state.list);
          }
          if (state is OnGotStates) {
            // selectState(context, state.list, "State");
          }
          if (state is OnGotCities) {
            // selectCity(context, state.list, "City");
          }
          if (state is OnGotCasteList) {
            // selectSubCast(state.caste);
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
        }, builder: (context, state) {
          initData(context);
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(children: [
                SizedBox(
                  height: 20,
                ),
// age
                buildAgePreference(),
                // Text(
                //   "Age Peference",
                //   style:
                //       MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Colors.black54),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         "Selected age is between 24 and 28",
                //         style: MmmTextStyles.bodyMediumSmall(
                //             textColor: Colors.black87),
                //       ),
                //       SizedBox(
                //         height: 20,
                //       ),
                //       RangeSlider(
                //           divisions: 100,
                //           activeColor: Colors.red[700],
                //           inactiveColor: Colors.red[300],
                //           min: 1,
                //           max: 100,
                //           values: values,
                //           labels: labels,
                //           onChanged: (value) {
                //             print("START: ${value.start}, End: ${value.end}");
                //             setState(() {
                //               values = value;
                //               labels = RangeLabels(
                //                   "${value.start.toInt().toString()}",
                //                   "${value.start.toInt().toString()}");
                //             });
                //           }),
                //       SizedBox(
                //         height: 20,
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Profile Peference",
                  style:
                      MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                ),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons('Doesn\'t Matter ', action: () {
                  print('ok');
                  showDialog(
                      context: context,
                      builder: (ctx) => verificationSttausAlert());
                }),

                SizedBox(
                  height: 20,
                ),
                Text(
                  "Personal Peference",
                  style:
                      MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                ),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons('Height ', action: () {}),
                SizedBox(
                  height: 10,
                ),
                // MmmButtons.myProfileButtons("Marital Status", action: () {}),
                buildMaritalStatus(),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons("Disability", action: () {}),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Religion Peference",
                  style:
                      MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                ),
                SizedBox(
                  height: 10,
                ),
                // MmmButtons.myProfileButtons("Religion", action: () {}),
                buildReligion(),
                SizedBox(
                  height: 10,
                ),
                buildCaste(),
                // MmmButtons.myProfileButtons("Cast", action: () {}),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons("Sub-Cast", action: () {}),
                // buildCaste(),
                SizedBox(
                  height: 10,
                ),
                // MmmButtons.myProfileButtons("Mother Tongue", action: () {}),
                buildMotherTongue(),
                SizedBox(
                  height: 10,
                ),
                // MmmButtons.myProfileButtons("Gothra", action: () {}),
                // SizedBox(
                //   height: 10,
                // ),
                // MmmButtons.myProfileButtons("Manglink", action: () {}),
                SizedBox(
                  height: 24,
                ),
                MmmButtons.categoryButtons(
                    'Gothra',
                    this.gothra != null ? gothra : 'Select your gothra',
                    'Select your gothra',
                    'images/rightArrow.svg', action: () {
                  selectGothra(context);
                }, required: false),

                SizedBox(
                  height: 20,
                ),
                Text(
                  "Career Peference",
                  style:
                      MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                ),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons('Employeed in ', action: () {}),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons('Occupation ', action: () {}),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons('Highest Education', action: () {}),
                SizedBox(
                  height: 10,
                ),
                // MmmButtons.myProfileButtons('Annual Income', action: () {}),
                MmmButtons.categoryButtons(
                    'Annual Income',
                    anualIncome != null
                        ?
                        //'${describeEnum(anualIncome!)}'
                        //incomes[anualIncome!.index]
                        AppHelper.getStringFromEnum(
                            AnualIncome.values[anualIncome!.index])
                        : 'Select your income',
                    'Select your income',
                    'images/rightArrow.svg', action: () {
                  selectAnualIncome(context);
                }),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Lifestyle Peference",
                  style:
                      MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
                ),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons('Food', action: () {}),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons('Smoke', action: () {}),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons('Drink', action: () {}),
                SizedBox(
                  height: 10,
                ),
                MmmButtons.myProfileButtons('Interests', action: () {}),
                SizedBox(
                  height: 30,
                ),
                MmmButtons.enabledRedButtonbodyMedium(50, 'Apply Filter',
                    action: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  // BlocProvider.of<BioBloc>(context)
                  //     .add(UpdateBio(this.bioController.text));
                }),
                SizedBox(
                  height: 30,
                ),
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
    SimpleMasterData doesntMatter = SimpleMasterData();
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
    return //BlocProvider.of<ProfilePreferenceBloc>(context).checkCaste()?
        Container(
            child: MmmButtons.categoryButtons(
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
              Text(
                "Selected age is between ${minAge.round()} and ${maxAge.round()}",
                style: MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
              ),
              // Text(
              //   ' ${minAge.round()} Yrs <---> ${maxAge.round()} Yrs',
              //   style: MmmTextStyles.bodyRegular(textColor: kDark5),
              // ),

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

  static Widget verificationSttausAlert() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        //width: 328,
        height: 293,
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
            // Container(
            //   width: double.infinity,
            //   height: 163,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(8),
            //     child: Image.asset(
            //       'images/stackviewImage.jpg',
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
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
                height: 60,
                child: Text(
                  'Your document is sent for the verification. We’ll notify you once verification is done..',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.bodySmall(textColor: kDark5),
                )),
            SizedBox(
              height: 34,
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
                      onTap: () {},
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

  static PreferredSize customAppBar(String title, String trailText,
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
            children: [
              Text(
                title,
                style: MmmTextStyles.heading4(textColor: kLight2),
              ),
              SizedBox(
                width: MediaQuery.of(context!).size.width / 2,
              ),
              Text(
                trailText,
                style: MmmTextStyles.bodySmall(textColor: kLight2),
                // textAlign: TextAlign.right,
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
            color: kSecondary),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }
}
