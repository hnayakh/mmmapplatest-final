import 'package:makemymarry/bloc/base_event_state.dart';

class ReligionState extends BaseEventState {}

class OnReligionLoading extends ReligionState {}

class OnError extends ReligionState {
  final String message;

  OnError(this.message);
}

class ReligionInitialState extends ReligionState {}

class MoveToCarrer extends ReligionState {}
