import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class AboutEvent extends BaseEventState {}

class OnMaritalStatusSelected extends AboutEvent {
  late final MaritalStatus ms;

  OnMaritalStatusSelected(this.ms);
}

class OnHeightStatusSelected extends AboutEvent {
  final int height;

  OnHeightStatusSelected(this.height);
}

class OnChildrenSelected extends AboutEvent {
  late final ChildrenStatus childrenStatus;

  OnChildrenSelected(this.childrenStatus);
}

class onAboutDataLoad extends AboutEvent {
  final String basicUserId;

  onAboutDataLoad(this.basicUserId);
}

class OnDisabilitySelected extends AboutEvent {
  late final AbilityStatus abilityStatus;

  OnDisabilitySelected(this.abilityStatus);
}

class OnChangeNoOfChildren extends AboutEvent {
  final NoOfChildren noOfChildren;

  OnChangeNoOfChildren(this.noOfChildren);
}

class OnDOBSelected extends AboutEvent {
  late final DateTime dob;

  OnDOBSelected(this.dob);
}

class OnNavigationButtonClicked extends AboutEvent {
  late final String name;
  late final MaritalStatus ms;
  late final int height;
  late final ChildrenStatus childrenStatus;
  late final AbilityStatus abilityStatus;
  late final String dob;

  OnNavigationButtonClicked(this.name, this.ms, this.height,
      this.childrenStatus, this.abilityStatus, this.dob);
}

class OnAboutDone extends AboutEvent {
  final String name;
  final MaritalStatus maritalStatus;
  final int heightStatus;
  final ChildrenStatus childrenStatus;
  final DateTime dateOfBirth;
  final AbilityStatus abilityStatus;
  bool isAnUpdate;
  OnAboutDone(
      this.name,
      this.maritalStatus,
      this.heightStatus,
      this.childrenStatus,
      this.dateOfBirth,
      this.abilityStatus,
      this.isAnUpdate);
}
