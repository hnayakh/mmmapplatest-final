import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/recharge.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_bloc.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_event.dart';
import 'package:makemymarry/views/home/menu/wallet/recharge/recharge_connect_state.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/wallet%20screens/payment_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'apply_coupon/apply_coupon_screen.dart';

class RechargeConnect extends StatelessWidget {
  final UserRepository userRepository;

  const RechargeConnect({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RechargeConnectBloc(userRepository),
      child: RechargeConnectScreen(),
    );
  }
}

class RechargeConnectScreen extends StatefulWidget {
  const RechargeConnectScreen({Key? key}) : super(key: key);

  @override
  _RechargeConnectScreenState createState() => _RechargeConnectScreenState();
}

class _RechargeConnectScreenState extends State<RechargeConnectScreen> {
  late int connectCounts = 0;
  late String mobile, email;
  bool showUi = false;
  double totalAmount = 0, tax = 0, promoDiscount = 0;
  double totalPayable = 0;
  CouponDetails? couponDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved("Buy Connects", context: context),
      body: BlocConsumer<RechargeConnectBloc, RechargeConnectState>(
          builder: (context, state) {
        this.connectCounts =
            BlocProvider.of<RechargeConnectBloc>(context).connectCount;
        this.totalAmount =
            BlocProvider.of<RechargeConnectBloc>(context).totalAmount;
        this.tax = BlocProvider.of<RechargeConnectBloc>(context).tax;
        this.promoDiscount =
            BlocProvider.of<RechargeConnectBloc>(context).promoDiscount;
        this.totalPayable =
            BlocProvider.of<RechargeConnectBloc>(context).totalPayable;
        this.couponDetails =
            BlocProvider.of<RechargeConnectBloc>(context).couponDetails;
        this.mobile = BlocProvider.of<RechargeConnectBloc>(context)
            .userRepository
            .useDetails!
            .mobile;
        this.email = BlocProvider.of<RechargeConnectBloc>(context)
            .userRepository
            .useDetails!
            .email;
        if (state is RechargeConnectInitialState) {
          BlocProvider.of<RechargeConnectBloc>(context).add(GetConnectPrice());
        }
        return buildUi(context, state);
      }, listener: (context, state) {
        if (state is OnGotConnectDetails) {
          showUi = true;
        }
        if (state is OnRechargeSuccess) {
          print("Connect Count: ${state.connectCount}");
          // Navigator.of(context).pop(state.connectCount);
        }
      }),
    );
  }

  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_KKICP7OGSuGiN1',
      'amount': this.totalPayable * 100,
      'name': 'Ironage Tech Pvt. Ltd.',
      'description': 'MakeMyMarry Connect Recharge',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '$mobile', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Container buildUi(BuildContext context, RechargeConnectState state) {
    return Container(
        child: Stack(
      children: [
        Container(
          padding: kMargin16,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      'Select your connects:',
                      style: MmmTextStyles.bodyMedium(textColor: kDark5),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(),
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.16,
                              width: MediaQuery.of(context).size.width * 0.72,
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient:
                                    MmmDecorations.primaryGradientOpacity(),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MmmButtons.plusMinusButton(
                                      context, 'images/minus.svg', action: () {
                                    BlocProvider.of<RechargeConnectBloc>(
                                            context)
                                        .add(ChangeConnectCount(-1));
                                  }),
                                  Container(
                                    width: 48,
                                    // color: Colors.white,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$connectCounts',
                                      style: MmmTextStyles.heading2(
                                          textColor: kDark5),
                                    ),
                                  ),
                                  MmmButtons.plusMinusButton(
                                      context, 'images/plus.svg', action: () {
                                    BlocProvider.of<RechargeConnectBloc>(
                                            context)
                                        .add(ChangeConnectCount(1));
                                  })
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '*you can connect with $connectCounts people',
                              textScaleFactor: 1.0,
                              style: MmmTextStyles.bodySmall(textColor: gray3),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Divider(),
                        SizedBox(
                          height: 24,
                        ),
                        this.couponDetails != null
                            ? buildCouponWidget()
                            : MmmButtons.walletButtons('Have Coupons?',
                                action: () {
                                navigateToCoupon();
                              }),
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Total Amount',
                                textScaleFactor: 1.0,
                                style:
                                    MmmTextStyles.heading5(textColor: kDark5),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Item Total',
                                          textScaleFactor: 1.0,
                                          style: MmmTextStyles.bodySmall(
                                              textColor: kDark5),
                                        ),
                                        Text(
                                          '\u{20B9}${totalAmount.toStringAsFixed(2)}',
                                          textScaleFactor: 1.0,
                                          style: MmmTextStyles.bodySmall(
                                              textColor: kDark5),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'GST (18%)',
                                          textScaleFactor: 1.0,
                                          style: MmmTextStyles.bodySmall(
                                              textColor: kDark5),
                                        ),
                                        Text(
                                          '\u{20B9}${tax.toStringAsFixed(2)}',
                                          textScaleFactor: 1.0,
                                          style: MmmTextStyles.bodySmall(
                                              textColor: kDark5),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          this.couponDetails != null
                                              ? 'Promo Discount'
                                              : 'General Discount',
                                          textScaleFactor: 1.0,
                                          style: MmmTextStyles.bodySmall(
                                              textColor: kDark5),
                                        ),
                                        Text(
                                          '- \u{20B9}${promoDiscount.toStringAsFixed(2)}',
                                          textScaleFactor: 1.0,
                                          style: MmmTextStyles.bodySmall(
                                              textColor: kDark5),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Grand Total',
                                      textScaleFactor: 1.0,
                                      style: MmmTextStyles.bodyMedium(
                                          textColor: kDark5),
                                    ),
                                    Text(
                                      '\u{20B9}${totalPayable.toStringAsFixed(2)}',
                                      textScaleFactor: 1.0,
                                      style: MmmTextStyles.bodyMedium(
                                          textColor: kPrimary),
                                    ),
                                  ],
                                ),
                                height: 60,
                                decoration:
                                    MmmDecorations.whiteBgBottomShadow(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ])),
              SizedBox(
                height: 15,
              ),
              MmmButtons.enabledRedButtonbodyMedium(50, 'Proceed to buy',
                  action: () {
                openCheckout();
                // navigateTopay();
              })
            ],
          ),
        ),
        state is OnLoading ? MmmWidgets.buildLoader2(context) : Container(),
        state is OnRechargeSuccess
            ? buildRechargeSuccess(state.connectCount)
            : Container()
      ],
    ));
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: ${response.paymentId}');
    BlocProvider.of<RechargeConnectBloc>(context)
        .add(OnPaymentSuccess(response.paymentId!));
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void navigateToCoupon() async {
    var userRepo = BlocProvider.of<RechargeConnectBloc>(context).userRepository;
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) => ApplyCoupon(
              userRepository: userRepo,
            ));
    if (result != null && result is CouponDetails) {
      BlocProvider.of<RechargeConnectBloc>(context)
          .add(ApplyCouponCode(result));
    }
  }

  Widget buildCouponWidget() {
    return Container(
      height: 74,
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          MmmShadow.filterButton(),
        ],
        //border: Border.all(width: 1, color: kLight4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.only(left: 22, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${this.couponDetails!.code}",
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.bodyMedium(textColor: kDark5),
                    ),
                    Text(
                      "Promo Code applied",
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.bodySmall(textColor: kDark2),
                    ),
                  ],
                ),
                // SvgPicture.asset(
                //   'images/rightArrow.svg',
                //   width: 24,
                //   height: 24,
                //   color: gray3,
                //   fit: BoxFit.cover,
                // ),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<RechargeConnectBloc>(context)
                          .add(RemovePromoCode());
                    },
                    icon: Icon(
                      Icons.delete,
                      color: kPrimary,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRechargeSuccess(int connectCount) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white.withOpacity(0.5),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
          //width: 328,
          height: 393,
          padding: kMargin12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xffFFFFFF),
              boxShadow: [
                MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Container(
                width: double.infinity,
                height: 163,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'images/connect_success.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                child: Text(
                  'Recharge Successful',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading4(textColor: kDark5),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                  height: 60,
                  child: Text(
                    '${connectCounts} connects has been added your account successfully.',
                    textAlign: TextAlign.center,
                    style: MmmTextStyles.bodySmall(textColor: kDark5),
                  )),
              Container(
                height: 42,
                child: Container(
                  decoration: MmmDecorations.primaryButtonDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(connectCount);
                        },
                        child: Center(
                          child: Text(
                            'Continue',
                            style: MmmTextStyles.heading6(textColor: gray7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// void navigateTopay() {
//   Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => PaymentMethodScreen(
//             connects: this.i,
//           )));
// }
}
