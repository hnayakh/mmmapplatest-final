import 'package:makemymarry/base_event_state.dart';

class MobileVerificationEvent extends BaseEventState {}

class OnOtpverification extends MobileVerificationEvent {
  final String otp;

  OnOtpverification(this.otp,);
}
class GenerateOtp extends MobileVerificationEvent{

}