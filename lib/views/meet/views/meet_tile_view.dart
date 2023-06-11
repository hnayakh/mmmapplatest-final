import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/meet/bloc/meet_list_bloc.dart';
import 'package:makemymarry/views/meet/bloc/meet_list_state.dart';
import 'package:makemymarry/views/meet/views/meet_location.dart';

import 'meet_timing/schedule_meeting_date.dart';

class MeetTile extends StatelessWidget {
  const MeetTile({required this.connection,this.isReceived = false,  Key? key}) : super(key: key);

  final Activeconnection connection;
  final bool isReceived;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  connection.user.thumbnailUrl,
                  errorBuilder: (a,b,c) => Icon(Icons.error),
                  height: MediaQuery.of(context).size.width * 0.28,
                  width: MediaQuery.of(context).size.width * 0.28,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        connection.link.isNotEmpty
                            ? 'Virtual Meet'
                            : 'Meet in person',
                        style: MmmTextStyles.bodySmall(textColor: kPrimary),
                      ),
                      if (connection.link.isEmpty) ...[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.22,
                        ),
                        InkWell(
                          onTap: () async {
                            await context.navigate.push(
                                MeetLocationView.getRoute(
                                    connection: connection));
                            context.read<MeetListBloc>().fetchAllMeets();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient:
                                    MmmDecorations.primaryGradientOpacity(),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              'images/send.svg',
                              height: 15,
                              color: gray7,
                            ),
                          ),
                        )
                      ]
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    connection.user.name,
                    style: MmmTextStyles.heading5(textColor: kDark5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "on ${DateFormat('dd MMMM, yyyy').format(connection.scheduleTime)} on ${DateFormat('hh:mm a').format(connection.scheduleTime)}(IST)\nat ${connection.address}",
                    style: MmmTextStyles.footer(textColor: gray3),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ],
          ),
          subtitle: !isReceived
              ? Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.31,
                        ),
                        MmmButtons.rescheduleButtonMeet(
                          () async {
                            await context.navigate.push(BookYourDate.getRoute(
                              connection: connection,
                            ));
                            context.read<MeetListBloc>().fetchAllMeets();
                          },
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        MmmButtons.cancelButtonMeetScreen('Cancel', 76,
                            action: () {
                          _showDialog(context, () {
                            context
                                .read<MeetListBloc>()
                                .cancelMeetRequest(connection);
                          });
                        })
                      ],
                    )
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.31,
                        ),
                        MmmButtons.acceptMeetScreen(() {
                          context
                              .read<MeetListBloc>()
                              .acceptMeetRequest(connection);
                        }),
                        SizedBox(
                          width: 12,
                        ),
                        MmmButtons.cancelButtonMeetScreen('Not Now', 83,
                            action: () {
                          _showRejectDialog(context, () {
                            context
                                .read<MeetListBloc>()
                                .rejectMeetRequest(connection);
                          });
                        })
                      ],
                    )
                  ],
                ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context, void Function() onTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0))),
          backgroundColor: kWhite,
          title: Text("Cancel Request",
              textAlign: TextAlign.left,
              style: TextStyle( fontFamily: 'MakeMyMarry', 
                  fontWeight:
                      FontWeight.bold)), // To display the title it is optional
          content: new RichText(
              textAlign: TextAlign.center,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle( fontFamily: 'MakeMyMarry', 
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Are you want to cancel the request?'),
                  // new TextSpan(
                  //     text: ' mmyid', style: new TextStyle( fontFamily: 'MakeMyMarry', color: kPrimary)),
                  // new TextSpan(text: ' to find your perfect match.'),
                ],
              )),
          // Action widget which will provide the user to acknowledge the choice
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MmmButtons.primaryButtonMeetGray("Cancel", () {
                  Navigator.of(context).pop();
                  // navigateToHome(state);
                }),
                SizedBox(width: 10),
                MmmButtons.primaryButtonMeet("Confirm", () {
                  onTap();
                  Navigator.of(context).pop();
                  // navigateToHome(state);
                })
              ],
            ),
            SizedBox(height: 15)
          ],
        );
        //  AlertDialog(
        //   title: new Text("Alert!!"),
        //   content: new Text("You are awesome!"),
        //   actions: <Widget>[
        //     GestureDetector(
        //       child: new Text("OK"),
        //       onTap: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // );
      },
    );
  }

  void _showRejectDialog(BuildContext context, void Function() onTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: kWhite,
          title: Text("Cancel Request",
              textAlign: TextAlign.left,
              style: TextStyle( fontFamily: 'MakeMyMarry', 
                  fontWeight:
                      FontWeight.bold)), // To display the title it is optional
          content: new RichText(
              textAlign: TextAlign.left,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle( fontFamily: 'MakeMyMarry', 
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Are you want to cancel the request?'),
                  // new TextSpan(
                  //     text: ' mmyid', style: new TextStyle( fontFamily: 'MakeMyMarry', color: kPrimary)),
                  // new TextSpan(text: ' to find your perfect match.'),
                ],
              )),
          // Action widget which will provide the user to acknowledge the choice
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MmmButtons.primaryButtonMeetGray("Cancel", () {
                  Navigator.of(context).pop();
                  // navigateToHome(state);
                }),
                SizedBox(width: 10),
                MmmButtons.primaryButtonMeet("Confirm", () {
                  onTap();
                  Navigator.of(context).pop();
                  // navigateToHome(state);
                })
              ],
            ),
            SizedBox(height: 15)
          ],
        );
        //  AlertDialog(
        //   title: new Text("Alert!!"),
        //   content: new Text("You are awesome!"),
        //   actions: <Widget>[
        //     GestureDetector(
        //       child: new Text("OK"),
        //       onTap: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // );
      },
    );
  }
}
