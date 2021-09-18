import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_event.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_state.dart';

class StackViewBloc extends Bloc<StackViewEvent, StackViewState> {
  final UserRepository userRepository;
  final List<int> likeInfoList;

  int profileIndex;

  StackViewBloc(this.userRepository, this.likeInfoList, this.profileIndex)
      : super(StackViewInitialState());

  @override
  Stream<StackViewState> mapEventToState(StackViewEvent event) async* {
    yield OnLoading();

    if (event is SwipeUpEvent) {
      if (profileIndex == userRepository.listProfileDetails.length - 1) {
        //userRepository.listProfileDetails[profileIndex + 1].id == userRepository.useDetails.id

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
