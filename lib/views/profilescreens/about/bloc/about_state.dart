import '../../../../utils/mmm_enums.dart';

class AboutState  {}

class AboutInitialState extends AboutState {}

class AboutIdleState extends AboutState {
  final MaritalStatus? maritalStatus;
  final AbilityStatus? abilityStatus;
  final ChildrenStatus? childrenStatus;
  final NoOfChildren? noOfChildren;
  final int? heightStatus;
  final DateTime? dateOfBirth;
  final String? name;
  AboutIdleState({
    required this.maritalStatus,
    required this.abilityStatus,
    required this.childrenStatus,
    required this.noOfChildren,
    required this.heightStatus,
    required this.dateOfBirth,
    required this.name,
  });

  AboutIdleState copyWith({
    MaritalStatus? maritalStatus,
    AbilityStatus? abilityStatus,
    ChildrenStatus? childrenStatus,
    NoOfChildren? noOfChildren,
    int? heightStatus,
    DateTime? dateOfBirth,
    String? name,
  }) =>
      AboutIdleState(
          maritalStatus: maritalStatus ?? this.maritalStatus,
          abilityStatus: abilityStatus ?? this.abilityStatus,
          childrenStatus: childrenStatus ?? this.childrenStatus,
          noOfChildren: noOfChildren ?? this.noOfChildren,
          heightStatus: heightStatus ?? this.heightStatus,
          dateOfBirth: dateOfBirth ?? this.dateOfBirth,
          name: name ?? this.name);
}

class OnNavigationToMyProfiles extends AboutState {}

class OnLoading extends AboutState {}

class OnError extends AboutState {
  final String message;

  OnError(this.message);
}

class OnNavigationToHabits extends AboutState {}
