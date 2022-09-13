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
      var mmid = '';
      print('in profileloader');
      var result = await this.userRepository.getMyMatchingProfile();
      var resultSearch = await this.userRepository.getConnectThroughMMId(mmid);
      if (result.status == AppConstants.SUCCESS) {
        this.userRepository.updateRegistrationStep(10);
        // await this
        //     .userRepository
        //     .storageService
        //     .saveUserDetails(this.userRepository.useDetails!);
        print('in profileloader');
        print(this.userRepository.useDetails!.registrationStep);
        print(result.list);
        yield OnGotProfiles(result.list, resultSearch.searchList);
      } else {
        yield OnError(result.message);
        // print(result.status);
        // print(result.message);
      }
    }
  }
}
