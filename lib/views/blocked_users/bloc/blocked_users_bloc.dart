import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';

import 'blocked_users_event.dart';
import 'blocked_users_state.dart';

class BlockedUsersBloc extends Bloc<BlockedUsersEvents, BlockedUsersState> {
  BlockedUsersBloc(this.userRepository) : super(BlockedUsersEmptyState()) {
    add(GetListOfBlockedUsers());
  }

  final UserRepository userRepository;

  @override
  Stream<BlockedUsersState> mapEventToState(BlockedUsersEvents event) async* {
    yield BlockedUsersLoadingState();
    if (event is GetListOfBlockedUsers) {
      try {
        var res = await this
            .userRepository
            .getBlockedUsers(this.userRepository.useDetails!.id);
        yield BlockedUsersIdleState(data: res.data);
      } catch (e) {
        yield BlockedUsersErrorState();
      }
    }
    if (event is UnblockUser) {
      try {
        await this.userRepository.unBlockProfile(event.blockId);
        add(GetListOfBlockedUsers());
      } catch (e) {
        yield BlockedUsersErrorState();
      }
    }
  }
}
