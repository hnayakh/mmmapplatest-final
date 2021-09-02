import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/stackviewscreens/grid_view_stack.dart';

class StackView extends StatefulWidget {
  const StackView({Key? key}) : super(key: key);

  @override
  _StackViewState createState() => _StackViewState();
}

class _StackViewState extends State<StackView> {
  int index = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: gray6,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: (Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(boxShadow: [
                        MmmShadow.elevationStack(),
                      ]),
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MmmWidgets.bottomBarUnits(
                                'images/Search.svg',
                                'Search',
                                index == 0 ? kPrimary : gray3, action: () {
                              setColor(0);
                            }),
                            MmmWidgets.bottomBarUnits(
                                'images/filter2.svg',
                                'Filter',
                                index == 1 ? kPrimary : gray3, action: () {
                              setColor(1);
                            }),
                            MmmWidgets.bottomBarUnits(
                                'images/connect.svg',
                                'Connect',
                                index == 2 ? kPrimary : gray3, action: () {
                              setColor(2);
                            }),
                            MmmWidgets.bottomBarUnits(
                                'images/Search.svg',
                                'Notifications',
                                index == 3 ? kPrimary : gray3, action: () {
                              setColor(3);
                            }),
                            MmmWidgets.bottomBarUnits('images/menu.svg', 'More',
                                index == 4 ? kPrimary : gray3, action: () {
                              setColor(4);
                            })
                          ]),
                    ))),
                  ],
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                //border: Border.all(color: kBio),
                borderRadius: BorderRadius.circular(16),
                //boxShadow: [
                //   MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
                // ]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                child: Image.asset(
                  'images/stackviewImage.jpg',
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  //height: 548,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    //border: Border.,
                    color: kBlack.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                  ),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.72,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              //height: 26,
                              child: Text(
                                'Kristen Stewart,24   ',
                                style: MmmTextStyles.heading5(textColor: gray6),
                              ),
                            ),
                            SvgPicture.asset(
                              'images/Verified.svg',
                              //height: 17.45,
                              color: gray6,
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.07),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'images/location.svg',
                                color: gray6,
                              ),
                              Container(
                                child: Text(
                                  '  Pune, Maharashtra',
                                  style:
                                      MmmTextStyles.bodySmall(textColor: gray6),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    MmmIcons.heart(),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                )
              ],
            ),
            MmmButtons.swapViewButton(context, 'images/GridView.svg',
                action: navigateToGridView)
          ],
        ),
      ),
    );
  }

  void navigateToGridView() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => GridViewofStack()));
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }
}
