import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class OccupationEvent extends BaseEventState {}

class OnOccupationSelected extends OccupationEvent {
  final String occupation;

  OnOccupationSelected(this.occupation);
}

class OnAnnualIncomeSelected extends OccupationEvent {
  final AnualIncome income;

  OnAnnualIncomeSelected(this.income);
}

class OnEducationSelected extends OccupationEvent {
  final String education;

  OnEducationSelected(this.education);
}

class UpdateCareer extends OccupationEvent {
  final String occupation;
  final AnualIncome anualIncome;
  final String education;
  final StateModel myState;
  final StateModel city;
  // final String name;
  // final String income;
  // final String country;
  // final String stateName;
  // final String city;
  bool isAnUpdate;

  // UpdateCareer(this.name, this.income, this.country, this.stateName, this.city,
  //     this.isAnUpdate);
  UpdateCareer(this.occupation, this.anualIncome, this.education, this.myState,
      this.city, this.isAnUpdate);
}

class GetAllCountries extends OccupationEvent {}

class OnCountrySelected extends OccupationEvent {
  final CountryModel countryModel;

  OnCountrySelected(this.countryModel);
}

class GetAllStates extends OccupationEvent {}

class OnStateSelected extends OccupationEvent {
  final StateModel stateModel;

  OnStateSelected(this.stateModel);
}

class GetAllCities extends OccupationEvent {}

class OnCitySelected extends OccupationEvent {
  final StateModel stateModel;

  OnCitySelected(this.stateModel);
}

class onOccupationDataLoad extends OccupationEvent {
  final String basicUserId;

  onOccupationDataLoad(this.basicUserId);
}
