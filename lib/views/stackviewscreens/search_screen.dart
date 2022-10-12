import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/premium_members/premium_members.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/custom_drawer.dart';
import 'package:makemymarry/saurabh/filter_preference.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/stackviewscreens/notification_list.dart';

import '../home/matching_profile/matching_profile_bloc.dart';
import '../home/matching_profile/matching_profile_event.dart';

class SearchScreen extends StatefulWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile> premiumList;
  final List<MatchingProfile> recentViewList;

  const SearchScreen(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.premiumList,
      required this.searchList,
      required this.recentViewList})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var index;
  final myController = TextEditingController();

  String? searchText = "";

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
//  myController.value = TextEditingValue(text: "MM");
    myController.addListener(onChangeTextSearch);
  }

  void onChangeTextSearch() {
    setState(() {
      this.searchText = myController.text;
    });
    print('Second text field: ${myController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved(
        'Search',
        // context: context
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: kMargin16,
              height: MediaQuery.of(context).size.height * 0.757,
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.74,
                            height: 60,
                            padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [MmmShadow.elevation1()]),
                            child: Container(
                              width: 100,
                              child: TextField(
                                  onTap: () {
                                    myController.value =
                                        TextEditingValue(text: "MM");
                                  },
                                  controller: myController,
                                  //controller: cntrlr,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 1,
                                  maxLength: 15,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: "MMABC123",
                                    hintStyle: MmmTextStyles.bodyRegular(
                                        textColor: gray4),
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                  )),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
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
                                            print("search button click");
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
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        height: MediaQuery.of(context).size.width * 0.14,
                        //alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              MmmShadow.filterButton(
                                  shadowColor: kShadowColorForGrid)
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: SvgPicture.asset(
                                      'images/filter2.svg',
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  MmmButtons.searchButtons(
                      'images/online.svg', 'Online Members', action: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PremiumMembersScreen(
                                userRepository: widget.userRepository,
                                list: widget.list,
                                searchList: widget.searchList,
                                premiumList: widget.premiumList,
                                recentViewList: widget.recentViewList,
                                screenName: "OnlineMembers",
                              )),
                    );
                  }),
                  SizedBox(height: 8),
                  MmmButtons.searchButtons(
                      'images/online.svg', 'Premium Members', action: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PremiumMembersScreen(
                                userRepository: widget.userRepository,
                                list: widget.list,
                                searchList: widget.searchList,
                                premiumList: widget.premiumList,
                                recentViewList: widget.recentViewList,
                                screenName: "PremiumMembers",
                              )),
                    );
                  }),
                  SizedBox(height: 8),
                  MmmButtons.searchButtons(
                      'images/profileViewed.svg', 'Profile Viewed by',
                      action: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PremiumMembersScreen(
                                userRepository: widget.userRepository,
                                list: widget.list,
                                searchList: widget.searchList,
                                premiumList: widget.premiumList,
                                recentViewList: widget.recentViewList,
                                screenName: "ProfileViewedBy",
                              )),
                    );
                  }),
                  SizedBox(height: 8),
                  MmmButtons.searchButtons(
                      'images/Search.svg', 'Profile Recently Viewed',
                      action: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PremiumMembersScreen(
                                userRepository: widget.userRepository,
                                list: widget.list,
                                searchList: widget.searchList,
                                premiumList: widget.premiumList,
                                recentViewList: widget.recentViewList,
                                screenName: "ProfileRecentlyViewed",
                              )),
                    );
                  }),
                  SizedBox(height: 8),
                  MmmButtons.searchButtons(
                      'images/Check.svg', 'Recommended Profile', action: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PremiumMembersScreen(
                                userRepository: widget.userRepository,
                                list: widget.list,
                                searchList: widget.searchList,
                                premiumList: widget.premiumList,
                                recentViewList: widget.recentViewList,
                                screenName: "RecomendedProfile",
                              )),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                    child: (Container(
                  height: 68,
                  decoration: BoxDecoration(boxShadow: [
                    MmmShadow.elevationStack(),
                  ]),
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MmmWidgets.bottomBarUnits('images/Search.svg', 'Search',
                            index == 0 ? kPrimary : gray3, action: () {
                          setColor(0);
                        }),
                        MmmWidgets.bottomBarUnits(
                            'images/filter2.svg',
                            'Filter',
                            index == 1 ? kPrimary : gray3, action: () {
                          setColor(1);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => FilterPrefsScreen(
                                    userRepository: widget.userRepository)),
                          );
                        }),
                        MmmWidgets.bottomBarUnits(
                            'images/connect.svg',
                            'Connect',
                            index == 2 ? kPrimary : gray3, action: () {
                          setColor(2);
                        }),
                        MmmWidgets.bottomBarUnits(
                            'images/Search.svg',
                            'Notifications',
                            index == 3 ? kPrimary : gray3, action: () {
                          setColor(3);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Notifications(
                                      userRepository: widget.userRepository,
                                    )),
                          );
                        }),
                        MmmWidgets.bottomBarUnits('images/menu.svg', 'More',
                            index == 4 ? kPrimary : gray3, action: () {
                          setColor(4);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AppDrawer()),
                          );
                        })
                      ]),
                ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showOptionsSearchThroughId() async {
    // context.read<MatchingProfileBloc>().add(OnSearchByMMID(this.searchText));
    // print('SearchhhhNow');
    //print(searchList);
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => PremiumMembersScreen(
                userRepository: widget.userRepository,
                list: widget.list,
                searchList: widget.searchList,
                premiumList: widget.premiumList,
                recentViewList: widget.recentViewList,
                screenName: "",
                searchText: this.searchText,
              )),
    );
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }
}
