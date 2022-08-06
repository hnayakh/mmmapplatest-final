import 'package:makemymarry/bloc/base_event_state.dart';

class VerifyState extends BaseEventState {}

class VerifyInitialState extends VerifyState {}

class OnLoading extends VerifyState {}

class OnError extends VerifyState {
  final String message;

  OnError(this.message);
}
