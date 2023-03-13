import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/recharge.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_event.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_state.dart';

class RechargeConnectBloc
    extends Bloc<RechargeConnectEvent, RechargeConnectState> {
  final UserRepository userRepository;
  int connectCount = 0;
  double totalAmount = 0, tax = 0, promoDiscount = 0, generalDiscount = 0;
  double totalPayable = 0;
  late ConnectPriceDetails connectPriceDetails;
  CouponDetails? couponDetails;

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
        connectCount = 1;
        calculateInvoice();
      }
      yield OnGotConnectDetails();
    }
    if (event is ChangeConnectCount) {
      if (event.value == -1) {
        if (this.connectCount != 1) {
          this.connectCount -= 1;
        }
      } else if(this.connectCount < 100) {
        this.connectCount += 1;
      }
      calculateInvoice();
      yield OnGotConnectDetails();
    }
    if (event is ApplyCouponCode) {
      this.couponDetails = event.couponDetails;
      calculateInvoice();
      yield OnGotConnectDetails();
    }
    if (event is RemovePromoCode) {
      this.couponDetails = null;
      calculateInvoice();
      yield OnGotConnectDetails();
    }
    if (event is OnPaymentSuccess) {
      var rechargeModel = RechargeModel(
          totalAmount,
          promoDiscount,
          connectCount,
          totalPayable,
          event.transactionId,
          userRepository.useDetails!.id,
          couponDetails);
      var response = await this.userRepository.recharge(rechargeModel);
      if (response.status == AppConstants.SUCCESS) {
        yield OnRechargeSuccess(this.connectCount);
      } else {
        yield OnError(response.message);
      }
    }
  }

  void calculateInvoice() {
    this.totalAmount = connectPriceDetails.connectPrice * this.connectCount;
    this.generalDiscount = (totalAmount * connectPriceDetails.discount) / 100;

    if (this.couponDetails != null) {
      if (this.couponDetails!.discountType == 0) {
        this.promoDiscount = (totalAmount * couponDetails!.discount) / 100;
      } else {
        promoDiscount = couponDetails!.discount;
      }
    }
    this.tax =
        ((this.totalAmount - generalDiscount - promoDiscount) * 18 / 100);
    this.totalPayable =
        this.totalAmount - this.promoDiscount - promoDiscount + this.tax;
  }
}
