import 'package:makemymarry/bloc/base_event_state.dart';

class SentStates extends BaseEventState {}

class SentInitialState extends SentStates {}

class OnLoading extends SentStates {}

class OnError extends SentStates {
  final String message;

  OnError(this.message);
}

class SentListisEmpty extends SentStates {}

class SentListIsNotEmpty extends SentStates {}
