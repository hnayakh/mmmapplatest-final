import 'package:makemymarry/bloc/base_event_state.dart';

class SigninState extends BaseEventState{

}
class SigninInitialState extends SigninState{

}
class OnValidationFail extends SigninState{
  final String message;

  OnValidationFail(this.message);
}
class OnSignIn extends SigninState{

}
class OnSigninFailed extends SigninState{

}