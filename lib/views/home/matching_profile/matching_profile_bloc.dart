import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_event.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_state.dart';

class MatchingProfileBloc
    extends Bloc<MatchingProfileEvent, MatchingProfileState> {
  final UserRepository userRepository;
  List<MatchingProfile> list;
  int selectedPos = 0;

  MatchingProfileBloc(this.userRepository, this.list)
      : super(MatchingProfileInitialState());

  @override
  Stream<MatchingProfileState> mapEventToState(
      MatchingProfileEvent event) async* {
    yield OnLoading();
    if (event is GetProfileDetails) {
      var result = await this
          .userRepository
          .getOtheruserDetails(this.list[event.pos].id);

      if (result.status == AppConstants.SUCCESS) {
        yield OnGotProfileDetails(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }
  }
}
