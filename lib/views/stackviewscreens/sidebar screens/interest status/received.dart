import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/received_bloc/received_events.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/received_bloc/received_states.dart';

import 'received_bloc/received_bloc.dart';

class Received extends StatelessWidget {
  final List<ActiveInterests> listReceived;
  final UserRepository userRepository;

  const Received(
      {Key? key, required this.listReceived, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceivedsBloc(userRepository, listReceived),
      child: ReceivedScreen(),
    );
  }
}

class ReceivedScreen extends StatelessWidget {
  //const ReceivedScreen({Key? key}) : super(key: key);
  late List<ActiveInterests> listReceived;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          listReceived[index].requestedUserDeatails.imageURL,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listReceived[index]
                                    .requestedUserDeatails
                                    .displayId,
                                style: MmmTextStyles.bodySmall(
                                    textColor: kPrimary),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              SvgPicture.asset(
                                'images/Verified.svg',
                                color: kPrimary,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.19,
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
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            listReceived[index].requestedUserDeatails.name,
                            style: MmmTextStyles.heading5(textColor: kDark5),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            listReceived[index].requestedUserDeatails.aboutMe,
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
      ),
    );
  }

  void initData(BuildContext context) {
    this.listReceived = BlocProvider.of<ReceivedsBloc>(context).listReceived;
    print(listReceived);
  }
}
