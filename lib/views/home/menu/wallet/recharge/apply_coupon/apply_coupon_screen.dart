import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/alert.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/apply_coupon/apply_coupon_bloc.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/apply_coupon/apply_coupon_event.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/apply_coupon/apply_coupon_state.dart';

class ApplyCoupon extends StatelessWidget {
  final UserRepository userRepository;

  const ApplyCoupon({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplyCouponBloc(userRepository),
      child: ApplyCouponScreen(),
    );
  }
}

class ApplyCouponScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ApplyCouponScreenState();
  }
}

class ApplyCouponScreenState extends State<ApplyCouponScreen> {
  TextEditingController promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplyCouponBloc, ApplyCouponState>(
        builder: (context, state) {
      return Container(

          padding: kMargin12,
          height: 350,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(30))
              // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    MmmButtons.backButton(context),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Apply Promo Code',
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.bodyMedium(textColor: kDark5),
                    ),
                    Divider(),
                    Container(
                      child: Column(
                        children: [
                          MmmTextFileds.textFiledWithLabel(
                              null, "Enter Code", promoController,
                              textCapitalization:
                                  TextCapitalization.characters),
                          SizedBox(
                            height: 4,
                          ),
                          state is OnError
                              ? Text(
                                  state.message,
                                  textScaleFactor: 1.0,
                                  style: MmmTextStyles.bodyRegular(
                                      textColor: kPrimary),
                                )
                              : Container(),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                    ),
                  ])),
              SizedBox(
                height: 24,
              ),
              state is OnLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(kPrimary),
                      ),
                    )
                  : MmmButtons.enabledRedButtonbodyMedium(50, 'Apply',
                      action: () {
                      BlocProvider.of<ApplyCouponBloc>(context)
                          .add(ApplyCouponCode(promoController.text.trim()));
                    })
            ],
          ));
    }, listener: (context, state) {
      if (state is OnCouponApplied) {
        Navigator.of(context).pop(state.couponDetails);
        Alert.message(context, message: "Coupon applied successfully");
      }
    });
  }
}
