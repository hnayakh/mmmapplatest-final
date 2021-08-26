import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'otp_screen_event.dart';
import 'otp_screen_state.dart';

class OtpScreenBloc extends Bloc<OtpScreenEvent, OtpScreenState> {
  final UserRepository userRepository;

  OtpScreenBloc(this.userRepository) : super(OtpScreenInitialState());
  late String otp;
  String email = '';

  @override
  Stream<OtpScreenState> mapEventToState(OtpScreenEvent event) async* {
    yield OnLoading();
    if (event is GenerateOtp) {
      this.email = event.email;
      if (!RegExp(AppConstants.EMAILREGEXP).hasMatch(this.email)) {
        yield OnError("Enter Valid Email");
      } else {
        var result = await this.userRepository.sendOtpEmail(this.email);
        if (result.status == AppConstants.SUCCESS) {
          yield OnOtpGenerated();
        } else {
          yield OnError(result.message);
        }
      }
    }
    if (event is OnOtpverification) {
      this.email = event.email;
      this.otp = event.otp;
      if (event.otp.length != 6) {
        yield OnError('Enter 6-digit otp');
      } else {
        var result =
            await this.userRepository.verifyOtpEmail(this.email, this.otp);

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails = result.userDetails;
          // await this.userRepository.saveUserDetails();
          yield NavigateToReset();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
