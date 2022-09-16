import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/text_styles.dart';

import '../../utils/buttons.dart';
import '../hexcolor.dart';

class AddIterests extends StatefulWidget {
  const AddIterests({Key? key}) : super(key: key);

  @override
  State<AddIterests> createState() => _AddIterestsState();
}

class _AddIterestsState extends State<AddIterests> {
  chooseMethod(position) {
    setState(() {
      for (int i = 0; i < interestList.length; i++) {
        if (i == position) {
          if (interestList[i]['status'] == true) {
            interestList[i]['status'] = false;
          } else {
            interestList[i]['status'] = true;
          }
        } else {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var primaryColor = HexColor('C9184A');
    return Scaffold(
        appBar: MmmButtons.appBarCurved('About', context: context),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Flexible(
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 4 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: interestList.length,
                        itemBuilder: (BuildContext ctx, i) {
                          return InkWell(
                            onTap: () {
                              chooseMethod(i);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: interestList[i]['status'] == true
                                          ? Colors.white
                                          : Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                  color: interestList[i]['status'] == true
                                      ? primaryColor
                                      : Colors.white),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      interestList[i]['icon'].toString(),
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      interestList[i]['name'].toString(),
                                      style: MmmTextStyles.cardNumber(
                                          textColor:
                                              interestList[i]['status'] == true
                                                  ? Colors.white
                                                  : Colors.black),
                                    )
                                  ]),
                            ),
                          );
                        }),
                  ),
                  // Column(
                  //   children: List.generate(
                  //       interestList.length,
                  //       (i) => Container(
                  //             alignment: Alignment.center,
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(20),
                  //                 color: primaryColor),
                  //             child: Row(children: [
                  //               SvgPicture.asset(
                  //                   interestList[i]['icon'].toString()),
                  //               Text(interestList[i]['name'].toString())
                  //             ]),
                  //           )),
                  // ),
                ])));
  }
}

var interestList = [
  {'icon': '', 'name': "Sports", "status": true},
  {'icon': '', 'name': "Ravel", "status": true},
  {'icon': 'images/icons/camera.svg', 'name': "Photography", "status": true},
  {'icon': '', 'name': "Gaming ", "status": true},
  {'icon': 'images/icons/singing.svg', 'name': "Singing", "status": false},
  {'icon': '', 'name': "Dance", "status": false},
  {'icon': 'images/icons/food.svg', 'name': "Food", "status": false},
  {'icon': 'images/icons/music.svg', 'name': "Music", "status": true},
  {'icon': '', 'name': "Art", "status": false},
  {'icon': '', 'name': "Cooking", "status": true},
  {'icon': 'images/icons/fashion.svg', 'name': "Fashion", "status": true},
  {'icon': 'images/icons/vblog.svg', 'name': "Vbolgging", "status": false},
  {'icon': 'images/icons/animals.svg', 'name': "Animal", "status": true},
  {'icon': 'images/icons/nature.svg', 'name': "Nature", "status": false},
  {'icon': 'images/icons/tech.svg', 'name': "Tech", "status": true},
  {'icon': 'images/icons/social.svg', 'name': "Social", "status": true},
];
