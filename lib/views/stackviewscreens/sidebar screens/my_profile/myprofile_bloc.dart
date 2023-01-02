import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile_event.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile_state.dart';

class MyProfileBloc extends Bloc<ProfileEvent, MyProfileState> {
  final UserRepository userRepository;
  final ProfileDetails profileDetails;

  int matchingPercentage = 0;
  String images = '';

  MyProfileBloc(this.userRepository, this.profileDetails)
      : super(MyProfileInitialState());

  @override
  Stream<MyProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is MyProfileFetch) {
      print("Details...");
      print(profileDetails);
      //yield OnLoading();
      var response =
          await this.userRepository.getMatchPercentage(this.profileDetails.id);
      if (response.status == AppConstants.SUCCESS) {
        this.matchingPercentage = response.percent;
        this.images = this.profileDetails.images[0];
        yield OnProfileFetched();
      } else {
        yield OnErrorFetch(response.message);
      }
    }

    // if (event is MatchProfileImages) {
    //   //yield OnLoading();
    //   var response =
    //       await this.userRepository.getMatchPercentage(this.profileDetails.id);
    //   if (response.status == AppConstants.SUCCESS) {
    //     this.matchingPercentage = response.percent;
    //     yield OnProfileVisited(
    //         this.matchingPercentage, this.profileDetails.images[0]);
    //   } else {
    //     yield OnError(response.message);
    //   }
    // }
  }
}
