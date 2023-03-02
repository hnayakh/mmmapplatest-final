import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/chat_room/chat_page.dart';
import 'package:makemymarry/views/connect_pages/call/in_app_call.dart';

import '../../../../../repo/chat_repo.dart';
import '../../../../profile_detail_view/profile_view.dart';
import 'bloc/sent_bloc.dart';
import 'bloc/sent_events.dart';
import 'bloc/sent_states.dart';

class Sent extends StatelessWidget {
  final List<ActiveInterests> listSent;
  final UserRepository userRepository;

  const Sent({Key? key, required this.listSent, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SentBloc(userRepository, listSent),
      child: SentScreen(),
    );
  }
}

class SentScreen extends StatelessWidget {
  late List<ActiveInterests> listSent;
  late UserRepository userRepository;
  //const SentScreen({Key? key, required this.listSent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<SentBloc, SentStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData(context);
          if (state is SentInitialState) {
            BlocProvider.of<SentBloc>(context).add(CheckSentListIsEmpty());
          }

          if (state is SentListisEmpty) {
            return Center(
              child: Text(
                'No requests sent yet..',
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
              )
              //   child: ListView.separated(
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Row(
              //         children: [
              //           ClipRRect(
              //             borderRadius: BorderRadius.circular(12),
              //             child: Image.network(
              //               listSent[index].requestedUserDeatails.imageURL,
              //               height: MediaQuery.of(context).size.width * 0.28,
              //               width: MediaQuery.of(context).size.width * 0.28,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           SizedBox(
              //             width: 16,
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Text(
              //                     listSent[index]
              //                         .requestedUserDeatails
              //                         .displayId
              //                         .toUpperCase(),
              //                     textScaleFactor: 1.0,
              //                     style: MmmTextStyles.bodyRegular(
              //                         textColor: kPrimary),
              //                   ),
              //                   SizedBox(
              //                     width:
              //                     MediaQuery.of(context).size.width * 0.04,
              //                   ),
              //                   listSent[index]
              //                       .requestedUserDeatails
              //                       .activationStatus ==
              //                       ActivationStatus.Verified.index
              //                       ? SvgPicture.asset(
              //                     'images/Verified.svg',
              //                     color: kPrimary,
              //                   )
              //                       : Container()
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 8,
              //               ),
              //               Text(
              //                 listSent[index].requestedUserDeatails.name,
              //                 textScaleFactor: 1.0,
              //                 style: MmmTextStyles.heading5(textColor: kDark5),
              //               ),
              //               SizedBox(
              //                 height: 4,
              //               ),
              //               Text(
              //                 "${AppHelper.getAgeFromDob(listSent[index].requestedUserDeatails.dateOfBirth)} Years, "
              //                     "${listSent[index].requestedUserDeatails.height}', ${listSent[index].requestedUserDeatails.highestEducation}",
              //                 textScaleFactor: 1.0,
              //                 maxLines: 2,
              //                 style: MmmTextStyles.footer(textColor: gray3),
              //               ),
              //               Text(
              //                 "${listSent[index].requestedUserDeatails.careerCity}, ${listSent[index].requestedUserDeatails.careerState}, ${listSent[index].requestedUserDeatails.careerCountry}",
              //                 textScaleFactor: 1.0,
              //                 maxLines: 2,
              //                 style: MmmTextStyles.footer(textColor: gray3),
              //               )
              //             ],
              //           ),
              //         ],
              //       ),
              //       subtitle: Column(
              //         children: [
              //           SizedBox(
              //             height: 8,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               SizedBox(
              //                 width: MediaQuery.of(context).size.width * 0.32,
              //               ),
              //               MmmButtons.connectButton('Connect Now',
              //                   action: () {}),
              //               SizedBox(
              //                 width: 12,
              //               ),
              //               MmmButtons.cancelButtonInterestScreen(() {
              //                 BlocProvider.of<SentsBloc>(context)
              //                     .add(CancelSentInterest(index));
              //               })
              //             ],
              //           )
              //         ],
              //       ),
              //     );
              //   },
              //   itemCount: listSent.length,
              //   separatorBuilder: (BuildContext context, int index) {
              //     return Divider();
              //   },
              // ),
              );
        },
      ),
    );
  }

  void initData(BuildContext context) {
    this.listSent = BlocProvider.of<SentBloc>(context).listSent;
  }

  List<Widget> buildList(BuildContext context) {
    List<Widget> list = [];
    for (var index = 0; index < listSent.length; index++) {
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
                    listSent[index].user.imageURL,
                    height: MediaQuery.of(context).size.width * 0.28,
                    width: MediaQuery.of(context).size.width * 0.28,
                    fit: BoxFit.cover,
                    errorBuilder: (context, obj, str) => Container(
                        color: Colors.grey,
                        height: MediaQuery.of(context).size.width * 0.28,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Icon(Icons.error)),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              var data = await getIt<UserRepository>()
                                  .getOtheruserDetails(listSent[index].user.id,
                                      ProfileActivationStatus.Verified);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ProfileView(
                                          userRepository:
                                              getIt<UserRepository>(),
                                          profileDetails: data.profileDetails,
                                        )),
                              );
                            },
                            child: Text(
                              listSent[index].user.displayId.toUpperCase(),
                              textScaleFactor: 1.0,
                              style: MmmTextStyles.bodyRegular(
                                  textColor: kPrimary),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          listSent[index].user.activationStatus ==
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
                      Text(listSent[index].user.name,
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.heading5(textColor: kDark5)),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${AppHelper.getAgeFromDob(listSent[index].user.dateOfBirth)} Years, "
                        "${listSent[index].user.height.isNotNullEmpty ? AppHelper.heightString(double.parse(listSent[index].user.height)) : ""}, ${listSent[index].user.highestEducation}",
                        textScaleFactor: 1.0,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: MmmTextStyles.footer(textColor: gray3),
                      ),
                      Text(
                        "${listSent[index].user.careerCity} ${listSent[index].user.careerState}  ${listSent[index].user.careerCountry}",
                        textScaleFactor: 1.0,
                        maxLines: 2,
                        style: MmmTextStyles.footer(textColor: gray3),
                      )
                    ],
                  ),
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
                    // listSent[index].user.connectStatus
                    //     ? MmmButtons.connectButton('Call Now', action: () {})
                    //     :
                    MmmButtons.connectButton(
                      'Connect Now',
                      action: () async {
                        if (listSent[index].user.connectStatus) {
                          var otherUser = await getIt<ChatRepo>().getChatUser(
                              id: listSent[index].requestedUserBasicId);
                          var chatRoom = await getIt<ChatRepo>().getChatRoom(
                              listSent[index].requestingUserBasicId, otherUser);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                room: chatRoom,
                                userRepo: getIt<UserRepository>(),
                              ),
                            ),
                          );
                        } else {
                          BlocProvider.of<AppBloc>(navigatorKey.currentContext!)
                              .connectNow(
                                  otherUserId:
                                      listSent[index].requestedUserBasicId,
                                  onDone: () async {
                                    navigatorKey.currentState?.push(
                                        (await ChatPage.getRoute(
                                            navigatorKey.currentContext!,
                                            listSent[index]
                                                .requestedUserBasicId)));
                                  },
                                  onError: () async {},
                                  profileDetails: listSent[index],
                                  context: navigatorKey.currentContext!);
                        }
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    MmmButtons.cancelButtonInterestScreen(
                      action: () {
                        print("object");
                        var requiredBloc = context.read<SentBloc>();
                        _showDialog(context, requiredBloc, index);
                      },
                    )
                    // MmmButtons.cancelButtonInterestScreen(() {
                    //   BlocProvider.of<SentsBloc>(context)
                    //       .add(CancelSentInterest(index));
                    // })
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

  void navigateToInAppCall(BuildContext context, InterestUser user) {
    var userRepo = BlocProvider.of<SentBloc>(context).userRepository;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InAppCall(
          userRepository: userRepo,
          image: user.imageURL,
          name: user.name,
          destinationUserId: user.id,
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, SentBloc bloc, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (ctx) => SentBloc(userRepository, listSent),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: kWhite,
            title: Text("Cancel Request",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight
                        .bold)), // To display the title it is optional
            content: new RichText(
                textAlign: TextAlign.left,
                text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                  children: <TextSpan>[
                    new TextSpan(text: 'Are you want to cancel the request?'),
                    // new TextSpan(
                    //     text: ' mmyid', style: new TextStyle(color: kPrimary)),
                    // new TextSpan(text: ' to find your perfect match.'),
                  ],
                )),
            // Action widget which will provide the user to acknowledge the choice
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MmmButtons.primaryButtonMeetGray("Cancel", () {
                    Navigator.of(context).pop();
                    // navigateToHome(state);
                  }),
                  SizedBox(
                    width: 10,
                  ),
                  MmmButtons.primaryButtonMeet("Confirm", () {
                    bloc.add(CancelSentInterest(index));
                    Navigator.of(context).pop();
                  })
                ],
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
          // );
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
        );
      },
    );
  }
}
