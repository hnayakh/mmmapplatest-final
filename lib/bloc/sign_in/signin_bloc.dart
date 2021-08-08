import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/sign_in/signin_event.dart';
import 'package:makemymarry/bloc/sign_in/signin_state.dart';
import 'package:makemymarry/repo/user_repo.dart';

class SignInBloc extends Bloc<SignInEvent, SigninState> {
  final UserRepository userRepository;

  SignInBloc(this.userRepository) : super(SigninInitialState());

  @override
  Stream<SigninState> mapEventToState(SignInEvent event) async* {
    if(event is ValidateAndSignin){

    }
  }
}
