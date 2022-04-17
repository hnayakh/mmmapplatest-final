import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/sent_bloc/sent_events.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/sent_bloc/sent_states.dart';

class SentsBloc extends Bloc<SentEvents, SentStates> {
  late final UserRepository userRepository;
  late final List<ActiveInterests> listSent; //sent

  SentsBloc(this.userRepository, this.listSent) : super(SentInitialState());

  @override
  Stream<SentStates> mapEventToState(SentEvents event) async* {
    yield OnLoading();

    if (event is CancelSentInterest) {
      print(listSent.length);
      var result = await this.userRepository.cancelSentInterest(
          listSent[event.index].requestingUserBasicId,
          listSent[event.index].requestedUserBasicId,
          listSent[event.index].id);
      if (result.status == AppConstants.SUCCESS) {
        listSent.removeAt(event.index);
        yield SentInitialState();
      }
    }
  }
}
