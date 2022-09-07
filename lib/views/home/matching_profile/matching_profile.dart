import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/filter_screens/filter_screen.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_event.dart';

import 'matching_profile_grid.dart';
import 'matching_profile_stack.dart';
import 'matching_profile_state.dart';

// TextEditingController mycontroller = TextEditingController();

// ignore: must_be_immutable
class MatchingProfileScreen extends StatefulWidget {
  final UserRepository userRepository;
  List<MatchingProfile> list;
  List<MatchingProfileSearch> searchList;
  String? searchText;
  List<String> filters = [
    "Recommended",
    "Profile Visitors",
    "Recent Views",
    "Search With Filter"
  ];

  // MatchingProfileScreen(
  //     {Key? key,
  //     required this.userRepository,
  //     required this.list,
  //     required this.searchList})
  //     : super(key: key);
  MatchingProfileScreen(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.searchList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MatchingProfileScreenState(list, searchText);
  }
}

// class MatchingProfileScreenView extends StatefulWidget {

// }

class MatchingProfileScreenState extends State<MatchingProfileScreen> {
  final myController = TextEditingController();
  bool isStack = true;
  int selectedFilterPos = 0;
  late List<MatchingProfile> list = [];
  late List<MatchingProfileSearch> searchList = [];
  String? searchText;
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(onChangeTextSearch);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  MatchingProfileScreenState(this.list, searchText);
  void onChangeTextSearch() {
    setState(() {
      this.searchText = myController.text;
    });
    print('Second text field: ${myController.text}');
  }

  @override
  Widget build(BuildContext context) {
    print("searchHer");
    print(this.searchList);
    return BlocProvider(
      create: (context) =>
          MatchingProfileBloc(widget.userRepository, list, searchList),
      child: Container(
        height: MediaQuery.of(context).size.height - 72,
        width: MediaQuery.of(context).size.width,
        color: gray5,
        child: Stack(
          children: [
            this.isStack
                ? MatchingProfileStackView(
                    userRepository: widget.userRepository,
                    list: list,
                    searchList: searchList)
                : MatchingProfileGridView(
                    userRepository: widget.userRepository,
                    list: list,
                    searchList: searchList),
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
                        // onChanged: (text) {
                        //   var value = text;
                        //   print('Akash');
                        //   print(value);
                        // },
                        controller: myController,

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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 9),
                            hintText: "Search by mm id",
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle:
                                MmmTextStyles.bodyRegular(textColor: kDark2)),
                      ),
                    )),
                    Column(
                      children: [
                        Container(
                            width: 44,
                            height: 44,
                            // alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kLight4,
                                boxShadow: [
                                  MmmShadow.filterButton(
                                      shadowColor: kShadowColorForGrid)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () {
                                        showOptionsSearchThroughId();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                          'images/Search.svg',
                                          fit: BoxFit.cover,
                                        ),
                                      ))),
                            )),
                      ],
                    ),
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
      ),
    );
  }

  void viewProfile() async {
    print("test");
    print(searchText);
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

  void showOptionsSearchThroughId() async {
    var result =
        await widget.userRepository.getConnectThroughMMId(this.searchText);
    print('Result');
    print(result);
    if (result.status == AppConstants.SUCCESS) {
      setState(() {
        searchList = result.searchList;
      });
    }
    // BlocProvider.of<MatchingProfileBloc>(context)
    //     .add(OnSearchByMMID(this.searchText));
    // print('SearchhhhNow');
    // print(searchList);
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
      } else if (res == 2) {
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
