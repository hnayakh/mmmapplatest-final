import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/filter_screens/filter_screen.dart';

import 'matching_profile_grid.dart';
import 'matching_profile_stack.dart';

class MatchingProfileScreen extends StatefulWidget {
  final UserRepository userRepository;

  List<MatchingProfile> list;
  List<String> filters = [
    "Recommended",
    "Profile Visitors",
    "Recent Views",
    "Search With Filter"
  ];

  MatchingProfileScreen(
      {Key? key, required this.userRepository, required this.list})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MatchingProfileScreenState(list);
  }
}

class MatchingProfileScreenState extends State<MatchingProfileScreen> {
  bool isStack = true;
  int selectedFilterPos = 0;
  List<MatchingProfile> list =[];

  MatchingProfileScreenState(this.list);

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
                  list: list,
                )
              : MatchingProfileGridView(
                  userRepository: widget.userRepository,
                  list: list,
                ),
          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
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
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(6)),
                      child: SvgPicture.asset(
                        this.isStack
                            ? "images/stack.svg"
                            : "images/stack.svg",
                        color: kShadowColorForGrid,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
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
                          // navigateToFilter();
                          showOptions();
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

  void showOptions() async {
    var res = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 270,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop(index);
                  },
                  title: Text(
                    widget.filters[index],
                    textScaleFactor: 1.0,
                    style: MmmTextStyles.bodyMedium(),
                  ),
                );
              },
              itemCount: widget.filters.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          );
        });
    if (res != null) {
      this.selectedFilterPos = res;
      if (res == 3) {
        navigateToFilter();
      } else if (res == 0) {
        var result = await widget.userRepository.getMyMatchingProfile();
        if (result.status == AppConstants.SUCCESS) {
          setState(() {
            list = result.list;
          });
        }
      } else if (res == 1) {
        var result = await widget.userRepository.getProfileVisitor();
        if (result.status == AppConstants.SUCCESS) {
          setState(() {
            list = result.list;
          });
        }
      }else if(res == 2){
        var result = await widget.userRepository.getProfileVisitor();
        if (result.status == AppConstants.SUCCESS) {
          setState(() {
            list = result.list;
          });
        }
      }
      print(list.length);
    }
  }
}
