import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';

import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';
import 'package:makemymarry/views/profilescreens/occupation/anual_income_bottom_sheet.dart';

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
  List<String> incomes = [
    'Less Than 1Lacs',
    '1 to 3Lacs',
    '3 to 5Lacs',
    '5 to 7Lacs',
    '7 to 10Lacs',
    '10 to 12Lacs',
    'More than 12Lacs'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Career'),
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
            Scaffold.of(context).showSnackBar(SnackBar(
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
                          height: 24,
                        ),
                        MmmButtons.categoryButtons(
                            'Occupation',
                            occupation != null
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
                            anualIncome != null
                                ?
                                //'${describeEnum(anualIncome!)}'
                                incomes[anualIncome!.index]
                                : 'Select your occupation',
                            'Select your occupation',
                            'images/rightArrow.svg', action: () {
                          selectAnualIncome(context);
                        }),
                        SizedBox(
                          height: 24,
                        ),
                        MmmTextFileds.textFiledWithLabelStar(
                            'Employeed in',
                            'Enter name of your organisation',
                            orgNameController),
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtons(
                            'Highest Education',
                            education != null
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
                        MmmButtons.categoryButtons(
                            'State',
                            myState != null
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
                        MmmButtons.categoryButtons(
                            'City',
                            city != null ? '${city!.name}' : 'Select City',
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
                  bottom: 24,
                  right: 24,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<OccupationBloc>(context).add(UpdateCareer(
                          orgNameController.text.trim(),
                          annIncomeController.text.trim(),
                          countryController.text.trim(),
                          stateController.text.trim(),
                          cityController.text.trim()));
                    },
                    child: MmmIcons.rightArrowEnabled(),
                  )),
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
    this.anualIncome = BlocProvider.of<OccupationBloc>(context).anualIncome;
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
}
