import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/matching_percentage/matching_percentage_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_event.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_state.dart';
import 'package:makemymarry/views/profileviewscreens/profile_view.dart';

class MatchingProfileGridView extends StatelessWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;
  final List<MatchingProfile> premiumList;
  final List<MatchingProfile> searchList;
  final List<MatchingProfile>? mySearCh;
  final String? screenName;

  const MatchingProfileGridView(
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
    // return BlocBuilder<MatchingProfileBloc, MatchingProfileState>(
    //     builder: (context, searchList) {
    //   print("object_search => $searchList");
    return MatchingProfileGridViewScreen();
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
        builder: (context, state) {
      if (state is MatchingProfileInitialState) {
        this.list = BlocProvider.of<MatchingProfileBloc>(context).list;
      }
      if (state is OnSearchByMMID) {
        this.searchList =
            BlocProvider.of<MatchingProfileBloc>(context).searchList;
      }
      if (state is OnGotPremium) {
        this.premiumList =
            BlocProvider.of<MatchingProfileBloc>(context).premiumList;
      }
      //}
      print("premiumList$premiumList");
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: kMargin16,
            child: buildGridView(),
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
    if (this.searchList.length > 0) {
      result = this.searchList.length;
    }
    return result;
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
        MatchingProfile item = getItem(index);
        // this.searchList.length > 0
        //     ? this.searchList[index]
        //     : this.list[index];
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
