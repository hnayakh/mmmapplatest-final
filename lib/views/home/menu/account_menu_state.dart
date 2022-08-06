import 'package:makemymarry/bloc/base_event_state.dart';

class AccountMenuState extends BaseEventState {}

class AccountMenuInitialState extends AccountMenuState {}

class OnLoading extends AccountMenuState {}

class OnGotProfile extends AccountMenuState {}

class OnError extends AccountMenuState {
  final String message;

  OnError(this.message);
}
