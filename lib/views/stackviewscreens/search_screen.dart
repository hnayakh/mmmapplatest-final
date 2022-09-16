import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/custom_drawer.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class SearchScreen extends StatefulWidget {
  final UserRepository userRepository;

  const SearchScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Search', context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: kMargin16,
              height: MediaQuery.of(context).size.height * 0.757,
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.74,
                            height: 60,
                            padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [MmmShadow.elevation1()]),
                            child: Container(
                              width: 100,
                              child: TextField(
                                  //controller: cntrlr,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 1,
                                  maxLength: 15,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Search by mmy id',
                                    hintStyle: MmmTextStyles.bodyRegular(
                                        textColor: gray4),
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                  )),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                                width: 44,
                                height: 44,
                                // alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: kLight4,
                                    boxShadow: [
                                      MmmShadow.filterButton(
                                          shadowColor: kShadowColorForGrid)
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: () {
                                            print("serach started");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                              'images/Search.svg',
                                              fit: BoxFit.cover,
                                            ),
                                          ))),
                                )),
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        height: MediaQuery.of(context).size.width * 0.14,
                        //alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              MmmShadow.filterButton(
                                  shadowColor: kShadowColorForGrid)
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: SvgPicture.asset(
                                      'images/filter2.svg',
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  MmmButtons.searchButtons(
                      'images/online.svg', 'Online Members',
                      action: () {}),
                  SizedBox(height: 8),
                  MmmButtons.searchButtons(
                      'images/online.svg', 'Premium Members',
                      action: () {}),
                  SizedBox(height: 8),
                  MmmButtons.searchButtons(
                      'images/profileViewed.svg', 'Profile Viewed by',
                      action: () {}),
                  SizedBox(height: 8),
                  MmmButtons.searchButtons(
                      'images/Search.svg', 'Profile Recently Viewed',
                      action: () {}),
                  SizedBox(height: 8),
                  MmmButtons.searchButtons(
                      'images/Check.svg', 'Recommended Profile',
                      action: () {}),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: (Container(
                  height: 68,
                  decoration: BoxDecoration(boxShadow: [
                    MmmShadow.elevationStack(),
                  ]),
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MmmWidgets.bottomBarUnits('images/Search.svg', 'Search',
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AppDrawer()),
                          );
                        })
                      ]),
                ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }
}
