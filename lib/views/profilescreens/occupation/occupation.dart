import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/views/profilescreens/about/about_bloc.dart';

import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/family_details.dart';
import 'package:makemymarry/views/profilescreens/habbit/habits.dart';
import 'package:makemymarry/views/profilescreens/occupation/anual_income_bottom_sheet.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile.dart';

import '../select_city_state.dart';
import '../select_country_bottom_sheet.dart';
import 'education_bottom_sheet.dart';
import 'occupation_bloc.dart';
import 'occupation_bottom_sheet.dart';
import 'occupation_event.dart';
import 'occupation_state.dart';

class Occupations extends StatelessWidget {
  final UserRepository userRepository;

  const Occupations({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OccupationBloc(userRepository),
      child: OccupationScreen(),
    );
  }
}

class OccupationScreen extends StatefulWidget {
  OccupationScreen({Key? key}) : super(key: key);

  @override
  _OccupationScreenState createState() => _OccupationScreenState();
}

class _OccupationScreenState extends State<OccupationScreen> {
  var titleRedOcc = '';

  var titleRedEdu = '';

  final TextEditingController orgNameController = TextEditingController();

  final TextEditingController annIncomeController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  String? occupation;
  AnualIncome? anualIncome;
  String? education;
  CountryModel? countryModel;
  StateModel? myState, city;
  late UserDetails userDetails;
  @override
  void initState() {
    myState = StateModel("", -1);
    myState!.name = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.userDetails =
        BlocProvider.of<OccupationBloc>(context).userRepository.useDetails!;
    print("USERDETAIL${userDetails.religion.title}");
    if (this.userDetails.registrationStep > 4) {
      BlocProvider.of<OccupationBloc>(context)
          .add(onOccupationDataLoad(userDetails.id));
    }
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Career', context: context),
      //  floatingActionButton: FloatingActionButton(
      //    child: MmmIcons.rightArrowEnabled(),
      //   onPressed: () {
      //      BlocProvider.of<OccupationBloc>(context).add(UpdateCareer(
      //         orgNameController.text.trim(),
      //         annIncomeController.text.trim(),
      //          countryController.text.trim(),
      //         stateController.text.trim(),
      //         cityController.text.trim()));
      //   },
      //    backgroundColor: gray5,
      //  ),
      body: BlocConsumer<OccupationBloc, OccupationState>(
        listener: (context, state) {
          if (state is MoveToFamily) {
            navigateToFamily(context);
          }

          if (state is OnNavigationToMyProfiles) {
            navigateToMyProfile();
            // navigateToHabits();
          }
          if (state is MoveToFamilyTo) {
            navigateToFamilyTo(context);
          }
          if (state is OnGotCounties) {
            selectCountry(context, state.list);
          }
          if (state is OnGotStates) {
            selectStateCity(context, state.list, this.myState, "State");
          }
          if (state is OnGotCities) {
            selectStateCity(context, state.list, this.city, "City");
          }
          if (state is OnError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: kError,
            ));
          }
        },
        builder: (context, state) {
          initData(context);
          return Stack(
            children: [
              SingleChildScrollView(
                padding: kMargin16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 34,
                        ),
                        MmmButtons.categoryButtonsNotRequired(
                            'Occupation',
                            occupation != null && occupation != ''
                                ? '${occupation!}'
                                : 'Select your occupation',
                            'Select your occupation',
                            'images/rightArrow.svg', action: () {
                          selectOccupation(context);
                        }),
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtonsNotRequired(
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
                        // SizedBox(
                        //   height: 24,
                        // ),
                        // MmmTextFileds.textFiledWithLabelStar(
                        //     'Employeed in',
                        //     'Enter name of your organisation',
                        //     orgNameController),
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtonsNotRequired(
                            'Highest Education',
                            education != null && education != ''
                                ? '${education!}'
                                : 'Select your highest education',
                            'Select your highest education',
                            'images/rightArrow.svg', action: () {
                          selectEducation(context);
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Current location ',
                              style: MmmTextStyles.bodyMedium(
                                  textColor: kModalPrimary),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        MmmButtons.categoryButtonsNotRequired(
                            'Country',
                            countryModel != null
                                ? '${countryModel!.name}'
                                : 'Select Country',
                            'Select Country',
                            'images/rightArrow.svg', action: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          BlocProvider.of<OccupationBloc>(context)
                              .add(GetAllCountries());
                        }),
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtonsNotRequired(
                            'State',
                            myState != null && myState!.name != ''
                                ? '${myState!.name}'
                                : 'Select State',
                            'Select State',
                            'images/rightArrow.svg', action: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          BlocProvider.of<OccupationBloc>(context)
                              .add(GetAllStates());
                        }),
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtonsNotRequired(
                            'City',
                            city != null && city!.name != ''
                                ? '${city!.name}'
                                : 'Select City',
                            'Select City',
                            'images/rightArrow.svg', action: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          BlocProvider.of<OccupationBloc>(context)
                              .add(GetAllCities());
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 15,
                  right: 24,
                  child: this.userDetails.registrationStep > 4
                      ? InkWell(
                          onTap: () {
                            // BlocProvider.of<OccupationBloc>(context).add(UpdateCareer(
                            //     orgNameController.text.trim(),
                            //     annIncomeController.text.trim(),
                            //     countryController.text.trim(),
                            //     stateController.text.trim(),
                            //     cityController.text.trim(),
                            //     this.userDetails.registrationStep > 4));
                            BlocProvider.of<OccupationBloc>(context).add(
                                UpdateCareer(
                                    this.occupation!,
                                    this.anualIncome!,
                                    this.education!,
                                    this.myState!,
                                    this.city!,
                                    this.userDetails.registrationStep > 4));
                          },
                          child: MmmIcons.saveIcon(),
                        )
                      : InkWell(
                          onTap: () {
                            // BlocProvider.of<OccupationBloc>(context).add(UpdateCareer(
                            //     orgNameController.text.trim(),
                            //     annIncomeController.text.trim(),
                            //     countryController.text.trim(),
                            //     stateController.text.trim(),
                            //     cityController.text.trim(),
                            //     this.userDetails.registrationStep > 4));
                            BlocProvider.of<OccupationBloc>(context).add(
                                UpdateCareer(
                                    this.occupation!,
                                    this.anualIncome!,
                                    this.education!,
                                    this.myState!,
                                    this.city!,
                                    this.userDetails.registrationStep > 4));
                          },
                          child: MmmIcons.rightArrowEnabled(),
                        )),
              InkWell(
                onTap: () {
                  BlocProvider.of<OccupationBloc>(context).add(UpdateCareer(
                      this.occupation!,
                      this.anualIncome!,
                      this.education!,
                      this.myState!,
                      this.city!,
                      this.userDetails.registrationStep > 4));

                  // var userRepo =
                  //     BlocProvider.of<OccupationBloc>(context).userRepository;

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (_) => FamilyDetails(
                  //           userRepository: userRepo, onComplete: onComplete)),
                  // );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 20, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '(This section is optional)',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text('Skip >',
                          style: TextStyle(color: kPrimary, fontSize: 15)),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //     top: 10,
              //     left: 15,
              //     child:
              // InkWell(
              //     onTap: () {
              // BlocProvider.of<OccupationBloc>(context).add(
              //     UpdateCareer(

              // orgNameController.text.trim(),
              // annIncomeController.text.trim(),
              // countryController.text.trim(),
              // stateController.text.trim(),
              // cityController.text.trim()));
              //     },
              //     // child: MmmIcons.rightArrowEnabled(),
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             '(This section is optional)',
              //             style: TextStyle(fontSize: 14),
              //           ),
              //           SizedBox(width: 155),
              //           SizedBox(
              //             height: 24,
              //           ),
              //           Text('Skip >',
              //               style:
              //                   TextStyle(color: kPrimary, fontSize: 15)),
              //         ],
              //       ),
              //     )),
              // Positioned(
              //     bottom: 24,
              //     left: 24,
              //     child: InkWell(
              // onTap: () {
              //   BlocProvider.of<OccupationBloc>(context).add(
              //       UpdateCareer(
              //           orgNameController.text.trim(),
              //           annIncomeController.text.trim(),
              //           countryController.text.trim(),
              //           stateController.text.trim(),
              //           cityController.text.trim()));
              // },
              //         // child: MmmIcons.rightArrowEnabled(),
              //         child: Text('Skip >',
              //             style: TextStyle(color: kPrimary, fontSize: 18)))),
              state is OnLoading
                  ? MmmWidgets.buildLoader(context)
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  void initData(BuildContext context) {
    if (this.education == null)
      this.education = BlocProvider.of<OccupationBloc>(context).education;
    this.occupation = BlocProvider.of<OccupationBloc>(context).occupation;
    this.countryModel = BlocProvider.of<OccupationBloc>(context).countryModel;
    this.myState = BlocProvider.of<OccupationBloc>(context).myState;
    this.city = BlocProvider.of<OccupationBloc>(context).city;
    this.anualIncome = BlocProvider.of<OccupationBloc>(context).anualIncome;

    if (BlocProvider.of<OccupationBloc>(context).profileDetails != null) {
      print(
          "EDUCATION${BlocProvider.of<OccupationBloc>(context).profileDetails!.annualIncome}");
      if (this.education == null)
        this.education = BlocProvider.of<OccupationBloc>(context)
            .profileDetails!
            .highiestEducation;
      //print("EDUCATION${this.city}");
      if (this.occupation == null)
        this.occupation =
            BlocProvider.of<OccupationBloc>(context).profileDetails!.occupation;
      if (this.anualIncome == null)
        this.anualIncome = BlocProvider.of<OccupationBloc>(context)
            .profileDetails!
            .annualIncome;
      if (this.city == null) {
        //var cityName = this.city!.name;
        var cityName =
            BlocProvider.of<OccupationBloc>(context).profileDetails!.city;
        var cityId =
            BlocProvider.of<OccupationBloc>(context).profileDetails!.cityId;
        this.city = StateModel(cityName, cityId);
      }
      if (this.myState == null) {
        var stateName =
            BlocProvider.of<OccupationBloc>(context).profileDetails!.state;
        var stateId =
            BlocProvider.of<OccupationBloc>(context).profileDetails!.stateId;
        this.myState = StateModel(stateName, stateId);
      }
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

  void selectOccupation(BuildContext context) async {
    var list = BlocProvider.of<OccupationBloc>(context)
        .userRepository
        .masterData
        .listOccupation;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => OccupationBottomSheet(
              list: list,
              titleRed: titleRedOcc,
            ));

    if (result != null && result is SimpleMasterData) {
      BlocProvider.of<OccupationBloc>(context)
          .add(OnOccupationSelected(result.title));
      titleRedOcc = result.title;
    }
  }

  void selectEducation(BuildContext context) async {
    var list = BlocProvider.of<OccupationBloc>(context)
        .userRepository
        .masterData
        .listEducation;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => EducationBottomSheet(
              list: list,
              titleRed: titleRedEdu,
            ));
    if (result != null && result is Education) {
      print("RESULT${result.title}");
      this.education = result.title;
      BlocProvider.of<OccupationBloc>(context)
          .add(OnEducationSelected(result.title));
      titleRedEdu = result.title;
    }
  }

  void selectCountry(BuildContext context, List<CountryModel> list) async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SelectCountryBottomSheet(
              list: list,
              countryModel: this.countryModel,
            ));
    if (result != null && result is CountryModel) {
      BlocProvider.of<OccupationBloc>(context).add(OnCountrySelected(result));
    }
  }

  void selectStateCity(BuildContext context, List<StateModel> list,
      StateModel? data, String title) async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SelectStateCityBottomSheet(
              list: list,
              stateModel: data,
              title: '',
            ));
    if (result != null && result is StateModel) {
      if (title == "State")
        BlocProvider.of<OccupationBloc>(context).add(OnStateSelected(result));
      else
        BlocProvider.of<OccupationBloc>(context).add(OnCitySelected(result));
    }
  }

  void navigateToFamily(BuildContext context) {
    var userRepo = BlocProvider.of<OccupationBloc>(context).userRepository;
    var countryModel = BlocProvider.of<OccupationBloc>(context).countryModel!;
    var stateModel = BlocProvider.of<OccupationBloc>(context).myState!;
    var city = BlocProvider.of<OccupationBloc>(context).city!;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FamilyScreen(
              userRepository: userRepo,
              countryModel: countryModel,
              stateModel: stateModel,
              city: city,
            )));
  }

  void navigateToMyProfile() {
    var userRepo = BlocProvider.of<OccupationBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AboutBloc(userRepo),
                  ),
                  BlocProvider(
                    create: (context) => OccupationBloc(userRepo),
                  ),
                  BlocProvider(
                    create: (context) => AccountMenuBloc(userRepo),
                  ),
                ],
                child: MyProfileScreen(
                  userRepository: userRepo,
                ))));
  }

  void navigateToFamilyTo(BuildContext context) {
    var userRepo = BlocProvider.of<OccupationBloc>(context).userRepository;
    // var countryModel = BlocProvider.of<OccupationBloc>(context).countryModel!;
    // var stateModel = BlocProvider.of<OccupationBloc>(context).myState!;
    // var city = BlocProvider.of<OccupationBloc>(context).city!;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FamilyScreen(
              userRepository: userRepo,
              // countryModel: countryModel,
              // stateModel: stateModel,
              // city: city,
            )));
  }
}
