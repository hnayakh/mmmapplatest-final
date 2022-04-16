import 'package:flutter/material.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile.dart';

class FilterUsers extends StatelessWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;

  const FilterUsers(
      {Key? key, required this.userRepository, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MatchingProfileScreen(
        userRepository: userRepository,
        list: list,
      ),
    );
  }
}
