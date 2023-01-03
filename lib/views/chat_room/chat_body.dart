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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) => ui.Chat(
        theme: ui.DefaultChatTheme(primaryColor: kSecondary ),
        showUserNames: true,
        showUserAvatars: false,
        isAttachmentUploading: state.isAttachmentUploading,
        messages: state.message,
        onAttachmentPressed: () {
          context.read<ChatCubit>().handleAttachmentPressed(context);
        },
        customBottomWidget: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          width: double.infinity,
          height: 56,
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: Colors.black26)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: Colors.black26)),
              hintText: 'Type your message',
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                mainAxisSize: MainAxisSize.min, // added line
                children: <Widget>[
                  // IconButton(
                  //   color: Colors.black38,
                  //   onPressed: () {},
                  //   // ignore: prefer_const_constructors
                  //   icon: Icon(Icons.camera_alt_outlined, size: 36.0),
                  // ),
                  IconButton(
                    color: Colors.black38,
                    onPressed: () {
                      final trimmedText = _textController.text.trim();
                      if (trimmedText != '') {
                        final partialText =
                            types.PartialText(text: trimmedText);
                        context
                            .read<ChatCubit>()
                            .handleSendPressed(partialText);
                        _textController.clear();
                      }
                    },
                    icon: const Icon(Icons.send_rounded, size: 36.0),
                  )
                ],
              ),
            ),
          ),
        ),
        onSendPressed: context.read<ChatCubit>().handleSendPressed,
        onMessageTap: context.read<ChatCubit>().handleMessageTap,
        user: types.User(id: context.read<ChatCubit>().chatRoom.users.first.id),
      ),
    );
  }
}
