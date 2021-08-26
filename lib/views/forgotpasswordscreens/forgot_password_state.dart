import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/views/profilescreens/occupation/occupation_event.dart';

class ForgotPasswordState extends BaseEventState {}

class OnLoading extends ForgotPasswordState {}

class OnError extends ForgotPasswordState {
  final String message;
  OnError(this.message);
}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class MoveToOtpScreen extends ForgotPasswordState {}
