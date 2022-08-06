import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';

import 'accepted.dart';
import 'interest_events.dart';
import 'interest_states.dart';
import 'interests_bloc.dart';
import 'received.dart';
import 'sent.dart';

class Interests extends StatelessWidget {
  final UserRepository userRepository;

  const Interests({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InterestsBloc(userRepository),
      child: InterestStatusScreen(),
    );
  }
}

class InterestStatusScreen extends StatefulWidget {
  const InterestStatusScreen({Key? key}) : super(key: key);

  @override
  _InterestStatusScreenState createState() => _InterestStatusScreenState();
}

class _InterestStatusScreenState extends State<InterestStatusScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late List<ActiveInterests> listSent = []; //sent
  late List<ActiveInterests> listConnections = []; //accepted
  late List<ActiveInterests> listInvites = []; //received

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InterestsBloc, InterestStates>(
        builder: (context, state) {
          initData();
          if (state is InterestInitialState) {
            BlocProvider.of<InterestsBloc>(context).add(GetListOfInterests());
          }
          if (state is OnLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kPrimary,
              ),
            );
          }
          return Container(
            child: Column(
              children: [
                Container(
                  child: PreferredSize(
                      preferredSize: Size.fromHeight(
                          74),
                      child: Container(
                          child: AppBar(
                        toolbarHeight:
                            74,
                        title: Text(
                          "Interests",
                          style: MmmTextStyles.heading4(textColor: kLight2),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                      ))),
                  decoration: BoxDecoration(color: kSecondary),
                ),
                Material(color: Colors.white,child: TabBar(
                  controller: tabController,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 4.0,
                        color: kPrimary,
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 16.0)),
                  automaticIndicatorColorAdjustment: true,
                  labelColor: kPrimary,
                  labelStyle: MmmTextStyles.heading6(),
                  unselectedLabelColor: kDark5,
                  unselectedLabelStyle: MmmTextStyles.heading6(),
                  tabs: [
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Sent',
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Received',
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Accepted',
                        ),
                      ),
                    ),
                  ],
                ),elevation: 4,),
                Expanded(
                    child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Sent(
                      listSent: this.listSent,
                      userRepository: BlocProvider.of<InterestsBloc>(context)
                          .userRepository,
                    ),
                    Received(
                      listReceived: this.listInvites,
                      userRepository: BlocProvider.of<InterestsBloc>(context)
                          .userRepository,
                    ),
                    Accepted(
                        listAccepted: this.listConnections,
                        userRepository: BlocProvider.of<InterestsBloc>(context)
                            .userRepository)
                  ],
                ))
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is OnError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: kError,
            ));
          }
        },
      ),
    );
  }

  void initData() {
    var interests = BlocProvider.of<InterestsBloc>(context);
    this.listConnections = interests.listConnections;
    this.listInvites = interests.listInvites;
    print('listInvites=' + '$listInvites');
    this.listSent = interests.listSent;
  }
}
