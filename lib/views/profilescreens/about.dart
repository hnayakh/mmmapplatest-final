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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('About'),

      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
      floatingActionButton: FloatingActionButton(
        child: MmmIcons.rightArrowDisabled(),
        onPressed: () {
          navigateToHabits();
        },
        backgroundColor: gray5,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              MmmButtons.categoryButton(
                  'Date of birth', 'DD/MM/YYYY', 'images/Calendar.svg'),
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButton('Marital Status',
                  'Select your maritial status', 'images/rightArrow.svg'),
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
                          activeColor: kPrimary,
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
                          activeColor: kPrimary,
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
              MmmButtons.categoryButton(
                  'Height', 'Select your height', 'images/rightArrow.svg'),
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
                              activeColor: kPrimary,
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
                              activeColor: kPrimary,
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
      ),
    );
  }

  void navigateToHabits() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HabitScreen()));
  }
}
