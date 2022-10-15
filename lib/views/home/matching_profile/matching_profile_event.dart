import 'package:makemymarry/bloc/base_event_state.dart';

class MatchingProfileEvent extends BaseEventState {}

class GetProfileDetails extends MatchingProfileEvent {
  final int pos;

  GetProfileDetails(this.pos);
}

class GetMyConnects extends MatchingProfileEvent {}

class OnSearchByMMID extends MatchingProfileEvent {
  final String? mmmId;
  OnSearchByMMID(this.mmmId);
}

class GetPremiumMembers extends MatchingProfileEvent {}

class GetRecentViewMembers extends MatchingProfileEvent {}

class GetProfileVisited extends MatchingProfileEvent {}

class GetOnlineMembers extends MatchingProfileEvent {}

class IsLikedAEvent extends MatchingProfileEvent {
  final int index;
  IsLikedAEvent(this.index);
}
