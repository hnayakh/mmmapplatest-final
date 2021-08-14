import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/bio.dart';
import 'package:makemymarry/views/profilescreens/family_background.dart';
import 'package:makemymarry/views/profilescreens/family_details.dart';

class FamilyScreen extends StatefulWidget {
  FamilyScreen({Key? key}) : super(key: key);

  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen>
    with SingleTickerProviderStateMixin {
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
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: Container(
            child: AppBar(
              bottom:TabBar(
                controller: tabController,
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
              ) ,
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
              title: Container(
                width: MediaQuery.of(context).size.width,
                child:  Text(
                  'Family',
                  style: MmmTextStyles.heading4(textColor: kLight2),
                ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
                    gradient: LinearGradient(
                        colors: [kPrimary, kSecondary],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                  )
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),

          ),
          //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
        ),

        floatingActionButton: FloatingActionButton(
          child: MmmIcons.rightArrowDisabled(),
          onPressed: () {
            navigateTobio(context);
          },
          backgroundColor: gray5,
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            FamilyBackground(),
            FamilyDetails(),
          ],
        ),
      );
  }

  void navigateTobio(BuildContext context) {
    if (tabController.index == 0) {
      setState(() {
        tabController.index = 1;
      });
    } else
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Bio()));
  }
}
