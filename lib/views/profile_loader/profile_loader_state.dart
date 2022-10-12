import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class ProfileLoaderState extends BaseEventState {}

class ProfileLoaderInitialState extends ProfileLoaderState {}

class OnLoading extends ProfileLoaderState {}

class OnGotProfiles extends ProfileLoaderState {
  final List<MatchingProfile> list;
  final List<MatchingProfile> premiumList;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile> recentViewList;

  OnGotProfiles(
      this.list, this.searchList, this.premiumList, this.recentViewList);
}

class OnError extends ProfileLoaderState {
  final String message;

  OnError(this.message);
}
