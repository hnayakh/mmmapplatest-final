import 'package:makemymarry/bloc/base_event_state.dart';

class SplashState extends BaseEventState{

}
class SplashScreenInitialState extends SplashState{

}
class OnLoading extends SplashState{

}
class OnResult extends SplashState{
  final String status,message;

  OnResult(this.status, this.message);
}
class MoveToInstructionScreen extends SplashState{

}
class MoveToLogin extends SplashState{

}
class MoveToHome extends SplashState{

}
class MoveToWaitingApprovalScreen extends SplashState{

}
