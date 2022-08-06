import 'package:makemymarry/bloc/base_event_state.dart';

class OtpScreenState extends BaseEventState {}

class NavigateToReset extends OtpScreenState {}

class OnError extends OtpScreenState {
  final String message;
  OnError(this.message);
}

class OtpScreenInitialState extends OtpScreenState {}

class OnLoading extends OtpScreenState {}

class OnOtpGenerated extends OtpScreenState {}
