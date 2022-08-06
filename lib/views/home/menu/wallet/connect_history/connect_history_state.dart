import 'package:makemymarry/bloc/base_event_state.dart';

class ConnectHistoryState extends BaseEventState {}

class OnLoading extends ConnectHistoryState {}

class ConnectHistoryInitialState extends ConnectHistoryState {}

class OnGotConnectHistory extends ConnectHistoryState {}

class OnError extends ConnectHistoryState {
  final String message;

  OnError(this.message);
}
