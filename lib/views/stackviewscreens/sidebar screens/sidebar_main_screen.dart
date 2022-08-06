import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';

class SidebarScreen extends StatelessWidget {
  const SidebarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
        child: Stack(
          children: [
            Container(
              child: AppBar(
                leading: Container(
                  margin: EdgeInsets.fromLTRB(10, 50, 10, 50),
                  decoration: BoxDecoration(
                      color: kLight2.withOpacity(0.60),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        MmmShadow.elevationbBackButton(
                            shadowColor: kShadowColorForWhite)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (context != null) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                            height: 32,
                            width: 32,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'images/arrowLeft.svg',
                              height: 17.45,
                              width: 17.45,
                              color: gray3,
                            )),
                      ),
                    ),
                  ),
                ),
                toolbarHeight: MediaQuery.of(context).size.height * 0.2,
                //title: ,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(32)),
                gradient: LinearGradient(
                    colors: [kPrimary, kSecondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
              ),
            ),
            Positioned(
                left: 65,
                top: 55,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 74,
                          width: 74,
                          color: Colors.transparent,
                        ),
                        CircleAvatar(
                          radius: 37,
                          child: ClipOval(
                            child: Image.asset(
                              'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: Stack(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kWhite,
                                ),
                              ),
                              Positioned(
                                top: 2,
                                bottom: 2,
                                right: 2,
                                left: 2,
                                child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kGreen,
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Kristen Stewart',
                          style: MmmTextStyles.heading4(textColor: kLight2),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'images/Verified.svg',
                              color: kWhite,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Verified User',
                              style: MmmTextStyles.caption(textColor: gray7),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          MmmButtons.searchScreenButton('My Profile', action: () {}),
          MmmButtons.searchScreenButton('Search', action: () {}),
          MmmButtons.searchScreenButton('Interests', action: () {}),
          MmmButtons.searchScreenButton('Connect', action: () {}),
          MmmButtons.searchScreenButton('Wallet', action: () {}),
          MmmButtons.searchScreenButton('Setting', action: () {}),
          MmmButtons.searchScreenButton('Sign Out', action: () {}),
        ],
      ),
    );
  }
}
