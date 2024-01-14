import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';
import 'package:makemymarry/views/profilescreens/occupation/views/anual_income_bottom_sheet.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile.dart';

import '../../select_city_state.dart';
import '../../select_country_bottom_sheet.dart';
import '../bloc/occupation_state.dart';
import 'education_bottom_sheet.dart';
import '../bloc/occupation_bloc.dart';
import 'occupation_bottom_sheet.dart';
import '../bloc/occupation_event.dart';

class Occupations extends StatelessWidget {
  final UserRepository userRepository;
  final bool toUpdate;

  const Occupations(
      {Key? key, required this.userRepository, this.toUpdate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OccupationBloc(
        userRepository,
      ),
      child: OccupationScreen(toUpdate: toUpdate),
    );
  }
}

class OccupationScreen extends StatefulWidget {
  final bool toUpdate;
  OccupationScreen({Key? key, required this.toUpdate}) : super(key: key);

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
  AnnualIncome? anualIncome;
  String? education;
  CountryModel? countryModel;
  StateModel? myState, city;
  late UserDetails userDetails;
  @override
  void initState() {
    super.initState();
    myState = StateModel("", -1);
    myState!.name = '';

  }

  @override
  Widget build(BuildContext context) {
    this.userDetails =
        BlocProvider.of<OccupationBloc>(context).userRepository.useDetails!;

    BlocProvider.of<OccupationBloc>(context)
        .add(onOccupationDataLoad(userDetails.id));

    return Scaffold(
      appBar: MmmButtons.appBarCurved('Career', context: context),
      body: BlocConsumer<OccupationBloc, OccupationState>(
        listener: (context, state) {
          if (state is MoveToFamily) {
            navigateToFamily(context);
          }
          if (state is OnNavigationToMyProfiles) {
            Navigator.of(context).pop();
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
                          height: 0,
                        ),
                        MmmButtons.categoryButtons(
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
                        MmmButtons.categoryButtons(
                            'Annual Income',
                            anualIncome != null && anualIncome != AnnualIncome.NotMentioned
                                ?
                                AppHelper.getStringFromEnum(
                                    AnnualIncome.values[anualIncome!.index])
                                : 'Select your income',
                            'Select your income',
                            'images/rightArrow.svg', action: () {
                          selectAnualIncome(context);
                        }),
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtons(
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
                        MmmButtons.categoryButtons(
                            'Country',
                            countryModel != null && countryModel!.name.isNotNullEmpty
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
                        MmmButtons.categoryButtons(
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
                        if (countryModel != null &&
                            countryModel?.name.toLowerCase() == "india")
                          MmmButtons.categoryButtons(
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
                  child: widget.toUpdate
                      ? InkWell(
                          onTap: () {
                            BlocProvider.of<OccupationBloc>(context).add(
                                UpdateCareer(
                                    this.occupation,
                                    this.anualIncome,
                                    this.education,
                                    this.myState,
                                    this.city,
                                    widget.toUpdate));
                          },
                          child: MmmIcons.saveIcon(),
                        )
                      : InkWell(
                          onTap: () {
                            BlocProvider.of<OccupationBloc>(context).add(
                                UpdateCareer(
                                    this.occupation,
                                    this.anualIncome,
                                    this.education,
                                    this.myState,
                                    this.city,
                                    widget.toUpdate));
                          },
                          child: MmmIcons.rightArrowEnabled(),
                        )),
              // InkWell(
              //   onTap: () {
              //     BlocProvider.of<OccupationBloc>(context).add(UpdateCareer(
              //         this.occupation!,
              //         this.anualIncome!,
              //         this.education!,
              //         this.myState!,
              //         this.city!,
              //         this.userDetails.registrationStep > 4));
              //   },
              //   child: Container(
              //     margin: EdgeInsets.fromLTRB(15, 15, 20, 1),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           '(This section is optional)',
              //           style: TextStyle( fontFamily: 'MakeMyMarry', fontSize: 14),
              //         ),
              //         SizedBox(
              //           height: 24,
              //         ),
              //         Text('Skip >',
              //             style: TextStyle( fontFamily: 'MakeMyMarry', color: kPrimary, fontSize: 15)),
              //       ],
              //     ),
              //   ),
              // ),
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
    this.education = BlocProvider.of<OccupationBloc>(context).education;
    this.occupation = BlocProvider.of<OccupationBloc>(context).occupation;
    this.countryModel = BlocProvider.of<OccupationBloc>(context).countryModel;
    this.myState = BlocProvider.of<OccupationBloc>(context).myState;
    this.city = BlocProvider.of<OccupationBloc>(context).city;
    this.anualIncome = BlocProvider.of<OccupationBloc>(context).annualIncome;

    if (BlocProvider.of<OccupationBloc>(context).profileDetails != null &&
        context.read<OccupationBloc>().state is OccupationDetailsState) {
      if (this.education == null)
        this.education = BlocProvider.of<OccupationBloc>(context)
            .profileDetails!
            .highiestEducation;
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

    if (result != null && result is AnnualIncome) {
      BlocProvider.of<OccupationBloc>(context)
          .add(OnAnnualIncomeSelected(result));
    }
  }

  void selectOccupation(BuildContext context) async {
    var list = BlocProvider.of<OccupationBloc>(context)
        .userRepository
        .masterData
        .listOccupation;
    titleRedOcc = this.occupation ?? "";
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
    titleRedEdu = education ?? "";
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
    var city =
        BlocProvider.of<OccupationBloc>(context).city ?? StateModel("", 0);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FamilyScreen(
              userRepository: userRepo,
              countryModel: countryModel,
              stateModel: stateModel,
              city: city,
            )));
  }

  void navigateToMyProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyProfileScreen(),
      ),
    );
  }

  void navigateToFamilyTo(BuildContext context) {
    var userRepo = BlocProvider.of<OccupationBloc>(context).userRepository;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FamilyScreen(
          userRepository: userRepo,
        ),
      ),
    );
  }
}
