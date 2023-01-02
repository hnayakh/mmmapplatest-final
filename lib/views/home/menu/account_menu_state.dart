import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class AccountMenuState extends BaseEventState {}

class AccountMenuInitialState extends AccountMenuState {}

class OnLoading extends AccountMenuState {}

class OnGotProfile extends AccountMenuState {
  final ProfileDetails profileDetails;
  OnGotProfile(this.profileDetails);
}

class OnError extends AccountMenuState {
  final String message;

  OnError(this.message);
}
