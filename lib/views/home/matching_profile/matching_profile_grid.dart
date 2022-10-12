import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/matching_percentage/matching_percentage_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/home.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_event.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_state.dart';
import 'package:makemymarry/views/profile_loader/profile_loader_bloc.dart';
import 'package:makemymarry/views/profile_loader/profile_loader_event.dart';
import 'package:makemymarry/views/profileviewscreens/profile_view.dart';
import 'package:makemymarry/views/stackviewscreens/search_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_contactsupport_screen.dart';

import '../../../saurabh/hexcolor.dart';

class MatchingProfileGridView extends StatelessWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  final List<MatchingProfile> premiumList;
  final List<MatchingProfile> recentViewList;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile>? mySearCh;
  final String? screenName;

  const MatchingProfileGridView(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.searchList,
      required this.premiumList,
      required this.recentViewList,
      this.mySearCh,
      this.screenName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<MatchingProfileBloc, MatchingProfileState>(
    //     builder: (context, searchList) {
    //   print("object_search => $searchList");
    return MatchingProfileGridViewScreen();
    // return BlocProvider(
    //   create: (context) =>
    //       MatchingProfileBloc(userRepository, list, searchList, premiumList),
    //   child: MatchingProfileGridViewScreen(),
    // );
    //});
  }
}

class MatchingProfileGridViewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MatchingProfileGridViewScreenState();
  }
}

class MatchingProfileGridViewScreenState
    extends State<MatchingProfileGridViewScreen> {
  List<MatchingProfile> list = [];
  List<MatchingProfile> searchList = [];
  List<MatchingProfile> premiumList = [];
  List<MatchingProfile> recentViewList = [];
  List<MatchingProfile> profileVisitorList = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
        builder: (context, state) {
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

      //}
      print("premiumList$premiumList");
      print("recentC=ViewList$recentViewList");
      print("ProfileVisitorsList$profileVisitorList");
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: kMargin16,
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
                            new TextSpan(text: ' to find your perfect match.'),
                          ],
                        )),
                    // Action widget which will provide the user to acknowledge the choice
                    actions: [
                      MmmButtons.primaryButton("Ok", () {
                        navigateToHome(state);
                      })
                    ],
                  )
                : buildGridView(),
          ),
          state is OnLoading ? MmmWidgets.buildLoader(context) : Container()
        ],
      );
    }, listener: (context, state) {
      if (state is OnGotProfileDetails) {
        navigateToProfileDetails(state.profileDetails);
      }
    });
  }

  int getListLength() {
    var result = this.list.length;
    if (this.premiumList.length > 0) {
      result = this.premiumList.length;
    }
    if (this.profileVisitorList.length > 0) {
      result = this.profileVisitorList.length;
    }
    if (this.recentViewList.length > 0) {
      result = this.recentViewList.length;
    }
    if (this.searchList.length > 0) {
      result = this.searchList.length;
    }
    return result;
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
              profileVisitorList: profileVisitorList)));
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

  getItem(index) {
    var result = this.list[index];
    if (this.premiumList.length > 0) {
      result = this.premiumList[index];
    }
    if (this.searchList.length > 0) {
      result = this.searchList[index];
    }

    return result;
  }

  GridView buildGridView() {
    // var listLength =
    //     this.searchList.length > 0 ? this.searchList.length : this.list.length;
    var listLength = getListLength();

    return GridView.builder(
      padding: const EdgeInsets.only(top: 96),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 4 / 5,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16),
      itemBuilder: (context, index) {
        MatchingProfile item =
            //getItem(index);
            this.searchList.length > 0
                ? this.searchList[index]
                : this.premiumList.length > 0
                    ? this.premiumList[index]
                    : this.recentViewList.length > 0
                        ? this.recentViewList[index]
                        : this.profileVisitorList.length > 0
                            ? this.profileVisitorList[index]
                            : this.list[index];
        print('itemDetails: $item');
        return InkWell(
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  child: Image.network(
                    '${item.imageUrl}',
                    width: (MediaQuery.of(context).size.width - 48) / 2,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                item.activationStatus == ProfileActivationStatus.Verified
                    ? Positioned(
                        child: Container(
                          child: SvgPicture.asset(
                            "images/Verified.svg",
                            color: kSecondary,
                          ),
                        ),
                        top: 2,
                        right: 2,
                      )
                    : Container(),
                Positioned(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.name}, ${AppHelper.getAgeFromDob(item.dateOfBirth)}",
                          style: MmmTextStyles.heading6(textColor: gray6),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "images/location.svg",
                              color: Colors.white,
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Text("${item.city}, ${item.state}",
                                    textScaleFactor: 1.0,
                                    style: MmmTextStyles.bodySmall(
                                        textColor: Colors.white),
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                      ],
                    ),
                    width: (MediaQuery.of(context).size.width - 48) / 2,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.black.withAlpha(50),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4))),
                  ),
                  bottom: 0,
                )
              ],
            ),
          ),
          onTap: () {
            print("sadasd");
            BlocProvider.of<MatchingProfileBloc>(context)
                .add(GetProfileDetails(index));
          },
        );
      },
      itemCount: listLength,
    );
  }

  void navigateToProfileDetails(ProfileDetails profileDetails) {
    var userRepo = BlocProvider.of<MatchingProfileBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider(
              create: (context) =>
                  MatchingPercentageBloc(userRepo, profileDetails),
              child: ProfileView(
                userRepository: userRepo,
                profileDetails: profileDetails,
              ),
            )));
  }
}
