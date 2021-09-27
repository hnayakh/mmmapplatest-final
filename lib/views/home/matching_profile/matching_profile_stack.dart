import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';

import 'matching_profile_state.dart';

class MatchingProfileStackView extends StatelessWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;

  const MatchingProfileStackView(
      {Key? key, required this.userRepository, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchingProfileBloc(userRepository, list),
      child: MatchingProfileStackViewScreen(),
    );
  }
}

class MatchingProfileStackViewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MatchingProfileStackViewScreenState();
  }
}

class MatchingProfileStackViewScreenState
    extends State<MatchingProfileStackViewScreen>
    with TickerProviderStateMixin {
  late List<MatchingProfile> list;
  late CardController controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
      builder: (context, state) {
        this.list = BlocProvider.of<MatchingProfileBloc>(context).list;
        return Container(
          height: MediaQuery.of(context).size.height - 72,
          width: MediaQuery.of(context).size.width,
          color: gray5,
          child: new TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.TOP,
            totalNum: list.length,
            stackNum: list.length,
            allowVerticalMovement: true,
            swipeEdge: 2.5,
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height - 128,
            minWidth: MediaQuery.of(context).size.width - 0.1,
            minHeight: MediaQuery.of(context).size.height - 144,
            cardBuilder: (context, index) => Card(
              child: Stack(
                children: [
                  ClipRRect(
                    child: Image.network(
                      '${list[index].imageUrl}',
                      height: MediaQuery.of(context).size.height - 100,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18)),
                  ),
                  Positioned(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${list[index].name}, ${AppHelper.getAgeFromDob(list[index].dateOfBirth)}",
                                      style: MmmTextStyles.heading5(
                                          textColor: gray6),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Stack(
                                      children: [
                                        SvgPicture.asset(
                                          "images/Verified.svg",
                                          color: Colors.white,
                                          width: 24,
                                          height: 24,
                                        ),
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                              color: kPrimary.withAlpha(50),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    )
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
                                    Text(
                                      "${this.list[index].city}, ${this.list[index].state}",
                                      textScaleFactor: 1.0,
                                      style: MmmTextStyles.bodyRegular(
                                          textColor: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
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
                                      gradient:
                                          MmmDecorations.primaryGradient(),
                                      border: Border.all(
                                          color: Colors.white, width: 1.2)),
                                ),
                                Container(
                                    height: 62,
                                    width: 62,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kPrimary.withAlpha(50),
                                        border: Border.all(
                                            color: Colors.white, width: 1.2)))
                              ],
                            ),
                          )
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 23, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.black.withAlpha(50),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18))),
                    ),
                    bottom: 0,
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18))),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              /// Get orientation & index of swiped card!
            },
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
