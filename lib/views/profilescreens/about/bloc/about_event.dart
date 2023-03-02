import 'package:makemymarry/utils/mmm_enums.dart';

class AboutEvent  {}

class OnMaritalStatusSelected extends AboutEvent {
  late final MaritalStatus ms;

  OnMaritalStatusSelected(this.ms);
}
class OnNameChanged extends AboutEvent {
  late final String name;

  OnNameChanged(this.name);
}

class OnHeightStatusSelected extends AboutEvent {
  final int height;

  OnHeightStatusSelected(this.height);
}

class OnChildrenSelected extends AboutEvent {
  late final ChildrenStatus childrenStatus;

  OnChildrenSelected(this.childrenStatus);
}

class OnAboutDataLoad extends AboutEvent {
  final String basicUserId;

  OnAboutDataLoad(this.basicUserId);
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

// class OnNavigationButtonClicked extends AboutEvent {
//   late final String name;
//   late final MaritalStatus ms;
//   late final int height;
//   late final ChildrenStatus childrenStatus;
//   late final AbilityStatus abilityStatus;
//   late final String dob;
//
//   OnNavigationButtonClicked(this.name, this.ms, this.height,
//       this.childrenStatus, this.abilityStatus, this.dob);
// }

class OnAboutDone extends AboutEvent{

  final bool isAnUpdate;

  OnAboutDone(this.isAnUpdate);

}
