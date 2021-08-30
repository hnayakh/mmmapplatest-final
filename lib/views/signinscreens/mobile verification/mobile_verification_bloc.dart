import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/forgotpasswordscreens/otp_screen.dart';

import 'mobile_verification_event.dart';
import 'mobile_verification_state.dart';

class MobileVerificationBloc
    extends Bloc<MobileVerificationEvent, MobileVerificationState> {
  final UserRepository userRepository;
  final String dialCode;
  final String mobile;
  final OtpType otpType;

  MobileVerificationBloc(
      this.userRepository, this.dialCode, this.mobile, this.otpType)
      : super(MobileVerificationInitialState());
  late String otp;
  String email = '';

  @override
  Stream<MobileVerificationState> mapEventToState(
      MobileVerificationEvent event) async* {
    yield OnLoading();
    if (event is GenerateOtp) {
      var result = await this
          .userRepository
          .sendOtp(this.dialCode, this.mobile, OtpType.Login);
      if (result.status == AppConstants.SUCCESS) {
        yield OnOtpGenerated();
      } else {
        yield OnError(result.message);
      }
    }
    if (event is OnOtpverification) {
      this.otp = event.otp;
      if (event.otp.length != 6) {
        yield OnError('Enter 6-digit otp');
      } else {
        var result = await this
            .userRepository
            .verifyOtp(this.dialCode, this.mobile, this.otpType, this.otp);

        if (result.status == AppConstants.SUCCESS) {
          if (otpType != OtpType.Registration)
            this.userRepository.useDetails = result.userDetails;
          // await this.userRepository.saveUserDetails();
          if (this.otpType == OtpType.Registration) {
            UserDetails userDetails = this.userRepository.useDetails!;
            var result = await this.userRepository.register(
                userDetails.relationship.index,
                userDetails.email,
                userDetails.dialCode,
                userDetails.mobile,
                Gender.values[userDetails.gender],
                userDetails.password);
            if (result.status == AppConstants.SUCCESS) {
              this.userRepository.useDetails = result.userDetails;
              this.userRepository.saveUserDetails();
              yield OnRegister();
            }
          } else {
            yield OnSignIn();
          }
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
