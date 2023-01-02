import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';

class SigninState extends BaseEventState {}

class SigninInitialState extends SigninState {}

class OnValidationFail extends SigninState {
  final String message;

  OnValidationFail(this.message);
}

class OnSignIn extends SigninState {
  final UserDetails userDetails;

  OnSignIn(this.userDetails);
}

class OnSigninFailed extends SigninState {}

class OnUserSignOut extends SigninState {}

class OnLoading extends SigninState {}

class OnError extends SigninState {
  final String message;

  OnError(this.message);
}
