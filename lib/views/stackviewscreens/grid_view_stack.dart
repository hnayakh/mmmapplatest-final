import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/stackviewscreens/stack_view.dart';

class GridViewofStack extends StatefulWidget {
  const GridViewofStack({Key? key}) : super(key: key);

  @override
  _GridViewofStackState createState() => _GridViewofStackState();
}

class _GridViewofStackState extends State<GridViewofStack> {
  int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                      padding: kMargin16,
                      child: GridView.builder(
                        shrinkWrap: false,
                        itemCount: 8,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1,
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemBuilder: (BuildContext context, int index) {
                          return MmmWidgets.stackUserprofileWidget(
                              context, 'images/stackviewImage.jpg');
                        },
                      )),
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
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              MmmButtons.swapViewButton(context, 'images/stack view.svg',
                  action: navigateToStackView),
            ],
          ),
        ],
      ),
    );
  }

  void navigateToStackView() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => StackView()));
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }
}
