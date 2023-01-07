import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/user_model.dart';

class AppState extends BaseEventState {}

class AppInitialState extends AppState {}

class AppLoggedInState extends AppState {
  final String currentUserId;
  final String currentUserDisplayId;
  final UserDetails userDetails;
  final Stream<List<String>> onlineMembers;

  AppLoggedInState(
      {required this.currentUserId,
      required this.currentUserDisplayId,
      required this.userDetails,
      required this.onlineMembers});
}

class AppLoggedOutState extends AppState {}
