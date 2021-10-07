import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/wallet%20screens/payment_screen.dart';

class SelectConnectsBottomSheet extends StatefulWidget {
  const SelectConnectsBottomSheet({Key? key}) : super(key: key);

  @override
  _SelectConnectsBottomSheetState createState() =>
      _SelectConnectsBottomSheetState();
}

class _SelectConnectsBottomSheetState extends State<SelectConnectsBottomSheet> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kMargin16,
        height: 440,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MmmButtons.backButton(context),
          SizedBox(
            height: 24,
          ),
          Text(
            'Select your connects:',
            style: MmmTextStyles.bodyMedium(textColor: kDark5),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: kLight4,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: MmmDecorations.primaryGradientOpacity(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MmmButtons.plusMinusButton(
                                context, 'images/plus.svg', action: () {
                              addConnects();
                            }),
                            Text(
                              '$i',
                              style: MmmTextStyles.heading2(textColor: kDark5),
                            ),
                            MmmButtons.plusMinusButton(
                                context, 'images/minus.svg', action: () {
                              subtractConnects();
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
                        '*you can connect with $i people',
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
                  MmmButtons.buyConnectsButton('$i Connects', 'Rs ${50 * i}'),
                  SizedBox(
                    height: 15,
                  ),
                  MmmButtons.enabledRedButtonbodyMedium(50, 'Proceed to buy',
                      action: () {
                    navigateTopay();
                  })
                ],
              ),
            ),
          )
        ]));
  }

  void addConnects() {
    setState(() {
      i = i + 1;
    });
  }

  void subtractConnects() {
    if (i != 0) {
      setState(() {
        i = i - 1;
      });
    }
  }

  void navigateTopay() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PaymentMethodScreen(
              connects: this.i,
            )));
  }
}
