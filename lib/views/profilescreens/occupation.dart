import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';

class Carrer extends StatelessWidget {
  final UserRepository userRepository;

  Carrer({Key? key,required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OccupationScreen();
  }
}

class OccupationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OccupationScreenState();
  }
}

class OccupationScreenState extends State<OccupationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Career'),
      floatingActionButton: FloatingActionButton(
        child: MmmIcons.rightArrowDisabled(),
        onPressed: () {
          navigateToFamily(context);
        },
        backgroundColor: gray5,
      ),
      body: SingleChildScrollView(
        padding: kMargin16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 24,
                ),
                MmmButtons.categoryButton('Employeed in',
                    'Select your organisation', 'images/rightArrow.svg'),
                SizedBox(
                  height: 24,
                ),
                MmmButtons.categoryButton('Occupation',
                    'Select your occupation', 'images/rightArrow.svg'),
                SizedBox(
                  height: 24,
                ),
                MmmButtons.categoryButton('Annual Income',
                    'Select your annual income', 'images/rightArrow.svg'),
                SizedBox(
                  height: 24,
                ),
                MmmButtons.categoryButton('Highest Education',
                    'Select your highest education', 'images/rightArrow.svg'),
              ],
            ),
            SizedBox(
              height: 48,
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
                MmmButtons.categoryButton(
                    'Country', 'Select your country', 'images/rightArrow.svg'),
                SizedBox(
                  height: 24,
                ),
                MmmButtons.categoryButton(
                    'State', 'Select your state', 'images/rightArrow.svg'),
                SizedBox(
                  height: 24,
                ),
                MmmButtons.categoryButton(
                    'City', 'Select your city', 'images/rightArrow.svg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToFamily(BuildContext context) {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => FamilyScreen()));
  }
}
