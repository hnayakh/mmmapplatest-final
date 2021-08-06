import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';

class Occupation extends StatelessWidget {
  String employtext = 'Select your organisation';

  String occupationtext = 'Select your occupation';

  String incometext = 'Select your annual income';

  String highestEdutext = 'Select your highest education';

  String countrytext = 'Select your country';

  String statetext = 'Select your state';

  String citytext = 'Select your city';

  Occupation({Key key}) : super(key: key);

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
            toolbarHeight: 74.0,
            title: Text(
              'Religion',
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
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Employeed in',
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
                      height: 45,
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
                                  employtext,
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.start,
                                  style:
                                      employtext == 'Select your organisation'
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
                          'Occupation',
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
                      height: 45,
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
                                  occupationtext,
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.start,
                                  style:
                                      occupationtext == 'Select your occupation'
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
                          'Annual Income',
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
                      height: 45,
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
                                width: 221,
                                child: Text(
                                  incometext,
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.start,
                                  style:
                                      incometext == 'Select your annual income'
                                          ? MmmTextStyles.bodyRegular(
                                              textColor: kDark2)
                                          : MmmTextStyles.bodyRegular(
                                              textColor: kDark5),
                                ),
                              ),
                              SizedBox(
                                width: 105,
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
                          'Highest Education',
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
                      height: 45,
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
                                width: 240,
                                child: Text(
                                  highestEdutext,
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.start,
                                  style: highestEdutext ==
                                          'Select your highest education'
                                      ? MmmTextStyles.bodyRegular(
                                          textColor: kDark2)
                                      : MmmTextStyles.bodyRegular(
                                          textColor: kDark5),
                                ),
                              ),
                              SizedBox(
                                width: 85,
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
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Current location of groom’s',
                      style: MmmTextStyles.bodyMedium(textColor: kModalPrimary),
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
                      height: 45,
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
                      height: 45,
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
                      height: 45,
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
              ],
            ),
            MmmIcons.rightArrowEnabled()
          ],
        ),
      ),
    );
  }
}
