import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/accepted.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/interest_events.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/interest_states.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/interests_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/received.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/interest%20status/sent.dart';

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
                          MediaQuery.of(context).size.height * 0.1),
                      child: Container(
                          child: AppBar(
                        leading: Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          decoration: BoxDecoration(
                              color: kLight2.withOpacity(0.60),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                MmmShadow.elevationbBackButton(
                                    shadowColor: kShadowColorForWhite)
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    height: 32,
                                    width: 32,
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'images/arrowLeft.svg',
                                      height: 17.45,
                                      width: 17.45,
                                      color: gray3,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        toolbarHeight:
                            MediaQuery.of(context).size.height * 0.108,
                        title: Text(
                          "Interests",
                          style: MmmTextStyles.heading4(textColor: kLight2),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                      ))),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [kPrimary, kSecondary],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                  ),
                ),
                TabBar(
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
                ),
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
                    AcceptedScreen()
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
