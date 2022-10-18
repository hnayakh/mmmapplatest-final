import 'package:flutter/material.dart';
import 'package:makemymarry/utils/colors.dart';

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
              height: 450.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/refer_earn.png'))),
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
                    onPressed: () {},
                    // ignore: sort_child_properties_last
                    child: const Text(
                      'Refer Now',
                      style: TextStyle(
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
                      style: TextStyle(height: 1),
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
