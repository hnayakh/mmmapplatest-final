import 'package:makemymarry/bloc/base_event_state.dart';

class MobileVerificationState extends BaseEventState {}

class OnSignIn extends MobileVerificationState {}

class OnError extends MobileVerificationState {
  final String message;
  OnError(this.message);
}

class MobileVerificationInitialState extends MobileVerificationState {}

class OnLoading extends MobileVerificationState {}
class OnOtpGenerated extends MobileVerificationState{

}