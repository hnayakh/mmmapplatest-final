import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'received_events.dart';
import 'received_states.dart';

class ReceivedsBloc extends Bloc<ReceivedEvents, ReceivedStates> {
  late final UserRepository userRepository;
  late List<ActiveInterests> listReceived = []; //Received

  ReceivedsBloc(
    this.userRepository,
  ) : super(ReceivedInitialState());

  @override
  Stream<ReceivedStates> mapEventToState(ReceivedEvents event) async* {
    yield OnLoading();

    if (event is CheckListisEmpty) {
      print(userRepository.useDetails!.id);
      var result = await this
          .userRepository
          .getInterestList(this.userRepository.useDetails!.id);
      if (result.status == AppConstants.SUCCESS) {
        this.listReceived = result.data.activeInvites;
        if (this.listReceived.length == 0) {
          yield ListIsEmptyState();
        } else {
          yield ListIsNotEmpty();
        }
      }
    }
    if (event is RejectInterestEvent) {
      print(listReceived.length);
      var result = await this.userRepository.rejectReceivedInterest(
          listReceived[event.index].requestingUserBasicId,
          listReceived[event.index].requestedUserBasicId,
          listReceived[event.index].id);
      if (result.status == AppConstants.SUCCESS) {
        listReceived.removeAt(event.index);
        yield ReceivedInitialState();
      }
    }
    if (event is AcceptInterestEvent) {
      print(listReceived.length);
      var result = await this.userRepository.acceptReceivedInterest(
          listReceived[event.index].requestingUserBasicId,
          listReceived[event.index].requestedUserBasicId,
          listReceived[event.index].id);
      if (result.status == AppConstants.SUCCESS) {
        listReceived.removeAt(event.index);
        yield ReceivedInitialState();
      }
    }
  }
}
