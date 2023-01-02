import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/chat_repo.dart';
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
      // var resultSearch = await this.userRepository.getConnectThroughMMId(mmid);
      // var premium = await this.userRepository.getPremiumMembers();
      // var recentViewed = await this.userRepository.getRecentViews();
      // var profileVisitorList = await this.userRepository.getProfileVisitor();
      // var onlineMembersList = await this.userRepository.getOnlineMembers();
      if (result.status == AppConstants.SUCCESS) {
        this.userRepository.updateRegistrationStep(10);
        var userDetails  = (await this.userRepository.getUserDetails())!;
        getIt<ChatRepo>().updateChatUser(id: userDetails.id, fullName: userDetails.name, imageUrl: "");
        yield OnGotProfiles(result.list, [], [], [], [], []);
      } else {
        yield OnError(result.message);
        // print(result.status);
        // print(result.message);
      }
    }
  }
}
