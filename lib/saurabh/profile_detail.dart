import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makemymarry/repo/user_repo.dart';

import '../utils/text_styles.dart';
import 'custom_drawer.dart';
import 'hexcolor.dart';

class ProfileDetailsScreen extends StatefulWidget {
  ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetailsScreen> {
  bool favStatus = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        drawer: AppDrawer(
          userRepository: UserRepository(),
        ),
        body: Container(
          padding: EdgeInsets.only(top: kToolbarHeight / 2),
          child: Column(
            children: [
              Container(
                height: screenSize.height / 1.2,
                width: screenSize.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'images/icons/female.png',
                        ),
                        fit: BoxFit.cover),
                    // color: Colors.black12,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                // child: Image.asset(""),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                barrierColor: Colors.black26,
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      insetPadding: const EdgeInsets.all(0),
                                      elevation: 0,
                                      backgroundColor: const Color(0xffffffff),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        height: 200,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            iconText(
                                                leading: Icon(Icons
                                                    .verified_user_outlined),
                                                text: "Online Members"),
                                            iconText(
                                                leading: Icon(
                                                    Icons.workspace_premium),
                                                text: "Premium Members"),
                                            iconText(
                                                leading: Icon(
                                                    Icons.visibility_outlined),
                                                text: "Profile Visitors"),
                                            iconText(
                                                leading: Icon(Icons.search),
                                                text: "Recently Viewed"),
                                          ],
                                        ),
                                      ));
                                },
                              );
                            },
                            child: Container(
                                height: 32,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    Image.asset('images/icons/grid-icon.png')),
                          ),
                          Container(
                              height: 32,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  Image.asset('images/icons/shuffle-icon.png')),
                        ],
                      ),
                    ),
                    Container(
                        height: 100,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Alia Sharma, 24 years ",
                                      style: MmmTextStyles.heading4(
                                          textColor: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.verified_user_outlined,
                                      size: 18,
                                      color: Colors.white,
                                    )

                                    // images\icons\grid-icon.png
                                    // images\icons\fav-icon.png
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Hindu , Marathi ",
                                      style: MmmTextStyles.heading6(
                                          textColor: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.locationDot,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Pune , Maharshtra ",
                                      style: MmmTextStyles.heading6(
                                          textColor: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            // images\icons\cross-icon.png
                            if (favStatus)
                              Row(
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          favStatus = !favStatus;
                                        });
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                        size: 25,
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          favStatus = !favStatus;
                                        });
                                      },
                                      child: Icon(
                                        Icons.check_circle,
                                        color: HexColor('C9184A'),
                                        size: 25,
                                      )

                                      //  Image.asset(
                                      //   'images/icons/tick-icon.png',
                                      //   fit: BoxFit.contain,
                                      //   height: 50,
                                      //   // width: 0,
                                      // )

                                      )
                                ],
                              ),

                            if (!favStatus)
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      favStatus = !favStatus;
                                    });
                                  },
                                  child:
                                      Image.asset('images/icons/fav-icon.png'))
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  iconText({leading, String? text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          leading,
          SizedBox(
            width: 20,
          ),
          Text(
            text!,
            style: MmmTextStyles.bodyMediumSmall(),
          ),
        ],
      ),
    );
  }
}
