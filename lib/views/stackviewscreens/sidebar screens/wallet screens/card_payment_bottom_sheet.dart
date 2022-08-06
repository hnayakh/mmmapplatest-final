import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class CardPaymentBottomSheet extends StatefulWidget {
  const CardPaymentBottomSheet({Key? key}) : super(key: key);

  @override
  _CardPaymentBottomSheetState createState() => _CardPaymentBottomSheetState();
}

class _CardPaymentBottomSheetState extends State<CardPaymentBottomSheet> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final FocusNode fn1 = FocusNode();
  final FocusNode fn2 = FocusNode();
  final FocusNode fn3 = FocusNode();
  final FocusNode fn4 = FocusNode();

  String currentText1 = '';
  String currentText2 = '';
  String currentText3 = '';
  String currentText4 = '';

  @override
  void initState() {
    controller1.addListener(() {
      if (fn1.hasFocus && controller1.text.length == 4) {
        fn2.requestFocus();
      }
    });
    controller2.addListener(() {
      if (fn2.hasFocus && controller2.text.length == 4) {
        fn3.requestFocus();
      }
    });
    controller3.addListener(() {
      if (fn3.hasFocus && controller3.text.length == 4) {
        fn4.requestFocus();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kMargin12,
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
            'Add details:',
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
                  children: [
                    Text(
                      'Card Number',
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.bodySmall(textColor: kDark5),
                    ),
                    Text(
                      ' *',
                      style: MmmTextStyles.bodySmall(textColor: kredStar),
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kLight4,
                          border: Border.all(width: 1, color: kDark2)),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.05,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: TextField(
                            focusNode: fn1,
                            autofocus: false,
                            style: MmmTextStyles.bodyMedium(textColor: kDark5),
                            smartDashesType: SmartDashesType.enabled,
                            cursorHeight: 18,
                            cursorWidth: 1.5,
                            controller: controller1,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            //maxLines: null,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '_ _ _ _',
                              hintStyle:
                                  MmmTextStyles.bodySmall(textColor: kBio),
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            )),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.25,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: TextField(
                            focusNode: fn2,
                            autofocus: false,
                            style: MmmTextStyles.bodyMedium(textColor: kDark5),
                            cursorHeight: 18,
                            cursorWidth: 1.5,
                            controller: controller2,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            //maxLines: null,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '_ _ _ _',
                              hintStyle:
                                  MmmTextStyles.bodySmall(textColor: kBio),
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            )),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.45,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: TextField(
                            focusNode: fn3,
                            autofocus: false,
                            style: MmmTextStyles.bodyMedium(textColor: kDark5),
                            cursorHeight: 18,
                            cursorWidth: 1.5,
                            controller: controller3,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            //maxLines: null,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '_ _ _ _',
                              hintStyle:
                                  MmmTextStyles.bodySmall(textColor: kBio),
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            )),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.65,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: TextField(
                            focusNode: fn4,
                            autofocus: false,
                            style: MmmTextStyles.bodyMedium(textColor: kDark5),
                            cursorHeight: 18,
                            cursorWidth: 1.5,
                            controller: controller4,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            //maxLines: null,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '_ _ _ _',
                              hintStyle:
                                  MmmTextStyles.bodySmall(textColor: kBio),
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Expiry',
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.bodySmall(textColor: kDark5),
                        ),
                        Text(
                          ' *',
                          style: MmmTextStyles.bodySmall(textColor: kredStar),
                        )
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.32,
                    ),
                    Row(
                      children: [
                        Text(
                          'CVV',
                          textScaleFactor: 1.0,
                          style: MmmTextStyles.bodySmall(textColor: kDark5),
                        ),
                        Text(
                          ' *',
                          style: MmmTextStyles.bodySmall(textColor: kredStar),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kLight4,
                          border: Border.all(width: 1, color: kDark2)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'MM/YYYY',
                                    style: MmmTextStyles.bodyMedium(
                                        textColor: kDark2),
                                  ),
                                  SvgPicture.asset('images/Calendar.svg')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kLight4,
                          border: Border.all(width: 1, color: kDark2)),
                      child: TextField(
                          //focusNode: fn4,
                          autofocus: false,
                          style: MmmTextStyles.bodyMedium(textColor: kDark5),
                          cursorHeight: 18,
                          cursorWidth: 1.5,
                          //controller: controller4,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          //maxLines: null,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: '_ _ _',
                            hintStyle:
                                MmmTextStyles.bodySmall(textColor: kDark2),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                MmmButtons.enabledRedButtonbodyMedium(50, 'Buy Connects',
                    action: () {}),
                SizedBox(
                  height: 24,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      'images/lock.svg',
                      height: 30,
                      color: gray3,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7),
                      child: Text(
                        'We only securely save card & expiry details for \nfuture use.',
                        style:
                            MmmTextStyles.captionBold(textColor: kBioSecondary),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
        ]));
  }
}
