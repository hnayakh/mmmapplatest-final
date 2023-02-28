import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/utility_service.dart';
import 'package:makemymarry/views/profile_detail_view/profile_view_event.dart';
import 'package:makemymarry/views/profile_detail_view/profile_view_state.dart';

import '../../app/bloc/app_bloc.dart';
import '../../app/bloc/app_state.dart';
import '../../datamodels/martching_profile.dart';
import '../chat_room/chat_page.dart';

class ProfileViewBloc extends Bloc<ProfileViewEvent, ProfileViewState> {
  final UserRepository userRepository;
  late ProfileDetails profileDetails;
  late String message = "";

  ProfileViewBloc(this.userRepository, this.profileDetails)
      : super(ProfileViewInitialState());

  @override
  Stream<ProfileViewState> mapEventToState(ProfileViewEvent event) async* {
    if (event is VisitProfile) {
      yield OnLoading();
      this.userRepository.visitProfile(this.profileDetails.id);
      yield OnProfileVisited();
    }
    if (event is GetProfileViewDetails) {
      var result;
      if(event.displayId.contains("MM")) {
        result = await this.userRepository.getOtherUserDetailsByDisplayId(
            event.displayId,
            ProfileActivationStatus.Verified,
            this.userRepository.useDetails?.displayId == event.displayId
                ? null
                : this.userRepository.useDetails?.displayId);
      }else{
        result = await this.userRepository.getOtheruserDetails(
            event.displayId,
            ProfileActivationStatus.Verified,
            );
      }
      if (result.status == AppConstants.SUCCESS &&
          result.message == "User basic details fetched successful.") {
        this.profileDetails = result.profileDetails;
        yield OnGotProfileDetails(result.profileDetails);
      } else {
        this.message = result.message;
        yield OnErrorView(result.message);
      }
    }
    if (event is SendLikeRequest) {
      yield OnLoading();
      BlocProvider.of<AppBloc>(navigatorKey.currentContext!)
          .makeProposalRequest(
        otherUserId: profileDetails.id,
        onDone: () async {
          this.add(GetProfileViewDetails(profileDetails.id));
        },
        onError: () async {
          this.add(GetProfileViewDetails(profileDetails.id));
        }, requestId: profileDetails.proposalId,
      );
    }
    if (event is BlockProfile) {
      yield OnLoading();
      await this.userRepository.blockProfile(
            this.userRepository.useDetails!.id,
            this.profileDetails.id,
          );
      this.add(GetProfileViewDetails(profileDetails.id));
    }
    if (event is UnBlockProfile) {
      yield OnLoading();
      await this.userRepository.unBlockProfile(this.profileDetails.blockId);
      this.add(GetProfileViewDetails(profileDetails.id));
    }
    if (event is CancelLikeRequest) {
      yield OnLoading();
      BlocProvider.of<AppBloc>(navigatorKey.currentContext!).revertProposal(
        otherUserId: profileDetails.id,
        onDone: () async {
          this.add(GetProfileViewDetails(profileDetails.id));
        },
        onError: () async {
          this.add(GetProfileViewDetails(profileDetails.id));
        },
        requestId: profileDetails.proposalId ?? "",
      );
    }
    if (event is AcceptLikeRequest) {
      yield OnLoading();
      BlocProvider.of<AppBloc>(navigatorKey.currentContext!).acceptProposal(
        otherUserId: profileDetails.id,
        onDone: () async {
          this.add(GetProfileViewDetails(profileDetails.id));
        },
        onError: () async {
          this.add(GetProfileViewDetails(profileDetails.id));
        },
        requestId: profileDetails.proposalId!,
      );
    }
    if (event is RejectLikeRequest) {
      yield OnLoading();
      BlocProvider.of<AppBloc>(navigatorKey.currentContext!).rejectProposal(
        otherUserId: profileDetails.id,
        onDone: () async {
          this.add(GetProfileViewDetails(profileDetails.id));
        },
        onError: () async {
          this.add(GetProfileViewDetails(profileDetails.id));
        },
        requestId: profileDetails.proposalId!,
      );
    }
    if (event is MakeConnectRequest) {
      // yield OnLoading();
      BlocProvider.of<AppBloc>(navigatorKey.currentContext!).connectNow(
          otherUserId: profileDetails.id,
          onDone: () async {
            navigatorKey.currentState?.push((await ChatPage.getRoute(
                navigatorKey.currentContext!, profileDetails.id)));
          },
          onError: () async {
            this.add(GetProfileViewDetails(profileDetails.id));
          },
          profileDetails: profileDetails,
          context: navigatorKey.currentContext!);
    }
  }
}
