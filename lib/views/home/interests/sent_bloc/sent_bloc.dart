import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'sent_events.dart';
import 'sent_states.dart';

class SentsBloc extends Bloc<SentEvents, SentStates> {
  late final UserRepository userRepository;
  late final List<ActiveInterests> listSent; //sent

  SentsBloc(this.userRepository, this.listSent) : super(SentInitialState());

  @override
  Stream<SentStates> mapEventToState(SentEvents event) async* {
    yield OnLoading();

    if (event is CheckSentListIsEmpty) {
      if (this.listSent.length == 0) {
        yield SentListisEmpty();
      } else {
        yield SentListIsNotEmpty();
      }
    }

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
    if (event is ConnectNow) {
      print("Connect By ----> ${event.connectById}");
      print("Connect To ----> ${event.connectToId}");
      var result = await this
          .userRepository
          .connectUsers(event.connectById, event.connectToId);
      if (result.status == AppConstants.SUCCESS) {
        var result = this.listSent.firstWhere((element) =>
            element.requestingUserBasicId == event.connectById &&
            element.requestedUserBasicId == event.connectToId);
        result.user.connectStatus = true;
        result.user.connectId = result.id;
        yield SentInitialState();
      } else {
        yield OnError(result.message);
      }
    }
  }
}
