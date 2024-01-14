import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/chat_room/chat_page.dart';
import 'package:makemymarry/views/home/interests/bloc/interests_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/connect/chat_screen_ui.dart';

import '../../home/interests/bloc/interest_events.dart';
import '../../home/interests/bloc/interest_states.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var index;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Room>>(
                  future: getIt<ChatRepo>()
                      .getMyChatRooms(getIt<UserRepository>().useDetails!.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return BlocBuilder<InterestsBloc, InterestStates>(
                          builder: (context, state) {
                        if (state is InterestInitialState) {
                          BlocProvider.of<InterestsBloc>(context)
                              .add(GetListOfInterests());
                        }
                        if (state is OnGotInterestLists) {
                          final myUserId =
                              getIt<UserRepository>().useDetails!.id;
                          var acceptedUserIds = context
                              .read<InterestsBloc>()
                              .listConnections
                              .map((e) => myUserId == e.requestingUserBasicId
                                  ? e.requestedUserBasicId
                                  : e.requestingUserBasicId)
                              .toList();
                          final data = snapshot.data
                                  ?.where((element) => acceptedUserIds
                                      .contains(element.users[0].id == myUserId ? element.users[1].id : element.users[0].id ))
                                  .toList() ??
                              [];
                          return ListView.separated(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  navigateToChat(data[index]);
                                },
                                child: ListTile(
                                  leading: Container(
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    height: 56,
                                    width: 56,
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      data[index].imageUrl ?? "",
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (a, b, c) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  // trailing: Column(
                                  //   children: [
                                  //     CircleAvatar(
                                  //       radius: 8,
                                  //       backgroundColor: kPrimary,
                                  //       child: Text(
                                  //         '1',
                                  //         textAlign: TextAlign.center,
                                  //         style: MmmTextStyles.caption(
                                  //             textColor: kWhite),
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       '8m ago',
                                  //       style: MmmTextStyles.caption(
                                  //           textColor: gray1),
                                  //     ),
                                  //   ],
                                  // ),
                                  title: Text(
                                    '${data[index].name}',
                                    style: MmmTextStyles.heading5(),
                                  ),
                                  subtitle: Text(
                                    '${data[index].lastMessages.isNotNullEmpty ? data[index].lastMessages!.first.id : ""}',
                                    style: MmmTextStyles.bodySmall(),
                                  ),
                                ),
                              );
                            },
                            itemCount: data.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          );
                        }  if (state is OnLoading) {
                          return MmmWidgets.buildLoader(context);
                        }
                        return Container();
                      });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong. Please try again."),
                      );
                    } else {
                      return MmmWidgets.buildLoader(context);
                    }
                  }),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //         child: (Container(
            //       height: 68,
            //       decoration: BoxDecoration(boxShadow: [
            //         MmmShadow.elevationStack(),
            //       ]),
            //       padding: EdgeInsets.only(top: 8, bottom: 8),
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             MmmWidgets.bottomBarUnits('images/Search.svg', 'Search',
            //                 index == 0 ? kPrimary : gray3, action: () {
            //               setColor(0);
            //             }),
            //             MmmWidgets.bottomBarUnits(
            //                 'images/filter2.svg',
            //                 'Filter',
            //                 index == 1 ? kPrimary : gray3, action: () {
            //               setColor(1);
            //             }),
            //             MmmWidgets.bottomBarUnits(
            //                 'images/connect.svg',
            //                 'Connect',
            //                 index == 2 ? kPrimary : gray3, action: () {
            //               setColor(2);
            //             }),
            //             MmmWidgets.bottomBarUnits(
            //                 'images/Search.svg',
            //                 'Notifications',
            //                 index == 3 ? kPrimary : gray3, action: () {
            //               setColor(3);
            //             }),
            //             MmmWidgets.bottomBarUnits('images/menu.svg', 'More',
            //                 index == 4 ? kPrimary : gray3, action: () {
            //               setColor(4);
            //             })
            //           ]),
            //     ))),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }

  void navigateToChat(Room chatRoom) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            room: chatRoom,
            userRepo: getIt<UserRepository>(),
          ),
        ));
  }
}
