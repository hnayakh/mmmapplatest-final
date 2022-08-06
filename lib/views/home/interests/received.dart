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

import 'received_bloc/received_bloc.dart';
import 'received_bloc/received_events.dart';
import 'received_bloc/received_states.dart';

class Received extends StatelessWidget {
  final List<ActiveInterests> listReceived;
  final UserRepository userRepository;

  const Received(
      {Key? key, required this.listReceived, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceivedsBloc(userRepository),
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
      child: BlocConsumer<ReceivedsBloc, ReceivedStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData(context);
          if (state is ReceivedInitialState) {
            BlocProvider.of<ReceivedsBloc>(context).add(CheckListisEmpty());
          }
          if (state is ListIsEmptyState) {
            return Center(
              child: Text(
                'No requests received yet..',
                style: TextStyle(color: kPrimary),
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
          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                  // width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          listReceived[index].user.imageURL,
                          height: MediaQuery.of(context).size.width * 0.28,
                          width: MediaQuery.of(context).size.width * 0.28,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      listReceived[index]
                                          .user
                                          .displayId
                                          .toUpperCase(),
                                      textScaleFactor: 1.0,
                                      style: MmmTextStyles.bodyRegular(
                                          textColor: kPrimary),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.04,
                                    ),
                                    listReceived[index]
                                                .user
                                                .activationStatus ==
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
                                child: Stack(
                                  children: [
                                    Container(
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
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            listReceived[index].user.name,
                            style: MmmTextStyles.heading5(textColor: kDark5),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            listReceived[index].user.aboutMe,
                            style: MmmTextStyles.footer(textColor: gray3),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                        MmmButtons.acceptInterestScreen(() {
                          BlocProvider.of<ReceivedsBloc>(context)
                              .add(AcceptInterestEvent(index));
                        }),
                        SizedBox(
                          width: 12,
                        ),
                        MmmButtons.rejectButtonInterestScreen(() {
                          BlocProvider.of<ReceivedsBloc>(context)
                              .add(RejectInterestEvent(index));
                        })
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: listReceived.length,
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
    for (var index = 0; index < listReceived.length; index++) {
      list.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 48,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      listReceived[index].user.imageURL,
                      height: MediaQuery.of(context).size.width * 0.28,
                      width: MediaQuery.of(context).size.width * 0.28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 16,
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
                                Text(
                                  listReceived[index]
                                      .user
                                      .displayId
                                      .toUpperCase(),
                                  textScaleFactor: 1.0,
                                  style: MmmTextStyles.bodyRegular(
                                      textColor: kPrimary),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                listReceived[index]
                                            .user
                                            .activationStatus ==
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
                            child: Stack(
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
                        "${listReceived[index].user.height}', ${listReceived[index].user.highestEducation}",
                        textScaleFactor: 1.0,
                        maxLines: 2,
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
                      width: MediaQuery.of(context).size.width * 0.31,
                    ),
                    MmmButtons.acceptInterestScreen(() {
                      BlocProvider.of<ReceivedsBloc>(context)
                          .add(AcceptInterestEvent(index));
                    }),
                    SizedBox(
                      width: 12,
                    ),
                    MmmButtons.rejectButtonInterestScreen(() {
                      BlocProvider.of<ReceivedsBloc>(context)
                          .add(RejectInterestEvent(index));
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
    this.listReceived = BlocProvider.of<ReceivedsBloc>(context).listReceived;
    print(listReceived);
  }
}
