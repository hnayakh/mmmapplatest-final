import 'package:makemymarry/bloc/base_event_state.dart';

class PhoneSigninState extends BaseEventState {}

class PhoneSigninInitialState extends PhoneSigninState {}

class OnLoading extends PhoneSigninState {}

class OnError extends PhoneSigninState {
  final String message;

  OnError(this.message);
}

class MoveToMobileVerification extends PhoneSigninState {}
