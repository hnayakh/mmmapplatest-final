import 'package:flutter/material.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../utils/buttons.dart';
import 'schedule_meeting_time.dart';

class BookYourDate extends StatefulWidget {
  BookYourDate({key}) : super(key: key);

  @override
  _BookYourDate createState() => _BookYourDate();
}

class _BookYourDate extends State<BookYourDate> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(top: 40, left: 5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
            child: Column(children: [
              const SizedBox(
                height: 15,
              ),

              //Left Arrow Mark
              ClipRRect(
                child: Padding(
                  padding: const EdgeInsets.only(right: 350),
                  child: MmmButtons.backButton(context),
                ),
              ),

              // Choose Your Type
              const SizedBox(
                width: 350,
                child: Text(
                  'Book your Date',
                  style: TextStyle(fontSize: 18, height: 3),
                ),
              ),
              Column(
                children: [
                  Container(
                    child: TableCalendar(
                      firstDay: DateTime(2002),
                      lastDay: DateTime(3000),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      rowHeight: 40,
                      daysOfWeekHeight: 20,
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                      ),
                      calendarStyle: const CalendarStyle(
                          selectedDecoration: BoxDecoration(
                              color: kPrimary, shape: BoxShape.circle)),
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _selectedDay = selectedDay;
                            focusedDay = focusedDay;
                          });
                        }
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            // ignore: sort_child_properties_last
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  //fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 170,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ScheduleMeetingTime()));
                            },
                            // ignore: sort_child_properties_last
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                  //fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: kPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ])));
  }
}
