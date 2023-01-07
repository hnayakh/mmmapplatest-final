import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile_event.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/my_profile/myprofile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileBloc extends Bloc<ProfileEvent, MyProfileState> {
  final UserRepository userRepository;

  int matchingPercentage = 0;
  String images = '';

  MyProfileBloc(
    this.userRepository,
  ) : super(MyProfileInitialState()) {
    loadMyData();
  }

  loadMyData() async {
    var userId =
        (await SharedPreferences.getInstance()).getString(AppConstants.USERID);
    var result = await this
        .userRepository
        .getOtheruserDetails(userId!, ProfileActivationStatus.Verified);

    if (result.status == AppConstants.SUCCESS) {
      add(
        MyProfileFetched(
          userDetails: result.profileDetails,
        ),
      );
    } else {
      add(
        ProfileFetchedError(
          errorMessage: result.message,
        ),
      );
    }
  }

  @override
  Stream<MyProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is MyProfileFetched) {
      yield MyProfileInitialState();
      yield OnProfileFetched(
        userDetails: event.userDetails,
      );
    } else if (event is ProfileFetchedError) {
      yield OnErrorFetch(event.errorMessage);
    }
  }
}
