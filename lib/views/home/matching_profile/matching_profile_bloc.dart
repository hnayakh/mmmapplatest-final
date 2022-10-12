import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_event.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_state.dart';

class MatchingProfileBloc
    extends Bloc<MatchingProfileEvent, MatchingProfileState> {
  final UserRepository userRepository;
  List<MatchingProfile> list;
  List<MatchingProfile> premiumList;
  List<MatchingProfile> recentViewList;
  List<MatchingProfile> profileVisitorList;
  List<MatchingProfile> searchList;
  int selectedPos = 0;
  List<bool> isLikedList = [];

  MatchingProfileBloc(this.userRepository, this.list, this.searchList,
      this.premiumList, this.recentViewList, this.profileVisitorList)
      : super(MatchingProfileInitialState()) {
    this.isLikedList = List.generate(list.length, (index) => false);
  }

  @override
  Stream<MatchingProfileState> mapEventToState(
      MatchingProfileEvent event) async* {
    yield OnLoading();
    if (event is GetProfileDetails) {
      var result = await this.userRepository.getOtheruserDetails(
          this.list[event.pos].id, this.list[event.pos].activationStatus);

      if (result.status == AppConstants.SUCCESS) {
        yield OnGotProfileDetails(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }

    if (event is IsLikedAEvent) {
      this.isLikedList[event.index] = !this.isLikedList[event.index];
      var likedByUserId = this.userRepository.useDetails!.id;
      var likedUserId = this.list[event.index].id;
      var result =
          await this.userRepository.setLikeStatus(likedUserId, likedByUserId);
      if (result.status == AppConstants.SUCCESS) {
        list.removeAt(event.index);
        yield MatchingProfileInitialState();
      } else {
        yield OnError(result.message);
      }
    }

    if (event is OnSearchByMMID) {
      print("search clicked");
      // yield OnLoading();
      var response =
          await this.userRepository.getConnectThroughMMId(event.mmmId);
      if (response.status == AppConstants.SUCCESS) {
        this.searchList = response.searchList;
        yield OnMMIDSearch(this.searchList);
      } else {
        yield OnError(response.message);
      }
    }
    if (event is GetPremiumMembers) {
      var result = await this.userRepository.getPremiumMembers();
      if (result.status == AppConstants.SUCCESS) {
        this.premiumList = result.list;
        print("PREMIUM MEMBERS");
        print(result.list);
        yield OnGotPremium(this.premiumList);
      } else {
        yield OnError(result.message);
        // print(result.status);
        // print(result.message);
      }
    }
    if (event is GetRecentViewMembers) {
      var result = await this.userRepository.getRecentViews();
      if (result.status == AppConstants.SUCCESS) {
        this.recentViewList = result.list;
        print("RECENT MEMBERS");
        print(result.list);
        yield OnGotRecentView(this.recentViewList);
      } else {
        yield OnError(result.message);
        // print(result.status);
        // print(result.message);
      }
    }
    if (event is GetProfileVisited) {
      var result = await this.userRepository.getProfileVisitor();
      if (result.status == AppConstants.SUCCESS) {
        this.profileVisitorList = result.list;
        print("PROFILE VISITORS");
        print(result.list);
        yield onGotProfileVisitors(this.profileVisitorList);
      } else {
        yield OnError(result.message);
      }
    }
  }
}
