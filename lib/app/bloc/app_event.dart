

import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/user_model.dart';

class AppEvent extends BaseEventState{}

class SignOutEvent extends AppEvent{}

class RefreshWalletCount extends AppEvent{}

class SignInEvent extends AppEvent{

  final UserDetails userDetails;

  SignInEvent({ required this.userDetails});

}