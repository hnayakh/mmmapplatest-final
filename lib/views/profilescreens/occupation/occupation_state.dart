import 'package:makemymarry/bloc/base_event_state.dart';

class OccupationState extends BaseEventState {}

class OnLoading extends OccupationState {}

class OnError extends OccupationState {
  final String message;

  OnError(this.message);
}

class OccupationInitialState extends OccupationState {}

class MoveToFamily extends OccupationState {}
