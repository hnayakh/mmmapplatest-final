import 'package:makemymarry/datamodels/martching_profile.dart';

import '../base_event_state.dart';

class HabitState extends BaseEventState {}

class HabitInitialState extends HabitState {}

class OnLoading extends HabitState {}

class OnError extends HabitState {
  final String message;

  OnError(this.message);
}

class NavigationToReligion extends HabitState {}

class NavigationToBio extends HabitState {}

class OnNavigationToMyProfiles extends HabitState {}

class HabitDetailsState extends HabitState {
  late final ProfileDetails profileDetails;
  HabitDetailsState(this.profileDetails);
}
