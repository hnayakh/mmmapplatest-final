import 'package:makemymarry/base_event_state.dart';

class BlockedUsersEvents extends BaseEventState {}

class GetListOfBlockedUsers extends BlockedUsersEvents {}
class UnblockUser extends BlockedUsersEvents {

  final String blockId;

  UnblockUser(this.blockId);

}

