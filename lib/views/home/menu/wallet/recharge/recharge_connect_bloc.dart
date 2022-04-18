import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/recharge.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_event.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_state.dart';

class RechargeConnectBloc
    extends Bloc<RechargeConnectEvent, RechargeConnectState> {
  final UserRepository userRepository;
  int connectCount = 1;
  double totalAmount = 0, tax = 0, promoDiscount = 0;
  double totalPayable = 0;
  late ConnectPriceDetails connectPriceDetails;

  RechargeConnectBloc(this.userRepository)
      : super(RechargeConnectInitialState());

  @override
  Stream<RechargeConnectState> mapEventToState(
      RechargeConnectEvent event) async* {
    yield OnLoading();
    if (event is GetConnectPrice) {
      var response = await this.userRepository.getConnectPrice();
      if (response.status == AppConstants.SUCCESS) {
        connectPriceDetails = response.couponDetails!;
        this.totalAmount = connectPriceDetails.connectPrice;
        promoDiscount = (connectPriceDetails.connectPrice *
                connectPriceDetails.discount /
                100)
            .toDouble();
        this.tax = (this.totalAmount * 18 / 100).roundToDouble();
        this.totalPayable = this.totalAmount + this.tax - this.promoDiscount;
      }
      yield OnGotConnectDetails();
    }
    if (event is ChangeConnectCount) {
      if (event.value == -1) {
        if (this.connectCount != 1) {
          this.connectCount -= 1;
        }
      } else {
        this.connectCount += 1;
      }
      yield OnGotConnectDetails();
    }
  }
}
