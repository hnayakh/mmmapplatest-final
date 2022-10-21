import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profileviewscreens/profile_view_event.dart';
import 'package:makemymarry/views/profileviewscreens/profile_view_state.dart';

import '../../datamodels/martching_profile.dart';

class ProfileViewBloc extends Bloc<ProfileViewEvent, ProfileViewState> {
  final UserRepository userRepository;
  late ProfileDetails profileDetails;
  late String message = "";

  ProfileViewBloc(this.userRepository, this.profileDetails)
      : super(ProfileViewInitialState());

  @override
  Stream<ProfileViewState> mapEventToState(ProfileViewEvent event) async* {
    if (event is VisitProfile) {
      yield OnLoading();
      this.userRepository.visitProfile(this.profileDetails.id);
      yield OnProfileVisited();
    }
    if (event is GetProfileViewDetails) {
      var result = await this.userRepository.getOtherUserDetailsByDisplayId(
          event.displayId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS &&
          result.message == "User basic details fetched successful.") {
        this.profileDetails = result.profileDetails;
        yield OnGotProfileDetails(result.profileDetails);
      } else {
        this.message = result.message;
        yield OnErrorView(result.message);
      }
    }
  }
}
