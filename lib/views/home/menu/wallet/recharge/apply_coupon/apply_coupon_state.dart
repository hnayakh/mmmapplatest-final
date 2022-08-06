import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/recharge.dart';

class ApplyCouponState extends BaseEventState {}

class ApplyCouponInitialLoading extends ApplyCouponState {}

class OnLoading extends ApplyCouponState {}

class OnCouponApplied extends ApplyCouponState {
  final CouponDetails couponDetails;

  OnCouponApplied(this.couponDetails);
}

class OnError extends ApplyCouponState {
  final String message;

  OnError(this.message);
}
