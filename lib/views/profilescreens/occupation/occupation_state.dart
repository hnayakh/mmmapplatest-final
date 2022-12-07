import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/master_data.dart';

class OccupationState extends BaseEventState {}

class OnLoading extends OccupationState {}

class OnError extends OccupationState {
  final String message;

  OnError(this.message);
}

class OccupationInitialState extends OccupationState {}

class MoveToFamily extends OccupationState {}

class OnNavigationToMyProfiles extends OccupationState {}

class MoveToFamilyTo extends OccupationState {}

class OnGotCounties extends OccupationState {
  final List<CountryModel> list;

  OnGotCounties(this.list);
}

class OnGotCities extends OccupationState {
  final List<StateModel> list;

  OnGotCities(this.list);
}

class OnGotStates extends OccupationState {
  final List<StateModel> list;

  OnGotStates(this.list);
}

class OccupationDetailsState extends OccupationState {
  late final ProfileDetails profileDetails;
  OccupationDetailsState(this.profileDetails);
}
