import 'package:flutter/material.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: ClipOval(
                        child: Image.asset(
                          'images/stackviewImage.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    trailing: Column(
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: kPrimary,
                          child: Text(
                            '1',
                            textAlign: TextAlign.center,
                            style: MmmTextStyles.caption(textColor: kWhite),
                          ),
                        ),
                        Text(
                          '8m ago',
                          style: MmmTextStyles.caption(textColor: gray1),
                        ),
                      ],
                    ),
                    title: Text(
                      'Header',
                      style: MmmTextStyles.heading5(),
                    ),
                    subtitle: Text(
                      "He'll want to use your yacht, and I don't want this thing smelling",
                      style: MmmTextStyles.bodySmall(),
                    ),
                  );
                },
                itemCount: 8,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
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
