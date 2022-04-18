import 'package:makemymarry/bloc/base_event_state.dart';

class WalletState extends BaseEventState {}

class WalletInitialState extends WalletState {}

class OnGotWalletBalance extends WalletState {}

class OnLoading extends WalletState {}

class OnError extends WalletState {
  final String message;

  OnError(this.message);
}
