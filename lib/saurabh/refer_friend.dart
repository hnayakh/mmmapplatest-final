import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/elevations.dart';

class ReferFriendScreen extends StatefulWidget {
  ReferFriendScreen({Key? key}) : super(key: key);

  @override
  ReferFriendScreenState createState() => ReferFriendScreenState();
}

class ReferFriendScreenState extends State<ReferFriendScreen> {
  get image => null;

  get decoration => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(8),
        )),
        child: Column(
          children: [
            Container(
              height: 400.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/refer_earn.png'))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Container(
                      height: 36,
                      width: 36,
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      decoration: BoxDecoration(
                        color: kLight2.withOpacity(0.60),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          MmmShadow.elevationbBackButton(
                            shadowColor: kShadowColorForWhite,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
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
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('Refer a friend to make marry'),
                    SizedBox(height: 15),
                    Text('Friend create a profile and get verifief'),
                    SizedBox(height: 15),
                    Text('You will get one free connect')
                  ],
                )),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(children: [
                Container(
                  width: 250,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Share.share(
                          'check out Make My Marry App in Play store https://play.google.com/store/games');
                    },
                    // ignore: sort_child_properties_last
                    child: const Text(
                      'Refer Now',
                      style: TextStyle( fontFamily: 'MakeMyMarry', 
                          //fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // <-- Radius
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  child: GestureDetector(
                    onTap: (() {
                      print("Click");
                    }),
                    child: const Text(
                      'Terms & Conditions',
                      style: TextStyle( fontFamily: 'MakeMyMarry', height: 1),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
