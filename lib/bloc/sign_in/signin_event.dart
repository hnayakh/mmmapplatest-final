import 'package:makemymarry/bloc/base_event_state.dart';

class SignInEvent extends BaseEventState {}

class ValidateAndSignin extends SignInEvent {
  final String email, password;

  ValidateAndSignin(this.email, this.password);
}
