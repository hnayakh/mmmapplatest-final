import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference_events.dart';

import 'profile_preference_state.dart';

class ProfilePreferenceBloc
    extends Bloc<ProfilePreferenceEvent, ProfilePreferenceState> {
  final UserRepository userRepository;
  late double minAge;
  late double maxAge;
  late double minHeight;
  late double maxHeight;

  ProfilePreferenceBloc(this.userRepository)
      : super(ProfilePreferenceInitialState()) {
    this.minAge = 18;
    this.maxAge = 100;
    this.minHeight = 4.5;
    this.maxAge = 8.0;
  }

  @override
  Stream<ProfilePreferenceState> mapEventToState(
      ProfilePreferenceEvent event) async* {
    yield OnLoading();
  }
}
