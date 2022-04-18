import 'package:makemymarry/bloc/base_event_state.dart';

class AcceptedStates extends BaseEventState {}

class AcceptedInitialState extends AcceptedStates {}

class OnLoading extends AcceptedStates {}

class OnError extends AcceptedStates {
  final String message;

  OnError(this.message);
}

class EmptyAcceptedListState extends AcceptedStates {}

class AcceptedListIsEmptyState extends AcceptedStates {}

class AcceptedListIsNotEmpty extends AcceptedStates {}
