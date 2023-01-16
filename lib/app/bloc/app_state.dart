import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/user_model.dart';

class AppState  {}

class AppInitialState extends AppState {}

class AppLoggedInState extends AppState {
  final String currentUserId;
  final String currentUserDisplayId;
  final int connectCount;
  final UserDetails userDetails;
  final Stream<List<String>> onlineMembers;

  AppLoggedInState({
    required this.currentUserId,
    required this.currentUserDisplayId,
    required this.userDetails,
    required this.onlineMembers,
    required this.connectCount,
  });

  AppLoggedInState copyWith({
    String? currentUserId,
    String? currentUserDisplayId,
    int? connectCount,
    UserDetails? userDetails,
    Stream<List<String>>? onlineMembers,
  }) =>
      AppLoggedInState(
          currentUserId: currentUserId ?? this.currentUserId,
          currentUserDisplayId:
              currentUserDisplayId ?? this.currentUserDisplayId,
          userDetails: userDetails ?? this.userDetails,
          onlineMembers: onlineMembers ?? this.onlineMembers,
          connectCount: connectCount ?? this.connectCount);
}

class AppLoggedOutState extends AppState {}
