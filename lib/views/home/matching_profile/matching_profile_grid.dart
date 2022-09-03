import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
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
  final List<MatchingProfileSearch> searchList;
  final List<MatchingProfileSearch>? mySearCh;

  const MatchingProfileGridView(
      {Key? key,
      required this.userRepository,
      required this.list,
      required this.searchList,
      this.mySearCh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MatchingProfileBloc(userRepository, list, searchList),
      child: MatchingProfileGridViewScreen(),
    );
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
  late List<MatchingProfile> list;
  late List<MatchingProfileSearch> searchList;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
        builder: (context, state) {
      this.list = BlocProvider.of<MatchingProfileBloc>(context).list;
      return Stack(
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

  GridView buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 96),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 4 / 5,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16),
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            child: Stack(
              children: [
                ClipRRect(
                  child: Image.network(
                    '${list[index].imageUrl}',
                    width: (MediaQuery.of(context).size.width - 48) / 2,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                list[index].activationStatus == ProfileActivationStatus.Verified
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
                          "${list[index].name}, ${AppHelper.getAgeFromDob(list[index].dateOfBirth)}",
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
                                child: Text(
                                    "${this.list[index].city}, ${this.list[index].state}",
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
      itemCount: this.list.length,
    );
  }

  void navigateToProfileDetails(ProfileDetails profileDetails) {
    var userRepo = BlocProvider.of<MatchingProfileBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileView(
              userRepository: userRepo,
              profileDetails: profileDetails,
            )));
  }
}
