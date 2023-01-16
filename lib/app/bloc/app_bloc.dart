import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/app/bloc/app_event.dart';
import 'package:makemymarry/app/bloc/app_state.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';

import '../../utils/app_constants.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this.chatRepo, this.userRepository) : super(AppInitialState());

  final ChatRepo chatRepo;
  final UserRepository userRepository;
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is SignInEvent) {
      var onlineMembers = chatRepo.getOnlineUsers();
      var response = await this.userRepository.fetchCurrentBalance();
      var connectCount = 0;
      if (response.status == AppConstants.SUCCESS) {
        connectCount = response.balance;
      }
      yield AppLoggedInState(
          currentUserDisplayId: event.userDetails.displayId,
          currentUserId: event.userDetails.id,
          userDetails: event.userDetails,
          onlineMembers: onlineMembers,
          connectCount: connectCount);
      updateOnlineStatus(true);
    }
    if (event is RefreshWalletCount) {
      var response = await this.userRepository.fetchCurrentBalance();
      if (response.status == AppConstants.SUCCESS) {
        yield (state as AppLoggedInState)
            .copyWith(connectCount: response.balance);
      }
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
