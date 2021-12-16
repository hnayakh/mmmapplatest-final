import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class ProfilePreferenceEvent extends BaseEventState {}

class CountrySelected extends ProfilePreferenceEvent {
  final CountryModel countryModel;

  CountrySelected(this.countryModel);
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

class RemoveIncome extends ProfilePreferenceEvent {}

class DietrySelected extends ProfilePreferenceEvent {
  final EatingHabit eatingHabit;

  DietrySelected(this.eatingHabit);
}

class DrinkingSelected extends ProfilePreferenceEvent {
  final DrinkingHabit drinkingHabit;

  DrinkingSelected(this.drinkingHabit);
}

class SmokingSelected extends ProfilePreferenceEvent {
  final SmokingHabit smokingHabit;

  SmokingSelected(this.smokingHabit);
}

class ChallengedSelected extends ProfilePreferenceEvent {}

class OnMaritalStatusSelected extends ProfilePreferenceEvent {
  final List<MaritalStatus> status;

  OnMaritalStatusSelected(this.status);
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

class GetMyCities extends ProfilePreferenceEvent {}

class OnCitySelected extends ProfilePreferenceEvent {
  final List<StateModel?> cityModel;

  OnCitySelected(this.cityModel);
}

class RemoveCountry extends ProfilePreferenceEvent {}

class RemoveState extends ProfilePreferenceEvent {}

class RemoveCity extends ProfilePreferenceEvent {}

class RemoveSmoking extends ProfilePreferenceEvent {}

class RemoveEating extends ProfilePreferenceEvent {}

class RemoveDrinking extends ProfilePreferenceEvent {}

class GetCasteList extends ProfilePreferenceEvent {}

class RemoveCaste extends ProfilePreferenceEvent {}

class RemoveEducation extends ProfilePreferenceEvent {}

class RemoveOccupation extends ProfilePreferenceEvent {}
class CompletePreference extends ProfilePreferenceEvent{

}
class AbilityStatusChanged extends ProfilePreferenceEvent{
  final AbilityStatus abilityStatus;

  AbilityStatusChanged(this.abilityStatus);
}