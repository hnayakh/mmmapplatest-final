import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';

class OccupationEvent extends BaseEventState {}

class OnOccupationSelected extends OccupationEvent {
  final String occupation;

  OnOccupationSelected(this.occupation);
}

class OnEducationSelected extends OccupationEvent {
  final String education;

  OnEducationSelected(this.education);
}

class UpdateCareer extends OccupationEvent {
  final String name;
  final String income;
  final String country;
  final String stateName;
  final String city;

  UpdateCareer(
    this.name,
    this.income,
    this.country,
    this.stateName,
    this.city,
  );
}
