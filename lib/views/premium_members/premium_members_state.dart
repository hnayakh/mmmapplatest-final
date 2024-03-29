import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class MatchingProfileState extends BaseEventState {}

class MatchingProfileInitialState extends MatchingProfileState {}

class OnLoading extends MatchingProfileState {}

class OnError extends MatchingProfileState {
  final String message;

  OnError(this.message);
}

class OnMMIDSearch extends MatchingProfileState {
  final searchList;
  OnMMIDSearch(this.searchList);
}

class OnGotProfileDetails extends MatchingProfileState {
  final ProfileDetails profileDetails;

  OnGotProfileDetails(this.profileDetails);
}
