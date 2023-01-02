import 'package:makemymarry/base_event_state.dart';

class SignInEvent extends BaseEventState {}

class ValidateAndSignin extends SignInEvent {
  final String email, password;

  ValidateAndSignin(this.email, this.password);
}

class UserLoggedOut extends SignInEvent {}
