import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/occupation.dart';

class Religion extends StatefulWidget {
  Religion({Key? key}) : super(key: key);

  @override
  _ReligionState createState() => _ReligionState();
}

class _ReligionState extends State<Religion> {
  String religiontext = 'Select your religion';

  String casttext = 'Select your cast';

  String subcasttext = 'Select your sub cast';

  String mothertonguetext = 'Select your mother tongue';

  String gothratext = 'Select your gothra';
  late String religion;
  late MasterData masterData;
  late SimpleMasterData simpleMasterData;

  int value1 = 1;

  int group = 0;

  int value2 = 2;

  late String religionStatusHintText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Religion'),
      floatingActionButton: FloatingActionButton(
        child: MmmIcons.rightArrowDisabled(),
        onPressed: () {
          navigateToCarrer();
        },
        backgroundColor: gray5,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: kMargin16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButtons(
                  'Religion', 'Select your religion', 'images/rightArrow.svg',
                  action: () {}),
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButtons(
                  'Caste', 'Select your caste', 'images/rightArrow.svg',
                  action: () {}),
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButtons(
                  'Sub-Caste', 'Select your sub-caste', 'images/rightArrow.svg',
                  action: () {}),
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButtons('Mother Tongue',
                  'Select your mother tongue', 'images/rightArrow.svg',
                  action: () {}),
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButtons(
                  'Gothra', 'Select your gothra', 'images/rightArrow.svg',
                  action: () {}),
              SizedBox(
                height: 24,
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
            ],
          ),
        ),
      ),
    );
  }

  void navigateToCarrer() {
    //  Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => Occupation()));
  }
}
