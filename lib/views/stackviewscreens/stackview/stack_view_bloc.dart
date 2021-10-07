import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_event.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_state.dart';

class StackViewBloc extends Bloc<StackViewEvent, StackViewState> {
  final UserRepository userRepository;

  StackViewBloc(this.userRepository,)
      : super(StackViewInitialState());

  @override
  Stream<StackViewState> mapEventToState(StackViewEvent event) async* {
    yield OnLoading();

    if (event is SwipeUpEvent) {

    } else if (event is SwipeDownEvent) {

    } else if (event is LikeOrUnlikeEvent) {

    } else {
    }
  }
}
