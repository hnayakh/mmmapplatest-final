import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/recharge.dart';

class RechargeConnectEvent extends BaseEventState {}

class GetConnectPrice extends RechargeConnectEvent {}

class ApplyCouponCode extends RechargeConnectEvent {
  final CouponDetails couponDetails;

  ApplyCouponCode(this.couponDetails);
}

class ChangeConnectCount extends RechargeConnectEvent {
  final int value;

  ChangeConnectCount(this.value);
}

class BuyConnects extends RechargeConnectEvent {}

class RemovePromoCode extends RechargeConnectEvent {}

class OnPaymentSuccess extends RechargeConnectEvent {
  final String transactionId;

  OnPaymentSuccess(this.transactionId);
}
