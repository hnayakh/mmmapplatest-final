import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'phone_event.dart';
import 'phone_state.dart';

class PhoneSigninBloc extends Bloc<PhoneSigninEvent, PhoneSigninState> {
  late final UserRepository userRepository;

  PhoneSigninBloc(this.userRepository) : super(PhoneSigninInitialState());

  late String mobile;
  Country selectedCountry = Country.parse("india");

  @override
  Stream<PhoneSigninState> mapEventToState(PhoneSigninEvent event) async* {
    yield OnLoading();
    if (event is OnCountrySelected) {
      this.selectedCountry = event.country;
      yield PhoneSigninInitialState();
    }
    if (event is GenerateOtp) {
      this.mobile = event.mobile;

      var result = await this.userRepository.sendOtp(
            this.selectedCountry.phoneCode,
            this.mobile,OtpType.Login
          );

      if (result.status == AppConstants.SUCCESS) {
        yield MoveToMobileVerification();
      } else {
        yield OnError(result.message);
      }
    }
  }
}
