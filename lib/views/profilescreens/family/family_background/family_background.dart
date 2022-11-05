import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/master_data.dart';
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
import 'package:makemymarry/views/profilescreens/bio/bio_bloc.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_event.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_state.dart';

import '../../bio/bio.dart';
import '../../select_city_state.dart';
import '../../select_country_bottom_sheet.dart';
import 'family_background_bloc.dart';
import 'family_status_bottom_sheet.dart';
import 'family_values_sheet.dart';

class FamilyBackground extends StatelessWidget {
  final UserRepository userRepository;
  final Function onComplete;
  final CountryModel? countryModel;
  final StateModel? stateModel;
  final StateModel? city;

  const FamilyBackground(
      {Key? key,
      required this.userRepository,
      required this.onComplete,
      required this.countryModel,
      required this.stateModel,
      required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FamilyBackgroundBloc(
            userRepository, countryModel, stateModel, city),
        child: FamilyBackgroundScreen(
          onComplete: onComplete,
          userRepository: userRepository,
        ));
  }
}

class FamilyBackgroundScreen extends StatefulWidget {
  final Function onComplete;
  final UserRepository userRepository;

  const FamilyBackgroundScreen(
      {Key? key, required this.onComplete, required this.userRepository})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FamilyBackgroundScreenState();
  }
}

class FamilyBackgroundScreenState extends State<FamilyBackgroundScreen> {
  String familyStatustext = 'Select your family status';
  String familyValuestext = 'Select your family value';
  FamilyAfluenceLevel? level;
  FamilyValues? values;
  FamilyType? type;
  CountryModel? countryModel;
  StateModel? myState, city;
  String countrytext = 'Select your country';

  String statetext = 'Select your state';

  String citytext = 'Select your city';
  bool? isStayingWithParents;
  late bool canSelectStayingWithParent;
  late UserDetails userDetails;
  @override
  Widget build(BuildContext context) {
    this.userDetails = BlocProvider.of<FamilyBackgroundBloc>(context)
        .userRepository
        .useDetails!;

    if (this.userDetails.registrationStep > 5) {
      print("registrationStep${this.userDetails.registrationStep}");
      BlocProvider.of<FamilyBackgroundBloc>(context)
          .add(onFamilyBackgroundDataLoad(userDetails.id));
    }
    return BlocConsumer<FamilyBackgroundBloc, FamilyBackgroundState>(
      builder: (context, state) {
        initData();
        return Container(
            child: Stack(
          children: [
            buildUi(context),
            Positioned(
                bottom: 24,
                right: 24,
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<FamilyBackgroundBloc>(context)
                        .add(UpdateFamilyBackground());
                  },
                  child: MmmIcons.rightArrowEnabled(),
                )),
            Positioned(
                bottom: 24,
                left: 24,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => Bio(
                                    userRepository: widget.userRepository,
                                  )));
                      // BlocProvider.of<OccupationBloc>(context).add(UpdateCareer(
                      //     orgNameController.text.trim(),
                      //     annIncomeController.text.trim(),
                      //     countryController.text.trim(),
                      //     stateController.text.trim(),
                      //     cityController.text.trim()));
                    },
                    // child: MmmIcons.rightArrowEnabled(),
                    child: Text('Skip >',
                        style: TextStyle(color: kPrimary, fontSize: 18)))),
            state is OnLoading ? MmmWidgets.buildLoader(context) : Container(),
          ],
        ));
      },
      listener: (context, state) {
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
        if (state is OnUpdate) {
          widget.onComplete();
        }
      },
    );
  }

  SingleChildScrollView buildUi(BuildContext context) {
    print("object$level");
    return SingleChildScrollView(
      child: Container(
        padding: kMargin16,
        child: Column(
          children: [
            Column(
              children: [
                MmmButtons.categoryButtons(
                    'Family Status',
                    level != null
                        ? AppHelper.getStringFromEnum(level!)
                        : familyStatustext,
                    familyStatustext,
                    "images/rightArrow.svg", action: () {
                  showFamilyStatusSheet();
                }),
                SizedBox(
                  height: 24,
                ),
                MmmButtons.categoryButtons(
                    'Family Values',
                    this.values != null
                        ? describeEnum(this.values!)
                        : familyValuestext,
                    "  familyValuestext",
                    "images/rightArrow.svg", action: () {
                  showFamilyValuesSheet();
                }),
                SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 8),
                      child: Text(
                        'Family Type',
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 1.2,
                            child: Radio(
                                activeColor: Colors.pinkAccent,
                                value: this.type!,
                                groupValue: FamilyType.Nuclear,
                                onChanged: (val) {
                                  BlocProvider.of<FamilyBackgroundBloc>(context)
                                      .add(OnFamilyTypeChanges(
                                          FamilyType.Nuclear));
                                }),
                          ),
                          Text(
                            'Nuclear Family',
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Radio(
                                activeColor: Colors.pinkAccent,
                                value: this.type!,
                                groupValue: FamilyType.Joint,
                                onChanged: (val) {
                                  BlocProvider.of<FamilyBackgroundBloc>(context)
                                      .add(OnFamilyTypeChanges(
                                          FamilyType.Joint));
                                }),
                          ),
                          Text(
                            'Joint Family',
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Radio(
                            activeColor: Colors.pinkAccent,
                            value: this.type!,
                            groupValue: FamilyType.Other,
                            onChanged: (val) {
                              BlocProvider.of<FamilyBackgroundBloc>(context)
                                  .add(OnFamilyTypeChanges(FamilyType.Other));
                            }),
                      ),
                      Text(
                        'Other',
                        style: MmmTextStyles.bodySmall(textColor: kDark5),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 96,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: kLight4)),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Current location of groom’s family',
                      style: MmmTextStyles.bodyMedium(textColor: kDark5),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                this.canSelectStayingWithParent
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Staying with parents?',
                            style: MmmTextStyles.bodyRegular(textColor: kDark5),
                          ),
                          Checkbox(
                              value: isStayingWithParents!,
                              onChanged: (onChanged) {
                                BlocProvider.of<FamilyBackgroundBloc>(context)
                                    .add(OnStayingWithParentsChanged(
                                        onChanged!));
                              })
                        ],
                      )
                    : Container(),
                this.isStayingWithParents!
                    ? Container()
                    : Column(
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          MmmButtons.categoryButtons(
                              'Country',
                              countryModel != null
                                  ? '${countryModel!.name}'
                                  : 'Select Country',
                              'Select Country',
                              'images/rightArrow.svg', action: () {
                            FocusScope.of(context).requestFocus(FocusNode());

                            BlocProvider.of<FamilyBackgroundBloc>(context)
                                .add(GetAllCountries());
                          }),
                          SizedBox(
                            height: 24,
                          ),
                          MmmButtons.categoryButtons(
                              'State',
                              myState != null && myState!.name != ""
                                  ? '${myState!.name}'
                                  : 'Select State',
                              'Select State',
                              'images/rightArrow.svg', action: () {
                            FocusScope.of(context).requestFocus(FocusNode());

                            BlocProvider.of<FamilyBackgroundBloc>(context)
                                .add(GetAllStates());
                          }),
                          SizedBox(
                            height: 24,
                          ),
                          MmmButtons.categoryButtons(
                              'City',
                              city != null && city!.name != ""
                                  ? '${city!.name}'
                                  : 'Select City',
                              'Select City',
                              'images/rightArrow.svg', action: () {
                            FocusScope.of(context).requestFocus(FocusNode());

                            BlocProvider.of<FamilyBackgroundBloc>(context)
                                .add(GetAllCities());
                          }),
                        ],
                      ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void initData() {
    this.values = BlocProvider.of<FamilyBackgroundBloc>(context).values;
    this.level = BlocProvider.of<FamilyBackgroundBloc>(context).level;
    this.type = BlocProvider.of<FamilyBackgroundBloc>(context).type;
    this.countryModel =
        BlocProvider.of<FamilyBackgroundBloc>(context).countryModel;
    this.myState = BlocProvider.of<FamilyBackgroundBloc>(context).myState;
    this.city = BlocProvider.of<FamilyBackgroundBloc>(context).city;
    this.isStayingWithParents =
        BlocProvider.of<FamilyBackgroundBloc>(context).isStayingWithParents;
    this.canSelectStayingWithParent =
        BlocProvider.of<FamilyBackgroundBloc>(context)
            .canSelectStayingWithParent;

    if (BlocProvider.of<FamilyBackgroundBloc>(context).profileDetails != null) {
      if (this.level == null)
        this.level = BlocProvider.of<FamilyBackgroundBloc>(context)
            .profileDetails!
            .familyAfluenceLevel;

      if (this.values == null)
        this.values = BlocProvider.of<FamilyBackgroundBloc>(context)
            .profileDetails!
            .familyValues;

      if (this.type == null)
        this.type = BlocProvider.of<FamilyBackgroundBloc>(context)
            .profileDetails!
            .familyType;

      if (this.myState == null) {
        var stateName = BlocProvider.of<FamilyBackgroundBloc>(context)
            .profileDetails!
            .familyState;

        var stateId = BlocProvider.of<FamilyBackgroundBloc>(context)
            .profileDetails!
            .familyStateId;

        this.myState = StateModel(stateName, stateId);
      }
      if (this.city == null) {
        var cityName = BlocProvider.of<FamilyBackgroundBloc>(context)
            .profileDetails!
            .familyCity;
        var cityId = BlocProvider.of<FamilyBackgroundBloc>(context)
            .profileDetails!
            .familyCityId;
        this.city = StateModel(cityName, cityId);
      }
    }
  }

  showFamilyStatusSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => FamilyStatusBottomSheet(
              level: this.level,
            ));
    if (result != null && result is FamilyAfluenceLevel) {
      BlocProvider.of<FamilyBackgroundBloc>(context)
          .add(OnFamilyStatusSelected(result));
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
      BlocProvider.of<FamilyBackgroundBloc>(context)
          .add(OnCountrySelected(result));
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
        BlocProvider.of<FamilyBackgroundBloc>(context)
            .add(OnStateSelected(result));
      else
        BlocProvider.of<FamilyBackgroundBloc>(context)
            .add(OnCitySelected(result));
    }
  }

  void showFamilyValuesSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => FamilyValuesBottomSheet(
              level: values,
            ));
    if (result != null && result is FamilyValues) {
      BlocProvider.of<FamilyBackgroundBloc>(context)
          .add(OnFamilyValueSelected(result));
    }
  }
}
