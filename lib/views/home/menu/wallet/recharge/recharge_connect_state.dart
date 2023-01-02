import 'package:makemymarry/base_event_state.dart';

class RechargeConnectState extends BaseEventState {}

class RechargeConnectInitialState extends RechargeConnectState {}

class OnLoading extends RechargeConnectState {}

class OnGotConnectDetails extends RechargeConnectState {}

class OnError extends RechargeConnectState {
  final String message;

  OnError(this.message);
}

class OnConnectCountChange extends RechargeConnectState {}

class OnRechargeSuccess extends RechargeConnectState {
  final int connectCount;

  OnRechargeSuccess(this.connectCount);
}
