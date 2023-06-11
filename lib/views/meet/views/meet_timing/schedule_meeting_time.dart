import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';

import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_bloc.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_state.dart';
import 'package:makemymarry/views/meet/views/meet_status_screen.dart';

class ScheduleMeetingTime extends StatefulWidget {
  ScheduleMeetingTime(
      {this.meetType,
      this.latLng,
      this.address,
      this.connection,
      this.profileDetails,
      this.selectedDate,
      key})
      : super(key: key);

  static getRoute({
    MeetType? meetType,
    LatLng? latLng,
    String? address,
    Activeconnection? connection,
    ProfileDetails? profileDetails,
    DateTime? selectedDate,
  }) =>
      MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (_) => MeetFormBloc(
                  userRepository: getIt<UserRepository>(),
                  profileDetails: profileDetails,
                  meet: connection),
              child: ScheduleMeetingTime(
                  meetType: meetType,
                  connection: connection,
                  latLng: latLng,
                  address: address,
                  profileDetails: profileDetails,
                  selectedDate: selectedDate)));

  final MeetType? meetType;
  final Activeconnection? connection;
  final LatLng? latLng;
  final String? address;
  final ProfileDetails? profileDetails;
  final DateTime? selectedDate;

  @override
  _ScheduleMeetingTimeState createState() => _ScheduleMeetingTimeState();
}

class _ScheduleMeetingTimeState extends State<ScheduleMeetingTime> {
  get image => null;

  DateTime selectedTime = DateTime.now();
  get decoration => null;

  @override
  void initState() {
    if (widget.connection != null) {
      selectedTime = widget.connection!.scheduleTime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MeetFormBloc, MeetFormState>(
        listener: (context, state) {
          switch (state.formState) {
            case CustomFormState.uploading:
            case CustomFormState.loading:
              {
                MmmWidgets.buildLoader(navigatorKey.currentContext!);
                break;
              }
            case CustomFormState.idle:
              {
                break;
              }
            case CustomFormState.error:
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message ??
                      "Something went wrong. Please try again."),
                  backgroundColor: kError,
                ));
                break;
              }
            case CustomFormState.success:
              {
                if (widget.connection != null) {
                  context.navigate.pop();
                  context.navigate.pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Meet Updated Successfully"),
                    backgroundColor: kSuccess,
                  ));
                } else {
                  openDilogue(
                      state, context.read<MeetFormBloc>().profileDetails!);
                }
                break;
              }
          }
        },
        child: SafeArea(
          child: Container(
            

            // height: 600,
            // width: 400,
            decoration: const BoxDecoration(
                //  color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
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
                                left: 12.0, top: 18, right: 12, bottom: 18),
                            child: SvgPicture.asset(
                              'images/leftArrow.svg',
                              color: Colors.white,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        )),
                  ],
                ),
                const Text(
                  'Timings for meet',
                  style: TextStyle(
                      fontFamily: 'MakeMyMarry',
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        child: CupertinoDatePicker(
                          initialDateTime:
                              widget.connection?.scheduleTime ?? DateTime.now(),
                          mode: CupertinoDatePickerMode.time,
                          onDateTimeChanged: (value) {
                            selectedTime = value;
                          },
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
                            if (widget.connection != null) {
                              context
                                  .read<MeetFormBloc>()
                                  .submitMeetDate(widget.selectedDate);
                              context
                                  .read<MeetFormBloc>()
                                  .submitMeetTime(selectedTime);
                              context.read<MeetFormBloc>().updateMeetRequest();
                            } else {
                              context
                                  .read<MeetFormBloc>()
                                  .submitMeetType(widget.meetType!);
                              if (widget.meetType == MeetType.realTime) {
                                context.read<MeetFormBloc>().submitMeetLocation(
                                    widget.latLng, widget.address);
                              }
                              context
                                  .read<MeetFormBloc>()
                                  .submitMeetDate(widget.selectedDate);
                              context
                                  .read<MeetFormBloc>()
                                  .submitMeetTime(selectedTime);
                              context.read<MeetFormBloc>().createMeetRequest();
                            }
                          },
                          // ignore: sort_child_properties_last
                          child: const Text(
                            'Send Request',
                            style: TextStyle(
                                fontFamily: 'MakeMyMarry',
                                fontSize: 18,
                                color: kPrimary),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: 400,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            // ignore: sort_child_properties_last
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontFamily: 'MakeMyMarry',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openDilogue(MeetFormState state, ProfileDetails profileDetails) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: kWhite,
              content: Container(
                margin: const EdgeInsets.only(top: 12, left: 5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          Flexible(
                            child: Text(
                              profileDetails.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'MakeMyMarry',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (profileDetails.activationStatus ==
                              ProfileActivationStatus.Verified)
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
                      height: 100,
                      width: 100,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        profileDetails.images.first,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    Container(
                      child: SizedBox(
                          width: 300,
                          child: Text(
                              'Your meet is scheduled on ${DateFormat('dd MMM yyyy').format(state.meetDateTime!)} at ${DateFormat('hh:mm a').format(state.meetDateTime!)} IST',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'MakeMyMarry', fontSize: 17))),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          context.navigate.pop();
                          context.navigate.pop();
                          context.navigate.pop();
                          if (state.meetType == MeetType.realTime) {
                            context.navigate.pop();
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MeetStatusScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPrimary,
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
                            const Text(
                              ' Add to your calendar',
                              style: TextStyle(
                                fontFamily: 'MakeMyMarry',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: SizedBox(
                          width: 280,
                          child: Text(
                              "we'll notify you if ${profileDetails.name} confirms your requests",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'MakeMyMarry', fontSize: 16))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
