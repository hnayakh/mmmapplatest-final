import 'package:flutter/material.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  var index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color.fromARGB(192, 221, 225, 230),
                  width: 1,
                ),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(83, 233, 30, 98)),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.asset(
                                  'images/addinterest/videocall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Image.asset(
                                  'images/addinterest/vcall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                                child: Image.asset(
                              'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Jacob Jones',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 120),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: kPrimary,
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.caption(
                                            textColor: kWhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text('can you tag me on that ?'),
                                  SizedBox(width: 50),
                                  Text(
                                    '8m ago',
                                    style:
                                        MmmTextStyles.caption(textColor: gray1),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // color: Color(0xffF0EFF5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color.fromARGB(192, 221, 225, 230),
                  width: 1,
                ),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(83, 233, 30, 98)),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.asset(
                                  'images/addinterest/videocall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Image.asset(
                                  'images/addinterest/vcall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                                child: Image.asset(
                              'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Jacob Jones',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 120),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: kPrimary,
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.caption(
                                            textColor: kWhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text('Available talk time '),
                                  Text(
                                    '30 mins',
                                    style: TextStyle(color: kSecondary),
                                  ),
                                  SizedBox(width: 40),
                                  Text(
                                    '8m ago',
                                    style:
                                        MmmTextStyles.caption(textColor: gray1),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // color: Color(0xffF0EFF5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color.fromARGB(192, 221, 225, 230),
                  width: 1,
                ),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(83, 233, 30, 98)),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.asset(
                                  'images/addinterest/videocall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Image.asset(
                                  'images/addinterest/vcall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                                child: Image.asset(
                              'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Jacob Jones',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 120),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: kPrimary,
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.caption(
                                            textColor: kWhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text('Full talk time'),
                                  SizedBox(width: 140),
                                  Text(
                                    '8m ago',
                                    style:
                                        MmmTextStyles.caption(textColor: gray1),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // color: Color(0xffF0EFF5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color.fromARGB(192, 221, 225, 230),
                  width: 1,
                ),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(83, 233, 30, 98)),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.asset(
                                  'images/addinterest/videocall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Image.asset(
                                  'images/addinterest/vcall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                                child: Image.asset(
                              'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Jacob Jones',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 120),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: kPrimary,
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.caption(
                                            textColor: kWhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text('can you tag me on that ?'),
                                  SizedBox(width: 50),
                                  Text(
                                    '8m ago',
                                    style:
                                        MmmTextStyles.caption(textColor: gray1),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // color: Color(0xffF0EFF5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color.fromARGB(192, 221, 225, 230),
                  width: 1,
                ),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(83, 233, 30, 98)),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.asset(
                                  'images/addinterest/videocall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Image.asset(
                                  'images/addinterest/vcall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                                child: Image.asset(
                              'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Jacob Jones',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 120),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: kPrimary,
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.caption(
                                            textColor: kWhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text('can you tag me on that ?'),
                                  SizedBox(width: 50),
                                  Text(
                                    '8m ago',
                                    style:
                                        MmmTextStyles.caption(textColor: gray1),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // color: Color(0xffF0EFF5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color.fromARGB(192, 221, 225, 230),
                  width: 1,
                ),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(83, 233, 30, 98)),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.asset(
                                  'images/addinterest/videocall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Image.asset(
                                  'images/addinterest/vcall.png',
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 1, 1, 30),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: kPrimary,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: MmmTextStyles.caption(
                                          textColor: kWhite),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                                child: Image.asset(
                              'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Jacob Jones',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 120),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: kPrimary,
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: MmmTextStyles.caption(
                                            textColor: kWhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text('can you tag me on that ?'),
                                  SizedBox(width: 50),
                                  Text(
                                    '8m ago',
                                    style:
                                        MmmTextStyles.caption(textColor: gray1),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Old Codes

            // Row(
            //   children: [
            //     Expanded(
            //         child: (Container(
            //       height: 68,
            //       decoration: BoxDecoration(boxShadow: [
            //         MmmShadow.elevationStack(),
            //       ]),
            //       padding: EdgeInsets.only(top: 8, bottom: 8),
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             MmmWidgets.bottomBarUnits('images/Search.svg', 'Search',
            //                 index == 0 ? kPrimary : gray3, action: () {
            //               setColor(0);
            //             }),
            //             MmmWidgets.bottomBarUnits(
            //                 'images/filter2.svg',
            //                 'Filter',
            //                 index == 1 ? kPrimary : gray3, action: () {
            //               setColor(1);
            //             }),
            //             MmmWidgets.bottomBarUnits(
            //                 'images/connect.svg',
            //                 'Connect',
            //                 index == 2 ? kPrimary : gray3, action: () {
            //               setColor(2);
            //             }),
            //             MmmWidgets.bottomBarUnits(
            //                 'images/Search.svg',
            //                 'Notifications',
            //                 index == 3 ? kPrimary : gray3, action: () {
            //               setColor(3);
            //             }),
            //             MmmWidgets.bottomBarUnits('images/menu.svg', 'More',
            //                 index == 4 ? kPrimary : gray3, action: () {
            //               setColor(4);
            //             })
            //           ]),
            //     ))),
            //   ],
            // )
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
