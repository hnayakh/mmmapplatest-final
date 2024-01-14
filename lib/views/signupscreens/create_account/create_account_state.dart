import 'package:country_picker/country_picker.dart';
import 'package:makemymarry/base_event_state.dart';

class CreateAccountState extends BaseEventState {}

class CreateAccountInitialState extends CreateAccountState {}

class OnLoading extends CreateAccountState {}

class OnError extends CreateAccountState {
  final String message;

  OnError(this.message);
}

class OnSignUp extends CreateAccountState {}

class OnOtpGenerated extends CreateAccountState {
  final Country? selectedCountry;

  OnOtpGenerated(this.selectedCountry);
}
