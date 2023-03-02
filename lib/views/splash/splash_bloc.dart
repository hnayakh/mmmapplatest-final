import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/app/bloc/app_bloc.dart';
import 'package:makemymarry/app/bloc/app_event.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/preference_helper.dart';
import 'package:makemymarry/views/splash/splash_event.dart';
import 'package:makemymarry/views/splash/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserRepository userRepository;

  SplashBloc({required this.userRepository})
      : super(SplashScreenInitialState()) {
    on<GetUserEvent>(
      (event, emit) async {
        var result = await this.userRepository.getMasterData();

        if (result.status == AppConstants.SUCCESS) {
          if (result.data != null) {
            getIt<UserRepository>().masterData = result.data!;
          }
          this.userRepository.masterData = result.data!;
          var userDetails = await this.userRepository.getUserDetails();

          getIt<UserRepository>().useDetails = userDetails;
          this.userRepository.useDetails = userDetails;

          List<String> countryPickerList = [];
          for (var country in PreferenceHelper.countryList) {
            countryPickerList.add(country["shortName"]);
          }
          PreferenceHelper.countryPickerList = countryPickerList;

          if (userDetails == null) {
            emit(MoveToLogin());
          } else {
            BlocProvider.of<AppBloc>(navigatorKey.currentContext!)
                .add(SignInEvent(userDetails: this.userRepository.useDetails!));
            emit(MoveToHome());
          }
        } else {
          emit(OnResult(result.status, result.message));
        }
      },
    );
  }
}
