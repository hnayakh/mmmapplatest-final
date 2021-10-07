import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';

import 'matching_profile_grid.dart';
import 'matching_profile_stack.dart';

class MatchingProfileScreen extends StatefulWidget {
  final UserRepository userRepository;

  final List<MatchingProfile> list;

  const MatchingProfileScreen(
      {Key? key, required this.userRepository, required this.list})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MatchingProfileScreenState();
  }
}

class MatchingProfileScreenState extends State<MatchingProfileScreen> {
  bool isStack = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 72,
      width: MediaQuery.of(context).size.width,
      color: gray5,
      child: Stack(
        children: [
          this.isStack
              ? MatchingProfileStackView(
                  userRepository: widget.userRepository,
                  list: widget.list,
                )
              : MatchingProfileGridView(
                  userRepository: widget.userRepository,
                  list: widget.list,
                ),
          Positioned(
            child: InkWell(
              onTap: () {
                setState(() {
                  this.isStack = !this.isStack;
                });
              },
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: kPrimary.withAlpha(50),
                    borderRadius: BorderRadius.circular(6)),
                child: SvgPicture.asset(
                  this.isStack
                      ? "images/GridView.svg"
                      : "images/stack_view.svg",
                  color: Colors.white,
                ),
              ),
            ),
            top: 62,
            right: 28,
          )
        ],
      ),
    );
  }
}
