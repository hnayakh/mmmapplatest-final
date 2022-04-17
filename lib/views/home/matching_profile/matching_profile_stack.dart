import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_tindercard/flutter_tindercard.dart';

import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';
import 'package:makemymarry/views/profileviewscreens/profile_view.dart';

import 'matching_profile_event.dart';
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
  late bool isLiked;

  // late CardController controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
      builder: (context, state) {
        this.list = BlocProvider.of<MatchingProfileBloc>(context).list;
        return Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height - 72,
                width: MediaQuery.of(context).size.width,
                color: gray5,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    initData(index);
                    return Stack(
                      children: [
                        Card(
                          child: InkWell(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    '${list[index].imageUrl}',
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
                                                    "${list[index].name}, ${AppHelper.getAgeFromDob(list[index].dateOfBirth)}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        MmmTextStyles.heading5(
                                                            textColor: gray6),
                                                  )
                                                  //)
                                                  ,
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  list[index].activationStatus ==
                                                          ProfileActivationStatus
                                                              .Verified
                                                      ? Stack(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "images/Verified.svg",
                                                              color:
                                                                  Colors.white,
                                                              width: 24,
                                                              height: 24,
                                                            ),
                                                            Container(
                                                              height: 24,
                                                              width: 24,
                                                              decoration: BoxDecoration(
                                                                  color: kPrimary
                                                                      .withAlpha(
                                                                          50),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6)),
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
                                                    "${this.list[index].city}, ${this.list[index].state}",
                                                    textScaleFactor: 1.0,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: MmmTextStyles
                                                        .bodyRegular(
                                                            textColor:
                                                                Colors.white),
                                                  )
                                                  //)
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
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
                            onTap: () {
                              BlocProvider.of<MatchingProfileBloc>(context)
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
                          child: InkWell(
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
                              )

                              // !isLiked
                              //     ? Stack(
                              //         children: [
                              //           Container(
                              //               height: 62,
                              //               width: 62,
                              //               decoration: BoxDecoration(
                              //                   shape: BoxShape.circle,
                              //                   color: kLight4,
                              //                   border: Border.all(
                              //                       color: kPrimaryHeart,
                              //                       width: 1.2))),
                              //           Container(
                              //             height: 62,
                              //             width: 62,
                              //             child: Center(
                              //               child: SvgPicture.asset(
                              //                 "images/heart.svg",
                              //                 color: kPrimaryHeart,
                              //                 height: 32,
                              //                 width: 32,
                              //               ),
                              //             ),
                              //             decoration: BoxDecoration(
                              //                 shape: BoxShape.circle,
                              //                 border: Border.all(
                              //                     color: kPrimaryHeart,
                              //                     width: 1.2)),
                              //           ),
                              //         ],
                              //       )
                              //     : Stack(
                              //         children: [
                              //           Container(
                              //             height: 62,
                              //             width: 62,
                              //             child: Center(
                              //               child: SvgPicture.asset(
                              //                 "images/heart.svg",
                              //                 color: Colors.white,
                              //                 height: 32,
                              //                 width: 32,
                              //               ),
                              //             ),
                              //             decoration: BoxDecoration(
                              //                 shape: BoxShape.circle,
                              //                 gradient: MmmDecorations
                              //                     .primaryGradient(),
                              //                 border: Border.all(
                              //                     color: Colors.white,
                              //                     width: 1.2)),
                              //           ),
                              //           Container(
                              //               height: 62,
                              //               width: 62,
                              //               decoration: BoxDecoration(
                              //                   shape: BoxShape.circle,
                              //                   color: kPrimary.withAlpha(50),
                              //                   border: Border.all(
                              //                       color: Colors.white,
                              //                       width: 1.2)))
                              //         ],
                              //       ),
                              ),
                        ),
                      ],
                    );
                  },
                  itemCount: list.length,
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

  void navigateToProfileDetails(ProfileDetails profileDetails) {
    var userRepo = BlocProvider.of<MatchingProfileBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileView(
              userRepository: userRepo,
              profileDetails: profileDetails,
            )));
  }

  void initData(int index) {
    this.isLiked =
        BlocProvider.of<MatchingProfileBloc>(context).isLikedList[index];
  }
}
