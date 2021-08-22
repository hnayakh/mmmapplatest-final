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
  String? otp;
  late String email;
  late String dialCode;
  late String mobile;

  @override
  Stream<MobileVerificationState> mapEventToState(
      MobileVerificationEvent event) async* {
    yield OnLoading();

    if (event is OnOtpverification) {
      if (this.otp == null) {
        yield OnError('Enter 4-digit otp');
      } else {
        var result = await this
            .userRepository
            .sendOtp(email, dialCode, mobile, OtpType.Registration, otp!);

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails = result.userDetails;
          // await this.userRepository.saveUserDetails();
          yield OnSignIn();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
