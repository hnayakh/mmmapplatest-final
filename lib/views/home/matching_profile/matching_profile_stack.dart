import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/connect.dart';
// import 'package:flutter_tindercard/flutter_tindercard.dart';

import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/home.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';
import 'package:makemymarry/views/profileviewscreens/profile_view.dart';

import 'matching_profile_event.dart';
import 'matching_profile_state.dart';

class MatchingProfileStackView extends StatelessWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile>? mySearCh;
  final List<MatchingProfile> premiumList;
  final String? screenName;

  const MatchingProfileStackView(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.searchList,
      required this.premiumList,
      this.mySearCh,
      this.screenName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) =>
    //       MatchingProfileBloc(userRepository, this.list, this.searchList),
    //   child: MatchingProfileStackViewScreen(),
    // );
    return MatchingProfileStackViewScreen(this.screenName!);
  }
}

class MatchingProfileStackViewScreen extends StatefulWidget {
  final String screenName;
  MatchingProfileStackViewScreen(this.screenName);

  @override
  State<StatefulWidget> createState() {
    return MatchingProfileStackViewScreenState(this.screenName);
  }
}

class MatchingProfileStackViewScreenState
    extends State<MatchingProfileStackViewScreen>
    with TickerProviderStateMixin {
  List<MatchingProfile> list = [];
  List<MatchingProfile> searchList = [];
  List<MatchingProfile> premiumList = [];
  List<MatchingProfile> recentViewList = [];
  List<MatchingProfile> profileVisitorList = [];

  MatchingProfileStackViewScreenState(screenName);
  //late List<MatchingProfileSearch> myNewSearch;
  late bool isLiked;

  //from grid
  // int getListLength() {
  //   var result = this.list.length;
  //   if (this.premiumList.length > 0) {
  //     result = this.premiumList.length;
  //   }
  //   if (this.profileVisitorList.length > 0) {
  //     result = this.profileVisitorList.length;
  //   }
  //   if (this.recentViewList.length > 0) {
  //     result = this.recentViewList.length;
  //   }
  //   if (this.searchList.length > 0) {
  //     result = this.searchList.length;
  //   }
  //   return result;
  // }
  int getListLength(screenName) {
    var result = this.list.length;
    if (screenName == "") {
      return result;
    }
    if (screenName == "PremiumMembers" && this.premiumList.length > 0) {
      result = this.premiumList.length;
    }
    if (screenName == "ProfileViewedBy" && this.profileVisitorList.length > 0) {
      result = this.profileVisitorList.length;
    }
    if (screenName == "ProfileRecentlyViewed" &&
        this.recentViewList.length > 0) {
      result = this.recentViewList.length;
    }
    if (screenName == "SearchMMID" && this.searchList.length > 0) {
      result = this.searchList.length;
    }
    return result;
  }

//from grid
  // getItem(index) {
  //   var result = this.list[index];
  //   if (this.premiumList.length > 0) {
  //     result = this.premiumList[index];
  //   }
  //   if (this.searchList.length > 0) {
  //     result = this.searchList[index];
  //   }

  //   return result;
  // }
  getItem(index, screenName) {
    var result = this.list[index];
    if (screenName == "") {
      return result;
    }
    if (screenName == "PremiumMembers" && this.premiumList.length > 0) {
      result = this.premiumList[index];
    }
    if (screenName == "ProfileViewedBy" && this.profileVisitorList.length > 0) {
      result = this.profileVisitorList[index];
    }
    if (screenName == "ProfileRecentlyViewed" &&
        this.recentViewList.length > 0) {
      result = this.recentViewList[index];
    }
    if (screenName == "SearchMMID" && this.searchList.length > 0) {
      result = this.searchList[index];
    }

    return result;
  }

  // late CardController RepositoryProvider(
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
      builder: (context, state) {
        // this.list = BlocProvider.of<MatchingProfileBloc>(context).list;
        // this.searchList =
        //     BlocProvider.of<MatchingProfileBloc>(context).searchList;
        // this.premiumList =
        //     BlocProvider.of<MatchingProfileBloc>(context).premiumList;
        // this.myNewSearch =
        //  BlocProvider.of<MatchingProfileBloc>(context).searchList;
        if (widget.screenName == "") {
          this.searchList = [];
          this.premiumList = [];
          this.recentViewList = [];
          this.profileVisitorList = [];
          this.list = BlocProvider.of<MatchingProfileBloc>(context).list;
        }
        if (state is MatchingProfileInitialState ||
            state is OnGotProfileDetails) {
          this.list = BlocProvider.of<MatchingProfileBloc>(context).list;
        }
        if (state is OnMMIDSearch) {
          this.searchList =
              BlocProvider.of<MatchingProfileBloc>(context).searchList;
        }
        if (state is OnGotPremium) {
          this.premiumList =
              BlocProvider.of<MatchingProfileBloc>(context).premiumList;
        }
        if (state is OnGotRecentView) {
          this.recentViewList =
              BlocProvider.of<MatchingProfileBloc>(context).recentViewList;
        }
        if (state is onGotProfileVisitors) {
          this.profileVisitorList =
              BlocProvider.of<MatchingProfileBloc>(context).profileVisitorList;
        }
        print("test");
        // print(myNewSearch);
        var listLength = getListLength(widget.screenName);
        // this.searchList.length > 0
        //     ? this.searchList.length
        //     : this.list.length;
        return Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height - 72,
                width: MediaQuery.of(context).size.width,
                color: gray5,
                child: this.searchList.length == 0 && state is OnMMIDSearch
                    ? AlertDialog(
                        backgroundColor: kWhite,
                        title: Text("User doesn't exist",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight
                                    .bold)), // To display the title it is optional
                        content: new RichText(
                            textAlign: TextAlign.center,
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(text: 'Please enter correct'),
                                new TextSpan(
                                    text: ' mmyid',
                                    style: new TextStyle(color: kPrimary)),
                                new TextSpan(
                                    text: ' to find your perfect match.'),
                              ],
                            )),
                        // Action widget which will provide the user to acknowledge the choice
                        actions: [
                          MmmButtons.primaryButton("Ok", () {
                            navigateToHome(state);
                          })
                        ],
                      )
                    : PageView.builder(
                        itemBuilder: (context, index) {
                          MatchingProfile item =
                              getItem(index, widget.screenName);
                          // this.searchList.length > 0
                          //     ? this.searchList[index]
                          //     : this.premiumList.length > 0
                          //         ? this.premiumList[index]
                          //         : this.recentViewList.length > 0
                          //             ? this.recentViewList[index]
                          //             : this.profileVisitorList.length > 0
                          //                 ? this.profileVisitorList[index]
                          //                 : this.list[index];

                          initData(index);

                          return Stack(
                            children: [
                              Card(
                                child: InkWell(
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        child: Image.network(
                                          '${item.imageUrl}',
                                          height: double.maxFinite,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(18),
                                            bottomRight: Radius.circular(18)),
                                      ),
                                      Positioned(
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        // Expanded(
                                                        //     child:
                                                        Text(
                                                          "${item.name}, ${AppHelper.getAgeFromDob(item.dateOfBirth)}",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: MmmTextStyles
                                                              .heading5(
                                                                  textColor:
                                                                      gray6),
                                                        )
                                                        //)
                                                        ,
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        item.activationStatus ==
                                                                ProfileActivationStatus
                                                                    .Verified
                                                            ? Stack(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "images/Verified.svg",
                                                                    color: Colors
                                                                        .white,
                                                                    width: 24,
                                                                    height: 24,
                                                                  ),
                                                                  Container(
                                                                    height: 24,
                                                                    width: 24,
                                                                    decoration: BoxDecoration(
                                                                        color: kPrimary.withAlpha(
                                                                            50),
                                                                        borderRadius:
                                                                            BorderRadius.circular(6)),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                ],
                                                              )
                                                            : Container()
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          "images/location.svg",
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        // Expanded(
                                                        //     child:
                                                        Text(
                                                          searchList.length > 0
                                                              ? ''
                                                              : "${item.city}, ${item.state}",
                                                          textScaleFactor: 1.0,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: MmmTextStyles
                                                              .bodyRegular(
                                                                  textColor:
                                                                      Colors
                                                                          .white),
                                                        )
                                                        //)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ],
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 23, horizontal: 16),
                                          decoration: BoxDecoration(
                                              color: Colors.black.withAlpha(50),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(18),
                                                  bottomRight:
                                                      Radius.circular(18))),
                                        ),
                                        bottom: 0,
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    BlocProvider.of<MatchingProfileBloc>(
                                            context)
                                        .add(GetProfileDetails(index));
                                  },
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(18),
                                        bottomRight: Radius.circular(18))),
                                elevation: 4,
                                margin: const EdgeInsets.only(bottom: 16),
                              ),
                              Positioned(
                                bottom: 30,
                                right: 20,
                                child: item.isConnected
                                    ? buildConnected(context, index)
                                    : buildInterest(context, index),
                              ),
                            ],
                          );
                        },
                        itemCount: listLength,
                        scrollDirection: Axis.vertical,
                      )),
            state is OnLoading ? MmmWidgets.buildLoader(context) : Container()
          ],
        );
      },
      listener: (context, state) {
        if (state is OnGotProfileDetails) {
          navigateToProfileDetails(state.profileDetails);
        }
      },
    );
  }

  InkWell buildInterest(BuildContext context, int index) {
    MatchingProfile item = this.searchList.length > 0
        ? this.searchList[index]
        : this.premiumList.length > 0
            ? this.premiumList[index]
            : this.recentViewList.length > 0
                ? this.recentViewList[index]
                : this.profileVisitorList.length > 0
                    ? this.profileVisitorList[index]
                    : this.list[index];
    if (item.requestStatus == InterestRequest.Accepted) {
      buildConnect(context, index);
    } else if (item.requestStatus == InterestRequest.Sent) {
      return InkWell(
          onTap: () {
            BlocProvider.of<MatchingProfileBloc>(context)
                .add(IsLikedAEvent(index));
          },
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    child: Center(
                      child: SvgPicture.asset(
                        "images/cancel.svg",
                        color: Colors.white,
                        height: 32,
                        width: 32,
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: MmmDecorations.primaryGradient(),
                        border: Border.all(color: Colors.white, width: 1.2)),
                  ),
                  Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimary.withAlpha(50),
                          border: Border.all(color: Colors.white, width: 1.2)))
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    child: Center(
                      child: SvgPicture.asset(
                        "images/heart.svg",
                        color: Colors.white,
                        height: 32,
                        width: 32,
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: MmmDecorations.primaryGradient(),
                        border: Border.all(color: Colors.white, width: 1.2)),
                  ),
                  Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kGreen.withAlpha(50),
                          border: Border.all(color: Colors.white, width: 1.2)))
                ],
              )
            ],
          ));
    } else if (item.requestStatus == InterestRequest.Received) {
      return InkWell(
          onTap: () {
            BlocProvider.of<MatchingProfileBloc>(context)
                .add(IsLikedAEvent(index));
          },
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    child: Center(
                      child: SvgPicture.asset(
                        "images/Cross.svg",
                        color: Colors.white,
                        height: 32,
                        width: 32,
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kShadowColorForGrid.withAlpha(7),
                        border: Border.all(color: Colors.white, width: 1.2)),
                  ),
                  Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimary.withAlpha(50),
                          border: Border.all(color: Colors.white, width: 1.2)))
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    child: Center(
                      child: SvgPicture.asset(
                        "images/Check.svg",
                        color: Colors.white,
                        height: 32,
                        width: 32,
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: MmmDecorations.primaryGradient(),
                        border: Border.all(color: Colors.white, width: 1.2)),
                  ),
                  Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kGreen.withAlpha(50),
                          border: Border.all(color: Colors.white, width: 1.2)))
                ],
              )
            ],
          ));
    }
    return InkWell(
        onTap: () {
          BlocProvider.of<MatchingProfileBloc>(context)
              .add(IsLikedAEvent(index));
        },
        child: Stack(
          children: [
            Container(
              height: 62,
              width: 62,
              child: Center(
                child: SvgPicture.asset(
                  "images/heart.svg",
                  color: Colors.white,
                  height: 32,
                  width: 32,
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: MmmDecorations.primaryGradient(),
                  border: Border.all(color: Colors.white, width: 1.2)),
            ),
            Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimary.withAlpha(50),
                    border: Border.all(color: Colors.white, width: 1.2)))
          ],
        ));
  }

  InkWell buildConnect(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          BlocProvider.of<MatchingProfileBloc>(context)
              .add(IsLikedAEvent(index));
        },
        child: Stack(
          children: [
            Container(
              height: 62,
              width: 62,
              child: Center(
                child: SvgPicture.asset(
                  "images/heart.svg",
                  color: Colors.white,
                  height: 32,
                  width: 32,
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: MmmDecorations.primaryGradient(),
                  border: Border.all(color: Colors.white, width: 1.2)),
            ),
            Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kGreen.withAlpha(50),
                    border: Border.all(color: Colors.white, width: 1.2)))
          ],
        ));
  }

  InkWell buildConnected(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          BlocProvider.of<MatchingProfileBloc>(context)
              .add(IsLikedAEvent(index));
        },
        child: Stack(
          children: [
            Container(
              height: 62,
              width: 62,
              child: Center(
                child: SvgPicture.asset(
                  "images/connect.svg",
                  color: Colors.white,
                  height: 32,
                  width: 32,
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: MmmDecorations.primaryGradient(),
                  border: Border.all(color: Colors.white, width: 1.2)),
            ),
            Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimary.withAlpha(50),
                    border: Border.all(color: Colors.white, width: 1.2)))
          ],
        ));
  }

  void navigateToProfileDetails(ProfileDetails profileDetails) {
    var userRepo = BlocProvider.of<MatchingProfileBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileView(
              userRepository: userRepo,
              profileDetails: profileDetails,
            )));
  }

  void navigateToHome(state) {
    print("navigate to home");

    this.list = BlocProvider.of<MatchingProfileBloc>(context).list;
    //  Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => ContactSupportScreen(userRepository)),
    //     );

    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      var userRepo =
          BlocProvider.of<MatchingProfileBloc>(context).userRepository;
      // var list = BlocProvider.of<MatchingProfileBloc>(context).list;
      // var searchList = BlocProvider.of<MatchingProfileBloc>(context).searchList;
      var premiumList =
          BlocProvider.of<MatchingProfileBloc>(context).premiumList;
      var recentViewList =
          BlocProvider.of<MatchingProfileBloc>(context).recentViewList;
      var profileVisitorList =
          BlocProvider.of<MatchingProfileBloc>(context).profileVisitorList;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(
                userRepository: userRepo,
                list: list,
                searchList: searchList,
                premiumList: premiumList,
                recentViewList: recentViewList,
                profileVisitorList: profileVisitorList,
                screenName: "",
              )));
    }
    // premiumList: premiumList)),
    // builder: (context) => ContactSupportScreen(
    //       userRepository: UserRepository(),
    //       // list: this.list,
    //       // searchList: this.searchList,
    //       // premiumList: this.premiumList
    //     )),
    //);
    // Navigator.of(context, rootNavigator: true).pop(context);
    //  if (Navigator.canPop(context)) {
    //   Navigator.of(context).pop();
    // } else {
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (_) => MatchingProfileGridView(
    //             userRepository: UserRepository(),
    //             list: list,
    //             searchList: searchList,
    //             premiumList: premiumList)));
    //  }
    // Navigator.of(context).maybePop();

    //Navigator.of(context, rootNavigator: true).pop('dialog');
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => SearchScreen(
    //           userRepository: UserRepository(),
    //           list: list,
    //           premiumList: premiumList,
    //           searchList: searchList)),
    // );
  }

  void initData(int index) {
    this.isLiked =
        BlocProvider.of<MatchingProfileBloc>(context).isLikedList[index];
  }
}
