import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class ProfilePreferenceEvent extends BaseEventState {}

class CountrySelected extends ProfilePreferenceEvent {
  final CountryModel countryModel;

  CountrySelected(this.countryModel);
}

class OnStateSelected extends ProfilePreferenceEvent {
  final StateModel stateModel;

  OnStateSelected(this.stateModel);
}

class OnReligionSelected extends ProfilePreferenceEvent {
  final SimpleMasterData data;

  OnReligionSelected(this.data);
}

class OnSubCastSelected extends ProfilePreferenceEvent {
  final dynamic caste;

  OnSubCastSelected(this.caste);
}

class OnMotherTongueSelected extends ProfilePreferenceEvent {
  final SimpleMasterData motherTongue;

  OnMotherTongueSelected(this.motherTongue);
}

class OnEducationSelected extends ProfilePreferenceEvent {
  final String title;

  OnEducationSelected(this.title);
}

class OnOccupationSelected extends ProfilePreferenceEvent {
  final String title;

  OnOccupationSelected(this.title);
}

class ImcomeSelected extends ProfilePreferenceEvent {}

class DietrySelected extends ProfilePreferenceEvent {}

class DrinkingSelected extends ProfilePreferenceEvent {}

class SmokingSelected extends ProfilePreferenceEvent {}

class ChallengedSelected extends ProfilePreferenceEvent {}

class OnMaritalStatusSelected extends ProfilePreferenceEvent {
  final MaritalStatus status;

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
  final StateModel stateModel;

  OnCitySelected(this.stateModel);
}
