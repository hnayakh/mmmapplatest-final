import 'package:flutter/material.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/home/matching_profile/views/matching_profile.dart';

class FilterUsers extends StatelessWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile> premiumList;
  final List<MatchingProfile> recentViewList;
  final List<MatchingProfile> profileVisitorList;
  final List<MatchingProfile> onlineMembersList;

  const FilterUsers(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.searchList,
      required this.premiumList,
      required this.recentViewList,
      required this.profileVisitorList,
      required this.onlineMembersList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MatchingProfileScreen(
        list: this.list,
        // userRepository: userRepository,
        // list: list,
        // searchList: searchList,
        // premiumList: premiumList,
        // recentViewList: recentViewList,
        // profileVisitorList: profileVisitorList,
        // onlineMembersList: onlineMembersList,
      ),
    );
  }
}
