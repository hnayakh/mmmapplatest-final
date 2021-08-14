import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';

import 'habits.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  TextEditingController namecontroller = TextEditingController();

  int value1 = 1;

  int value2 = 2;

  int group = 0;
  int dvalue1 = 1;
  int dvalue2 = 2;
  int dgroup = 0;

  String datetext = 'DD/MM/YYYY';

  String maritaltext = 'Select your maritial status';

  String heighttext = 'Select your height';

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
              'About',
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

      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
      floatingActionButton: FloatingActionButton(
        child: MmmIcons.rightArrowDisabled(),
        onPressed: () {
          navigateToHabits();
        },
        backgroundColor: gray5,
      ),
      body: Container(
        padding: kMargin16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            MmmTextFileds.textFiledWithLabelStar(
                'Name of Son/Daughter/Sister/Brother',
                "Enter Son's name",
                namecontroller),
            SizedBox(
              height: 24,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Date of birth',
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
                          Expanded(
                            child: Text(
                              datetext,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.start,
                              style: datetext == 'DD/MM/YYYY'
                                  ? MmmTextStyles.bodyRegular(textColor: kDark2)
                                  : MmmTextStyles.bodyRegular(
                                      textColor: kDark5),
                            ),
                          ),
                          SvgPicture.asset(
                            "images/Calendar.svg",
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
                      'Marital Status',
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
                            width: 216,
                            child: Text(
                              maritaltext,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.start,
                              style: maritaltext ==
                                      'Select your maritial status'
                                  ? MmmTextStyles.bodyRegular(textColor: kDark2)
                                  : MmmTextStyles.bodyRegular(
                                      textColor: kDark5),
                            ),
                          ),
                          SizedBox(
                            width: 110,
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
              margin: EdgeInsets.only(left: 8),
              child: Text(
                'Children',
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
            SizedBox(
              height: 24,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Height',
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
                            width: 216,
                            child: Text(
                              heighttext,
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.start,
                              style: heighttext == 'Select your height'
                                  ? MmmTextStyles.bodyRegular(textColor: kDark2)
                                  : MmmTextStyles.bodyRegular(
                                      textColor: kDark5),
                            ),
                          ),
                          SizedBox(
                            width: 110,
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
                  margin: EdgeInsets.only(left: 8),
                  child: Text(
                    'Disability',
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
                            value: dvalue1,
                            groupValue: dgroup,
                            onChanged: (val) {
                              setState(() {
                                dvalue1 = dgroup;
                                dvalue2 = 2;
                              });
                            }),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Normal',
                        style: MmmTextStyles.bodySmall(textColor: kDark5),
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Radio(
                            activeColor: Colors.pinkAccent,
                            value: dvalue2,
                            groupValue: dgroup,
                            onChanged: (val) {
                              setState(() {
                                dvalue2 = dgroup;
                                dvalue1 = 1;
                              });
                            }),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Physically Challenged',
                        style: MmmTextStyles.bodySmall(textColor: kDark5),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToHabits() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HabitScreen()));
  }
}
