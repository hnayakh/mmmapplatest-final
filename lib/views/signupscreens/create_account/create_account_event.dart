import 'package:country_picker/country_picker.dart';
import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class CreateAccountEvent extends BaseEventState {}

class OnProfileCreatedForSelected extends CreateAccountEvent {
  final Relationship pos;

  OnProfileCreatedForSelected(this.pos);
}

class OnGenderSelected extends CreateAccountEvent {
  final Gender gender;

  OnGenderSelected(this.gender);
}

class OnCountrySelected extends CreateAccountEvent {
  final Country country;

  OnCountrySelected(this.country);
}

class ChangeAcceptTerms extends CreateAccountEvent {
  final bool isChecked;

  ChangeAcceptTerms(this.isChecked);
}

class OnSignupClicked extends CreateAccountEvent {
  final String email, password, confirmPassword, mobile;

  OnSignupClicked(this.email, this.password, this.confirmPassword, this.mobile);
}
