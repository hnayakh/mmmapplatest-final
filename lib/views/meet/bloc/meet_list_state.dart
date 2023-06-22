import 'package:makemymarry/views/meet/bloc/meet_form_state.dart';

import '../../../datamodels/user_model.dart';

class MeetListState {
  final ViewState viewState;
  final List<Activeconnection> sentMeets;
  final List<Activeconnection> activeMeets;
  final List<Activeconnection> receivedMeets;
  final String? message;

  MeetListState({required this.viewState, required this.sentMeets,required this.activeMeets,required this.receivedMeets, this.message});

  factory MeetListState.initial() => MeetListState(
        viewState: ViewState.empty,
    sentMeets: <Activeconnection>[],
    activeMeets: <Activeconnection>[],
    receivedMeets: <Activeconnection>[],
      );
  MeetListState copWith({
    ViewState? viewState,
    List<Activeconnection>? receivedMeets,
    List<Activeconnection>? activeMeets,
    List<Activeconnection>? sentMeets,
    String? message,
  }) =>
      MeetListState(
          viewState: viewState ?? this.viewState,
          sentMeets: sentMeets ?? this.sentMeets,
          activeMeets: activeMeets ?? this.activeMeets,
          receivedMeets: receivedMeets ?? this.receivedMeets,
          message: message ?? this.message);
}

enum ViewState {
  loading,
  error,
  idle,
  empty,
}
