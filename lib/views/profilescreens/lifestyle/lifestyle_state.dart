import 'package:makemymarry/datamodels/martching_profile.dart';

import '../../../base_event_state.dart';
import 'lifestyle_event.dart';

class LifeStyleState  {}


class LifeStyleIdleState extends LifeStyleState {
  final LifeStyleData data;

  LifeStyleIdleState({
    required this.data,
  });
}

class LifeStyleInitialState extends LifeStyleState {
  final LifeStyleData data;

  LifeStyleInitialState({
    this.data = const LifeStyleData(
        openToPets: false,
        ownsCar: false,
        ownsHouse: false,
        ownsTwoWheeler: false,
        ownsBusiness: false,
        haveOther: false),
  });
}

class LifeStyleLoadingState extends LifeStyleState {}

class LifeStyleErrorState extends LifeStyleState {
  final String message;

  LifeStyleErrorState(this.message);
}

class NavigationToReligion extends LifeStyleState {}

class NavigationToBio extends LifeStyleState {}

class NavigateToMyProfile extends LifeStyleState {}
