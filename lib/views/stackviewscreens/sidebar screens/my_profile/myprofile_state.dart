import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class MyProfileState extends BaseEventState {}

class MyProfileInitialState extends MyProfileState {}

class OnProfileFetched extends MyProfileState {
  final ProfileDetails userDetails;

  OnProfileFetched({required this.userDetails});

}

class OnErrorFetch extends MyProfileState {
  final String message;

  OnErrorFetch(this.message);
}
