import 'package:makemymarry/bloc/base_event_state.dart';
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

class OnUpdate extends FamilyBackgroundEvent {
  final String country, state, city;

  OnUpdate(this.country, this.state, this.city);
}
