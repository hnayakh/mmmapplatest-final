import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';

import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/signupscreens/create_account/create_account_event.dart';
import 'package:makemymarry/views/signupscreens/create_account/create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final UserRepository userRepository;

  String email = '', password = '', confirmPassword = '', mobile = '';
  Gender? gender = Gender.Male;
  Country selectedCountry = Country.parse("india");
  bool acceptTerms = false;
  Relationship? profileCreatedFor = Relationship.Self;

  CreateAccountBloc(this.userRepository) : super(CreateAccountInitialState());

  @override
  Stream<CreateAccountState> mapEventToState(CreateAccountEvent event) async* {
    yield OnLoading();
    if (event is OnGenderSelected) {
      this.gender = event.gender;
      yield CreateAccountInitialState();
    }
    if (event is OnCountrySelected) {
      this.selectedCountry = event.country;
      yield CreateAccountInitialState();
    }
    if (event is ChangeAcceptTerms) {
      this.acceptTerms = event.isChecked;
      yield CreateAccountInitialState();
    }
    if (event is OnProfileCreatedForSelected) {
      this.profileCreatedFor = event.pos;
      if (event.pos == Relationship.Brother || event.pos == Relationship.Son) {
        this.gender = Gender.Male;
      } else if (event.pos == Relationship.Daughter ||
          event.pos == Relationship.Daughter) {
        this.gender = Gender.Female;
      }
      yield CreateAccountInitialState();
    }
    if (event is OnSignupClicked) {
      this.email = event.email;
      this.password = event.password;
      this.confirmPassword = event.confirmPassword;
      this.mobile = event.mobile;

      if (profileCreatedFor == null) {
        yield OnError("Select Profile Created For");
      } else if (!RegExp(AppConstants.EMAILREGEXP).hasMatch(this.email)) {
        yield OnError("Enter Valid Email");
      } else if (gender == null) {
        yield OnError("Select Gender");
      } else if (mobile.length != 10) {
        yield OnError("Enter Valid Mobile Number");
      } else if (!RegExp(AppConstants.PASSWORDREGEXP).hasMatch(this.password)) {
        yield OnError("Password must be alphanumeric and of size 8 or more.");
      } else if (password != confirmPassword) {
        yield OnError("Password doesn't match");
      } else if (!this.acceptTerms) {
        yield OnError("Accept terms and conditions.");
      } else {
        this.userRepository.useDetails = UserDetails.fromStorage(
          "",
          mobile,
          selectedCountry.phoneCode,
          email,
          this.gender!.index,
          true,
          0,
          0,
          0,
        );
        this.userRepository.useDetails!.relationship = this.profileCreatedFor!;
        this.userRepository.useDetails!.password = this.password;
        var otpResponse = await this.userRepository.sendOtp(
            this.selectedCountry.phoneCode, mobile, OtpType.Registration,
            email: this.email);
        if (otpResponse.status == AppConstants.SUCCESS) {
          yield OnOtpGenerated();
        } else {
          yield OnError(otpResponse.message);
        }
      }
    }
  }
}
