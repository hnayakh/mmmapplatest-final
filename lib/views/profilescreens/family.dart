import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';

class FamilyScreen extends StatefulWidget {
  FamilyScreen({Key key}) : super(key: key);

  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  String familyStatustext = 'Select your family status';

  String familyValuestext = 'Select your family values';
  int brothers = 0;
  int marriedBrothers = 0;
  int sisters = 0;
  int marriedSisters = 0;

  int value1 = 1;

  int group = 0;

  int value2 = 2;

  String countrytext = 'Select your country';

  String statetext = 'Select your state';

  String citytext = 'Select your city';

  String fatherOcctext = 'Select your father’s occupation';

  String motherOcctext = 'Select your mother’s occupation';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: Container(
            child: AppBar(
              flexibleSpace: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 95,
                  ),
                  Container(
                    width: double.infinity,
                    color: Color(0xffFFFFFF),
                    height: 49,
                    child: TabBar(
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 4.0,
                            color: kPrimary,
                          ),
                          insets: EdgeInsets.symmetric(horizontal: 16.0)),
                      automaticIndicatorColorAdjustment: true,
                      labelColor: kPrimary,
                      labelStyle: MmmTextStyles.heading6(),
                      unselectedLabelColor: kDark5,
                      unselectedLabelStyle: MmmTextStyles.heading6(),
                      tabs: [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Family Background',
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Family Details',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
                'Family',
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
        body: TabBarView(
          children: [
            Container(
                padding: kMargin16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Family Status',
                                  textScaleFactor: 1.0,
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '*',
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kredStar),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: kLight4,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1, color: kDark2),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          familyStatustext,
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.start,
                                          style: familyStatustext ==
                                                  'Select your family status'
                                              ? MmmTextStyles.bodyRegular(
                                                  textColor: kDark2)
                                              : MmmTextStyles.bodyRegular(
                                                  textColor: kDark5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                      ),
                                      SvgPicture.asset(
                                        "images/rightArrow.svg",
                                        width: 24,
                                        height: 24,
                                        color: Color(0xff878D96),
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Family Values',
                                  textScaleFactor: 1.0,
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '*',
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kredStar),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: kLight4,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1, color: kDark2),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          familyValuestext,
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.start,
                                          style: familyValuestext ==
                                                  'Select your family values'
                                              ? MmmTextStyles.bodyRegular(
                                                  textColor: kDark2)
                                              : MmmTextStyles.bodyRegular(
                                                  textColor: kDark5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                      ),
                                      SvgPicture.asset(
                                        "images/rightArrow.svg",
                                        width: 24,
                                        height: 24,
                                        color: Color(0xff878D96),
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 8),
                              child: Text(
                                'Family Type',
                                style: MmmTextStyles.bodyRegular(
                                    textColor: kDark5),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Radio(
                                        activeColor: Colors.pinkAccent,
                                        value: value1,
                                        groupValue: group,
                                        onChanged: (val) {
                                          setState(() {
                                            value1 = group;
                                            value2 = 2;
                                          });
                                        }),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Nuclear Family',
                                    style: MmmTextStyles.bodySmall(
                                        textColor: kDark5),
                                  ),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Radio(
                                        activeColor: Colors.pinkAccent,
                                        value: value2,
                                        groupValue: group,
                                        onChanged: (val) {
                                          setState(() {
                                            value2 = group;
                                            value1 = 1;
                                          });
                                        }),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Joint Family',
                                    style: MmmTextStyles.bodySmall(
                                        textColor: kDark5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 360,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kLight4)),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '   Current location of groom’s family',
                              style:
                                  MmmTextStyles.bodyMedium(textColor: kDark5),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Country',
                                  textScaleFactor: 1.0,
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '*',
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kredStar),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: kLight4,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1, color: kDark2),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          countrytext,
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.start,
                                          style: countrytext ==
                                                  'Select your country'
                                              ? MmmTextStyles.bodyRegular(
                                                  textColor: kDark2)
                                              : MmmTextStyles.bodyRegular(
                                                  textColor: kDark5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                      ),
                                      SvgPicture.asset(
                                        "images/rightArrow.svg",
                                        width: 24,
                                        height: 24,
                                        color: Color(0xff878D96),
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'State',
                                  textScaleFactor: 1.0,
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '*',
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kredStar),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: kLight4,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1, color: kDark2),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          statetext,
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.start,
                                          style:
                                              statetext == 'Select your state'
                                                  ? MmmTextStyles.bodyRegular(
                                                      textColor: kDark2)
                                                  : MmmTextStyles.bodyRegular(
                                                      textColor: kDark5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                      ),
                                      SvgPicture.asset(
                                        "images/rightArrow.svg",
                                        width: 24,
                                        height: 24,
                                        color: Color(0xff878D96),
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'City',
                                  textScaleFactor: 1.0,
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '*',
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kredStar),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: kLight4,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1, color: kDark2),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          citytext,
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.start,
                                          style: citytext == 'Select your city'
                                              ? MmmTextStyles.bodyRegular(
                                                  textColor: kDark2)
                                              : MmmTextStyles.bodyRegular(
                                                  textColor: kDark5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                      ),
                                      SvgPicture.asset(
                                        "images/rightArrow.svg",
                                        width: 24,
                                        height: 24,
                                        color: Color(0xff878D96),
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MmmIcons.rightArrowEnabled()
                      ],
                    )
                  ],
                )),
            Container(
              padding: kMargin16,
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Father’s Occupation',
                            textScaleFactor: 1.0,
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '*',
                            style: MmmTextStyles.bodySmall(textColor: kredStar),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: kLight4,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: kDark2),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  width: 250,
                                  child: Text(
                                    fatherOcctext,
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.start,
                                    style: fatherOcctext ==
                                            'Select your father’s occupation'
                                        ? MmmTextStyles.bodyRegular(
                                            textColor: kDark2)
                                        : MmmTextStyles.bodyRegular(
                                            textColor: kDark5),
                                  ),
                                ),
                                SizedBox(
                                  width: 75,
                                ),
                                SvgPicture.asset(
                                  "images/rightArrow.svg",
                                  width: 24,
                                  height: 24,
                                  color: Color(0xff878D96),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Mother’s Occupation',
                            textScaleFactor: 1.0,
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '*',
                            style: MmmTextStyles.bodySmall(textColor: kredStar),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: kLight4,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: kDark2),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  width: 260,
                                  child: Text(
                                    motherOcctext,
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.start,
                                    style: motherOcctext ==
                                            'Select your mother’s occupation'
                                        ? MmmTextStyles.bodyRegular(
                                            textColor: kDark2)
                                        : MmmTextStyles.bodyRegular(
                                            textColor: kDark5),
                                  ),
                                ),
                                SizedBox(
                                  width: 65,
                                ),
                                SvgPicture.asset(
                                  "images/rightArrow.svg",
                                  width: 24,
                                  height: 24,
                                  color: Color(0xff878D96),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 360,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: kLight4)),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '   Brother’s details of groom’s',
                            style: MmmTextStyles.bodyMedium(textColor: kDark5),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'No of Brother’s',
                                textScaleFactor: 1.0,
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '*',
                                style: MmmTextStyles.bodySmall(
                                    textColor: kredStar),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 88,
                          ),
                          Row(
                            children: [
                              Text(
                                'Married',
                                textScaleFactor: 1.0,
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '*',
                                style: MmmTextStyles.bodySmall(
                                    textColor: kredStar),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 42,
                            width: 157,
                            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                            decoration: BoxDecoration(
                                color: kLight4,
                                border:
                                    Border.all(color: kBioSecondary, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (brothers == -1) {
                                          brothers = 0;
                                        } else {
                                          brothers--;
                                        }
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'images/minus.svg',
                                      height: 24,
                                      width: 24,
                                      color: kDark2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 26,
                                  child: Text(
                                    brothers > -1 ? '$brothers' : '0',
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: kDark5),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        brothers++;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'images/plus.svg',
                                      height: 24,
                                      width: 24,
                                      color: kDark2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 42,
                          ),
                          Container(
                            height: 42,
                            width: 157,
                            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                            decoration: BoxDecoration(
                                color: kLight4,
                                border:
                                    Border.all(color: kBioSecondary, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (marriedBrothers == -1) {
                                          marriedBrothers = 0;
                                        } else {
                                          marriedBrothers--;
                                        }
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'images/minus.svg',
                                      height: 24,
                                      width: 24,
                                      color: kDark2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 26,
                                  child: Text(
                                    marriedBrothers > -1
                                        ? '$marriedBrothers'
                                        : '0',
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: kDark5),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        marriedBrothers++;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'images/plus.svg',
                                      height: 24,
                                      width: 24,
                                      color: kDark2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: 360,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: kLight4)),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '   Sister’s details of groom’s',
                            style: MmmTextStyles.bodyMedium(textColor: kDark5),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'No of Sister’s',
                                textScaleFactor: 1.0,
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '*',
                                style: MmmTextStyles.bodySmall(
                                    textColor: kredStar),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Row(
                            children: [
                              Text(
                                'Married',
                                textScaleFactor: 1.0,
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '*',
                                style: MmmTextStyles.bodySmall(
                                    textColor: kredStar),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 42,
                            width: 157,
                            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                            decoration: BoxDecoration(
                                color: kLight4,
                                border:
                                    Border.all(color: kBioSecondary, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (sisters == -1) {
                                          sisters = 0;
                                        } else {
                                          sisters--;
                                        }
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'images/minus.svg',
                                      height: 24,
                                      width: 24,
                                      color: kDark2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 26,
                                  child: Text(
                                    sisters > -1 ? '$sisters' : '0',
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: kDark5),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        sisters++;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'images/plus.svg',
                                      height: 24,
                                      width: 24,
                                      color: kDark2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 42,
                          ),
                          Container(
                            height: 42,
                            width: 157,
                            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                            decoration: BoxDecoration(
                                color: kLight4,
                                border:
                                    Border.all(color: kBioSecondary, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (marriedSisters == -1) {
                                          marriedSisters = 0;
                                        } else {
                                          marriedSisters--;
                                        }
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'images/minus.svg',
                                      height: 24,
                                      width: 24,
                                      color: kDark2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 26,
                                  child: Text(
                                    marriedSisters > -1
                                        ? '$marriedSisters'
                                        : '0',
                                    style: MmmTextStyles.bodyRegular(
                                        textColor: kDark5),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        marriedSisters++;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'images/plus.svg',
                                      height: 24,
                                      width: 24,
                                      color: kDark2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  MmmIcons.rightArrowEnabled()
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
