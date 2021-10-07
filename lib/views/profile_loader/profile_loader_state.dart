import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class ProfileLoaderState extends BaseEventState {}

class ProfileLoaderInitialState extends ProfileLoaderState {}

class OnLoading extends ProfileLoaderState {}

class OnGotProfiles extends ProfileLoaderState {
  final List<MatchingProfile> list;

  OnGotProfiles(this.list);
}

class OnError extends ProfileLoaderState {
  final String message;

  OnError(this.message);
}
