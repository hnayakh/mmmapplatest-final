import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference_events.dart';

import '../../../locator.dart';
import 'profile_preference_state.dart';

class ProfilePreferenceBloc
    extends Bloc<ProfilePreferenceEvent, ProfilePreferenceState> {
  final UserRepository userRepository;

  late double minAge;
  late double minSliderAge;
  late double maxSliderAge;
  late double maxAge;
  late double minHeight;
  late double maxHeight;
  bool singleCountryInList = true;
  final bool forFilters;
  late List<MaritalStatus> maritalStatus = [];
  late CountryModel countryModel;
  List<CountryModel> countryModelList = [];
  List<StateModel?> myState = [];
  List<StateModel?> city = [];
  List<SimpleMasterData> religion = [];
  List<dynamic> subCaste = [];
  List<SimpleMasterData> motherTongue = [];
  List<String?> occupation = [];
  List<Education> education = [];
  List<AnnualIncome> annualIncomeMax = [];
  List<AnnualIncome> annualIncome = [];
  late List<EatingHabit> eatingHabit = [];
  late List<InterestFilter> interestHabit = [];
  late List<SmokingHabit> smokingHabit = [];
  late List<DrinkingHabit> drinkingHabit = [];
  late AbilityStatus abilityStatus;
  late Gender gender;
  dynamic gothra = "";

  ProfilePreferenceBloc(this.userRepository, {this.forFilters = false})
      : super(ProfilePreferenceInitialState()) {
    initializeFilters();
  }

  initializeFilters() {
    this.gender = Gender.values[this.userRepository.useDetails!.gender];
    var myAge = DateTime.now()
            .difference(DateFormat(AppConstants.SERVERDATEFORMAT)
                .parse(this.userRepository.useDetails!.dateOfBirth))
            .inDays ~/
        365;
    var myHeight = this.userRepository.useDetails?.height ?? 64;
    if (myHeight > 84) {
      myHeight = 64;
    }
    this.maxSliderAge = 70;
    if (this.userRepository.useDetails!.gender == Gender.Male.index) {
      this.minAge = myAge - 4;
      this.maxAge = myAge.toDouble();
      this.minHeight = myHeight - 6;
      this.maxHeight = myHeight;
      this.minSliderAge = 18;
    } else {
      this.minSliderAge = 21;
      this.minAge = myAge.toDouble();
      this.maxAge = myAge + 4;
      this.minHeight = myHeight;
      this.maxHeight = myHeight + 6;
    }
    if (minAge < minSliderAge) {
      this.minAge = minSliderAge;
    }
    if (maxAge > maxSliderAge) {
      maxAge = maxSliderAge;
    }
    if (minHeight < 48) {
      minHeight = 48;
    }
    if (maxHeight > 84) {
      maxHeight = 84;
    }
    this.maritalStatus
      ..clear()
      ..add(this.userRepository.useDetails!.maritalStatus);
    this.abilityStatus = this.userRepository.useDetails!.abilityStatus;

    this.countryModel = this.userRepository.useDetails!.countryModel;
    this.religion
      ..clear()
      ..add(this.userRepository.useDetails!.religion);
    this.motherTongue
      ..clear()
      ..add(this.userRepository.useDetails!.motherTongue);
    this.countryModelList
      ..clear()
      ..add(countryModel);
    if (!this.forFilters) {
      this.add(GetPartnerPreference());
    }
  }

  @override
  Stream<ProfilePreferenceState> mapEventToState(
      ProfilePreferenceEvent event) async* {
    yield OnLoading();
    if (event is GetPartnerPreference) {
      var result = await this.userRepository.getPartnerPreference();
      this.minAge = result.preferences.minAge.toDouble();
      this.maxAge = result.preferences.maxAge.toDouble();
      this.minHeight = result.preferences.minHeight.toDouble();
      this.maxHeight = result.preferences.maxHeight.toDouble();
      this.maritalStatus
        ..clear()
        ..addAll(result.preferences.maritalStatus);
      this.abilityStatus = result.preferences.isPhysicallyChallenged
          ? AbilityStatus.PhysicallyChallenged
          : AbilityStatus.Normal;
      this.religion
        ..clear()
        ..addAll(result.preferences.religions);
      this.motherTongue
        ..clear()
        ..addAll(result.preferences.motherTongue);
      this.countryModelList
        ..clear()
        ..addAll(result.preferences.countries);
      this.drinkingHabit
        ..clear()
        ..addAll(result.preferences.drinkingHabits);
      this.eatingHabit
        ..clear()
        ..addAll(result.preferences.eatingHabit);
      this.smokingHabit
        ..clear()
        ..addAll(result.preferences.smokingHabit);
      this.annualIncome
        ..clear()
        ..addAll(result.preferences.minIncome.map((e) => AnnualIncome.values[e]));
      this.annualIncomeMax
        ..clear()
        ..addAll(result.preferences.maxIncome.map((e) => AnnualIncome.values[e]));
      this.occupation
        ..clear()
        ..addAll(result.preferences.occupation.map((e) => e.title));
      this.subCaste
        ..clear()
        ..addAll(result.preferences.castes.map((e) => e).toSet().toList());
      this.education
        ..clear()
        ..addAll(result.preferences.education);
      yield ProfilePreferenceInitialState();
    }
    if (event is ResetFilters) {
      initializeFilters();
      yield ProfilePreferenceInitialState();
    }
    if (event is OnAgeRangeChanged) {
      this.minAge = event.start;
      this.maxAge = event.end;
      yield ProfilePreferenceInitialState();
    }
    if (event is OnHeightRangeChanged) {
      this.minHeight = event.start;
      this.maxHeight = event.end;
      yield ProfilePreferenceInitialState();
    }
    if (event is OnMaritalStatusSelected) {
      this.maritalStatus = event.status;
      yield ProfilePreferenceInitialState();
    }
    if (event is SmokingSelected) {
      this.smokingHabit = event.smokingHabit;
      yield ProfilePreferenceInitialState();
    }
    if (event is GetAllCountries) {
      var result = await this.userRepository.getCountries();
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotCounties(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is OnCountrySelected) {
      this.countryModel = event.countryModel;
      yield ProfilePreferenceInitialState();
    }
    if (event is OnCountryListSelected) {
      this.singleCountryInList = false;
      this.countryModelList = event.countryModelList;
      if (this.countryModelList.length == 1) {
        this.singleCountryInList = true;
      }
      yield ProfilePreferenceInitialState();
    }
    if (event is GetAllStates) {
      var result = await this.userRepository.getStates(this.countryModel.id);
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotStates(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is GetAllStatesFromCountryList) {
      var result =
          await this.userRepository.getStates(this.countryModelList[0].id);
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotStates(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is OnStateSelected) {
      this.myState = event.stateModel;
      yield ProfilePreferenceInitialState();
    }
    if (event is GetMyCities) {
      List<List<StateModel>> listCities = [];
      for (int i = 0; i < this.myState.length; i++) {
        var result = await this.userRepository.getCities(this.myState[i]!.id);
        if (result.status == AppConstants.SUCCESS) {
          listCities.add(result.list);
          //    yield OnGotCities(result.list);
        } else {
          yield OnError(result.message);
        }
      }
      yield OnGotCities(listCities);
    }
    if (event is OnCitySelected) {
      this.city = event.cityModel;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveState) {
      this.myState = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveCity) {
      this.city = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is OnReligionSelected) {
      this.religion = event.data;
      yield ProfilePreferenceInitialState();
    }
    if (event is GetCasteList) {
      List<CastSubCast> castList = [];
      for (int i = 0; i < this.religion.length; i++) {
        var cast = this.userRepository.masterData.listCastSubCast.firstWhere(
            (element) =>
                element.cast.toLowerCase() ==
                this.religion[i].title.toLowerCase());
        castList.add(cast);
      }
      yield OnGotCasteList(castList);
    }
    if (event is OnSubCastSelected) {
      this.subCaste = event.caste;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveCaste) {
      this.subCaste = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is OnMotherTongueSelected) {
      this.motherTongue = event.motherTongue;
      yield ProfilePreferenceInitialState();
    }

    if (event is OnOccupationSelected) {
      this.occupation = event.title;
      yield ProfilePreferenceInitialState();
    }
    if (event is OnEducationSelected) {
      this.education = event.title;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveEducation) {
      this.education = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveMaritalStatus) {
      this.maritalStatus = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveReligion) {
      this.religion = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveCountryList) {
      this.countryModelList = [];
      this.singleCountryInList = false;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveOccupation) {
      this.occupation = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveMotherTongue) {
      this.motherTongue = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is IncomeSelected) {
      this.annualIncome = event.list;
      yield ProfilePreferenceInitialState();
    }
    if (event is IncomeSelectedMax) {
      this.annualIncomeMax = event.listMax;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveIncome) {
      this.annualIncome = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveMaxIncome) {
      this.annualIncomeMax = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is DrinkingSelected) {
      this.drinkingHabit = event.drinkingHabit;
      yield ProfilePreferenceInitialState();
    }
    if (event is OnGothraSelect) {
      this.gothra = event.gothra;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveDrinking) {
      this.drinkingHabit = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is DietarySelected) {
      this.eatingHabit = event.eatingHabit;
      yield ProfilePreferenceInitialState();
    }
    if (event is InterestSelected) {
      this.interestHabit = event.interestHabit;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveEating) {
      this.eatingHabit = [];
      yield ProfilePreferenceInitialState();
    }

    if (event is RemoveSmoking) {
      this.smokingHabit = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is AbilityStatusChanged) {
      this.abilityStatus = event.abilityStatus;
      yield ProfilePreferenceInitialState();
    }

    if (event is CompletePreference) {
      var result = await this.userRepository.completePreference(
          this.maxHeight,
          this.minHeight,
          this.maxAge,
          this.minAge,
          this.maritalStatus,
          this.countryModel,
          this.myState,
          this.city,
          this.religion,
          this.subCaste,
          this.motherTongue,
          this.occupation,
          this.education,
          this.annualIncome,
          this.annualIncomeMax,
          this.eatingHabit,
          this.drinkingHabit,
          this.smokingHabit,
          this.abilityStatus);
      if (result.status == AppConstants.SUCCESS) {
        if (userRepository.useDetails!.registrationStep < 10) {
          this.userRepository.updateRegistrationStep(10);
          this.userRepository.useDetails!.registrationStep = 10;
          await this.userRepository.saveUserDetails();
          var response = await this
              .userRepository
              .updateRegistartionStep(this.userRepository.useDetails!.id, 10);
          yield ProfilePreferenceComplete();
        } else {
          yield ProfilePreferenceUpdated();
        }
      } else {
        yield OnError(result.message);
      }
    }

    if (event is CompleteFilter) {
      var result = await this.userRepository.completeFilter(
          this.maxHeight,
          this.minHeight,
          this.maxAge,
          this.minAge,
          this.maritalStatus,
          this.countryModel,
          this.myState,
          this.city,
          this.religion,
          this.subCaste,
          this.motherTongue,
          this.occupation,
          this.education,
          this.annualIncome,
          this.annualIncomeMax,
          this.eatingHabit,
          this.drinkingHabit,
          this.smokingHabit,
          this.abilityStatus);
      if (result.status == AppConstants.SUCCESS) {
        yield ProfileFilterComplete(result.list);
      } else {
        yield OnError(result.message);
      }
    }
  }
}

class PartnerPreferences {
  final int minAge;
  final int maxAge;
  final int minHeight;
  final int maxHeight;
  final List<int> minIncome;
  final List<int> maxIncome;
  final List<MaritalStatus> maritalStatus;
  final List<CountryModel> countries;
  final List<StateModel> states;
  final List<StateModel> cities;
  final List<SimpleMasterData> religions;
  final List<dynamic> castes;
  final List<SimpleMasterData> motherTongue;
  final List<SimpleMasterData> occupation;
  final List<Education> education;
  final bool isPhysicallyChallenged;
  final List<DrinkingHabit> drinkingHabits;
  final List<EatingHabit> eatingHabit;
  final List<SmokingHabit> smokingHabit;

  PartnerPreferences({
    required this.minAge,
    required this.maxAge,
    required this.minHeight,
    required this.maxHeight,
    required this.minIncome,
    required this.maxIncome,
    required this.maritalStatus,
    required this.countries,
    required this.states,
    required this.cities,
    required this.religions,
    required this.castes,
    required this.motherTongue,
    required this.occupation,
    required this.education,
    required this.isPhysicallyChallenged,
    required this.drinkingHabits,
    required this.eatingHabit,
    required this.smokingHabit,
  });

  factory PartnerPreferences.fromJson({required Map<String, dynamic> json}) => PartnerPreferences(
      minAge: json["minAge"],
      maxAge: json["maxAge"],
      minHeight: json["minHeight"],
      maxHeight: json["maxHeight"],
      minIncome: json["minIncome"].toString().split(',').where((e) => e.isNotNullEmpty).map((e) => int.parse(e)).toList(),
      maxIncome: json["maxIncome"].toString().split(',').where((e) => e.isNotNullEmpty).map((e) => int.parse(e)).toList(),
      maritalStatus: json["maritalStatus"]
          .toString()
          .split(",")
          .map((e) => MaritalStatus.values[int.parse(e)])
          .toList(),
      countries: <CountryModel>[],
      states: [],
      cities: [],
      religions: json["religion"]
          .toString()
          .split(",")
          .where((e) => e.trim().isNotNullEmpty)
          .toList()
          .map((e) => getIt<UserRepository>()
              .masterData
              .listReligion
              .firstWhere((element) => element.title == e))
          .toList(),
      castes: getIt<UserRepository>()
          .masterData
          .listCastSubCast
          .fold<List<dynamic>>(
              <dynamic>[],
              (previousValue, element) =>
                  previousValue..addAll(element.subCasts))
          .where((e) => json["caste"]
              .toString()
              .split(",")
              .where((e) => e.isNotNullEmpty)
              .toList()
              .contains(e))
          .toList(),
      motherTongue: json["motherTongue"]
          .toString()
          .split(",")
          .where((e) => e.isNotNullEmpty)
          .toList()
          .map((e) =>
              getIt<UserRepository>().masterData.listMotherTongue.firstWhere((element) => element.title == e))
          .toList(),
      occupation: getIt<UserRepository>().masterData.listOccupation.fold<List<SimpleMasterData>>(<SimpleMasterData>[], (previousValue, element) => previousValue..addAll(element.subCategory)).where((e) => json["occupation"].toString().split(",").where((occupation) => occupation.isNotNullEmpty).toList().contains(e.id)).toList(),
      education: json["highestEducation"].toString().split(",").where((e) => e.isNotNullEmpty).toList().map((e) => getIt<UserRepository>().masterData.listEducation.firstWhere((element) => element.text == e)).toList(),
      isPhysicallyChallenged: json["challenged"] == "1",
      drinkingHabits: json["drinkingHabits"].toString().split(",").where((e) => e.isNotNullEmpty).toList().map((e) => DrinkingHabit.values[int.parse(e)]).toList(),
      eatingHabit: json["dietaryHabits"].toString().split(",").where((e) => e.isNotNullEmpty).toList().map((e) => EatingHabit.values[int.parse(e)]).toList(),
      smokingHabit: json["smokingHabits"].toString().split(",").where((e) => e.isNotNullEmpty).toList().map((e) => SmokingHabit.values[int.parse(e)]).toList());

  PartnerPreferences copyWith({
    int? minAge,
    int? maxAge,
    int? minHeight,
    int? maxHeight,
    List<int>? minIncome,
    List<int>? maxIncome,
    List<MaritalStatus>? maritalStatus,
    List<CountryModel>? countries,
    List<StateModel>? states,
    List<StateModel>? cities,
    List<SimpleMasterData>? religions,
    List<SimpleMasterData>? castes,
    List<SimpleMasterData>? motherTongue,
    List<SimpleMasterData>? occupation,
    List<Education>? education,
    bool? isPhysicallyChallenged,
    List<DrinkingHabit>? drinkingHabits,
    List<EatingHabit>? eatingHabit,
    List<SmokingHabit>? smokingHabit,
  }) =>
      PartnerPreferences(
          minAge: minAge ?? this.minAge,
          maxAge: maxAge ?? this.maxAge,
          minHeight: minHeight ?? this.minHeight,
          maxHeight: maxHeight ?? this.maxHeight,
          minIncome: minIncome ?? this.minIncome,
          maxIncome: maxIncome ?? this.maxIncome,
          maritalStatus: maritalStatus ?? this.maritalStatus,
          countries: countries ?? this.countries,
          states: states ?? this.states,
          cities: cities ?? this.cities,
          religions: religions ?? this.religions,
          castes: castes ?? this.castes,
          motherTongue: motherTongue ?? this.motherTongue,
          occupation: occupation ?? this.occupation,
          education: education ?? this.education,
          isPhysicallyChallenged:
              isPhysicallyChallenged ?? this.isPhysicallyChallenged,
          drinkingHabits: drinkingHabits ?? this.drinkingHabits,
          eatingHabit: eatingHabit ?? this.eatingHabit,
          smokingHabit: smokingHabit ?? this.smokingHabit);
}
