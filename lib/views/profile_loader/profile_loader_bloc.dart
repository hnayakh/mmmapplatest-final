import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/profile_loader/profile_loader_event.dart';
import 'package:makemymarry/views/profile_loader/profile_loader_state.dart';

class ProfileLoaderBloc extends Bloc<ProfileLoaderEvent, ProfileLoaderState> {
  final UserRepository userRepository;

  ProfileLoaderBloc(this.userRepository) : super(ProfileLoaderInitialState());

  @override
  Stream<ProfileLoaderState> mapEventToState(ProfileLoaderEvent event) async* {
    yield OnLoading();
    if (event is GetProfiles) {
      var result = await this.userRepository.getMyMatchingProfile();
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotProfiles(result.list);
      } else {
        yield OnError(result.message);
      }
    }
  }
}
