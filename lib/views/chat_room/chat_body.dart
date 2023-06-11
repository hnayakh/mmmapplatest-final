import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as ui;
import 'package:makemymarry/utils/colors.dart';

import 'chat_cubit.dart';
import 'chat_state.dart';

class ChatBody extends StatelessWidget {
  ChatBody() : super();
  final _textController = TextEditingController();

  GlobalKey chatKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            state.estate == EChatState.loaded
                ? Expanded(
                    child: Container(
                      child: ui.Chat(
                        key: GlobalKey(),
                        customBottomWidget: Container(),
                        theme: ui.DefaultChatTheme(
                            sendButtonIcon: Icon(
                              Icons.send_rounded,
                              size: 36.0,
                              color: kSecondary,
                            ),
                            inputPadding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            inputTextColor: Colors.black54,
                            primaryColor: kSecondary,
                            inputMargin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            inputBackgroundColor: Colors.white,
                            inputBorderRadius: BorderRadius.circular(100),
                            inputContainerDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.fromBorderSide(
                                    BorderSide(color: Colors.black26)))),
                        showUserNames: true,
                        showUserAvatars: false,
                        isAttachmentUploading: state.isAttachmentUploading,
                        messages: state.message,

                        onSendPressed: context
                            .read<ChatCubit>()
                            .handleSendPressed, //context.read<ChatCubit>().handleSendPressed,
                        // onMessageTap: context.read<ChatCubit>().handleMessageTap,
                        user: types.User(
                            id: context.read<ChatCubit>().chatRoom.users.first.id),
                      ),
                    ),
                  )
                : Expanded(child: Center(child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator()))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    suffixIcon: InkWell(
                        onTap: () {
                          types.PartialText message =
                              types.PartialText(text: _textController.text);
                          context.read<ChatCubit>().handleSendPressed(message);
                          _textController.text = "";
                        },
                        child: Icon(Icons.send_rounded)),
                    // contentPadding: EdgeInsets.symmetric(v),
                    hintText: "Type here to chat...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
