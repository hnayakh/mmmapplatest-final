import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/sign_in/signin_event.dart';
import 'package:makemymarry/bloc/sign_in/signin_state.dart';

import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

class SignInBloc extends Bloc<SignInEvent, SigninState> {
  final UserRepository userRepository;
  String email = '', password = '';

  SignInBloc(this.userRepository) : super(SigninInitialState());

  @override
  Stream<SigninState> mapEventToState(SignInEvent event) async* {
    yield OnLoading();

    if (event is ValidateAndSignin) {
      yield OnLoading();
      this.email = event.email;
      this.password = event.password;
      if (!RegExp(AppConstants.EMAILREGEXP).hasMatch(this.email)) {
        yield OnError("Enter Valid Email");
      } else if (!RegExp(AppConstants.PASSWORDREGEXP).hasMatch(this.password)) {
        yield OnError("Password must be alphanumeric and of size 8 or more.");
      } else {
        var result = await this.userRepository.login(this.email, this.password);
        //or  var result=await this.userRepository.apiClient.signinUser(email, password);
        if (result.status == AppConstants.FAILURE) {
          print('result.status=${result.status}');
          yield OnValidationFail('Entered email and password is incorrect.');
        } else if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails = result.userDetails;

          //await this.userRepository.saveUserDetails();
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          yield OnSignIn(this.userRepository.useDetails!);
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
