import 'package:country_picker/country_picker.dart';
import 'package:makemymarry/bloc/base_event_state.dart';

class PhoneSigninEvent extends BaseEventState {}

class GenerateOtp extends PhoneSigninEvent {
  final String mobile;

  GenerateOtp( this.mobile);
}

class OnCountrySelected extends PhoneSigninEvent {
  final Country country;

  OnCountrySelected(this.country);
}