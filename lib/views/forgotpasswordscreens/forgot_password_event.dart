import 'package:makemymarry/bloc/base_event_state.dart';

class ForgotPasswordEvent extends BaseEventState {}

class SendOtpEvent extends ForgotPasswordEvent {
  final String email;
  SendOtpEvent(this.email);
}
