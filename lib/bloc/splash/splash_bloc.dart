import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/splash/splash_event.dart';
import 'package:makemymarry/bloc/splash/splash_state.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserRepository userRepository = UserRepository();

  SplashBloc() : super(SplashScreenInitialState());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    yield OnLoading();
    if (event is GetUserState) {
      var result = await this.userRepository.getMasterData();
      if (result.status == AppConstants.SUCCESS) {
        this.userRepository.masterData = result.data!;
        // var isFirstTimeLogin = await this.userRepository.getHasOpenedBefore();
        // if (isFirstTimeLogin == null) {
        //   //TODO: Update Firsts time
        //   yield MoveToInstructionScreen();
        // } else {
        var userDetails = await this.userRepository.getUserDetails();

        this.userRepository.useDetails = userDetails;
        print(this.userRepository.useDetails!.id);
        //testing only
        // this.userRepository.useDetails!.registrationStep = 5;
        //userDetails = null;

        if (userDetails == null) {
          print('values of relationship');
          for (int i = 0; i < Relationship.values.length; i++) {
            print('$i=${Relationship.values[i]}');
          }

          yield MoveToLogin();
        } else {
          print('movetohome from splash');
          print(this.userRepository.useDetails!.registrationStep);

          // var id = userDetails.id;
          // var profiles = await this.userRepository.getAllUsersProfileData(id);
          // if (profiles.status == AppConstants.SUCCESS) {
          //   this.userRepository.listProfileDetails =
          //       profiles.listProfileDetails;
          // }
          yield MoveToHome();
          //   }
        }
      } else {
        yield OnResult(result.status, result.message);
      }
    }
  }
}
