import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';

class HabitScreen extends StatefulWidget {
  HabitScreen({Key key}) : super(key: key);

  @override
  _HabitScreenState createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  int eatValue;
  int smokeValue;
  int alcValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.0),
        child: Container(
          child: AppBar(
            leading: Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              decoration: BoxDecoration(
                  color: kLight2.withOpacity(0.60),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    MmmShadow.elevationbBackButton(
                        shadowColor: kShadowColorForWhite)
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'images/arrowLeft.svg',
                          height: 17.45,
                          width: 17.45,
                          color: gray3,
                        )),
                  ),
                ),
              ),
            ),
            toolbarHeight: 74.0,
            title: Text(
              'Habits',
              style: MmmTextStyles.heading4(textColor: kLight2),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
            gradient: LinearGradient(
                colors: [kPrimary, kSecondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
          ),
        ),
        //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
      ),
      body: Container(
        margin: kMargin16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eating',
                  style: MmmTextStyles.bodySmall(textColor: kModalPrimary),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    eatValue == 1
                        ? Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFF4D6D),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xffF0EFF5),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffFF4D6D).withOpacity(0.24),
                                    blurRadius: 14.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(0.0, 4.0),
                                  )
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 152,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/Veg2.svg',
                                        color: Color(0xffFCFCFD),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Vegeterrian',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.0,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: gray7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF0EFF5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xffF0EFF5),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    eatValue = 1;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 152,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/Veg2.svg',
                                        color: Color(0xff121619),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Vegetarrian',
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: kDark5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 8,
                    ),
                    eatValue == 2
                        ? Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFF4D6D),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xffF0EFF5),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffFF4D6D).withOpacity(0.24),
                                    blurRadius: 14.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(0.0, 4.0),
                                  )
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 144,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/egg.svg',
                                        color: Color(0xffFCFCFD),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'eggetarian',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.0,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: gray7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF0EFF5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xffF0EFF5),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    eatValue = 2;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 144,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/egg.svg',
                                        color: Color(0xff121619),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Eggetarian',
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: kDark5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                eatValue == 3
                    ? Container(
                        decoration: BoxDecoration(
                            color: Color(0xffFF4D6D),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xffF0EFF5),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffFF4D6D).withOpacity(0.24),
                                blurRadius: 14.0,
                                spreadRadius: 0.0,
                                offset: Offset(0.0, 4.0),
                              )
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 193,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SvgPicture.asset(
                                    'images/non veg.svg',
                                    color: Color(0xffFCFCFD),
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Non-Vegetarrian',
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.0,
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: gray7),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF0EFF5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xffF0EFF5),
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                eatValue = 3;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 193,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SvgPicture.asset(
                                    'images/non veg.svg',
                                    color: Color(0xff121619),
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Non-Vegetarrian',
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.center,
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: kDark5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smoking',
                  style: MmmTextStyles.bodySmall(textColor: kModalPrimary),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    smokeValue == 1
                        ? Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFF4D6D),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xffF0EFF5),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffFF4D6D).withOpacity(0.24),
                                    blurRadius: 14.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(0.0, 4.0),
                                  )
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 116,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/smoke.svg',
                                        color: Color(0xffFCFCFD),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Smoker',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.0,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: gray7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF0EFF5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xffF0EFF5),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    smokeValue = 1;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 116,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/smoke.svg',
                                        color: Color(0xff121619),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Smoker',
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: kDark5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 8,
                    ),
                    smokeValue == 2
                        ? Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFF4D6D),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xffF0EFF5),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffFF4D6D).withOpacity(0.24),
                                    blurRadius: 14.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(0.0, 4.0),
                                  )
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 161,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/noSmoke.svg',
                                        color: Color(0xffFCFCFD),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Never Smoke',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.0,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: gray7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF0EFF5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xffF0EFF5),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    smokeValue = 2;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 161,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/noSmoke.svg',
                                        color: Color(0xff121619),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Never Smoke',
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: kDark5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alcoholic',
                  style: MmmTextStyles.bodySmall(textColor: kModalPrimary),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    alcValue == 1
                        ? Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFF4D6D),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xffF0EFF5),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffFF4D6D).withOpacity(0.24),
                                    blurRadius: 14.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(0.0, 4.0),
                                  )
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 130,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/alco holic.svg',
                                        color: Color(0xffFCFCFD),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Alcoholic',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.0,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: gray7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF0EFF5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xffF0EFF5),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    alcValue = 1;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 130,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/alcoholic.svg',
                                        color: Color(0xff121619),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Alcoholic',
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: kDark5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 8,
                    ),
                    alcValue == 2
                        ? Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFF4D6D),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xffF0EFF5),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffFF4D6D).withOpacity(0.24),
                                    blurRadius: 14.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(0.0, 4.0),
                                  )
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 165,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/non_alcoholic.svg',
                                        color: Color(0xffFCFCFD),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Non-Alcoholic',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.0,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: gray7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF0EFF5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xffF0EFF5),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    alcValue = 2;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 165,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        'images/non_alcoholic.svg',
                                        color: Color(0xff121619),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Non-Alcoholic',
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: kDark5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                alcValue == 3
                    ? Container(
                        decoration: BoxDecoration(
                            color: Color(0xffFF4D6D),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xffF0EFF5),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffFF4D6D).withOpacity(0.24),
                                blurRadius: 14.0,
                                spreadRadius: 0.0,
                                offset: Offset(0.0, 4.0),
                              )
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 160,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SvgPicture.asset(
                                    'images/occasionally.svg',
                                    color: Color(0xffFCFCFD),
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Occasionally',
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.0,
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: gray7),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF0EFF5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xffF0EFF5),
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                alcValue = 3;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 160,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SvgPicture.asset(
                                    'images/occasionally.svg',
                                    color: Color(0xff121619),
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Occasionally',
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.center,
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: kDark5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            MmmIcons.rightArrowEnabled()
          ],
        ),
      ),
    );
  }
}
