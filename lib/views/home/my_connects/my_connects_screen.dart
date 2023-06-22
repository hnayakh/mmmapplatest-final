import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/interests/bloc/interests_bloc.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_bloc.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_event.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_state.dart';
import 'package:makemymarry/views/stackviewscreens/connect/chat_screen.dart';
import 'package:makemymarry/views/stackviewscreens/connect/connect_screen.dart';

import '../../../datamodels/interests_model.dart';

class MyConnects extends StatelessWidget {
  final UserRepository userRepository;

  const MyConnects({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InterestsBloc(userRepository),
        ),
        BlocProvider(
          create: (context) => MyConnectsBloc(userRepository),
        ),
      ],
      child: MyConnectsScreen(),
    );
  }
}

class MyConnectsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyConnectsScreenState();
  }
}

class MyConnectsScreenState extends State<MyConnectsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<MyConnectItem> list = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MyConnectsBloc, MyConnectsState>(
        builder: (context, state) {
          if (state is MyConnectsInitialState) {
            BlocProvider.of<MyConnectsBloc>(context).add(GetMyConnects());
          }
          return Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    // MmmButtons.appBarCurved('Connects', context: context),
                    Container(
                      child: PreferredSize(
                          preferredSize: Size.fromHeight(74),
                          child: Container(
                              child: AppBar(
                            toolbarHeight: 74,
                            title: Text(
                              "Connects",
                              style: MmmTextStyles.heading4(textColor: kLight2),
                            ),
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                          ))),
                      decoration: BoxDecoration(color: kSecondary),
                    ),
                    Material(
                      color: Colors.white,
                      child: TabBar(
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
                                'Connects',
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Chats',
                              ),
                            ),
                          )
                        ],
                      ),
                      elevation: 4,
                    ),
                    Expanded(
                        child: TabBarView(
                      controller: tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        // ChatsScreen(),
                        ConnectScreen(
                          userRepository: getIt<UserRepository>(),
                        ),
                        ChatScreen()
                        // ConnectedScreen(),
                      ],
                    ))
                    // Expanded(child: Text('Hello'))
                  ],
                ),
              ),
              state is OnLoading
                  ? MmmWidgets.buildLoader2(context)
                  : Container()
            ],
          );
        },
        listener: (context, state) {
          if (state is OnGotMyConnects) {
            this.list = state.list;
          }
        },
      ),
    );
  }
}
