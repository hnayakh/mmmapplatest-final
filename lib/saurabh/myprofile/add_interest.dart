import 'package:flutter/material.dart';
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
    var primaryColor = HexColor('#FF4D6D');
    return Scaffold(
        appBar: MmmButtons.appBarCurved('Add Interests', context: context),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 1.6,
                                crossAxisSpacing: 15,
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
                                    Image.asset(
                                        interestList[i]['icon'].toString()),
                                    SizedBox(
                                      width: 10,
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
                ])));
  }
}

var interestList = [
  {'icon': 'images/addinterest/sports.png', 'name': "Sports", "status": true},
  {'icon': 'images/addinterest/travel.png', 'name': "Travel", "status": true},
  {
    'icon': 'images/addinterest/photo.png',
    'name': "Photography",
    "status": true
  },
  {'icon': 'images/addinterest/games.png', 'name': "Gaming ", "status": true},
  {
    'icon': 'images/addinterest/singing.png',
    'name': "Singing",
    "status": false
  },
  {'icon': 'images/addinterest/dance.png', 'name': "Dance", "status": false},
  {'icon': 'images/addinterest/food.png', 'name': "Food", "status": false},
  {'icon': 'images/addinterest/music.png', 'name': "Music", "status": true},
  {'icon': 'images/addinterest/art.png', 'name': "Art", "status": false},
  {'icon': 'images/addinterest/cooking.png', 'name': "Cooking", "status": true},
  {'icon': 'images/addinterest/fashion.png', 'name': "Fashion", "status": true},
  {
    'icon': 'images/addinterest/vblog.png',
    'name': "Vbolgging",
    "status": false
  },
  {'icon': 'images/addinterest/animals.png', 'name': "Animal", "status": true},
  {'icon': 'images/addinterest/nature.png', 'name': "Nature", "status": false},
  {'icon': 'images/addinterest/tech.png', 'name': "Tech", "status": true},
  {'icon': 'images/addinterest/social.png', 'name': "Social", "status": true},
];
