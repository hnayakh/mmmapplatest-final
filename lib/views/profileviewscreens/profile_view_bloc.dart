import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/profileviewscreens/profile_view_event.dart';
import 'package:makemymarry/views/profileviewscreens/profile_view_state.dart';

import '../../datamodels/martching_profile.dart';

class ProfileViewBloc extends Bloc<ProfileViewEvent, ProfileViewState> {
  final UserRepository userRepository;
  final ProfileDetails profileDetails;

  ProfileViewBloc(this.userRepository, this.profileDetails)
      : super(ProfileViewInitialState());

  @override
  Stream<ProfileViewState> mapEventToState(ProfileViewEvent event) async* {
    if (event is VisitProfile) {
      yield OnLoading();
      this.userRepository.visitProfile(this.profileDetails.id);
      yield OnProfileVisited();
    }
  }
}
