import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class FilterEvent extends BaseEventState {}

class OnMaritalFilterSelected extends FilterEvent {
  late final MaritalStatusFilter ms;

  OnMaritalFilterSelected(this.ms);
}

class OnManglikFilterSelected extends FilterEvent {
  late final ManglikFilter isManglik;

  OnManglikFilterSelected(this.isManglik);
}

class OnFoodFilterSelected extends FilterEvent {
  late final EatingHabitFilter foodStatus;

  OnFoodFilterSelected(this.foodStatus);
}

class OnDrinkFilterSelected extends FilterEvent {
  late final DrinkingHabitFilter drinkStatus;

  OnDrinkFilterSelected(this.drinkStatus);
}

class OnSmokeFilterSelected extends FilterEvent {
  late final SmokingHabit smokeStatus;

  OnSmokeFilterSelected(this.smokeStatus);
}

class OnInterestFilterSelected extends FilterEvent {
  late final InterestFilter interestStatus;

  OnInterestFilterSelected(this.interestStatus);
}

class OnEmployeedInFilterSelected extends FilterEvent {
  late final EmployeedInFilter employeedIn;

  OnEmployeedInFilterSelected(this.employeedIn);
}

class OnHeightFilterSelected extends FilterEvent {
  final dynamic height;

  OnHeightFilterSelected(this.height);
}

class OnProfileFilterSelected extends FilterEvent {
  final int profileby;

  OnProfileFilterSelected(this.profileby);
}

class OnDisabilityFilterSelected extends FilterEvent {
  final int disabilityType;

  OnDisabilityFilterSelected(this.disabilityType);
}

class OnReligionFilterSelected extends FilterEvent {
  final SimpleMasterData religion;

  OnReligionFilterSelected(this.religion);
}

class OnCastFilterSelected extends FilterEvent {
  // final CastSubCast cast;
  final String caste;

  OnCastFilterSelected(this.caste);
}

class OnMotherTongueFilterSelected extends FilterEvent {
  final String motherTongue;

  OnMotherTongueFilterSelected(this.motherTongue);
}

class OnGothraFilterSelected extends FilterEvent {
  final dynamic gothra;

  OnGothraFilterSelected(this.gothra);
}

class OnOccupationFilterSelected extends FilterEvent {
  late final String occupation;

  OnOccupationFilterSelected(this.occupation);
}

class OnEducationFilterSelected extends FilterEvent {
  late final String education;

  OnEducationFilterSelected(this.education);
}
