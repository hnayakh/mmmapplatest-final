import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';

class MSentScreen extends StatelessWidget {
  const MSentScreen({Key? key}) : super(key: key);

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
                          'images/bio.jpg',
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
                            height: 20,
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
                          MmmButtons.rescheduleButtonMeet(),
                          SizedBox(
                            width: 12,
                          ),
                          MmmButtons.cancelButtonMeetScreen('Cancel', 76,
                              action: () {})
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
                                'Meet in person',
                                style: MmmTextStyles.bodySmall(
                                    textColor: kPrimary),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
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
                          MmmButtons.rescheduleButtonMeet(),
                          SizedBox(
                            width: 12,
                          ),
                          MmmButtons.cancelButtonMeetScreen('Cancellll', 76,
                              action: () {
                            print("Hello");
                            // AlertDialog(
                            //   backgroundColor: kWhite,
                            //   title: Text("User doesn't exist",
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //           fontWeight: FontWeight
                            //               .bold)), // To display the title it is optional
                            //   content: new RichText(
                            //       textAlign: TextAlign.center,
                            //       text: new TextSpan(
                            //         // Note: Styles for TextSpans must be explicitly defined.
                            //         // Child text spans will inherit styles from parent
                            //         style: new TextStyle(
                            //           fontSize: 14.0,
                            //           color: Colors.black,
                            //         ),
                            //         children: <TextSpan>[
                            //           new TextSpan(
                            //               text: 'Please enter correct'),
                            //           new TextSpan(
                            //               text: ' mmyid',
                            //               style:
                            //                   new TextStyle(color: kPrimary)),
                            //           new TextSpan(
                            //               text: ' to find your perfect match.'),
                            //         ],
                            //       )),
                            //   // Action widget which will provide the user to acknowledge the choice
                            //   actions: [
                            //     MmmButtons.primaryButton("Ok", () {
                            //       // navigateToHome(state);
                            //     })
                            //   ],
                            // );
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
}
