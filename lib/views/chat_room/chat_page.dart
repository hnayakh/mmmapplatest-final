
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:makemymarry/app/bloc/app_bloc.dart';
import 'package:makemymarry/app/bloc/app_state.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/hexcolor.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/views/connects/views/video_call.dart';

import '../../utils/colors.dart';
import '../connects/views/audio_call.dart';
import 'chat_body.dart';
import 'chat_cubit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(
      {required this.room, required this.userRepo, this.allowCalls = false});

  final types.Room room;
  final UserRepository userRepo;
  final bool allowCalls;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        chatRoom: room,
      ),
      child: Builder(
        builder: (context) {
          var primaryColor = HexColor('#EB5884');
          return Scaffold(

            extendBodyBehindAppBar: true,
            appBar: AppBar(
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(100)),
                    gradient: LinearGradient(
                        colors: [kSecondary, kPrimary],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft),
                  )),
              leading: InkWell(
                onTap: () {
                  context.navigate.pop();
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 36,
                ),
              ),
              leadingWidth: 56,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (room.imageUrl.isNotNullEmpty)
                    CircleAvatar(
                      minRadius: 24,
                      backgroundImage: NetworkImage(
                        room.imageUrl!,
                      ),
                    ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: Text(
                      '${room.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style:
                      TextStyle( fontFamily: 'MakeMyMarry', fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              actions: !allowCalls
                  ? null
                  : <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context.navigate.push(
                            MaterialPageRoute(
                              builder: (context) => VideoCallView(
                                uid: room.users.last.id,
                                imageUrl: room.imageUrl!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          child: Image.asset(
                            'images/video.png',
                            // width: 30,
                            height: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          context.navigate.push(
                            MaterialPageRoute(
                              builder: (context) => AudioCallView(
                                uid: room.users.last.id,
                                imageUrl: room.imageUrl!,
                                userRepo: userRepo,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          child: Image.asset(
                            'images/audio.png',
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ],
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              backgroundColor: primaryColor,
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    //bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(100))),
            ),
            body: ChatBody(),
          );
        },
      ),
    );
  }
  static Future<Route<Object?>> getRoute(BuildContext context, String userId) async {
    var otherUser = await getIt<ChatRepo>().getChatUser(id: userId);
    String currentId = (BlocProvider.of<AppBloc>(context).state
            as AppLoggedInState)
        .currentUserId;
    var chatRoom = await getIt<ChatRepo>().getChatRoom(currentId, otherUser);
    return MaterialPageRoute(
      builder: (context) => ChatPage(
        room: chatRoom,
        userRepo: getIt<UserRepository>(),
      ),
    );
  }
}
