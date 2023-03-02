import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/views/home/matching_profile/views/matching_profile.dart';

class MatchingProfileState  {

  final bool isStack;
  final ProfilesFilter currentFilter;

  MatchingProfileState({this.isStack = false, this.currentFilter = ProfilesFilter.recommendedProfile});
}

class MatchingProfileInitialState extends MatchingProfileState {

  final List<MatchingProfile> list;
  MatchingProfileInitialState(this.list);

}

class OnLoading extends MatchingProfileState {}

class OnGotProfiles extends MatchingProfileState {
  final List<MatchingProfile> list;
  OnGotProfiles(this.list, bool isStack,ProfilesFilter currentFilter):super(isStack: isStack,currentFilter: currentFilter) ;
}

class OnError extends MatchingProfileState {
  final String message;

  OnError(this.message);
}


class OnMMIDSearch extends MatchingProfileState {
  final searchList;
  OnMMIDSearch(this.searchList);
}
