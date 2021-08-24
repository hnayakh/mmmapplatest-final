import 'package:makemymarry/bloc/base_event_state.dart';
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

class OnDisabilitySelected extends AboutEvent {
  late final AbilityStatus abilityStatus;

  OnDisabilitySelected(this.abilityStatus);
}

class OnChangeNoOfChildren extends AboutEvent {
  late final NoOfChildren abilityStatus;

  OnChangeNoOfChildren(this.abilityStatus);
}

class OnDOBSelected extends AboutEvent {
  late final String dob;

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

  OnAboutDone(this.name);
}
