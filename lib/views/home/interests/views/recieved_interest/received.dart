import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/app/bloc/app_bloc.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/chat_room/chat_page.dart';

import '../../../../../repo/chat_repo.dart';
import '../../../../profile_detail_view/profile_view.dart';
import 'bloc/received_bloc.dart';
import 'bloc/received_events.dart';
import 'bloc/received_states.dart';

class Received extends StatelessWidget {
  final List<ActiveInterests> listReceived;
  final UserRepository userRepository;

  const Received(
      {Key? key, required this.listReceived, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceivedBloc(userRepository),
      child: ReceivedScreen(),
    );
  }
}

class ReceivedScreen extends StatelessWidget {
  //const ReceivedScreen({Key? key}) : super(key: key);
  late List<ActiveInterests> listReceived;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<ReceivedBloc, ReceivedStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData(context);
          if (state is ReceivedInitialState) {
            BlocProvider.of<ReceivedBloc>(context).add(CheckListisEmpty());
          }
          if (state is ListIsEmptyState) {
            return Center(
              child: Text(
                'No requests received yet..',
                style: TextStyle( fontFamily: 'MakeMyMarry', color: kPrimary),
              ),
            );
          }
          return Container(
            color: Colors.white24,
            child: SingleChildScrollView(
              child: Column(
                children: buildList(context),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> buildList(BuildContext context) {
    List<Widget> list = [];
    for (var index = 0; index < listReceived.length; index++) {
      list.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(listReceived[index].user.imageURL,
                        height: MediaQuery.of(context).size.width * 0.28,
                        width: MediaQuery.of(context).size.width * 0.28,
                        fit: BoxFit.cover,
                        errorBuilder: (context, obj, str) => Container(
                            color: Colors.grey, child: Icon(Icons.error))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var data = await getIt<UserRepository>()
                                        .getOtheruserDetails(
                                            listReceived[index].user.id,
                                            ProfileActivationStatus.Verified);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => ProfileView(
                                                userRepository:
                                                    getIt<UserRepository>(),
                                                profileDetails:
                                                    data.profileDetails,
                                              )),
                                    );
                                  },
                                  child: Text(
                                    listReceived[index]
                                        .user
                                        .displayId
                                        .toUpperCase(),
                                    textScaleFactor: 1.0,
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: kPrimary),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                listReceived[index].user.activationStatus ==
                                        ActivationStatus.Verified.index
                                    ? SvgPicture.asset(
                                        'images/Verified.svg',
                                        color: kPrimary,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Container(
                            child: FutureBuilder<int>(
                              future: getIt<ChatRepo>().getMessageCount(
                                userId: getIt<UserRepository>().useDetails!.id,
                                otherUser: getIt<UserRepository>()
                                            .useDetails!
                                            .id ==
                                        listReceived[index]
                                            .requestingUserBasicId
                                    ? listReceived[index].requestedUserBasicId
                                    : listReceived[index].requestingUserBasicId,
                              ),
                              builder: (context, snapshot) {
                                return (snapshot.hasData &&
                                        ((snapshot.data ?? 0) > 0))
                                    ? Stack(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AcceptRequestDialog(
                                                    user: listReceived[index]
                                                        .user,
                                                    requestId:
                                                        listReceived[index].id,
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              child: Container(
                                                height: 32,
                                                width: 32,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: kLight4),
                                                child: SvgPicture.asset(
                                                  'images/chat.svg',
                                                  height: 18,
                                                  color: kNotify,
                                                ),
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
                                                snapshot.data?.toString() ??
                                                    "0",
                                                textAlign: TextAlign.center,
                                                style: MmmTextStyles.footer(
                                                    textColor: kLight4),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        listReceived[index].user.name,
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.heading5(textColor: kDark5),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${AppHelper.getAgeFromDob(listReceived[index].user.dateOfBirth)} Years, "
                        "${listReceived[index].user.height.isNotNullEmpty ? AppHelper.heightString(double.parse(listReceived[index].user.height)) : ""}, ${listReceived[index].user.highestEducation}",
                        textScaleFactor: 1.0,
                        maxLines: 3,
                        style: MmmTextStyles.footer(textColor: gray3),
                      ),
                      Text(
                        "${listReceived[index].user.careerCity}, ${listReceived[index].user.careerState}, ${listReceived[index].user.careerCountry}",
                        textScaleFactor: 1.0,
                        maxLines: 2,
                        style: MmmTextStyles.footer(textColor: gray3),
                      )
                    ],
                  )),
                ],
              ),
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
                    MmmButtons.acceptInterestScreen(() {
                      BlocProvider.of<ReceivedBloc>(context)
                          .add(AcceptInterestEvent(index));
                    }),
                    SizedBox(
                      width: 12,
                    ),
                    MmmButtons.rejectButtonInterestScreen(() {
                      _showDialog(context, listReceived[index].user, listReceived[index].id, index,BlocProvider.of<ReceivedBloc>(context)  );
                    })
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
    this.listReceived = BlocProvider.of<ReceivedBloc>(context).listReceived;
    print(listReceived);
  }

  void _showDialog(BuildContext context, InterestUser user, String requestId, index, ReceivedBloc bloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: kWhite,
          title: Text("Cancel Request",
              textAlign: TextAlign.left,
              style: TextStyle( fontFamily: 'MakeMyMarry', fontWeight: FontWeight.bold)),
          content: new RichText(
            textAlign: TextAlign.left,
            text: new TextSpan(
              style: new TextStyle( fontFamily: 'MakeMyMarry', 
                fontSize: 14.0,
                color: Colors.grey,
              ),
              children: <TextSpan>[
                new TextSpan(text: 'Are you want to reject the request?'),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MmmButtons.primaryButtonMeetGray("Cancel", () {
                  Navigator.of(context).pop();
                  // navigateToHome(state);
                }),
                SizedBox(width: 10),
                MmmButtons.primaryButtonMeet("Confirm", () {
                  context.read<AppBloc>().rejectProposal(
                      otherUserId: user.id,
                      requestId: requestId,
                      onDone: () async {

                        bloc.add(RejectInterestEvent(index));
                        context.navigate.pop();

                      },
                      onError: () async {});
                })
              ],
            ),
            SizedBox(height: 15)
          ],
        );
        //  AlertDialog(
        //   title: new Text("Alert!!"),
        //   content: new Text("You are awesome!"),
        //   actions: <Widget>[
        //     GestureDetector(
        //       child: new Text("OK"),
        //       onTap: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // );
      },
    );
  }
}

class AcceptRequestDialog extends StatelessWidget {
  const AcceptRequestDialog(
      {Key? key, required this.user, required this.requestId})
      : super(key: key);
  final InterestUser user;
  final String requestId;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 350,
        width: 400,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(20),
        )),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 70,
              ),
              Container(
                child: Text(
                  user.name,
                  style: TextStyle( fontFamily: 'MakeMyMarry', 
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (user.activationStatus == 1)
                ClipOval(
                  child: Image.asset(
                    'images/sheild.png',
                    height: 20,
                    width: 20,
                  ),
                ),
            ]),
            Container(
              child: ClipRect(
                child: Image.network(
                  user.imageURL,
                  height: 100,
                  width: 80,
                  errorBuilder: (a, b, c) => Icon(Icons.error),
                ),
              ),
            ),
            Container(
              child: const SizedBox(
                  width: 300,
                  child: Text('Please accept the request to read a message',
                      textAlign: TextAlign.center,
                      style: TextStyle( fontFamily: 'MakeMyMarry', fontSize: 17))),
            ),
            MmmButtons.primaryButton('Confirm', () async {
              Navigator.of(context).pop();
              context.read<AppBloc>().acceptProposal(
                  otherUserId: user.id,
                  requestId: requestId,
                  onDone: () async {
                    Navigator.of(context).push(
                      (await ChatPage.getRoute(
                        context,
                        user.id,
                      )),
                    );
                  },
                  onError: () async {});
            }),
            Container(
              width: 240,
              child: MmmButtons.primaryButtonMeetGray(
                  'Decline', () => Navigator.pop(context)),
            )
            // Container(
            //   child: InkWell(
            //     onTap: (() {
            //       Navigator.pop(context);
            //     }),
            //     child: Container(
            //       height: 40,
            //       width: 230,
            //       decoration:
            //           BoxDecoration(
            //         borderRadius:
            //             BorderRadius.only(
            //           topLeft:
            //               Radius.circular(
            //                   8),
            //           topRight:
            //               Radius.circular(
            //                   8),
            //           bottomLeft:
            //               Radius.circular(
            //                   8),
            //           bottomRight:
            //               Radius.circular(
            //                   8),
            //         ),
            //         boxShadow: [
            //           BoxShadow(
            //               color: Color
            //                   .fromARGB(
            //                       73,
            //                       61,
            //                       75,
            //                       92),
            //               offset: Offset(
            //                   0, 4),
            //               blurRadius: 14)
            //         ],
            //         color: Color.fromRGBO(
            //             255, 255, 255, 1),
            //         border: Border.all(
            //           color: gray3,
            //           width: 1,
            //         ),
            //       ),
            //       alignment:
            //           Alignment.center,
            //       child: Text(
            //         'Decline',
            //         textScaleFactor: 1.0,
            //         style: MmmTextStyles
            //             .heading6(
            //                 textColor:
            //                     gray3),
            //         textAlign:
            //             TextAlign.center,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
