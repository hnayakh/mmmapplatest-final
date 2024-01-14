import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/app/bloc/app_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/home/matching_profile/bloc/matching_profile_state.dart';

import '../../../../utils/mmm_enums.dart';
import '../../../profile_detail_view/profile_view.dart';
import '../views/matching_profile.dart';
import 'matching_profile_event.dart';

class MatchingProfileBloc
    extends Bloc<MatchingProfileEvent, MatchingProfileState> {
  final UserRepository userRepository;
  final ProfilesFilter filter;
  List<MatchingProfile>? list;
  List<MatchingProfile>? premiumList;
  List<MatchingProfile>? recentViewList;
  List<MatchingProfile>? profileVisitorList;
  List<MatchingProfile>? onlineMembersList;
  List<MatchingProfile>? searchList;

  String clickedUserId = "";
  Map<String, ProposalStatus?> proposalStatuses = <String, ProposalStatus?>{};
  MatchingProfileBloc(this.userRepository, this.list, this.filter)
      : super(MatchingProfileInitialState(list ?? [])) {
    add(FetchProfiles(filter: filter, isStack: false));
  }

  @override
  Stream<MatchingProfileState> mapEventToState(
      MatchingProfileEvent event) async* {
    if (event is ToggleView) {
      if (state is MatchingProfileInitialState) {
        yield OnGotProfiles((state as MatchingProfileInitialState).list,
            !state.isStack, state.currentFilter);
      } else if (state is OnGotProfiles) {
        yield OnGotProfiles(
            (state as OnGotProfiles).list, !state.isStack, state.currentFilter);
      } else {
        yield OnGotProfiles([], !state.isStack, state.currentFilter);
      }
    } else if (event is GetProfileDetails) {
      var requiredElement = event.profile;
      var result = await this.userRepository.getOtheruserDetails(
          requiredElement.id, requiredElement.activationStatus);
      if (result.status == AppConstants.SUCCESS) {
        clickedUserId = result.profileDetails.id;
        await navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => ProfileView(
              userRepository: getIt<UserRepository>(),
              profileDetails: result.profileDetails,
            ),
          ),
        );
        add(FetchProfiles(filter: state.currentFilter, isStack: state.isStack));
      } else {
        yield OnError(result.message);
      }
    } else if (event is ChangeProposalStatus) {
      switch (event.status) {
        case ProposalStatus.Sent:
          {
            navigatorKey.currentContext?.read<AppBloc>().makeProposalRequest(
                  requestId: event.profile.proposalId,
                  otherUserId: event.profile.id,
                  onDone: () async {
                    this.onProposalRequestComplete(event);
                  },
                  onError: () async {},
                );
            break;
          }
        case ProposalStatus.Accepted:
          {
            navigatorKey.currentContext?.read<AppBloc>().acceptProposal(
                  otherUserId: event.profile.id,
                  onDone: () async {
                    this.onProposalRequestComplete(event);
                  },
                  onError: () async {},
                  requestId: event.profile.proposalId!,
                );
            break;
          }
        case ProposalStatus.Rejected:
          {
            navigatorKey.currentContext?.read<AppBloc>().rejectProposal(
                  otherUserId: event.profile.id,
                  onDone: () async {
                    this.onProposalRequestComplete(event);
                  },
                  onError: () async {},
                  requestId: event.profile.proposalId!,
                );
            break;
          }
        case ProposalStatus.Reverted:
          {
            navigatorKey.currentContext?.read<AppBloc>().revertProposal(
                  otherUserId: event.profile.id,
                  onDone: () async {
                    this.onProposalRequestComplete(event);
                  },
                  onError: () async {},
                  requestId: event.profile.proposalId!,
                );
            break;
          }
        case ProposalStatus.Received:
          {
            break;
          }
      }
    } else {
      yield OnLoading();
      if (event is OnSearchByMMID) {
        var response =
            await this.userRepository.getConnectThroughMMId(event.mmmId);
        if (response.status == AppConstants.SUCCESS) {
          this.searchList = response.searchList;
          yield OnMMIDSearch(this.searchList);
        } else {
          yield OnError(response.message);
        }
      }
      if (event is FetchProfiles) {
        switch (event.filter) {
          case ProfilesFilter.recommendedProfile:
            {
              var result = await this.userRepository.getMyMatchingProfile();

              if (result.status == AppConstants.SUCCESS) {
                proposalStatuses.clear();
                result.list.forEach((element) {
                  proposalStatuses.putIfAbsent(
                      element.id, () => element.proposalStatus);
                });
                yield OnGotProfiles(result.list, event.isStack,
                    ProfilesFilter.recommendedProfile);
              } else {
                yield OnError(result.message);
              }
              break;
            }
          case ProfilesFilter.onlineMembers:
            {
              var ids = await getIt<ChatRepo>().getOnlineUsers();
              print(ids.toString()  + "========================\n");
              var result = await this.userRepository.getOnlineMembers(ids);
              if (result.status == AppConstants.SUCCESS) {
                result.list.forEach((element) {
                  print(element.name + "========================\n");
                  proposalStatuses.putIfAbsent(
                      element.id, () => element.proposalStatus);
                });
                this.onlineMembersList = result.list;
                yield OnGotProfiles(this.onlineMembersList!, event.isStack,
                    ProfilesFilter.onlineMembers);
              } else {
                yield OnError(result.message);
              }
              break;
            }
          case ProfilesFilter.premiumMembers:
            {
              var result = await this.userRepository.getPremiumMembers();
              if (result.status == AppConstants.SUCCESS) {
                result.list.forEach((element) {
                  proposalStatuses.putIfAbsent(
                      element.id, () => element.proposalStatus);
                });
                this.premiumList = result.list;
                yield OnGotProfiles(this.premiumList!, event.isStack,
                    ProfilesFilter.premiumMembers);
              } else {
                yield OnError(result.message);
              }
              break;
            }
          case ProfilesFilter.profileVisitor:
            {
              var result = await this.userRepository.getProfileVisitor();
              if (result.status == AppConstants.SUCCESS) {
                result.list.forEach((element) {
                  proposalStatuses.putIfAbsent(
                      element.id, () => element.proposalStatus);
                });
                this.profileVisitorList = result.list;
                yield OnGotProfiles(this.profileVisitorList!, event.isStack,
                    ProfilesFilter.profileVisitor);
              } else {
                yield OnError(result.message);
              }
              break;
            }
          case ProfilesFilter.recentlyViewed:
            {
              var result = await this.userRepository.getRecentViews();
              if (result.status == AppConstants.SUCCESS) {
                result.list.forEach((element) {
                  proposalStatuses.putIfAbsent(
                      element.id, () => element.proposalStatus);
                });
                this.recentViewList = result.list;
                yield OnGotProfiles(this.recentViewList!, event.isStack,
                    ProfilesFilter.recentlyViewed);
              } else {
                yield OnError(result.message);
              }
              break;
            }
        }
      }
    }
  }

  void onProposalRequestComplete(ChangeProposalStatus event) {
    // this.proposalStatuses.update(event.profile.id, (value) => event.status);
    clickedUserId = event.profile.id;
    add(FetchProfiles(filter: state.currentFilter, isStack: state.isStack));
    // if (state is MatchingProfileInitialState) {
    //   this.emit(OnGotProfiles((state as MatchingProfileInitialState).list,
    //       state.isStack, state.currentFilter));
    // } else if (state is OnGotProfiles) {
    //   this.emit(OnGotProfiles(
    //       (state as OnGotProfiles).list, state.isStack, state.currentFilter));
    // } else {
    //   this.emit(OnGotProfiles([], state.isStack, state.currentFilter));
    // }
  }
}
