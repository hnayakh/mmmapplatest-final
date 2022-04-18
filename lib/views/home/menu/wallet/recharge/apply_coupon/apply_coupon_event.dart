import 'package:makemymarry/bloc/base_event_state.dart';

import 'package:makemymarry/bloc/base_event_state.dart';

class ApplyCouponEvent extends BaseEventState{

}
class ApplyCouponCode extends ApplyCouponEvent{
  final String coupon;

  ApplyCouponCode(this.coupon);
}