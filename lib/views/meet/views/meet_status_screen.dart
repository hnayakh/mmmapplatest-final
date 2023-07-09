import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/meet/bloc/meet_list_state.dart';
import 'package:makemymarry/views/meet/views/meet_accepted.dart';
import 'package:makemymarry/views/meet/views/meet_sent.dart';

import '../../../utils/elevations.dart';
import '../bloc/meet_list_bloc.dart';
import 'meet_received.dart';

class MeetStatusScreen extends StatefulWidget {
  const MeetStatusScreen({Key? key}) : super(key: key);

  @override
  _MeetStatusScreenState createState() => _MeetStatusScreenState();
}

class _MeetStatusScreenState extends State<MeetStatusScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: MmmButtons.appBarCurved('Meets', context: context),
      body: BlocProvider<MeetListBloc>(
        create: (_) => MeetListBloc(userRepository: getIt<UserRepository>()),
        child: Container(
          child: Column(
            children: [
              MmmButtons.appBarCurved('Meets', context: context),

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
                        'Recieved',
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
              BlocBuilder<MeetListBloc, MeetListState>(
                  builder: (context, state) {
                return state.viewState == ViewState.loading
                    ? MmmWidgets.buildLoader(context)
                    : Expanded(
                        child: TabBarView(
                          controller: tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            MSentScreen(),
                            MReceivedScreen(),
                            MAcceptedScreen()
                          ],
                        ),
                      );
              })

            ],
          ),
        ),
      ),
    );
  }
}
