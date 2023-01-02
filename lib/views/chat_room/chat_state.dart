import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatState {
  ChatState(
      {required this.message,
      required this.estate,
      required this.isAttachmentUploading});

  factory ChatState.empty() => ChatState(
        message: <types.Message>[],
        estate: EChatState.initial,
        isAttachmentUploading: false,
      );

  final List<types.Message> message;
  final EChatState estate;
  final bool isAttachmentUploading;

  ChatState copyWith({
    List<types.Message>? message,
    EChatState? estate,
    bool? isAttachmentUploading,
  }) =>
      ChatState(
        message: message ?? this.message,
        estate: estate ?? this.estate,
        isAttachmentUploading:
            isAttachmentUploading ?? this.isAttachmentUploading,
      );
}

enum EChatState {
  initial,
  loading,
  loaded,
  error,
}

class ChatInitial extends ChatState {
  ChatInitial()
      : super(
          message: <types.Message>[],
          estate: EChatState.initial,
          isAttachmentUploading: false,
        );
}
