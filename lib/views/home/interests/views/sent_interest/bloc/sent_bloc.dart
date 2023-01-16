import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/chat_room/chat_page.dart';

import 'sent_events.dart';
import 'sent_states.dart';

class SentBloc extends Bloc<SentEvents, SentStates> {
  late final UserRepository userRepository;
  late final List<ActiveInterests> listSent; //sent

  SentBloc(this.userRepository, this.listSent) : super(SentInitialState());

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
      var otherUser =
          await getIt<ChatRepo>().getChatUser(id: event.connectToId);
      var chatRoom =
          await getIt<ChatRepo>().getChatRoom(event.connectById, otherUser);
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => ChatPage(
            room: chatRoom,
            userRepo: getIt<UserRepository>(),
            allowCalls: false,
          ),
        ),
      );
    }
  }
}
