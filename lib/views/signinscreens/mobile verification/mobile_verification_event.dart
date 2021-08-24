import 'package:makemymarry/bloc/base_event_state.dart';

class MobileVerificationEvent extends BaseEventState {}

class OnOtpverification extends MobileVerificationEvent {
  final String otp;

  final String dialCode;
  final String mobile;
  OnOtpverification(this.otp, this.dialCode, this.mobile);
}
