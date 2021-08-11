import 'package:makemymarry/bloc/base_event_state.dart';

class SignInEvent extends BaseEventState {}

class ValidateAndSignin extends BaseEventState {
  final String email, password;

  ValidateAndSignin(this.email, this.password);
}
