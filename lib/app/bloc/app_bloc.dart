import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/app/bloc/app_event.dart';
import 'package:makemymarry/app/bloc/app_state.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/utility_service.dart';
import 'package:makemymarry/utils/widgets_large.dart';

import '../../utils/app_constants.dart';
import '../../views/home/menu/wallet/recharge/recharge_connect_screen.dart';

typedef AsyncCallback = Future<dynamic> Function();

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this.chatRepo, this.userRepository) : super(AppInitialState());

  final ChatRepo chatRepo;
  final UserRepository userRepository;
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is SignInEvent) {
      var onlineMembers = chatRepo.getOnlineUsersStream();
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

  Future<dynamic> makeProposalRequest({
    required String otherUserId,
    required String? requestId,
    required AsyncCallback onDone,
    required AsyncCallback onError,
  }) async {
    try {
      var result = await userRepository.setLikeStatus(
          otherUserId, (state as AppLoggedInState).currentUserId, requestId);
      if (result.status == AppConstants.SUCCESS) {
        onDone();
      } else {
        onError();
      }
    } catch (e) {
      onError.call();
      UtilityService.cprint(e.toString());
    }
  }

  Future<dynamic> acceptProposal({
    required String otherUserId,
    required String requestId,
    required AsyncCallback onDone,
    required AsyncCallback onError,
  }) async {
    try {
      var result = await userRepository.acceptReceivedInterest(
          (state as AppLoggedInState).currentUserId, otherUserId, requestId);
      if (result.status == AppConstants.SUCCESS) {
        onDone();
      } else {
        onError();
      }
    } catch (e) {
      onError.call();
      UtilityService.cprint(e.toString());
    }
  }

  Future<dynamic> rejectProposal({
    required String otherUserId,
    required String requestId,
    required AsyncCallback onDone,
    required AsyncCallback onError,
  }) async {
    try {
      var result = await userRepository.rejectReceivedInterest(
          (state as AppLoggedInState).currentUserId, otherUserId, requestId);
      if (result.status == AppConstants.SUCCESS) {
        onDone();
      } else {
        onError();
      }
    } catch (e) {
      onError.call();
      UtilityService.cprint(e.toString());
    }
  }

  Future<dynamic> revertProposal({
    required String otherUserId,
    required String requestId,
    required AsyncCallback onDone,
    required AsyncCallback onError,
  }) async {
    try {
      var result = await userRepository.cancelSentInterest(
          (state as AppLoggedInState).currentUserId, otherUserId, requestId);
      if (result.status == AppConstants.SUCCESS) {
        onDone();
      } else {
        onError();
      }
    } catch (e) {
      onError.call();
      UtilityService.cprint(e.toString());
    }
  }

  Future<dynamic> connectNow({
    required String otherUserId,
    required AsyncCallback onDone,
    required AsyncCallback onError,
    required dynamic profileDetails,
    required BuildContext context,
  }) async {
    if (profileDetails is ActiveInterests ||
        (profileDetails is ProfileDetails
            ? !profileDetails.connectStatus!
            : !profileDetails.isConnected)) {
      var response = await this.userRepository.fetchCurrentBalance();
      if (response.status == AppConstants.SUCCESS) {
        emit((state as AppLoggedInState)
            .copyWith(connectCount: response.balance));

        if ((this.state as AppLoggedInState).connectCount > 0) {
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) => MmmWidgets.requestConnectWidget(
              name: (profileDetails is MatchingProfile)
                  ? profileDetails.name
                  : (profileDetails is ActiveInterests)
                      ? profileDetails.user.name
                      : (profileDetails is ProfileDetails)
                          ? profileDetails.name
                          : "",
              imageUrl: (profileDetails is MatchingProfile)
                  ? profileDetails.imageUrl
                  : (profileDetails is ActiveInterests)
                      ? profileDetails.user.imageURL
                      : (profileDetails is ProfileDetails)
                          ? profileDetails.images.isNotNullEmpty
                              ? profileDetails.images.first
                              : ""
                          : "",
              isVerified: (((profileDetails is MatchingProfile)
                      ? profileDetails.activationStatus.index
                      : (profileDetails is ActiveInterests)
                          ? profileDetails.user.activationStatus
                          : (profileDetails is ProfileDetails)
                              ? profileDetails.activationStatus.index
                              : 0) == ProfileActivationStatus.Verified.index),
              onConfirm: () async {
                try {
                  var result = await userRepository.connectUsers(
                    (state as AppLoggedInState).currentUserId,
                    otherUserId,
                  );
                  if (result.status == AppConstants.SUCCESS) {

                    try{
                      Navigator.of(context).pop();
                      onDone();
                    }catch(e){
                      UtilityService.cprint(e.toString());
                    }
                  } else {
                    onError();
                  }
                } catch (e) {
                  onError.call();
                  UtilityService.cprint(e.toString());
                }
              },
            ),
          );
        } else {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return MmmWidgets.lowBalanceWidget(
                onConfirm: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RechargeConnect(
                        userRepository: getIt<UserRepository>(),
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      } else {
        onDone.call();
      }
    } else {
      onDone.call();
    }
  }

  bool get isLoggedIn => state is AppLoggedInState;
}
