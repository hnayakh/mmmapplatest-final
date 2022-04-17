import 'package:makemymarry/bloc/base_event_state.dart';

class ApplyCouponState extends BaseEventState {}

class ApplyCouponInitialLoading extends ApplyCouponState {}

class OnLoading extends ApplyCouponState {}

class OnCouponApplied extends ApplyCouponState {}

class OnError extends ApplyCouponState {
  final String message;

  OnError(this.message);
}
