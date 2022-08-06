import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

import 'app_payment_bottom_sheet.dart';
import 'card_payment_bottom_sheet.dart';

class PaymentMethodScreen extends StatefulWidget {
  final int? connects;
  const PaymentMethodScreen({Key? key, required this.connects})
      : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Payment Method'),
      body: Container(
        padding: kMargin16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 44,
            ),
            Text(
              'Amonut to Pay',
              style: MmmTextStyles.heading5(textColor: kDark5),
            ),
            SizedBox(
              height: 8,
            ),
            MmmButtons.buyConnectsButton(
                '${widget.connects} Connects', 'Rs ${widget.connects! * 50}'),
            SizedBox(
              height: 35,
            ),
            Text(
              'Select your payment method',
              style: MmmTextStyles.bodySmall(textColor: kDark5),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SvgPicture.asset('images/upi.svg'),
                Text(
                  'UPI(Phone Pe, GPay)',
                  style: MmmTextStyles.heading6(textColor: kDark5),
                ),
                Expanded(child: SizedBox()),
                TextButton(
                    onPressed: () {
                      apppaymentBottomSheet(context);
                    },
                    child: Text(
                      'Select App',
                      style: MmmTextStyles.bodyMedium(textColor: kPrimary),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Row(
              children: [
                SvgPicture.asset("images/credit.svg"),
                Text(
                  'Credit/Debit Card',
                  style: MmmTextStyles.heading6(textColor: kDark5),
                ),
                Expanded(child: SizedBox()),
                TextButton(
                    onPressed: () {
                      cardpaymentBottomSheet(context);
                    },
                    child: Text(
                      'Add Details',
                      style: MmmTextStyles.bodyMedium(textColor: kPrimary),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void cardpaymentBottomSheet(BuildContext context) async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => CardPaymentBottomSheet());
  }

  void apppaymentBottomSheet(BuildContext context) async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => AppPaymentBottomSheet());
  }
}
