import 'package:makemymarry/base_event_state.dart';

class MyProfileState extends BaseEventState {}

class OnProfileFetched extends MyProfileState {}

class MyProfileInitialState extends MyProfileState {}

// class OnLoading extends MatchingPercentageState {}

// class OnProfileVisited extends MatchingPercentageState {
//   final int matchingPercentage;
//   final String images;
//   OnProfileVisited(this.matchingPercentage, this.images);
// }

class OnErrorFetch extends MyProfileState {
  final String message;

  OnErrorFetch(this.message);
}
