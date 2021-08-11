import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class FamilyBackground extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FamilyBackgroundState();
  }
}

class FamilyBackgroundState extends State<FamilyBackground> {
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
    return Container(
        padding: kMargin16,
        child: Column(
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
                SizedBox(
                  height: 24,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Family Values',
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
                SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 8),
                      child: Text(
                        'Family Type',
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
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
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
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
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
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
            SizedBox(
              height: 48,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '   Current location of groom’s family',
                      style: MmmTextStyles.bodyMedium(textColor: kDark5),
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
                                width: 205,
                                child: Text(
                                  countrytext,
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.start,
                                  style: countrytext == 'Select your country'
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
                  height: 24,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'State',
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
                                width: 205,
                                child: Text(
                                  statetext,
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.start,
                                  style: statetext == 'Select your state'
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
                  height: 24,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'City',
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
              ],
            )
          ],
        ));
  }
}
