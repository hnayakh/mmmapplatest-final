import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/home/menu/wallet/connect_history/connect_history_event.dart';

import '../../../../../datamodels/connect.dart';
import 'connect_history_state.dart';

class ConnectHistoryBloc
    extends Bloc<ConnectHistoryEvent, ConnectHistoryState> {
  final UserRepository userRepository;

  ConnectHistoryBloc(this.userRepository) : super(ConnectHistoryInitialState());
  List<ConnectHistoryItem> list = [];

  @override
  Stream<ConnectHistoryState> mapEventToState(
      ConnectHistoryEvent event) async* {
    if (event is GetConnectHistory) {
      yield OnLoading();
      var response = await this.userRepository.getCOnnecHistory();
      if (response.status == AppConstants.SUCCESS) {
        this.list = response.list;
        yield OnGotConnectHistory();
      } else {
        yield OnError(response.message);
      }
    }
  }
}
