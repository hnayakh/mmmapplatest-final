import 'package:makemymarry/base_event_state.dart';

import '../../../datamodels/blocked_users_response.dart';

class BlockedUsersState extends BaseEventState {}

class BlockedUsersIdleState extends BlockedUsersState {

  final List<BlockedUser> data;

  BlockedUsersIdleState({required this.data});

}

class BlockedUsersLoadingState extends BlockedUsersState {}

class BlockedUsersEmptyState extends BlockedUsersState {}

class BlockedUsersErrorState extends BlockedUsersState {}

