import 'package:makemymarry/bloc/base_event_state.dart';

class PhoneSigninEvent extends BaseEventState {}

class OnNavigateToMobileVerification extends PhoneSigninEvent {
  final String dialCode;
  final String mobile;

  OnNavigateToMobileVerification(this.dialCode, this.mobile);
}
