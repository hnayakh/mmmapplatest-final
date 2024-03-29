import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/master_data.dart';

class ProfilePreferenceState extends BaseEventState {}

class ProfilePreferenceInitialState extends ProfilePreferenceState {}

class OnLoading extends ProfilePreferenceState {}

class OnError extends ProfilePreferenceState {
  final String message;

  OnError(this.message);
}

class OnUpdate extends ProfilePreferenceState {}

class OnGotCounties extends ProfilePreferenceState {
  final List<CountryModel> list;

  OnGotCounties(this.list);
}

class OnGotStates extends ProfilePreferenceState {
  final List<StateModel> list;

  OnGotStates(this.list);
}

class GetAllCities extends ProfilePreferenceState {}

class OnGotCities extends ProfilePreferenceState {
  final List<List<StateModel>> list;

  OnGotCities(this.list);
}

class OnGotCasteList extends ProfilePreferenceState {
  final List<CastSubCast> caste;
  OnGotCasteList(this.caste);
}

class ProfilePreferenceComplete extends ProfilePreferenceState {}
class ProfilePreferenceUpdated extends ProfilePreferenceState {}

class ProfileFilterComplete extends ProfilePreferenceState {
  final List<MatchingProfile> list;

  ProfileFilterComplete(this.list);
}
