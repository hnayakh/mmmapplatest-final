import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_event.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_state.dart';

class MyConnectsBloc extends Bloc<MyConnectsEvent, MyConnectsState> {
  final UserRepository userRepository;

  MyConnectsBloc(this.userRepository) : super(MyConnectsInitialState());

  @override
  Stream<MyConnectsState> mapEventToState(MyConnectsEvent event) async* {
    yield OnLoading();
    if (event is GetMyConnects) {
      var response = await this.userRepository.getMyConnects();
      if (response.status == AppConstants.SUCCESS) {
        yield OnGotMyConnects(response.list);
      } else {
        yield OnError(response.message);
      }
    }
  }
}
