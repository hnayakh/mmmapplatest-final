import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/accepted_bloc/accepted_states.dart';

import 'accepted_bloc/accepted_Bloc.dart';
import 'accepted_bloc/accepted_events.dart';

class Accepted extends StatelessWidget {
  final List<ActiveInterests> listAccepted;
  final UserRepository userRepository;

  const Accepted(
      {Key? key, required this.listAccepted, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AcceptedsBloc(userRepository),
      child: AcceptedScreen(),
    );
  }
}

class AcceptedScreen extends StatelessWidget {
  //const AcceptedScreen({Key? key}) : super(key: key);
  late List<ActiveInterests> listAccepted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocConsumer<AcceptedsBloc, AcceptedStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            initData(context);
            if (state is AcceptedInitialState) {
              BlocProvider.of<AcceptedsBloc>(context)
                  .add(CheckAcceptedListisEmpty());
            }
            if (state is AcceptedListIsEmptyState) {
              return Center(
                child: Text(
                  'No requests accepted yet..',
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
                          listAccepted[index].requestingUserDeatails.imageURL,
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
                                listAccepted[index]
                                    .requestingUserDeatails
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
                            listAccepted[index].requestingUserDeatails.name,
                            style: MmmTextStyles.heading5(textColor: kDark5),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            listAccepted[index].requestingUserDeatails.aboutMe,
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
      ),
    );
  }

  void initData(BuildContext context) {
    this.listAccepted = BlocProvider.of<AcceptedsBloc>(context).listAccepted;
  }
}
