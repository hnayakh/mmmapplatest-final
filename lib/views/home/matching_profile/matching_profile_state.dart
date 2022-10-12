import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class MatchingProfileState extends BaseEventState {}

class MatchingProfileInitialState extends MatchingProfileState {}

class OnLoading extends MatchingProfileState {}

class OnGotPremium extends MatchingProfileState {
  final List<MatchingProfile> list;
  OnGotPremium(this.list);
}

class OnGotRecentView extends MatchingProfileState {
  final List<MatchingProfile> list;
  OnGotRecentView(this.list);
}

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
