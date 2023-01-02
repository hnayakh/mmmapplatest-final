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
import 'package:makemymarry/views/home/home.dart';
import 'package:makemymarry/views/home/matching_profile/bloc/matching_profile_bloc.dart';

import '../bloc/matching_profile_event.dart';
import 'matching_profile_grid.dart';
import '../bloc/matching_profile_state.dart';
import 'matching_profile_stack.dart';

// TextEditingController mycontroller = TextEditingController();

// ignore: must_be_immutable
class MatchingProfileScreen extends StatefulWidget {
  final UserRepository userRepository;
  List<MatchingProfile> list;
  List<MatchingProfile> searchList;
  final List<MatchingProfile> premiumList;
  final List<MatchingProfile> recentViewList;
  final List<MatchingProfile> profileVisitorList;
  final List<MatchingProfile> onlineMembersList;
  String? searchText;
  final String? screenName;
  final String? searchTextNew;
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
      required this.searchList,
      required this.premiumList,
      required this.recentViewList,
      required this.profileVisitorList,
      required this.onlineMembersList,
      this.screenName,
      this.searchTextNew})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MatchingProfileScreenState(list, searchText, screenName);
  }
}

// class MatchingProfileScreenView extends StatefulWidget {

// }

class MatchingProfileScreenState extends State<MatchingProfileScreen> {
  final myController = TextEditingController();
  bool isStack = true;
  int selectedFilterPos = 0;
  List<MatchingProfile> list = [];
  UserRepository userRepository = UserRepository();
  List<MatchingProfile> searchList = [];
  List<MatchingProfile> premiumList = [];
  List<MatchingProfile> recentViewList = [];
  String? searchText;
  String? screenName;
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

  MatchingProfileScreenState(this.list, searchText, this.screenName);

  void onChangeTextSearch() {
    setState(() {
      this.searchText = myController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchTextNew != null) {
      showOptionsSearchThroughId(widget.searchTextNew);
    }
    // if (screenName == '') {
    //   context.read<MatchingProfileBloc>().add(GetProfileDetails(0));
    // }
    if (widget.screenName == 'PremiumMembers') {
      context.read<MatchingProfileBloc>().add(GetPremiumMembers());
    }
    if (widget.screenName == 'OnlineMembers') {
      context.read<MatchingProfileBloc>().add(GetOnlineMembers());
    }
    if (widget.screenName == 'ProfileRecentlyViewed') {
      context.read<MatchingProfileBloc>().add(GetRecentViewMembers());
    }
    if (widget.screenName == 'ProfileViewedBy') {
      context.read<MatchingProfileBloc>().add(GetProfileVisited());
    }
    return Container(
      height: MediaQuery.of(context).size.height - 72,
      width: MediaQuery.of(context).size.width,
      color: gray5,
      child: Stack(
        children: [
          this.isStack
              ? MatchingProfileGridView(
                  userRepository: widget.userRepository,
                  list: list,
                  searchList: searchList,
                  premiumList: premiumList,
                  recentViewList: recentViewList,
                  screenName: widget.screenName)
              : MatchingProfileStackView(
                  userRepository: widget.userRepository,
                  list: list,
                  premiumList: premiumList,
                  searchList: searchList,
                  screenName: widget.screenName),
          // Positioned(
          //child:
          Container(
            //added by Akaash
            margin: new EdgeInsets.symmetric(vertical: 50.0),
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
                          : "images/grid_view.svg",
                      color: kShadowColorForGrid,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Container(
                        child: widget.screenName == 'PremiumMembers'
                            ? Container(
                                height: 44,
                                //margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color.fromARGB(
                                            174, 181, 178, 178))),
                                child: Row(
                                  children: [
                                    // Icon(
                                    //   Icons.king_bed,
                                    //   size: 30,
                                    //   color: Colors.black,
                                    // ),
                                    Image.asset(
                                      "images/Vector.png",
                                      color: Colors.black,
                                      // fit: BoxFit.contain,
                                      height: 40.0,
                                      width: 40.0,
                                      // allowDrawingOutsideViewBox: false,
                                    ),
                                    Text(
                                      "Premium Members",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "MakeMyMarrySemiBold",
                                          color: kDark5),
                                    ),
                                  ],
                                ),
                              )
                            : widget.screenName == 'ProfileViewedBy'
                                ? Container(
                                    height: 44,
                                    //margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                174, 181, 178, 178))),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.king_bed,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                        Text("Profile Viewed By",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily:
                                                    "MakeMyMarrySemiBold")),
                                      ],
                                    ),
                                  )
                                : widget.screenName == 'ProfileRecentlyViewed'
                                    ? Container(
                                        height: 44,
                                        //margin: const EdgeInsets.all(15.0),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    174, 181, 178, 178))),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.king_bed,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                            Text("Recently Viewed",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "MakeMyMarrySemiBold")),
                                          ],
                                        ),
                                      )
                                    : widget.screenName == 'OnlineMembers'
                                        ? Container(
                                            height: 44,
                                            //margin: const EdgeInsets.all(15.0),
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        174, 181, 178, 178))),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.king_bed,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                                Text("Online Members",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "MakeMyMarrySemiBold")),
                                              ],
                                            ),
                                          )
                                        : widget.screenName ==
                                                'RecomendedProfile'
                                            ? Container(
                                                height: 44,
                                                //margin: const EdgeInsets.all(15.0),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            174,
                                                            181,
                                                            178,
                                                            178))),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.king_bed,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    Text(
                                                      "Recomended Profile",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                width: 0,
                                                height: 44,
                                              )

                        // TextField(
                        //     // onChanged: (text) {
                        //     //   var value = text;
                        //     //   print('Akash');
                        //     //   print(value);
                        //     // },
                        //     controller: myController,

                        //     decoration: InputDecoration(
                        //         counterText: '',
                        //         // suffix: Container(
                        //         //   width: 24,
                        //         //   height: 24,
                        //         //   padding: const EdgeInsets.all(8),
                        //         //   child: SvgPicture.asset(
                        //         //     "images/Search.svg",
                        //         //     color: kDark5,
                        //         //   ),
                        //         // ),
                        //         border: OutlineInputBorder(
                        //             borderSide: BorderSide(
                        //                 color: Colors.white,
                        //                 width: 1),
                        //             borderRadius:
                        //                 BorderRadius.circular(8)),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(
                        //               color: Colors.white,
                        //               width: 1),
                        //           borderRadius: BorderRadius.all(
                        //               Radius.circular(8)),
                        //         ),
                        //         contentPadding:
                        //             const EdgeInsets.symmetric(
                        //                 horizontal: 12,
                        //                 vertical: 9),
                        //         hintText: "Search by mm idss",
                        //         isDense: true,
                        //         filled: true,
                        //         fillColor: Colors.white,
                        //         hintStyle:
                        //             MmmTextStyles.bodyRegular(
                        //                 textColor: kDark2)),
                        //   ),
                        )),
                // Positioned(
                //   left: 8,
                //   top: 8,
                //   child:
                widget.screenName == '' || widget.screenName == null
                    ? Container(
                        width: 0,
                        height: 44,
                      )
                    //  Container(
                    //     width: 44,
                    //     height: 44,
                    //     // alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         color: kLight4,
                    //         boxShadow: [
                    //           MmmShadow.filterButton(
                    //               shadowColor: kShadowColorForGrid)
                    //         ],
                    //         borderRadius: BorderRadius.all(Radius.circular(8))),
                    //     child:
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(8),
                    //       child:
                    //       Material(
                    //           color: Colors.transparent,
                    //           child:
                    //           InkWell(
                    //               onTap: () {
                    //                 print("search button click");
                    //                 showOptionsSearchThroughId(this.searchText);
                    //               },
                    //               child: Container(
                    //                 padding: EdgeInsets.all(10),
                    //                 child: SvgPicture.asset(
                    //                   'images/Search.svg',
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               ))
                    //               ),
                    //     ))
                    : Container(
                        width: 0,
                        height: 44,
                      ),
                // ),
                SizedBox(
                  width: 16,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // navigateToFilter();
                        showDialog(
                          barrierColor: Colors.black26,
                          context: context,
                          builder: (context) {
                            return Dialog(
                                alignment: Alignment(0, -0.8),
                                // alignment: Alignment.(),
                                insetPadding: const EdgeInsets.all(0),
                                elevation: 0,
                                backgroundColor: const Color(0xffffffff),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  height: 240,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      iconText(
                                          action: () {
                                            print("Hello");
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                        userRepository: widget
                                                            .userRepository,
                                                        list: widget.list,
                                                        searchList:
                                                            widget.searchList,
                                                        premiumList:
                                                            widget.premiumList,
                                                        recentViewList: widget
                                                            .recentViewList,
                                                        profileVisitorList: widget
                                                            .profileVisitorList,
                                                        onlineMembersList: widget
                                                            .onlineMembersList,
                                                        screenName: "",
                                                      )),
                                            );
                                          },
                                          leading:
                                              // Icon(Icons.search),
                                              SvgPicture.asset(
                                            'images/tick.svg',
                                            color: gray4,
                                          ),
                                          text: "Recommended Profile"),
                                      iconText(
                                          leading:
                                              // Icon(Icons.online_prediction),
                                              Image.asset('images/online.png'),
                                          text: "Online Members"),
                                      iconText(
                                          action: () {
                                            print("Hello");
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                        userRepository: widget
                                                            .userRepository,
                                                        list: widget.list,
                                                        searchList:
                                                            widget.searchList,
                                                        premiumList:
                                                            widget.premiumList,
                                                        recentViewList: widget
                                                            .recentViewList,
                                                        profileVisitorList: widget
                                                            .profileVisitorList,
                                                        onlineMembersList: widget
                                                            .onlineMembersList,
                                                        screenName:
                                                            "PremiumMembers",
                                                      )),
                                            );
                                          },
                                          leading:
                                              //Icon(Icons.workspace_premium),
                                              Image.asset('images/crown.png'),
                                          text: "Premium Members"),
                                      iconText(
                                          action: () {
                                            print("Hello");
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                        userRepository: widget
                                                            .userRepository,
                                                        list: widget.list,
                                                        searchList:
                                                            widget.searchList,
                                                        premiumList:
                                                            widget.premiumList,
                                                        recentViewList: widget
                                                            .recentViewList,
                                                        profileVisitorList: widget
                                                            .profileVisitorList,
                                                        onlineMembersList: widget
                                                            .onlineMembersList,
                                                        screenName:
                                                            "ProfileViewedBy",
                                                      )),
                                            );
                                          },
                                          leading:
                                              // Icon(Icons.visibility_outlined),
                                              Image.asset(
                                            'images/profileVisitors.png',
                                          ),
                                          text: "Profile Visitors"),
                                      iconText(
                                          action: () {
                                            print("Hello");
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                        userRepository: widget
                                                            .userRepository,
                                                        list: widget.list,
                                                        searchList:
                                                            widget.searchList,
                                                        premiumList:
                                                            widget.premiumList,
                                                        recentViewList: widget
                                                            .recentViewList,
                                                        profileVisitorList: widget
                                                            .profileVisitorList,
                                                        onlineMembersList: widget
                                                            .onlineMembersList,
                                                        screenName:
                                                            "ProfileRecentlyViewed",
                                                      )),
                                            );
                                          },
                                          leading:
                                              //Icon(Icons.search),
                                              Image.asset(
                                                  'images/searchHome.png'),
                                          text: "Recently Viewed"),
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset('images/icons/shuffle-icon.png')),

                      // child: Container(
                      //   height: 44,
                      //   width: 44,
                      //   padding: const EdgeInsets.all(8),
                      //   decoration: BoxDecoration(
                      //       color: Colors.white.withOpacity(0.9),
                      //       borderRadius: BorderRadius.circular(6)),
                      //   child: SvgPicture.asset(
                      //     "images/filter2.svg",
                      //     color: kDark5,
                      //   ),
                      // ),
                    ),
                  ],
                )
              ],
            ),
          ),
          //  top: 62,
          // right: 28,
          //)
        ],
      ),
    );
    //   }),
    // );
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

  void showOptionsSearchThroughId(text) async {
    context.read<MatchingProfileBloc>().add(OnSearchByMMID(text));
  }

  void showOptions() async {
    // InkWell(
    //   onTap: () {
    //     showDialog(
    //       barrierColor: Colors.black26,
    //       context: context,
    //       builder: (context) {
    //         return Dialog(
    //             insetPadding: const EdgeInsets.all(0),
    //             elevation: 0,
    //             backgroundColor: const Color(0xffffffff),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(20.0),
    //             ),
    //             child: Container(
    //               height: 200,
    //               width: 30,
    //               decoration:
    //                   BoxDecoration(borderRadius: BorderRadius.circular(20)),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   iconText(
    //                       leading: Icon(Icons.verified_user_outlined),
    //                       text: "Online Members"),
    //                   iconText(
    //                       leading: Icon(Icons.workspace_premium),
    //                       text: "Premium Members"),
    //                   iconText(
    //                       leading: Icon(Icons.visibility_outlined),
    //                       text: "Profile Visitors"),
    //                   iconText(
    //                       leading: Icon(Icons.search), text: "Recently Viewed"),
    //                 ],
    //               ),
    //             ));
    //       },
    //     );
    //   },
    //   child: Container(
    //       height: 32,
    //       width: 35,
    //       decoration: BoxDecoration(
    //           color: Colors.white, borderRadius: BorderRadius.circular(10)),
    //       child: Image.asset('images/icons/grid-icon.png')),
    // );
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
    print('resejtbjhert $res');
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

  iconText({leading, String? text, action}) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(118, 158, 158, 158)),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            leading,
            SizedBox(
              width: 20,
            ),
            Text(
              text!,
              style: MmmTextStyles.bodyMediumSmall(),
            ),
          ],
        ),
      ),
    );
  }
}
