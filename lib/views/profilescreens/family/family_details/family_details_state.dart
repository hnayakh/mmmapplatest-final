import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class FamilyDetailState extends BaseEventState {}

class FamilyDetailInitialState extends FamilyDetailState {}

class OnNavigationToMyProfiles extends FamilyDetailState {}

class OnLoading extends FamilyDetailState {}

class OnError extends FamilyDetailState {
  final String message;

  OnError(this.message);
}

class OnFamilyDetailsUpdated extends FamilyDetailState {}

class familyDetailsDataState extends FamilyDetailState {
  late final ProfileDetails profileDetails;
  familyDetailsDataState(this.profileDetails);
}
