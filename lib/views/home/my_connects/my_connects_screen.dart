import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/interests/bloc/interests_bloc.dart';
import 'package:makemymarry/views/home/my_connects/chats.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_bloc.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_event.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_state.dart';
import 'package:makemymarry/views/stackviewscreens/connect/chat_screen.dart';
import 'package:makemymarry/views/stackviewscreens/connect/connect_screen.dart';
// import './chats.dart';
// import 'connected.dart';

class MyConnects extends StatelessWidget {
  final UserRepository userRepository;

  const MyConnects({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyConnectsBloc(userRepository),
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
    tabController = TabController(length: 2, vsync: this);

    super.initState();
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
                        ConnectScreen(),
                        ChatScreen(),
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

  Widget buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 29,
            child: ClipOval(
              child: Image.network(
                list[index].thumbnailURL,
                fit: BoxFit.cover,
                  errorBuilder: (context, obj, str) => Container(
                      color: Colors.grey,
                      child: Icon(Icons.error))

              ),
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: kPrimary,
                child: Text(
                  '1',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                  style: MmmTextStyles.caption(textColor: kWhite),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '8m ago',
                textScaleFactor: 1.0,
                style: MmmTextStyles.caption(textColor: gray1),
              ),
            ],
          ),
          title: Text(
            list[index].name,
            textScaleFactor: 1.0,
            style: MmmTextStyles.heading5(),
          ),
          subtitle: Text(
            "He'll want to use your yacht, and I don't want this thing smelling",
            textScaleFactor: 1.0,
            maxLines: 2,
            style: MmmTextStyles.bodySmall(),
          ),
        );
      },
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}
