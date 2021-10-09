import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class FamilyBackgroundEvent extends BaseEventState {}

class OnFamilyStatusSelected extends FamilyBackgroundEvent {
  final FamilyAfluenceLevel level;

  OnFamilyStatusSelected(this.level);
}

class OnFamilyValueSelected extends FamilyBackgroundEvent {
  final FamilyValues value;

  OnFamilyValueSelected(this.value);
}

class OnFamilyTypeChanges extends FamilyBackgroundEvent {
  final FamilyType familyType;

  OnFamilyTypeChanges(this.familyType);
}

class UpdateFamilyBackground extends FamilyBackgroundEvent {
}

class GetAllCountries extends FamilyBackgroundEvent {}

class OnCountrySelected extends FamilyBackgroundEvent {
  final CountryModel countryModel;

  OnCountrySelected(this.countryModel);
}

class GetAllStates extends FamilyBackgroundEvent {}

class OnStateSelected extends FamilyBackgroundEvent {
  final StateModel stateModel;

  OnStateSelected(this.stateModel);
}

class GetAllCities extends FamilyBackgroundEvent {}

class OnCitySelected extends FamilyBackgroundEvent {
  final StateModel stateModel;

  OnCitySelected(this.stateModel);
}
class OnStayingWithParentsChanged extends FamilyBackgroundEvent{
  final bool isStayingWithParents;

  OnStayingWithParentsChanged(this.isStayingWithParents);
}