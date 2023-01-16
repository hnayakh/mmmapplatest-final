import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/connect_pages/call/in_app_call.dart';
import '../../../../../app/bloc/app_bloc.dart';
import '../../../../../app/bloc/app_event.dart';
import '../../../../../app/bloc/app_state.dart';
import '../../../../../locator.dart';
import '../../../../../repo/chat_repo.dart';
import '../../../../chat_room/chat_page.dart';
import '../../../../profileviewscreens/profile_view.dart';
import '../../../menu/wallet/recharge/recharge_connect_screen.dart';
import 'bloc/accepted_bloc.dart';
import 'bloc/accepted_events.dart';
import 'bloc/accepted_states.dart';

class Accepted extends StatelessWidget {
  final List<ActiveInterests> listAccepted;
  final UserRepository userRepository;

  const Accepted(
      {Key? key, required this.listAccepted, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AcceptedBloc(userRepository),
      child: AcceptedScreen(),
    );
  }
}

class AcceptedScreen extends StatelessWidget {
  //const AcceptedScreen({Key? key}) : super(key: key);
  late List<ActiveInterests> listAccepted;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<AcceptedBloc, AcceptedStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData(context);
          if (state is AcceptedInitialState) {
            BlocProvider.of<AcceptedBloc>(context)
                .add(CheckAcceptedListIsEmpty());
          }
          if (state is AcceptedListIsEmptyState) {
            return Center(
              child: Text(
                'No requests accepted yet..',
                style: TextStyle(color: kPrimary),
              ),
            );
          }
          return Container(
              color: Colors.white24,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: buildList(context),
                    ),
                  ),
                  state is OnLoading
                      ? MmmWidgets.buildLoader2(context)
                      : Container()
                ],
              ));
          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        listAccepted[index].user.imageURL,
                        height: MediaQuery.of(context).size.width * 0.28,
                        width: MediaQuery.of(context).size.width * 0.28,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              listAccepted[index].user.displayId,
                              style:
                                  MmmTextStyles.bodySmall(textColor: kPrimary),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            SvgPicture.asset(
                              'images/Verified.svg',
                              color: kPrimary,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.12,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: kLight4),
                                    child: SvgPicture.asset(
                                      'images/chat.svg',
                                      height: 18,
                                      color: kNotify,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    //alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kPrimary),
                                    child: Text(
                                      '2',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.footer(
                                          textColor: kLight4),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          listAccepted[index].user.name,
                          style: MmmTextStyles.heading5(textColor: kDark5),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          listAccepted[index].user.aboutMe,
                          style: MmmTextStyles.footer(textColor: gray3),
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.31,
                        ),
                        MmmButtons.connectButton('Connect Now', action: () {}),
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: listAccepted.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          );
        },
      ),
    );
  }

  List<Widget> buildList(BuildContext context) {
    List<Widget> list = [];
    for (var index = 0; index < listAccepted.length; index++) {
      list.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    listAccepted[index].user.imageURL,
                    height: MediaQuery.of(context).size.width * 0.28,
                    width: MediaQuery.of(context).size.width * 0.28,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            var data = await getIt<UserRepository>()
                                .getOtheruserDetails(
                                    listAccepted[index].user.id,
                                    ProfileActivationStatus.Verified);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfileView(
                                      userRepository: getIt<UserRepository>(),
                                      profileDetails: data.profileDetails,
                                    )));
                          },
                          child: Text(
                            listAccepted[index].user.displayId.toUpperCase(),
                            textScaleFactor: 1.0,
                            style:
                                MmmTextStyles.bodyRegular(textColor: kPrimary),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        listAccepted[index].user.activationStatus ==
                                ActivationStatus.Verified.index
                            ? SvgPicture.asset(
                                'images/Verified.svg',
                                color: kPrimary,
                              )
                            : Container()
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      listAccepted[index].user.name,
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.heading5(textColor: kDark5),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${AppHelper.getAgeFromDob(listAccepted[index].user.dateOfBirth)} Years, "
                      "${listAccepted[index].user.height}', ${listAccepted[index].user.highestEducation}",
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1.0,
                      maxLines: 3,
                      style: MmmTextStyles.footer(textColor: gray3),
                    ),
                    Text(
                      "${listAccepted[index].user.careerCity}, ${listAccepted[index].user.careerState}, ${listAccepted[index].user.careerCountry}",
                      textScaleFactor: 1.0,
                      maxLines: 2,
                      style: MmmTextStyles.footer(textColor: gray3),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                    ),
                    // listAccepted[index].user.connectStatus
                    //     ? MmmButtons.connectButton('Call Now', action: () {})
                    //     :
                    MmmButtons.connectButton(
                      'Connect Now',
                      action: () async {
                        if (listAccepted[index].user.connectStatus) {
                          var otherUser = await getIt<ChatRepo>().getChatUser(
                              id: listAccepted[index].requestedUserBasicId);
                          var chatRoom = await getIt<ChatRepo>().getChatRoom(
                              listAccepted[index].requestingUserBasicId,
                              otherUser);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                room: chatRoom,
                                userRepo: getIt<UserRepository>(),
                              ),
                            ),
                          );
                        } else {
                          var appBloc = BlocProvider.of<AppBloc>(context);
                          appBloc.add(RefreshWalletCount());
                          if ((appBloc.state as AppLoggedInState).connectCount >
                              0) {
                            var bloc = BlocProvider.of<AcceptedBloc>(context);
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MmmWidgets.requestConnectWidget(
                                  name: listAccepted[index].user.name,
                                  imageUrl: listAccepted[index].user.imageURL,
                                  isVerified:
                                      listAccepted[index].user.isActive == 1,
                                  onConfirm: () {
                                    // bloc.add(ConnectNow(
                                    // connectById: listAccepted[index]
                                    //     .requestingUserBasicId,
                                    // connectToId: listAccepted[index]
                                    //     .requestedUserBasicId));
                                  },
                                );
                              },
                            );
                            appBloc.add(RefreshWalletCount());
                          } else {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MmmWidgets.lowBalanceWidget(
                                  onConfirm: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => RechargeConnect(
                                          userRepository:
                                              getIt<UserRepository>(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider()
          ],
        ),
      ));
    }
    return list;
  }

  void initData(BuildContext context) {
    this.listAccepted = BlocProvider.of<AcceptedBloc>(context).listAccepted;
  }

  void navigateToInAppCall(BuildContext context, InterestUser user) {
    var userRepo = BlocProvider.of<AcceptedBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => InAppCall(
              userRepository: userRepo,
              image: user.imageURL,
              name: user.name,
              destinationUserId: user.id,
            )));
  }
}
