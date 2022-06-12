import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_bloc.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_event.dart';
import 'package:makemymarry/views/home/my_connects/my_connects_state.dart';

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

class MyConnectsScreenState extends State<MyConnectsScreen> {
  List<MyConnectItem> list = [];

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
                    Container(
                      child: PreferredSize(
                          preferredSize: Size.fromHeight(74),
                          child: Container(
                              child: AppBar(
                            toolbarHeight: 74,
                            title: Text(
                              "Contacts",
                              style: MmmTextStyles.heading4(textColor: kLight2),
                            ),
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                          ))),
                      decoration: BoxDecoration(color: kSecondary),
                    ),
                    Expanded(child: buildList())
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
              SizedBox(height: 4,),
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
