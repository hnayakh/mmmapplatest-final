import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_event.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_state.dart';

class RechargeConnectBloc
    extends Bloc<RechargeConnectEvent, RechargeConnectState> {
  final UserRepository userRepository;
  int connectCount = 1;
  double totalAmount = 0, tax = 0, promoDiscount = 0;

  RechargeConnectBloc(this.userRepository)
      : super(RechargeConnectInitialState());

  @override
  Stream<RechargeConnectState> mapEventToState(
      RechargeConnectEvent event) async* {
    yield OnLoading();
    if (event is GetConnectPrice) {}
    if (event is ChangeConnectCount) {
      if (event.value == -1) {
        if (this.connectCount != 0) {
          this.connectCount -= 1;
        }
      } else {
        this.connectCount += 1;
      }
      yield OnGotConnectDetails();
    }
  }
}
