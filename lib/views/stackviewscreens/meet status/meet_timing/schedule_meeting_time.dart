import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/views/stackviewscreens/meet%20status/meet_status_screen.dart';

class ScheduleMeetingTime extends StatefulWidget {
  const ScheduleMeetingTime({Key? key}) : super(key: key);

  @override
  _ScheduleMeetingTimeState createState() => _ScheduleMeetingTimeState();
}

class _ScheduleMeetingTimeState extends State<ScheduleMeetingTime> {
  get image => null;

  get decoration => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        height: 600,
        width: 400,
        decoration: const BoxDecoration(
            //  color: Colors.blue,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Column(
          children: [
            ClipRRect(
              child: Padding(
                padding: const EdgeInsets.only(right: 350),
                child: MmmButtons.backButton(context),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Timings for meet',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Container(
                  height: 140,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (value) {},
                    initialDateTime: DateTime.now(),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    width: 400,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        openDilogue();
                      },
                      // ignore: sort_child_properties_last
                      child: const Text(
                        'Send Request',
                        style: TextStyle(fontSize: 18, color: kPrimary),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: 400,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      // ignore: sort_child_properties_last
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openDilogue() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: kWhite,
            content: Container(
              margin: const EdgeInsets.only(top: 40, left: 5),
              height: 400,
              width: 500,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                Radius.circular(20),
              )),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      child: const Text(
                        'Abhishek Sharma',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ClipOval(
                      //padding: const EdgeInsets.only(right: 330),
                      child: Image.asset(
                        'images/sheild.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ]),
                  Container(
                    child: ClipRect(
                      //padding: const EdgeInsets.only(right: 330),
                      child: Image.asset(
                        'images/profile.png',
                        height: 100,
                        width: 80,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Container(
                    child: const SizedBox(
                        width: 300,
                        child: Text(
                            'Your meet is scheduled on 27 APR 2021 at 11:00 PM 1ST',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MeetStatusScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: kPrimary,
                            fixedSize: const Size(250, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                'images/calendar.png',
                                height: 25,
                                width: 20,
                              ),
                              // const SizedBox(
                              //   width: 15,
                              // ),
                              const Text(
                                ' Add to your calendar',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: const SizedBox(
                        width: 280,
                        child: Text(
                            "we'll notify you if Abhishek  confirms your requests",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16))),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
