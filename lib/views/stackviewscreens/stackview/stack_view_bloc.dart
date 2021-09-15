import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_event.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_state.dart';

class StackViewBloc extends Bloc<StackViewEvent, StackViewState> {
  final UserRepository userRepository;
  var likeInfoList;

  int profileIndex = 0;

  StackViewBloc(this.userRepository) : super(StackViewInitialState());

  @override
  Stream<StackViewState> mapEventToState(StackViewEvent event) async* {
    this.likeInfoList = List.filled(userRepository.listProfileDetails.length, 0,
        growable: false);
    yield OnLoading();

    if (event is SwipeUpEvent) {
      if (profileIndex == userRepository.listProfileDetails.length - 1) {
        return;
      } else {
        profileIndex = profileIndex + 1;
      }
      yield StackViewInitialState();
    } else if (event is SwipeDownEvent) {
      if (profileIndex == 0) {
        return;
      } else {
        profileIndex = profileIndex - 1;
      }
      yield StackViewInitialState();
    } else if (event is LikeOrUnlikeEvent) {
      likeInfoList[profileIndex] = event.likeInfo;
      //call the api to post like info.
      yield StackViewInitialState();
    } else {
      yield OnError('result.message');
    }
  }
}
