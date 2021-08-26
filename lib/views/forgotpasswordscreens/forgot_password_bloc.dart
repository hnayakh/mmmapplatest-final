import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserRepository userRepository;
  String email = '';

  ForgotPasswordBloc(this.userRepository) : super(ForgotPasswordInitialState());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    yield OnLoading();

    if (event is SendOtpEvent) {
      this.email = event.email;
      if (!RegExp(AppConstants.EMAILREGEXP).hasMatch(this.email)) {
        yield OnError("Enter Valid Email");
      } else {
        var result = await this.userRepository.sendOtpEmail(this.email);

        if (result.status == AppConstants.SUCCESS) {
          // this.userRepository.useDetails = result.userDetails;
          // await this.userRepository.saveUserDetails();
          yield MoveToOtpScreen();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
