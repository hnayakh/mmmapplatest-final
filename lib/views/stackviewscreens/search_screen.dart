import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';

import '../../saurabh/partner_preference.dart';
import '../home/matching_profile/views/matching_profile.dart';
import '../profile_detail_view/profile_view.dart';
import '../profile_detail_view/profile_view_bloc.dart';
import '../profile_detail_view/profile_view_event.dart';
import '../profile_detail_view/profile_view_state.dart';

class SearchScreen extends StatefulWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile> premiumList;
  final List<MatchingProfile> recentViewList;
  final List<MatchingProfile> profileVisitorList;
  final List<MatchingProfile> onlineMembersList;

  const SearchScreen(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.premiumList,
      required this.searchList,
      required this.recentViewList,
      required this.profileVisitorList,
      required this.onlineMembersList})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var index;
  late String message;
  late bool isDilogueVisible = true;
  final myController = TextEditingController();

  String? searchText = "";

  @override
  void initState() {
    message = "";
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
    return BlocConsumer<ProfileViewBloc, ProfileViewState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is OnGotProfileDetails) {
          var profileDetails =
              BlocProvider.of<ProfileViewBloc>(context).profileDetails;
          showOptionsSearchThroughId(profileDetails);
        }
      },
      builder: (context, state) {
        if (state is OnErrorView) {
          this.message = BlocProvider.of<ProfileViewBloc>(context).message;
          print("MESSAGE${this.message}");

        }
        return Scaffold(
          appBar: MmmButtons.appBarCurved('Search',context: context, isTopLevel: true),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: kMargin16,
                  height: MediaQuery.of(context).size.height * 0.757,
                  child: SingleChildScrollView(
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
                                          myController.selection =
                                              TextSelection.collapsed(offset: myController.text.length);

                                        },
                                        controller: myController,
                                        keyboardType: TextInputType.name,
                                        maxLines: 1,
                                        maxLength: 15,
                                        textInputAction: TextInputAction.done,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$'), replacementString: '${myController.text}')
                                        ],
                                        decoration: InputDecoration(

                                          counterText: '',
                                          hintText: "MMABC1234",
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              ProfileViewBloc>(
                                                          context)
                                                      .add(GetProfileViewDetails(
                                                          myController.text));
                                                  print("search button click");
                                                  // setState(() {
                                                  //   isDilogueVisible = true;
                                                  // });
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [
                                    MmmShadow.filterButton(
                                        shadowColor: kShadowColorForGrid)
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PartnerPrefsScreen(
                                                userRepository:
                                                    widget.userRepository,
                                                    forFilters: true
                                              ),
                                            ),
                                          );
                                        },
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
                        this.message == "No user found for given DisplayId" &&
                                state is OnErrorView
                            ? this.isDilogueVisible
                                ? AlertDialog(
                                    backgroundColor: kWhite,
                                    title: Text("User doesn't exist",
                                        textAlign: TextAlign.center,
                                        style: TextStyle( fontFamily: 'MakeMyMarry', 
                                            fontWeight: FontWeight
                                                .bold)), // To display the title it is optional
                                    content: new RichText(
                                      textAlign: TextAlign.center,
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: new TextStyle( fontFamily: 'MakeMyMarry', 
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text: 'Please enter correct'),
                                          new TextSpan(
                                              text: ' mmyid',
                                              style:
                                                  new TextStyle( fontFamily: 'MakeMyMarry', color: kPrimary)),
                                          new TextSpan(
                                              text:
                                                  ' to find your perfect match.'),
                                        ],
                                      ),
                                    ),
                                    // Action widget which will provide the user to acknowledge the choice
                                    actions: [
                                      MmmButtons.primaryButton("Ok", () {
                                        setState(() {
                                          isDilogueVisible = false;
                                        });
                                        //navigateToSearch(state);
                                      })
                                    ],
                                  )
                                : Container()
                            : SizedBox(
                                height: 5,
                              ),
                        MmmButtons.searchButtons(
                          'images/online.svg',
                          'Online Members',
                          action: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MatchingProfileScreen(
                                  list: widget.list,
                                  filter: ProfilesFilter.onlineMembers,
                                  isTopLevel: false,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5),
                        MmmButtons.searchButtons(
                            'images/online.svg', 'Premium Members', action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MatchingProfileScreen(
                                list: widget.list,
                                filter: ProfilesFilter.premiumMembers,
                                isTopLevel: false,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 5),
                        MmmButtons.searchButtons(
                            'images/profileViewed.svg', 'Profile Viewed by',
                            action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MatchingProfileScreen(
                                list: widget.list,
                                filter: ProfilesFilter.profileVisitor,
                                isTopLevel: false,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 5),
                        MmmButtons.searchButtons(
                            'images/Search.svg', 'Profile Recently Viewed',
                            action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MatchingProfileScreen(
                                list: widget.list,
                                filter: ProfilesFilter.recentlyViewed,
                                isTopLevel: false,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 5),
                        MmmButtons.searchButtons(
                            'images/Check.svg', 'Recommended Profile',
                            action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MatchingProfileScreen(
                                list: widget.list,
                                filter: ProfilesFilter.recommendedProfile,
                                isTopLevel: false,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //         child: (Container(
                //       height: 68,
                //       decoration: BoxDecoration(boxShadow: [
                //         MmmShadow.elevationStack(),
                //       ]),
                //       padding: EdgeInsets.only(top: 8, bottom: 8),
                //       child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                //           children: [
                //             MmmWidgets.bottomBarUnits(
                //                 'images/Search.svg',
                //                 'Search',
                //                 index == 0 ? kPrimary : gray3, action: () {
                //               setColor(0);
                //             }),
                //             MmmWidgets.bottomBarUnits(
                //                 'images/filter2.svg',
                //                 'Filter',
                //                 index == 1 ? kPrimary : gray3, action: () {
                //               setColor(1);
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                     builder: (context) => FilterPrefsScreen(
                //                         userRepository: widget.userRepository)),
                //               );
                //             }),
                //             MmmWidgets.bottomBarUnits(
                //                 'images/connect.svg',
                //                 'Connect',
                //                 index == 2 ? kPrimary : gray3, action: () {
                //               setColor(2);
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                     builder: (context) => MyConnects(
                //                         userRepository: widget.userRepository)),
                //               );
                //             }),
                //             MmmWidgets.bottomBarUnits(
                //                 'images/Search.svg',
                //                 'Notifications',
                //                 index == 3 ? kPrimary : gray3, action: () {
                //               setColor(3);
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                     builder: (context) => Notifications(
                //                           userRepository: widget.userRepository,
                //                         )),
                //               );
                //             }),
                //             MmmWidgets.bottomBarUnits('images/menu.svg', 'More',
                //                 index == 4 ? kPrimary : gray3, action: () {
                //               setColor(4);
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                     builder: (context) => AppDrawer(
                //                           userRepository: widget.userRepository,
                //                         )),
                //               );
                //             })
                //           ]),
                //     ))),
                //   ],
                // )
              ],
            ),
          ),
        );
      },
    );
  }

  void showOptionsSearchThroughId(ProfileDetails profileDetails) async {
    // context.read<MatchingProfileBloc>().add(OnSearchByMMID(this.searchText));
    // print('SearchhhhNow');
    //print(searchList);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //       builder: (context) => PremiumMembersScreen(
    //             userRepository: widget.userRepository,
    //             list: widget.list,
    //             searchList: widget.searchList,
    //             premiumList: widget.premiumList,
    //             recentViewList: widget.recentViewList,
    //             profileVisitorList: widget.profileVisitorList,
    //             onlineMembersList: widget.onlineMembersList,
    //             screenName: "SearchMMID",
    //             searchText: this.searchText,
    //           )),
    // );
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ProfileView(
                userRepository: widget.userRepository,
                profileDetails: profileDetails,
                // list: widget.list,
                // searchList: widget.searchList,
                // premiumList: widget.premiumList,
                // recentViewList: widget.recentViewList,
                // profileVisitorList: widget.profileVisitorList,
                // onlineMembersList: widget.onlineMembersList,
                // screenName: "SearchMMID",
                // searchText: this.searchText,
              )),
    );
  }

  void navigateToSearch(state) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
    //  else {
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => SearchScreen(
    //             userRepository: widget.userRepository,
    //             list: widget.list,
    //             searchList: widget.searchList,
    //             premiumList: widget.premiumList,
    //             recentViewList: widget.recentViewList,
    //             profileVisitorList: widget.profileVisitorList,
    //             onlineMembersList: widget.onlineMembersList,
    //           )));
    // }
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }
}
