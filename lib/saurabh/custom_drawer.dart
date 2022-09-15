import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:makemymarry/saurabh/hexcolor.dart';

import '../utils/buttons.dart';
import '../utils/text_styles.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);
  var primaryColor = HexColor('C9184A');
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Drawer(
                width: screenSize.width / 1.1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // height: 200,
                        padding: EdgeInsets.symmetric(vertical: 40),
                        alignment: Alignment.center,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                            // color: HexColor('C9184A'),
                            gradient: LinearGradient(
                                colors: [
                                  HexColor('FF758F'),
                                  HexColor('C9184A'),
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 1.0]),
                            // FF758F
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                  "images/icons/female.png",
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Alia Sharma,  ",
                                      style: MmmTextStyles.heading4(
                                          textColor: Colors.white),
                                    ),
                                    Icon(
                                      Icons.verified_user,
                                      size: 22,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                Text(
                                  "MM235345 ",
                                  style: MmmTextStyles.bodyMedium(
                                      textColor: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Edit Profile  ",
                                      style: MmmTextStyles.bodyMediumSmall(
                                          textColor: Colors.white),
                                    ),
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 22,
                                      color: Colors.white,
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    // isScrollControlled: true,
                                    // backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 300,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30))),
                                        child: Container(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(
                                                  Icons.arrow_back,
                                                  color: primaryColor,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Container(
                                                height: 55,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Enter coupon code",
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            // BorderSide.none,
                                                            //
                                                            BorderSide(
                                                                width: 2,
                                                                color: Colors
                                                                    .blueGrey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 0),
                                              child: Text(
                                                "Promo code MMM20 is invalid. Please try another code",
                                                style: MmmTextStyles.caption(
                                                    textColor:
                                                        Colors.redAccent),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            MmmButtons.primaryButton(
                                                "Apply", () {})
                                          ],
                                        )),
                                      );
                                    });
                              },
                              child: customListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: primaryColor,
                                ),
                                text: "My Profile",
                              ),
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              text: "Partner and Prefereces",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.wallet,
                                color: primaryColor,
                              ),
                              text: "Wallet ",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.group_rounded,
                                color: primaryColor,
                              ),
                              text: "Meet",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              text: "Interest",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.contact_page,
                                color: primaryColor,
                              ),
                              text: "Contacts",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              text: "Search by ID",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.share_outlined,
                                color: primaryColor,
                              ),
                              text: "Refer & earn",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.settings,
                                color: primaryColor,
                              ),
                              text: "Setting",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.help,
                                color: primaryColor,
                              ),
                              text: "Help",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.person_add,
                                color: primaryColor,
                              ),
                              text: "Blocked Profile",
                            ),
                            customListTile(
                              leading: Icon(
                                Icons.logout,
                                color: primaryColor,
                              ),
                              text: "Sign out",
                            ),
                          ],
                        ),
                      )
                    ]))));
  }

  customListTile({leading, String? text}) {
    return ListTile(
        leading: leading,
        title: Text(
          text!,
          style: MmmTextStyles.cardNumber(),
        ),
        trailing: Icon(Icons.arrow_forward_ios));
  }
}
