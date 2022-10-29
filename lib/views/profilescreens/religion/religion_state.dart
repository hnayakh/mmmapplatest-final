import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class ReligionState extends BaseEventState {}

class OnReligionLoading extends ReligionState {}

class OnError extends ReligionState {
  final String message;

  OnError(this.message);
}

class ReligionInitialState extends ReligionState {}

class MoveToCarrer extends ReligionState {}

class ReligionDetailsState extends ReligionState {
  late final ProfileDetails profileDetails;
  ReligionDetailsState(this.profileDetails);
}
