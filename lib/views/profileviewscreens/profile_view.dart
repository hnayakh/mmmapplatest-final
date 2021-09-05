import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool showAppBar = false;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels >= 460) {
        setState(() {
          showAppBar = true;
        });
      }
      if (_controller.position.pixels < 460) {
        setState(() {
          showAppBar = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: showAppBar
          ? MmmButtons.appBarCurvedProfile('Kristen Stewart', context)
          : null,
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 475,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(23.3813)),
                    child: Image.asset(
                      'images/stackviewImage.jpg',
                      height: 453.01,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: Column(
                      children: [
                        MmmButtons.smallprofilePicButton('images/bio.jpg'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                        ),
                        MmmButtons.smallprofilePicButton('images/bio.jpg'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                        ),
                        MmmButtons.smallprofilePicButton('images/bio.jpg'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                        ),
                        MmmButtons.smallprofilePicButton('images/bio.jpg'),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(child: SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(flex: 20, child: SizedBox()),
                          MmmIcons.cancel(),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          MmmIcons.meet(),
                          Expanded(flex: 2, child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: kMargin16,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: Row(
                      children: [
                        Text(
                          'Kristen Stewart ',
                          style: MmmTextStyles.heading5(textColor: kPrimary),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Expanded(
                            // child:
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: kGreen),
                            ),
                            // ),
                            Expanded(child: SizedBox())
                          ],
                        ),
                        SvgPicture.asset(
                          'images/Verified.svg',
                          height: 20.51,
                          color: kPrimary,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  MmmWidgets.rowWidget(
                      "images/Users1.svg", ' Profile managed by Father'),
                  MmmWidgets.rowWidget(
                      "images/Calendar.svg", ' 25yrs, 12th Nov,1996 June'),
                  MmmWidgets.rowWidget(
                      "images/office.svg", 'Software Engineer'),
                  MmmWidgets.rowWidget("images/height.svg", '5’5’’ height'),
                  SizedBox(
                    height: 33,
                  ),
                  MmmButtons.profileViewButtons("images/Users1.svg", 'About'),
                  SizedBox(
                    height: 16,
                  ),
                  MmmButtons.profileViewButtons(
                      "images/education.svg", 'Career & Education'),
                  SizedBox(
                    height: 16,
                  ),
                  MmmButtons.profileViewButtons(
                      "images/heart.svg", 'Interests'),
                  SizedBox(
                    height: 16,
                  ),
                  MmmButtons.profileViewButtons(
                      "images/religion.svg", 'Religion Information'),
                  SizedBox(
                    height: 16,
                  ),
                  MmmButtons.profileViewButtons(
                      "images/occasionally.svg", 'Lifestyle'),
                  SizedBox(
                    height: 16,
                  ),
                  MmmButtons.profileViewButtons("images/family.svg", 'Family'),
                  SizedBox(
                    height: 60,
                  ),
                  MmmButtons.checkMatchButton(80, 'Check Match Percentage',
                      action: () {}),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Blocked Profile',
                    style: MmmTextStyles.bodyRegular(textColor: kPrimary),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
