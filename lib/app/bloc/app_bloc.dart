import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/app/bloc/app_event.dart';
import 'package:makemymarry/app/bloc/app_state.dart';
import 'package:makemymarry/repo/chat_repo.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this.chatRepo) : super(AppInitialState());

  final ChatRepo chatRepo;
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is SignInEvent) {
      var onlineMembers = chatRepo.getOnlineUsers();
      yield AppLoggedInState(
        currentUserDisplayId: event.userDetails.displayId,
        currentUserId: event.userDetails.id,
        userDetails: event.userDetails,
        onlineMembers: onlineMembers,
      );
      updateOnlineStatus(true);
    }
  }

  void updateOnlineStatus(isOnline) {
    if (isLoggedIn) {
      chatRepo.updateOnlineStatus(
          isOnline: isOnline,
          userId: (state as AppLoggedInState).currentUserId);
    }
  }

  getOnlineUsers() {
    if (isLoggedIn) {
      return (state as AppLoggedInState).onlineMembers;
    }
  }

  bool get isLoggedIn => state is AppLoggedInState;
}
