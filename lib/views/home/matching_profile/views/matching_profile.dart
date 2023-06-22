import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/filter_screens/filter_screen.dart';
import 'package:makemymarry/views/home/matching_profile/bloc/matching_profile_bloc.dart';

import '../../../../utils/buttons.dart';
import '../bloc/matching_profile_event.dart';
import '../bloc/matching_profile_state.dart';
import 'matching_profile_grid.dart';
import 'matching_profile_stack.dart';

class MatchingProfileScreen extends StatelessWidget {

  const MatchingProfileScreen({
    Key? key,
    required this.list,
    this.filter = ProfilesFilter.recommendedProfile,
    this.isTopLevel = true,
  }) : super(key: key);

  final ProfilesFilter filter;
  final List<MatchingProfile> list;
  final bool isTopLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray5,
      appBar: !isTopLevel ? MmmButtons.appBarCurved('Search', context: context) : null,
      body: BlocProvider<MatchingProfileBloc>(
        create: (context) => MatchingProfileBloc(
          getIt<UserRepository>(),
          list,
          filter
        ),
        child: Builder(
          builder: (context) {
            return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
              listener: (context, state) {

              },
              builder: (context, state) {
                  return Container(
                    height: MediaQuery.of(context).size.height - 72,
                    width: MediaQuery.of(context).size.width,
                    color: gray5,
                    child: Stack(
                      children: [
                        if (state is MatchingProfileInitialState) !state.isStack
                            ? ProfilesGridView(
                              list: state.list,
                            )
                            : MatchingProfileStackView(
                                list: state.list,
                              ),
                        if (state is OnGotProfiles) !state.isStack
                            ? ProfilesGridView(
                              list: state.list,
                            )
                            : MatchingProfileStackView(
                                list: state.list,
                              ),
                        Container(
                          margin: new EdgeInsets.symmetric(vertical: !isTopLevel ? 12 : 48.0),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<MatchingProfileBloc>(context).add(ToggleView());
                                },
                                child: Container(
                                  height: 44,
                                  width: 44,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.85),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: SvgPicture.asset(
                                    state.isStack
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
                                child:  buildScreenHeader(
                                        state.currentFilter,
                                      ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  var bloc = BlocProvider.of<MatchingProfileBloc>(
                                      context);
                                  showDialog(
                                    barrierColor: Colors.black26,
                                    context: context,
                                    builder: (context) {
                                      return FiltersDialog(
                                        bloc: bloc,
                                        isStack: state.isStack,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                      'images/icons/shuffle-icon.png'),
                                ),
                              )
                            ],
                          ),
                        ),
                        if (state is OnLoading) MmmWidgets.buildLoader(context, color: Colors.transparent)
                      ],

                    ),
                  );

              },
            );
          },
        ),
      ),
    );
  }

  Widget buildScreenHeader(ProfilesFilter filter) {
    return Container(
      height: 44,
      //margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(174, 181, 178, 178))),
      child: Row(
        children: [
          SvgPicture.asset(
            filter.asset,
            color: Colors.black,
            // fit: BoxFit.contain,
            height: 40.0,
            width: 40.0,
            // allowDrawingOutsideViewBox: false,
          ),
          SizedBox(width: 12,),
          Flexible(
            child: Text(
              filter.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.clip,
              softWrap: true,
              style: TextStyle(  fontFamily: "MakeMyMarrySemiBold", color: kDark5),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToFilter(BuildContext context) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Filter(userRepository: getIt<UserRepository>())));
  }
}

class FiltersDialog extends StatelessWidget {
  const FiltersDialog({Key? key, required this.bloc, required this.isStack}) : super(key: key);

  final MatchingProfileBloc bloc;
  final bool isStack;
  @override
  Widget build(BuildContext context) {
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...ProfilesFilter.values
                  .map((e) => FilterPopupTile(filter: e, bloc: this.bloc, isStack: this.isStack,))
                  .toList(),
            ],
          ),
        ));
  }
}

class FilterPopupTile extends StatelessWidget {
  const FilterPopupTile({Key? key, required this.filter, required this.bloc, required this.isStack})
      : super(key: key);

  final ProfilesFilter filter;
  final bool isStack;
  final MatchingProfileBloc bloc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState?.pop();
        bloc.add(FetchProfiles(filter: filter, isStack: isStack));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(118, 158, 158, 158)),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SvgPicture.asset(filter.asset),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                filter.label,
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: true,
                style: MmmTextStyles.bodyMediumSmall(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ProfilesFilter {
  recommendedProfile,
  onlineMembers,
  premiumMembers,
  profileVisitor,
  recentlyViewed
}

extension ProfilesFilterExtension on ProfilesFilter {
  String get label {
    switch (this) {
      case ProfilesFilter.recommendedProfile:
        return "Recommended Profile";
      case ProfilesFilter.onlineMembers:
        return "Online Members";
      case ProfilesFilter.premiumMembers:
        return "Premium Members";
      case ProfilesFilter.profileVisitor:
        return "Profile Visitors";
      case ProfilesFilter.recentlyViewed:
        return "Recently Viewed";
    }
  }

  String get asset {
    switch (this) {
      case ProfilesFilter.recommendedProfile:
        return "images/Check.svg";
      case ProfilesFilter.onlineMembers:
        return "images/online.svg";
      case ProfilesFilter.premiumMembers:
        return "images/Check.svg";
      case ProfilesFilter.profileVisitor:
        return "images/prodile_visitor.svg";
      case ProfilesFilter.recentlyViewed:
        return "images/Search.svg";
    }
  }
}

// iconText(
//     action: () {
//       print("Hello");
//       // Navigator.of(context).push(
//       //   MaterialPageRoute(
//       //       builder: (context) =>
//       //           HomeScreen(
//       //             userRepository: state
//       //                 .userRepository,
//       //             list: state.list,
//       //             searchList:
//       //             widget.searchList,
//       //             premiumList: widget
//       //                 .premiumList,
//       //             recentViewList: widget
//       //                 .recentViewList,
//       //             profileVisitorList: widget
//       //                 .profileVisitorList,
//       //             onlineMembersList: widget
//       //                 .onlineMembersList,
//       //             screenName: "",
//       //           )),
//       // );
//     },
//     leading:
//         // Icon(Icons.search),
//         SvgPicture.asset(
//       'images/tick.svg',
//       color: gray4,
//     ),
//     text: "Recommended Profile"),
// iconText(
//     leading:
//         // Icon(Icons.online_prediction),
//         Image.asset(
//             'images/online.png'),
//     text: "Online Members"),
// iconText(
//     action: () {
//       print("Hello");
//       // Navigator.of(context).push(
//       //   MaterialPageRoute(
//       //       builder: (context) =>
//       //           HomeScreen(
//       //             userRepository: widget
//       //                 .userRepository,
//       //             list: widget.list,
//       //             searchList:
//       //             widget.searchList,
//       //             premiumList: widget
//       //                 .premiumList,
//       //             recentViewList: widget
//       //                 .recentViewList,
//       //             profileVisitorList: widget
//       //                 .profileVisitorList,
//       //             onlineMembersList: widget
//       //                 .onlineMembersList,
//       //             screenName:
//       //             "PremiumMembers",
//       //           )),
//       // );
//     },
//     leading:
//         //Icon(Icons.workspace_premium),
//         Image.asset(
//             'images/crown.png'),
//     text: "Premium Members"),
// iconText(
//     action: () {
//       print("Hello");
//       // Navigator.of(context).push(
//       //   MaterialPageRoute(
//       //       builder: (context) =>
//       //           HomeScreen(
//       //             userRepository: widget
//       //                 .userRepository,
//       //             list: widget.list,
//       //             searchList:
//       //             widget.searchList,
//       //             premiumList: widget
//       //                 .premiumList,
//       //             recentViewList: widget
//       //                 .recentViewList,
//       //             profileVisitorList: widget
//       //                 .profileVisitorList,
//       //             onlineMembersList: widget
//       //                 .onlineMembersList,
//       //             screenName:
//       //             "ProfileViewedBy",
//       //           )),
//       // );
//     },
//     leading:
//         // Icon(Icons.visibility_outlined),
//         Image.asset(
//       'images/profileVisitors.png',
//     ),
//     text: "Profile Visitors"),
// iconText(
//     action: () {
//       print("Hello");
//       // Navigator.of(context).push(
//       //   MaterialPageRoute(
//       //       builder: (context) =>
//       //           HomeScreen(
//       //             userRepository: widget
//       //                 .userRepository,
//       //             list: widget.list,
//       //             searchList:
//       //             widget.searchList,
//       //             premiumList: widget
//       //                 .premiumList,
//       //             recentViewList: widget
//       //                 .recentViewList,
//       //             profileVisitorList: widget
//       //                 .profileVisitorList,
//       //             onlineMembersList: widget
//       //                 .onlineMembersList,
//       //             screenName:
//       //             "ProfileRecentlyViewed",
//       //           )),
//       // );
//     },
//     leading:
//         //Icon(Icons.search),
//         Image.asset(
//             'images/searchHome.png'),
//     text: "Recently Viewed"),

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

// Positioned(
//   left: 8,
//   top: 8,
//   child:
// state.screenName == '' || state.screenName == null
// ? Container(
// width: 0,
// height: 44,
// )
// //  Container(
// //     width: 44,
// //     height: 44,
// //     // alignment: Alignment.center,
// //     decoration: BoxDecoration(
// //         color: kLight4,
// //         boxShadow: [
// //           MmmShadow.filterButton(
// //               shadowColor: kShadowColorForGrid)
// //         ],
// //         borderRadius: BorderRadius.all(Radius.circular(8))),
// //     child:
// //     ClipRRect(
// //       borderRadius: BorderRadius.circular(8),
// //       child:
// //       Material(
// //           color: Colors.transparent,
// //           child:
// //           InkWell(
// //               onTap: () {
// //                 print("search button click");
// //                 showOptionsSearchThroughId(this.searchText);
// //               },
// //               child: Container(
// //                 padding: EdgeInsets.all(10),
// //                 child: SvgPicture.asset(
// //                   'images/Search.svg',
// //                   fit: BoxFit.cover,
// //                 ),
// //               ))
// //               ),
// //     ))
// : Container(
// width: 0,
// height: 44,
// ),
// ),
