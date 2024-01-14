import 'package:makemymarry/base_event_state.dart';

class ForgotPasswordState extends BaseEventState {}

class OnLoading extends ForgotPasswordState {}

class OnError extends ForgotPasswordState {
  final String message;
  OnError(this.message);
}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class MoveToOtpScreen extends ForgotPasswordState {}
