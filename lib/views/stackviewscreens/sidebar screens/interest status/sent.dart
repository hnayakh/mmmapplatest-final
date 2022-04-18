import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';

import 'package:makemymarry/utils/text_styles.dart';

import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/sent_bloc/sent_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/sent_bloc/sent_events.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/sent_bloc/sent_states.dart';

class Sent extends StatelessWidget {
  final List<ActiveInterests> listSent;
  final UserRepository userRepository;

  const Sent({Key? key, required this.listSent, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SentsBloc(userRepository, listSent),
      child: SentScreen(),
    );
  }
}

class SentScreen extends StatelessWidget {
  late List<ActiveInterests> listSent;
  //const SentScreen({Key? key, required this.listSent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocConsumer<SentsBloc, SentStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            initData(context);
            if (state is SentInitialState) {
              BlocProvider.of<SentsBloc>(context).add(CheckSentListIsEmpty());
            }

            if (state is SentListisEmpty) {
              return Center(
                child: Text(
                  'No requests sent yet..',
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
                        child: Image.network(
                          listSent[index].requestedUserDeatails.imageURL,
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
                                listSent[index].requestedUserDeatails.displayId,
                                style: MmmTextStyles.bodySmall(
                                    textColor: kPrimary),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              SvgPicture.asset(
                                'images/Verified.svg',
                                color: kPrimary,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            listSent[index].requestedUserDeatails.name,
                            style: MmmTextStyles.heading5(textColor: kDark5),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            listSent[index].requestedUserDeatails.aboutMe,
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
                          MmmButtons.connectButton('Connect Now',
                              action: () {}),
                          SizedBox(
                            width: 12,
                          ),
                          MmmButtons.cancelButtonInterestScreen(() {
                            BlocProvider.of<SentsBloc>(context)
                                .add(CancelSentInterest(index));
                          })
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: listSent.length,
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
    this.listSent = BlocProvider.of<SentsBloc>(context).listSent;
  }
}
