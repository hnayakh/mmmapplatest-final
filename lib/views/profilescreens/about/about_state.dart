import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class AboutState extends BaseEventState {}

class AboutInitialState extends AboutState {}

class ProfileDetailsState extends AboutState {
  late final ProfileDetails profileDetails;
  ProfileDetailsState(this.profileDetails);
}

class OnNavigationToMyProfiles extends AboutState {}

class OnLoading extends AboutState {}

class OnError extends AboutState {
  final String message;

  OnError(this.message);
}

class OnNavigationToHabits extends AboutState {}
