import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class FamilyDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FamilyDetailsState();
  }
}

class FamilyDetailsState extends State<FamilyDetails> {

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
                                ? MmmTextStyles.bodyRegular(textColor: kDark2)
                                : MmmTextStyles.bodyRegular(textColor: kDark5),
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
          SizedBox(
            height: 24,
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
                                ? MmmTextStyles.bodyRegular(textColor: kDark2)
                                : MmmTextStyles.bodyRegular(textColor: kDark5),
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
          SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: kLight4)),
          ),
          SizedBox(
            height: 24,
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
                    width: 88,
                  ),
                  Row(
                    children: [
                      Text(
                        'Married',
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
                    width: (MediaQuery.of(context).size.width /2) - 48,
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                        color: kLight4,
                        border: Border.all(color: kBioSecondary, width: 1),
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
                            style: MmmTextStyles.bodyRegular(textColor: kDark5),
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
                    width: (MediaQuery.of(context).size.width /2) - 48,
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                        color: kLight4,
                        border: Border.all(color: kBioSecondary, width: 1),
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
                            marriedBrothers > -1 ? '$marriedBrothers' : '0',
                            style: MmmTextStyles.bodyRegular(textColor: kDark5),
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
          SizedBox(
            height: 24,
          ),
          Container(
            width: 360,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: kLight4)),
          ),
          SizedBox(
            height: 24,
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
                    width: 100,
                  ),
                  Row(
                    children: [
                      Text(
                        'Married',
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
                    width: (MediaQuery.of(context).size.width /2) - 48,
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                        color: kLight4,
                        border: Border.all(color: kBioSecondary, width: 1),
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
                            style: MmmTextStyles.bodyRegular(textColor: kDark5),
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
                    width: (MediaQuery.of(context).size.width /2) - 48,
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                        color: kLight4,
                        border: Border.all(color: kBioSecondary, width: 1),
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
                            marriedSisters > -1 ? '$marriedSisters' : '0',
                            style: MmmTextStyles.bodyRegular(textColor: kDark5),
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
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
