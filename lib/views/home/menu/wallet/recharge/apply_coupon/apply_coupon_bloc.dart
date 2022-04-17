import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/apply_coupon/apply_coupon_event.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/apply_coupon/apply_coupon_state.dart';

class ApplyCouponBloc extends Bloc<ApplyCouponEvent, ApplyCouponState> {
  final UserRepository userRepository;

  ApplyCouponBloc(this.userRepository) : super(ApplyCouponInitialLoading());

  @override
  Stream<ApplyCouponState> mapEventToState(ApplyCouponEvent event) async* {
    yield OnLoading();
    if (event is ApplyCouponCode) {
      print(event.coupon);
      if (event.coupon.length == 0) {
        yield OnError("Please Enter Valid Coupon Code.");
      } else
        yield OnCouponApplied();
      // var response = await this.userRepository.applyCoupon(event.coupon);
    }
  }
}
