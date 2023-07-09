import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_bloc.dart';
import 'package:makemymarry/views/meet/views/meet_timing/schedule_meeting_time.dart';
import 'package:table_calendar/table_calendar.dart';

class BookYourDate extends StatefulWidget {
  BookYourDate(
      {this.meetType,
      this.latLng,
      this.address,
      this.connection,
      this.profileDetails,
      key})
      : super(key: key);

  static getRoute({
    MeetType? meetType,
    LatLng? latLng,
    String? address,
    Activeconnection? connection,
    ProfileDetails? profileDetails,
  }) =>
      MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (_) => MeetFormBloc(
                  userRepository: getIt<UserRepository>(),
                  profileDetails: profileDetails),
              child: BookYourDate(
                  meetType: meetType,
                  connection: connection,
                  latLng: latLng,
                  address: address,
                  profileDetails: profileDetails)));

  final MeetType? meetType;
  final Activeconnection? connection;
  final LatLng? latLng;
  final String? address;
  final ProfileDetails? profileDetails;

  @override
  _BookYourDate createState() => _BookYourDate();
}

class _BookYourDate extends State<BookYourDate> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  void initState() {
    if (widget.connection != null) {

      _focusedDay = widget.connection!.scheduleTime;
      _selectedDay = widget.connection!.scheduleTime;
    }
    super.initState();
  }

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
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: ShaderMask(
                      shaderCallback: (bounds) => RadialGradient(
                        center: Alignment.center,
                        radius: 0.5,
                        colors: [kPrimary, kSecondary],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 15, right: 12),
                        child: SvgPicture.asset(
                          'images/leftArrow.svg',
                          height: 24,
                          width: 24,
                        ),
                      ),
                    )),
              ],
            ),

            // Choose Your Type
            Text(
              'Book your Date',
              style: TextStyle(
                  fontFamily: 'MakeMyMarry', fontSize: 18, height: 3),
            ),
            Spacer(),
            Column(
              children: [
                Container(
                  child: TableCalendar(
                    firstDay: DateTime.now(),
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
                          _focusedDay = selectedDay;
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          // ignore: sort_child_properties_last
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                fontFamily: 'MakeMyMarry',
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
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.navigate.push(ScheduleMeetingTime.getRoute(
                                meetType: widget.meetType,
                                address: widget.address,
                                latLng: widget.latLng,
                                profileDetails: widget.profileDetails,
                                connection: widget.connection,
                                selectedDate: _selectedDay));
                          },
                          // ignore: sort_child_properties_last
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                fontFamily: 'MakeMyMarry',
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
                SizedBox(
                  height: 36,
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}
