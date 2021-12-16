import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference_events.dart';

import 'profile_preference_state.dart';

class ProfilePreferenceBloc
    extends Bloc<ProfilePreferenceEvent, ProfilePreferenceState> {
  final UserRepository userRepository;
  late double minAge;
  late double minSliderAge;
  late double maxAge;
  late double minHeight;
  late double maxHeight;
  late List<MaritalStatus> maritalStatus = [];
  late CountryModel countryModel;
  List<StateModel?> myState = [];
  List<StateModel?> city = [];
  List<SimpleMasterData> religion = [];
  List<dynamic> subCaste = [];
  List<SimpleMasterData> motherTongue = [];
  List<String?> occupation = [];
  List<Education> education = [];

  List<AnualIncome> annualIncome = [];
  EatingHabit? eatingHabit;
  SmokingHabit? smokingHabit;
  DrinkingHabit? drinkingHabit;
  late AbilityStatus abilityStatus;

  ProfilePreferenceBloc(this.userRepository)
      : super(ProfilePreferenceInitialState()) {
    print(this.userRepository.useDetails!.dateOfBirth);
    var myAge = DateTime.now()
            .difference(DateFormat(AppConstants.SERVERDATEFORMAT)
                .parse(this.userRepository.useDetails!.dateOfBirth))
            .inDays /
        365;
    print(myAge);

    if (this.userRepository.useDetails!.gender == Gender.Male.index) {
      this.minAge = myAge - 4;
      this.maxAge = myAge;
      this.minHeight = this.userRepository.useDetails!.height - 0.6;
      this.maxHeight = this.userRepository.useDetails!.height;
      this.minSliderAge = 18;
      if (minAge < minSliderAge) {
        this.minAge = 18;
      }
    } else {
      this.minAge = myAge;
      this.maxAge = myAge + 4;
      this.minHeight = this.userRepository.useDetails!.height;
      this.maxHeight = this.userRepository.useDetails!.height + 0.6;
      this.minSliderAge = 21;
    }
    print("$minAge -- $maxAge");
    print("$minHeight -- $maxHeight");
    this.maritalStatus.add(this.userRepository.useDetails!.maritalStatus);
    this.countryModel = this.userRepository.useDetails!.countryModel;
    this.religion.add(this.userRepository.useDetails!.religion);
    this.motherTongue.add(this.userRepository.useDetails!.motherTongue);
    this.abilityStatus = this.userRepository.useDetails!.abilityStatus;
  }

  @override
  Stream<ProfilePreferenceState> mapEventToState(
      ProfilePreferenceEvent event) async* {
    yield OnLoading();
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
    if (event is GetAllStates) {
      var result = await this.userRepository.getStates(this.countryModel.id);
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
    if (event is RemoveOccupation) {
      this.occupation = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is IncomeSelected) {
      this.annualIncome = event.list;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveIncome) {
      this.annualIncome = [];
      yield ProfilePreferenceInitialState();
    }
    if (event is DrinkingSelected) {
      this.drinkingHabit = event.drinkingHabit;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveDrinking) {
      this.drinkingHabit = null;
      yield ProfilePreferenceInitialState();
    }
    if (event is DietrySelected) {
      this.eatingHabit = event.eatingHabit;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveEating) {
      this.eatingHabit = null;
      yield ProfilePreferenceInitialState();
    }
    if (event is SmokingSelected) {
      this.smokingHabit = event.smokingHabit;
      yield ProfilePreferenceInitialState();
    }
    if (event is RemoveSmoking) {
      this.smokingHabit = null;
      yield ProfilePreferenceInitialState();
    }
    if (event is AbilityStatusChanged) {
      this.abilityStatus = event.abilityStatus;
      yield ProfilePreferenceInitialState();
    }

    if (event is CompletePreference) {
      var response = await this.userRepository.completePreference(
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
          this.eatingHabit,
          this.drinkingHabit,
          this.smokingHabit,
          this.abilityStatus);
      if (response.status == AppConstants.SUCCESS) {
        this.userRepository.updateRegistrationStep(11);
        yield ProfilePreferenceComplete();
      } else {
        yield OnError(response.message);
      }
    }
  }

//bool checkCaste() {
// if (casteNotAvailable()) {
//    return false;
//  } else {
//    return true;
//  }
// }

//  bool casteNotAvailable() {
//    return this.religion.title.toLowerCase().contains("budhhist") ||
//        this.religion.title.toLowerCase().contains("parsi") ||
//       this.religion.title.toLowerCase().contains("jewish") ||
//       this.religion.title.toLowerCase().contains("other") ||
//       this.religion.title.toLowerCase().contains("no religion") ||
//       this.religion.title.toLowerCase().contains("spiritual");
// }
}
