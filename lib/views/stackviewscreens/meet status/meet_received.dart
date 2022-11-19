import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';

class MReceivedScreen extends StatelessWidget {
  const MReceivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'images/scar.jpg',
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
                                'Virtual Meet',
                                style: MmmTextStyles.bodySmall(
                                    textColor: kPrimary),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            'Abhishek Sharma',
                            style: MmmTextStyles.heading5(textColor: kDark5),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "on 27th April, 2021 at 11:00 PM(IST)",
                            style: MmmTextStyles.footer(textColor: gray3),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
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
                          MmmButtons.acceptMeetScreen(),
                          SizedBox(
                            width: 12,
                          ),
                          MmmButtons.cancelButtonMeetScreen('Not Now', 83,
                              action: () {
                            _showDialog(context);
                          })
                        ],
                      )
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'images/stackviewImage.jpg',
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
                                'Meet in Person',
                                style: MmmTextStyles.bodySmall(
                                    textColor: kPrimary),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.22,
                              ),
                              Container(
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
                              )
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            'Abhishek Sharma',
                            style: MmmTextStyles.heading5(textColor: kDark5),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.6,
                                maxHeight: double.infinity),
                            child: Text(
                              "on 27th April, 2021 at 11:00 PM(IST)\nPizza Royal, Dwarka, New Delhi, India",
                              style: MmmTextStyles.footer(textColor: gray3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
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
                          MmmButtons.acceptMeetScreen(),
                          SizedBox(
                            width: 12,
                          ),
                          MmmButtons.cancelButtonMeetScreen('Not Now', 83,
                              action: () {
                            _showDialog(context);
                          })
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          },
          itemCount: 8,
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: kWhite,
          title: Text("Cancel Request",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight:
                      FontWeight.bold)), // To display the title it is optional
          content: new RichText(
              textAlign: TextAlign.left,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Are you want to cancel the request?'),
                  // new TextSpan(
                  //     text: ' mmyid', style: new TextStyle(color: kPrimary)),
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
