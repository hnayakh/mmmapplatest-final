import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/buttons.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/elevations.dart';
import '../utils/text_styles.dart';
import '../utils/view_decorations.dart';
import 'hexcolor.dart';

class PartnerPrefs extends StatefulWidget {
  const PartnerPrefs({Key? key}) : super(key: key);

  @override
  State<PartnerPrefs> createState() => _PartnerPrefsState();
}

class _PartnerPrefsState extends State<PartnerPrefs> {
  RangeLabels labels = RangeLabels('1', "100");
  // int values = 10;
  RangeValues values = RangeValues(1, 100);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var primaryColor = HexColor('C9184A');
    return Scaffold(
        appBar: customAppBar('Partner Preferences', "Reset", context: context),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Age Peference",
                style: MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Selected age is between 24 and 28",
                      style: MmmTextStyles.bodyMediumSmall(
                          textColor: Colors.black87),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RangeSlider(
                        divisions: 100,
                        activeColor: Colors.red[700],
                        inactiveColor: Colors.red[300],
                        min: 1,
                        max: 100,
                        values: values,
                        labels: labels,
                        onChanged: (value) {
                          print("START: ${value.start}, End: ${value.end}");
                          setState(() {
                            values = value;
                            labels = RangeLabels(
                                "${value.start.toInt().toString()}",
                                "${value.start.toInt().toString()}");
                          });
                        }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Profile Peference",
                style: MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Doesn\'t Matter ', action: () {
                print('ok');
                showDialog(
                    context: context,
                    builder: (ctx) => verificationSttausAlert());
              }),
              SizedBox(
                height: 20,
              ),
              Text(
                "Personal Peference",
                style: MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Height ', action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons("Marital Status", action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons("Disability", action: () {}),
              SizedBox(
                height: 20,
              ),
              Text(
                "Religion Peference",
                style: MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons("Religion", action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons("Cast", action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons("Sub-Cast", action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons("Mother Tongue", action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons("Gothra", action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons("Manglink", action: () {}),
              SizedBox(
                height: 20,
              ),
              Text(
                "Career Peference",
                style: MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Employeed in ', action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Occupation ', action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Highest Education', action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Annual Income', action: () {}),
              SizedBox(
                height: 10,
              ),
              Text(
                "Lifestyle Peference",
                style: MmmTextStyles.bodyMediumSmall(textColor: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Food', action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Smoke', action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Drink', action: () {}),
              SizedBox(
                height: 10,
              ),
              MmmButtons.myProfileButtons('Interests', action: () {}),
              SizedBox(
                height: 30,
              ),
              MmmButtons.enabledRedButtonbodyMedium(50, 'Apply Filter',
                  action: () {
                FocusScope.of(context).requestFocus(FocusNode());
                // BlocProvider.of<BioBloc>(context)
                //     .add(UpdateBio(this.bioController.text));
              }),
              SizedBox(
                height: 30,
              ),
            ])));
  }

  static Widget verificationSttausAlert() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        //width: 328,
        height: 293,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFFFF),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            // Container(
            //   width: double.infinity,
            //   height: 163,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(8),
            //     child: Image.asset(
            //       'images/stackviewImage.jpg',
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Text(
                'Verification Status',
                textAlign: TextAlign.center,
                style: MmmTextStyles.heading4(textColor: kDark5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
                height: 60,
                child: Text(
                  'Your document is sent for the verification. We’ll notify you once verification is done..',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.bodySmall(textColor: kDark5),
                )),
            SizedBox(
              height: 34,
            ),
            Container(
              height: 42,
              child: Container(
                decoration: MmmDecorations.primaryButtonDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Ok',
                          style: MmmTextStyles.heading6(textColor: gray7),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static PreferredSize customAppBar(String title, String trailText,
      {BuildContext? context}) {
    return PreferredSize(
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
                  onTap: () {
                    if (context != null) {
                      Navigator.of(context).pop();
                    }
                  },
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
          title: Row(
            children: [
              Text(
                title,
                style: MmmTextStyles.heading4(textColor: kLight2),
              ),
              SizedBox(
                width: MediaQuery.of(context!).size.width / 5,
              ),
              Text(
                trailText,
                style: MmmTextStyles.bodySmall(textColor: kLight2),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
            color: kSecondary),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }
}
