import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';

class Religion extends StatefulWidget {
  Religion({Key key}) : super(key: key);

  @override
  _ReligionState createState() => _ReligionState();
}

class _ReligionState extends State<Religion> {
  String religiontext = 'Select your religion';

  String casttext = 'Select your cast';

  String subcasttext = 'Select your sub cast';

  String mothertonguetext = 'Select your mother tongue';

  String gothratext = 'Select your gothra';

  int value1 = 1;

  int group = 0;

  int value2 = 2;

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
        padding: kMargin16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Religion',
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
                  height: 50,
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
                              religiontext,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.start,
                              style: religiontext == 'Select your religion'
                                  ? MmmTextStyles.bodyRegular(textColor: kDark2)
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
                      'Cast',
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
                  height: 50,
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
                              casttext,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.start,
                              style: casttext == 'Select your cast'
                                  ? MmmTextStyles.bodyRegular(textColor: kDark2)
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
                      'Sub-Cast',
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
                  height: 50,
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
                              subcasttext,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.start,
                              style: subcasttext == 'Select your sub cast'
                                  ? MmmTextStyles.bodyRegular(textColor: kDark2)
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
                      'Mother Tongue',
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
                  height: 50,
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
                              mothertonguetext,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.start,
                              style: mothertonguetext ==
                                      'Select your mother tongue'
                                  ? MmmTextStyles.bodyRegular(textColor: kDark2)
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
                      'Gothra',
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
                  height: 50,
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
                              gothratext,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.start,
                              style: gothratext == 'Select your gothra'
                                  ? MmmTextStyles.bodyRegular(textColor: kDark2)
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
                    'Manglik',
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
                        'Yes',
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
                        'No',
                        style: MmmTextStyles.bodySmall(textColor: kDark5),
                      ),
                    ],
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
