import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/filter_screens/filter_screen.dart';

import 'matching_profile_grid.dart';
import 'matching_profile_stack.dart';

class MatchingProfileScreen extends StatefulWidget {
  final UserRepository userRepository;

  List<MatchingProfile> list;

  MatchingProfileScreen(
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                          counterText: '',
                          // suffix: Container(
                          //   width: 24,
                          //   height: 24,
                          //   padding: const EdgeInsets.all(8),
                          //   child: SvgPicture.asset(
                          //     "images/Search.svg",
                          //     color: kDark5,
                          //   ),
                          // ),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 9),
                          hintText: "Search by mmy id",
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle:
                              MmmTextStyles.bodyRegular(textColor: kDark2)),
                    ),
                  )),
                  SizedBox(
                    width: 16,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          navigateToFilter();
                        },
                        child: Container(
                          height: 44,
                          width: 44,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(6)),
                          child: SvgPicture.asset(
                            "images/filter2.svg",
                            color: kDark5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.isStack = !this.isStack;
                          });
                        },
                        child: Container(
                          height: 44,
                          width: 44,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.45),
                              borderRadius: BorderRadius.circular(6)),
                          child: SvgPicture.asset(
                            this.isStack
                                ? "images/stack.svg"
                                : "images/stack.svg",
                            color: kShadowColorForGrid,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            top: 62,
            // right: 28,
          )
        ],
      ),
    );
  }

  void navigateToFilter() async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Filter(userRepository: widget.userRepository)));
    if (result != null && result is List<MatchingProfile>) {
      setState(() {
        widget.list = result;
      });
    }
  }
}
