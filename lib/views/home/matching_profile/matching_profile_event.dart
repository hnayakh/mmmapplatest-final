import 'package:makemymarry/bloc/base_event_state.dart';

class MatchingProfileEvent extends BaseEventState {}

class GetProfileDetails extends MatchingProfileEvent {
  final int pos;

  GetProfileDetails(this.pos);
}

class IsLikedAEvent extends MatchingProfileEvent {
  final int index;
  IsLikedAEvent(this.index);
}
