import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/app/bloc/app_bloc.dart';
import 'package:makemymarry/app/bloc/app_event.dart';
import 'package:makemymarry/views/splash/splash_event.dart';
import 'package:makemymarry/views/splash/splash_state.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/preference_helper.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserRepository userRepository;



  SplashBloc({required this.userRepository}) : super(SplashScreenInitialState()){
    on<GetUserEvent>((event, emit) async {
      var result = await this.userRepository.getMasterData();
      if (result.status == AppConstants.SUCCESS) {
        this.userRepository.masterData = result.data!;
        // var isFirstTimeLogin = await this.userRepository.getHasOpenedBefore();
        // if (isFirstTimeLogin == null) {
        //   //TODO: Update Firsts time
        //   yield MoveToInstructionScreen();
        // } else {
        var userDetails = await this.userRepository.getUserDetails();

        getIt<UserRepository>().useDetails = userDetails;
        this.userRepository.useDetails = userDetails;
        //print(this.userRepository.useDetails!.id);
        //testing only
        // this.userRepository.useDetails!.registrationStep = 5;
        // userDetails = null;

        List<String> countryPickerList = [];
        for (var country in PreferenceHelper.countryList) {
          countryPickerList.add(country["shortName"]);
        }
        PreferenceHelper.countryPickerList = countryPickerList;
        print('country picker list');
        print(PreferenceHelper.countryPickerList);

        if (userDetails == null) {
          // print('values of relationship');
          // for (int i = 0; i < Relationship.values.length; i++) {
          //   print('$i=${Relationship.values[i]}');
          // }

          emit(MoveToLogin());
        } else {
          BlocProvider.of<AppBloc>(navigatorKey.currentContext!).add(SignInEvent(userDetails: this.userRepository.useDetails!));
          print('movetohome from splash');
          print(this.userRepository.useDetails!.registrationStep);

          // var id = userDetails.id;
          // var profiles = await this.userRepository.getAllUsersProfileData(id);
          // if (profiles.status == AppConstants.SUCCESS) {
          //   this.userRepository.listProfileDetails =
          //       profiles.listProfileDetails;
          // }
           emit(MoveToHome());
          //   }
        }
      } else {
         emit(OnResult(result.status, result.message));
      }
    });
  }

  // @override
  // Stream<SplashState> mapEventToState(SplashEvent event) async* {
  //
  //   if (event is GetUserState)
  // }
}
