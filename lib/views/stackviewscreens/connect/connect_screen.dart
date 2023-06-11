import 'package:flutter/material.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/home/interests/bloc/interest_states.dart';
import 'package:makemymarry/views/home/interests/bloc/interests_bloc.dart';

import '../../../locator.dart';
import '../../connects/views/audio_call.dart';
import '../../connects/views/video_call.dart';
import '../../home/interests/bloc/interest_events.dart';

class ConnectScreen extends StatelessWidget {
  final UserRepository userRepository;

  const ConnectScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectStatusScreen();
  }
}

class ConnectStatusScreen extends StatefulWidget {
  const ConnectStatusScreen({Key? key}) : super(key: key);

  @override
  _InterestStatusScreenState createState() => _InterestStatusScreenState();
}

class _InterestStatusScreenState extends State<ConnectStatusScreen> {
  late List<ActiveInterests> listConnections = []; //accepted
  @override
  void initState() {
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
          return ListView.builder(
            itemCount: listConnections.length,
            itemBuilder: (context, index) =>
                ConnectTile(listConnections[index]),
          );
        },
        listener: (context, state) {
          if (state is OnError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: kError,
              ),
            );
          }
        },
      ),
    );
  }

  void initData() {
    var interests = BlocProvider.of<InterestsBloc>(context);
    this.listConnections = interests.listConnections;
  }
}

class ConnectTile extends StatelessWidget {
  const ConnectTile(
    this.interests, {
    super.key,
  });
  final ActiveInterests interests;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color.fromARGB(192, 221, 225, 230),
          width: 1,
        ),
      ),
      child: Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(83, 233, 30, 98)),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    InkWell(
                      onTap: (){
                        context.navigate.push(
                          MaterialPageRoute(
                            builder: (context) => AudioCallView(
                              uid: interests.user.id,
                              imageUrl: interests.user.thumbnailURL,
                              userRepo: getIt<UserRepository>(),
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        'images/addinterest/videocall.png',
                        width: 20,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: kPrimary,
                        child: Text(
                          '1',
                          textAlign: TextAlign.center,
                          style: MmmTextStyles.caption(textColor: kWhite),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: (){
                        context.navigate.push(
                          MaterialPageRoute(
                            builder: (context) => VideoCallView(
                              uid: interests.user.id,
                              imageUrl: interests.user.thumbnailURL,

                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        'images/addinterest/vcall.png',
                        width: 20,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: kPrimary,
                        child: Text(
                          '1',
                          textAlign: TextAlign.center,
                          style: MmmTextStyles.caption(textColor: kWhite),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  height: 56,
                  width: 56,
                  child: Image.network(
                    interests.user.thumbnailURL,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded
                  (
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        interests.user.name,
                        style:
                            TextStyle( fontFamily: 'MakeMyMarry', fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        interests.user.aboutMe,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle( fontFamily: 'MakeMyMarry', 
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
