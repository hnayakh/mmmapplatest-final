import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class ProfileViewState extends BaseEventState {}

class ProfileViewInitialState extends ProfileViewState {}

class OnLoading extends ProfileViewState {}

class OnProfileVisited extends ProfileViewState {}

class OnGotProfileDetails extends ProfileViewState {
  final ProfileDetails profileDetails;

  OnGotProfileDetails(this.profileDetails);
}

class OnErrorView extends ProfileViewState {
  final String message;

  OnErrorView(this.message);
}
