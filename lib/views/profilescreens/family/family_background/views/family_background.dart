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
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/bloc/family_background_event.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/bloc/family_background_state.dart';
import 'package:makemymarry/views/profilescreens/habbit/habits.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile.dart';

import '../../../select_city_state.dart';
import '../../../select_country_bottom_sheet.dart';
import '../bloc/family_background_bloc.dart';
import 'family_status_bottom_sheet.dart';
import 'family_values_sheet.dart';

class FamilyBackground extends StatelessWidget {
  final UserRepository userRepository;
  final Function onComplete;
  final CountryModel? countryModel;
  final StateModel? stateModel;
  final StateModel? city;
  final bool toUpdate;

  const FamilyBackground(
      {Key? key,
      required this.userRepository,
      required this.onComplete,
      required this.countryModel,
      required this.stateModel,
      required this.toUpdate,
      required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FamilyBackgroundScreen(
      onComplete: onComplete,
      userRepository: userRepository,
      toUpdate: toUpdate,
    );
  }
}

class FamilyBackgroundScreen extends StatefulWidget {
  final Function onComplete;
  final UserRepository userRepository;
  final bool toUpdate;

  const FamilyBackgroundScreen(
      {Key? key,
      required this.onComplete,
      required this.userRepository,
      required this.toUpdate})
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

      BlocProvider.of<FamilyBackgroundBloc>(context)
          .add(onFamilyBackgroundDataLoad(userDetails.id));
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
                child: widget.toUpdate
                    ? InkWell(
                        onTap: () {
                          BlocProvider.of<FamilyBackgroundBloc>(context).add(
                            UpdateFamilyBackground(
                              this.level,
                              this.values,
                              this.isStayingWithParents!,
                              this.city,
                              this.myState,
                              widget.toUpdate,
                              this.type,
                            ),
                          );
                        },
                        child: MmmIcons.saveIcon(),
                      )
                    : InkWell(
                        onTap: () {
                          BlocProvider.of<FamilyBackgroundBloc>(context).add(
                            UpdateFamilyBackground(
                              this.level,
                              this.values,
                              this.isStayingWithParents!,
                              this.city,
                              this.myState,
                              widget.toUpdate,
                              this.type,
                            ),
                          );
                        },
                        child: MmmIcons.rightArrowEnabled(),
                      ),
              ),
              widget.toUpdate
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
                        ),
                      ),
                    ),
              state is OnLoading
                  ? MmmWidgets.buildLoader(context)
                  : Container(),
            ],
          ),
        );
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
        if (state is OnNavigationToMyProfiles) {
          navigateToMyProfile();
          // navigateToHabits();
        }
      },
    );
  }

  SingleChildScrollView buildUi(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: kMargin16,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                MmmButtons.categoryButtonsNotRequired(
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
                MmmButtons.categoryButtonsNotRequired(
                    'Family Values',
                    this.values != null
                        ? AppHelper.getStringFromEnum(this.values!)
                        : familyValuestext,
                    familyValuestext,
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
                      this.userDetails.gender == 0
                          ? 'Current location of Groom’s family'
                          : "Current location of Bride's family",
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
                !this.isStayingWithParents!
                    ? Container()
                    : Column(
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          MmmButtons.categoryButtonsNotRequired(
                              'Country',
                              countryModel != null &&
                                      countryModel!.name.isNotNullEmpty
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
                          MmmButtons.categoryButtonsNotRequired(
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
                          if (countryModel != null &&
                              this.countryModel?.id == 101)
                            MmmButtons.categoryButtonsNotRequired(
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

    // if (BlocProvider.of<FamilyBackgroundBloc>(context).profileDetails != null &&
    //     context.read<FamilyBackgroundBloc>().state
    //         is familyBackgroundDataState) {
    //   if (this.level == null)
    //     this.level = BlocProvider.of<FamilyBackgroundBloc>(context)
    //         .profileDetails!
    //         .familyAfluenceLevel;
    //
    //   if (this.values == null)
    //     this.values = BlocProvider.of<FamilyBackgroundBloc>(context)
    //         .profileDetails!
    //         .familyValues;
    //
    //   if (this.type == null)
    //     this.type = BlocProvider.of<FamilyBackgroundBloc>(context)
    //         .profileDetails!
    //         .familyType;
    //
    //     var countryName = BlocProvider.of<FamilyBackgroundBloc>(context)
    //         .profileDetails!
    //         .familyCountry;
    //     var countryId = BlocProvider.of<FamilyBackgroundBloc>(context)
    //         .profileDetails!
    //         .familyCountryId;
    //
    //     this.countryModel = CountryModel.fromJson({
    //       "name": countryName,
    //       "shortName": countryName,
    //       "id": countryId,
    //       "phoneCode": 0,
    //     });
    //   if (this.myState == null) {
    //     var stateName = BlocProvider.of<FamilyBackgroundBloc>(context)
    //         .profileDetails!
    //         .familyState;
    //     var stateId = BlocProvider.of<FamilyBackgroundBloc>(context)
    //         .profileDetails!
    //         .familyStateId;
    //
    //     this.myState = StateModel(stateName, stateId);
    //   }
    //
    //   if (this.city == null) {
    //     var cityName = BlocProvider.of<FamilyBackgroundBloc>(context)
    //         .profileDetails!
    //         .familyCity;
    //     var cityId = BlocProvider.of<FamilyBackgroundBloc>(context)
    //         .profileDetails!
    //         .familyCityId;
    //     this.city = StateModel(cityName, cityId);
    //   }
    // }
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
      this.values = result;
    }
  }

  void navigateToMyProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyProfileScreen(),
      ),
    );
  }
}
