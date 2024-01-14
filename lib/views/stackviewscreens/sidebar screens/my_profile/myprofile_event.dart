import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class ProfileEvent extends BaseEventState {}

class MyProfileFetched extends ProfileEvent {
  final ProfileDetails userDetails;

  MyProfileFetched({required this.userDetails});



}


class ProfileFetchedError extends ProfileEvent {
  final String errorMessage;

  ProfileFetchedError({required this.errorMessage});



}
