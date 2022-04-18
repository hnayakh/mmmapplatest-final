import 'package:makemymarry/bloc/base_event_state.dart';

class ReceivedStates extends BaseEventState {}

class ReceivedInitialState extends ReceivedStates {}

class OnLoading extends ReceivedStates {}

class OnError extends ReceivedStates {
  final String message;

  OnError(this.message);
}

class EmptyReceivedListState extends ReceivedStates {}

class ListIsEmptyState extends ReceivedStates {}

class ListIsNotEmpty extends ReceivedStates {}
