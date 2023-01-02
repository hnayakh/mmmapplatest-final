import 'package:makemymarry/base_event_state.dart';

class OtpScreenEvent extends BaseEventState {}

class OnOtpverification extends OtpScreenEvent {
  final String email;
  final String otp;

  OnOtpverification(this.email, this.otp);
}

class GenerateOtp extends OtpScreenEvent {
  final String email;

  GenerateOtp(this.email);
}
