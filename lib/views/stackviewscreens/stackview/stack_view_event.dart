import 'package:makemymarry/base_event_state.dart';

class StackViewEvent extends BaseEventState {}

class SwipeUpEvent extends StackViewEvent {}

class SwipeDownEvent extends StackViewEvent {}

class LikeOrUnlikeEvent extends StackViewEvent {
  final int likeInfo;
  LikeOrUnlikeEvent(this.likeInfo);
}
