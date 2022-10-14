import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/colors.dart';

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
                      onPressed: () {},
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
                      onPressed: () {},
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
}
