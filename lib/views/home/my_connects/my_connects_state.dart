import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/connect.dart';

class MyConnectsState extends BaseEventState {}

class OnLoading extends MyConnectsState {}

class MyConnectsInitialState extends MyConnectsState {}

class OnGotMyConnects extends MyConnectsState {
  final List<MyConnectItem> list;

  OnGotMyConnects(this.list);
}

class OnError extends MyConnectsState {
  final String message;

  OnError(this.message);
}
