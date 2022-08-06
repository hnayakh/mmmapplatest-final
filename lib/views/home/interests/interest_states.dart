import 'package:makemymarry/bloc/base_event_state.dart';

class InterestStates extends BaseEventState {}

class InterestInitialState extends InterestStates {}

class OnLoading extends InterestStates {}

class OnError extends InterestStates {
  final String message;

  OnError(this.message);
}

class OnNavigationToHabits extends InterestStates {}

class OnGotInterestLists extends InterestStates {}
