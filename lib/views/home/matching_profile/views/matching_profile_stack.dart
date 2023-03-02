import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/home/matching_profile/bloc/matching_profile_bloc.dart';
import 'package:makemymarry/views/home/matching_profile/bloc/matching_profile_event.dart';
import 'package:makemymarry/views/home/matching_profile/bloc/matching_profile_state.dart';
import 'package:makemymarry/views/profile_detail_view/profile_view.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../utils/icons.dart';
import '../../../chat_room/chat_page.dart';

class MatchingProfileStackView extends StatelessWidget {
  final List<MatchingProfile> list;

  const MatchingProfileStackView({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
      builder: (context, state) {
        return Container(
            height: MediaQuery.of(context).size.height - 72,
            width: MediaQuery.of(context).size.width,
            color: gray5,
            child: PageView.builder(
              controller: PageController(
                  initialPage: list.indexWhere((element) =>
                              element.id ==
                              context
                                  .read<MatchingProfileBloc>()
                                  .clickedUserId) <
                          0
                      ? 0
                      : list.indexWhere((element) =>
                          element.id ==
                          context.read<MatchingProfileBloc>().clickedUserId)),
              itemBuilder: (context, index) {
                MatchingProfile item = list[index];
                return Stack(
                  children: [
                    Card(
                      child: InkWell(
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: Image.network('${item.imageUrl}',
                                  height: double.maxFinite,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, obj, str) =>
                                      Container(
                                          color: Colors.grey,
                                          child: Icon(Icons.error))),
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
                                              SizedBox(
                                                width: 8,
                                              ),
                                              StreamBuilder<bool>(
                                                  stream: getIt<ChatRepo>()
                                                      .getOnlineStatus(item.id),
                                                  builder: (context, snapshot) {
                                                    return Container(
                                                      height: 8,
                                                      width: 8,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: snapshot
                                                                      .data ==
                                                                  null
                                                              ? kGray
                                                              : snapshot.data!
                                                                  ? kGreen
                                                                  : kError),
                                                    );
                                                  }),
                                              SizedBox(
                                                width: 14,
                                              ),
                                              Text(
                                                "${item.name}, ${AppHelper.getAgeFromDob(item.dateOfBirth)} yrs,  ${AppHelper.heightString(item.height)}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: MmmTextStyles.heading5(
                                                    textColor: gray6),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              item.activationStatus ==
                                                      ProfileActivationStatus
                                                          .Verified
                                                  ? Stack(
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
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              // Expanded(
                                              //     child:
                                              Text(
                                                "    ${item.religion}, ${item.motherTongue}",
                                                textScaleFactor: 1.0,
                                                overflow: TextOverflow.ellipsis,
                                                style: MmmTextStyles.bodySmall(
                                                    textColor: Colors.white),
                                              )
                                              //)
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
                                              // Expanded(v
                                              //     child:
                                              Text(
                                                "${item.city}, ${item.state}",
                                                textScaleFactor: 1.0,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    MmmTextStyles.bodyRegular(
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
                              .add(GetProfileDetails(list[index]));
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
                      child:
                          // ? buildConnected(context, index)
                          buildInterest(context, index),
                    ),
                  ],
                );
              },
              itemCount: list.length,
              scrollDirection: Axis.vertical,
            ));
      },
      listener: (context, state) {},
    );
  }

  Widget buildInterest(BuildContext context, int index) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);
    MatchingProfile item = this.list[index];
    ProposalStatus? proposalStatus =
        context.watch<MatchingProfileBloc>().proposalStatuses[item.id];
    if (proposalStatus == ProposalStatus.Accepted) {
      return ConnectWidget(
        isDialOpen: isDialOpen,
        profileDetails: this.list[index],
      );
    } else if (proposalStatus == ProposalStatus.Sent) {
      return Row(
        children: [
          MmmIcons.largeCancel(
              action: () {
                BlocProvider.of<MatchingProfileBloc>(context)
                    .add(ChangeProposalStatus(ProposalStatus.Reverted, item));
              },
              isHalf: true),
          SizedBox(
            width: 6,
          ),
          MmmIcons.largeChat(context, this.list[index].id, () async {
            BlocProvider.of<AppBloc>(navigatorKey.currentContext!).connectNow(
                otherUserId: list[index].id,
                onDone: () async {
                  navigatorKey.currentState?.push((await ChatPage.getRoute(
                      navigatorKey.currentContext!, list[index].id)));
                },
                onError: () async {},
                profileDetails: list[index],
                context: navigatorKey.currentContext!);
          }, isHalf: true),
        ],
      );
    } else if (proposalStatus == ProposalStatus.Received) {
      return Row(
        children: [
          MmmIcons.largeReject(
            isHalf: true,
            action: () {
              BlocProvider.of<MatchingProfileBloc>(context)
                  .add(ChangeProposalStatus(ProposalStatus.Rejected, item));
            },
          ),
          SizedBox(width: 6),
          MmmIcons.largeAccept(
            isHalf: true,
            action: () {
              BlocProvider.of<MatchingProfileBloc>(context)
                  .add(ChangeProposalStatus(ProposalStatus.Accepted, item));
            },
          ),
        ],
      );
    }
    return MmmIcons.largeHeart(action: () {
      BlocProvider.of<MatchingProfileBloc>(context)
          .add(ChangeProposalStatus(ProposalStatus.Sent, item));
    });
  }

  InkWell buildConnect(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          // BlocProvider.of<MatchingProfileBloc>(context)
          //     .add(ChangeProposalStatus(index));
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
                    color: Colors.white.withAlpha(50),
                    border: Border.all(color: Colors.white, width: 1.2)))
          ],
        ));
  }

  InkWell buildConnected(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          // BlocProvider.of<MatchingProfileBloc>(context)
          //     .add(ChangeProposalStatus(index));
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
}
