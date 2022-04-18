import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/recharge.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge_history/RechargeHistoryEvent.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge_history/recharge_history_state.dart';

class RechargeHistoryBloc
    extends Bloc<RechargeHistoryEvent, RechargeHistoryState> {
  final UserRepository userRepository;
  List<RechargeHistoryItem> list = [];

  RechargeHistoryBloc(this.userRepository)
      : super(RechargeHistoryInitialState());

  @override
  Stream<RechargeHistoryState> mapEventToState(
      RechargeHistoryEvent event) async* {
    yield OnLoading();
    if (event is GetTransactionHistory) {
      var response = await this.userRepository.getTransactionHistory();
      if (response.status == AppConstants.SUCCESS) {
        this.list = response.list;
        yield OnGotTransactionList();
      } else {
        yield OnError(response.message);
      }
    }
  }
}
