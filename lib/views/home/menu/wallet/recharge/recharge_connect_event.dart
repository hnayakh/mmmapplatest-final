import 'package:makemymarry/bloc/base_event_state.dart';

class RechargeConnectEvent extends BaseEventState{

}
class GetConnectPrice extends RechargeConnectEvent{

}
class ApplyCouponCode extends RechargeConnectEvent{
  final String couponCode;

  ApplyCouponCode(this.couponCode);
}
class ChangeConnectCount extends RechargeConnectEvent{
  final int value;

  ChangeConnectCount(this.value);
}
class BuyConnects extends RechargeConnectEvent{

}