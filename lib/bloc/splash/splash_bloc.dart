import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/splash/splash_event.dart';
import 'package:makemymarry/bloc/splash/splash_state.dart';
import 'package:makemymarry/repo/user_repo.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserRepository userRepository = UserRepository();

  SplashBloc() : super(SplashScreenInitialState());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    yield OnLoading();
    if (event is GetUserState) {
      var isFirstTimeLogin = await this.userRepository.getHasOpenedBefore();
      if (isFirstTimeLogin == null) {
        //TODO: Update Firsts time
        yield MoveToInstructionScreen();
      } else {
        var userId = await this.userRepository.getUserDetails();
        if (userId == null) {
          yield MoveToLogin();
        } else {
          yield MoveToHome();
        }
      }
    }
  }
}
