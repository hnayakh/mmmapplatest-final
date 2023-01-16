import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/views/profilescreens/hobbies/hobby_details_view.dart';

import '../../../base_event_state.dart';
import 'hobby_event.dart';

class HobbyState {}

class HobbyIdleState extends HobbyState {
  final HobbyData data;

  HobbyIdleState({
    required this.data,
  });
}

class HobbyInitialState extends HobbyState {
  final HobbyData data;

  HobbyInitialState({
    this.data = const HobbyData(hobbies: <HobbyType>[]),
  });
}

class HobbyLoadingState extends HobbyState {}

class HobbyErrorState extends HobbyState {
  final String message;

  HobbyErrorState(this.message);
}

class NavigationToReligion extends HobbyState {}

class NavigationToBio extends HobbyState {}

class NavigateToMyProfile extends HobbyState {}
