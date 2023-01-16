import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class ProfilePreferenceEvent extends BaseEventState {}

class CountrySelected extends ProfilePreferenceEvent {
  final CountryModel countryModel;

  CountrySelected(this.countryModel);
}

class OnCountryListSelected extends ProfilePreferenceEvent {
  final List<CountryModel> countryModelList;

  OnCountryListSelected(this.countryModelList);
}

class OnStateSelected extends ProfilePreferenceEvent {
  final List<StateModel?> stateModel;

  OnStateSelected(this.stateModel);
}

class OnReligionSelected extends ProfilePreferenceEvent {
  final List<SimpleMasterData> data;

  OnReligionSelected(this.data);
}

class OnSubCastSelected extends ProfilePreferenceEvent {
  final List<dynamic> caste;

  OnSubCastSelected(this.caste);
}

class OnMotherTongueSelected extends ProfilePreferenceEvent {
  final List<SimpleMasterData> motherTongue;

  OnMotherTongueSelected(this.motherTongue);
}

class OnEducationSelected extends ProfilePreferenceEvent {
  final List<Education> title;

  OnEducationSelected(this.title);
}

class OnOccupationSelected extends ProfilePreferenceEvent {
  final List<String?> title;

  OnOccupationSelected(this.title);
}

class IncomeSelected extends ProfilePreferenceEvent {
  final List<AnualIncome> list;
  IncomeSelected(this.list);
}

class IncomeSelectedMax extends ProfilePreferenceEvent {
  final List<AnualIncome> listMax;
  IncomeSelectedMax(this.listMax);
}

class OnGothraSelect extends ProfilePreferenceEvent {
  final dynamic gothra;

  OnGothraSelect(this.gothra);
}

class RemoveIncome extends ProfilePreferenceEvent {}

class RemoveMaxIncome extends ProfilePreferenceEvent {}

class DietarySelected extends ProfilePreferenceEvent {
  final List<EatingHabit> eatingHabit;

  DietarySelected(this.eatingHabit);
}

class InterestSelected extends ProfilePreferenceEvent {
  final List<InterestFilter> interestHabit;
  InterestSelected(this.interestHabit);
}

class DrinkingSelected extends ProfilePreferenceEvent {
  final List<DrinkingHabit> drinkingHabit;

  DrinkingSelected(this.drinkingHabit);
}

class SmokingSelected extends ProfilePreferenceEvent {
  final List<SmokingHabit> smokingHabit;

  SmokingSelected(this.smokingHabit);
}

class ChallengedSelected extends ProfilePreferenceEvent {}

class OnMaritalStatusSelected extends ProfilePreferenceEvent {
  final List<MaritalStatus> status;

  OnMaritalStatusSelected(this.status);
}

class OnSelectSmoking extends ProfilePreferenceEvent {
  final List<SmokingHabit> status;

  OnSelectSmoking(this.status);
}

class OnAgeRangeChanged extends ProfilePreferenceEvent {
  final double start;
  final double end;

  OnAgeRangeChanged(this.start, this.end);
}

class OnHeightRangeChanged extends ProfilePreferenceEvent {
  final double start;
  final double end;

  OnHeightRangeChanged(this.start, this.end);
}

class GetAllCountries extends ProfilePreferenceEvent {}

class OnCountrySelected extends ProfilePreferenceEvent {
  final CountryModel countryModel;

  OnCountrySelected(this.countryModel);
}

class GetAllStates extends ProfilePreferenceEvent {}

class GetAllStatesFromCountryList extends ProfilePreferenceEvent {}

class GetMyCities extends ProfilePreferenceEvent {}

class OnCitySelected extends ProfilePreferenceEvent {
  final List<StateModel?> cityModel;

  OnCitySelected(this.cityModel);
}

class RemoveCountry extends ProfilePreferenceEvent {}

class RemoveCountryList extends ProfilePreferenceEvent {}

class RemoveState extends ProfilePreferenceEvent {}

class RemoveCity extends ProfilePreferenceEvent {}

class RemoveSmoking extends ProfilePreferenceEvent {}

class RemoveEating extends ProfilePreferenceEvent {}

class RemoveDrinking extends ProfilePreferenceEvent {}

class GetCasteList extends ProfilePreferenceEvent {}

class RemoveCaste extends ProfilePreferenceEvent {}

class RemoveEducation extends ProfilePreferenceEvent {}

class RemoveMaritalStatus extends ProfilePreferenceEvent {}

class RemoveOccupation extends ProfilePreferenceEvent {}

class RemoveReligion extends ProfilePreferenceEvent {}

class RemoveMotherTongue extends ProfilePreferenceEvent {}

class CompletePreference extends ProfilePreferenceEvent {}

class AbilityStatusChanged extends ProfilePreferenceEvent {
  final AbilityStatus abilityStatus;

  AbilityStatusChanged(this.abilityStatus);
}

class CompleteFilter extends ProfilePreferenceEvent {}
