import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class FamilyDetailsEvent extends BaseEventState {}

class OnFathersOccupationSelected extends FamilyDetailsEvent {
  final FatherOccupation occupation;

  OnFathersOccupationSelected(this.occupation);
}

class OnMothersOccupationSelected extends FamilyDetailsEvent {
  final MotherOccupation occupation;

  OnMothersOccupationSelected(this.occupation);
}

class ChangeNoOfBrothers extends FamilyDetailsEvent {
  final int change;

  ChangeNoOfBrothers(this.change);
}

class ChangeNoOfSisters extends FamilyDetailsEvent {
  final int change;

  ChangeNoOfSisters(this.change);
}

class ChangeNoOfSistersMarried extends FamilyDetailsEvent {
  final int change;

  ChangeNoOfSistersMarried(this.change);
}

class ChangeNoOfBrothersMarried extends FamilyDetailsEvent {
  final int change;

  ChangeNoOfBrothersMarried(this.change);
}

class UpdateFamilyDetails extends FamilyDetailsEvent {
  final FatherOccupation? fatherOccupation;
  final MotherOccupation? motherOccupation;
  final int noOfBrothers;
  final int noOfSister;
  final int brotherMarried;
  final int sistersMarried;

  UpdateFamilyDetails(
      this.fatherOccupation,
      this.motherOccupation,
      this.noOfBrothers,
      this.noOfSister,
      this.brotherMarried,
      this.sistersMarried);
}

class onFamilyDetailDataLoad extends FamilyDetailsEvent {
  final String basicUserId;

  onFamilyDetailDataLoad(this.basicUserId);
}
