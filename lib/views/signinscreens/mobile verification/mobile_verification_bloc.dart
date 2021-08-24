import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'mobile_verification_event.dart';
import 'mobile_verification_state.dart';

class MobileVerificationBloc
    extends Bloc<MobileVerificationEvent, MobileVerificationState> {
  late final UserRepository userRepository;

  MobileVerificationBloc(this.userRepository)
      : super(MobileVerificationInitialState());
  late String otp;
  late String email;
  late String dialCode;
  late String mobile;

  @override
  Stream<MobileVerificationState> mapEventToState(
      MobileVerificationEvent event) async* {
    yield OnLoading();

    if (event is OnOtpverification) {
      this.dialCode = event.dialCode;
      this.otp = event.otp;
      this.mobile = event.mobile;
      if (event.otp.length != 6) {
        yield OnError('Enter 6-digit otp');
      } else {
        var result = await this
            .userRepository
            .verifyOtp(this.dialCode, this.mobile, OtpType.Login, this.otp);

        if (result.status == AppConstants.SUCCESS) {
          // this.userRepository.useDetails = result.userDetails;
          // await this.userRepository.saveUserDetails();
          yield OnSignIn();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
