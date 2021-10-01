import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: Container(
            child: AppBar(
              leading: Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                child: ClipRRect(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Transform.scale(
                        scale: 0.8,
                        child: SvgPicture.asset(
                          "images/bigleftArrow.svg",
                          color: gray5,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              toolbarHeight: MediaQuery.of(context).size.height * 0.15,
              title: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        color: Colors.transparent,
                      ),
                      CircleAvatar(
                        radius: 24,
                        child: ClipOval(
                          child: Image.asset(
                            'images/stackviewImage.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
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
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    'Kristen Stewart',
                    style: MmmTextStyles.heading4(textColor: kLight2),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "images/video.svg",
                        height: 30,
                        color: gray5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "images/call.svg",
                          color: gray5,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ))
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
              gradient: LinearGradient(
                  colors: [kPrimary, kSecondary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Container(
                color: Colors.orangeAccent,
              )),
              Container(
                height: 70,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(25, 15, 0, 18),
                decoration: BoxDecoration(
                    boxShadow: [MmmShadow.textFieldMessaging()],
                    color: kWhite,
                    // border: Border.all(width: 1, color: kWhite),
                    borderRadius: BorderRadius.circular(36)),
                child: Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(

                        //controller: bioController,
                        //maxLength: 200,
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'Type your message',
                          hintStyle: MmmTextStyles.bodyMedium(textColor: kBio),
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          //enabledBorder: OutlineInputBorder(
                          //   borderSide:
                          //       BorderSide(color: kBio, width: 1),
                          //    borderRadius: BorderRadius.circular(8)),
                          //  focusedBorder: OutlineInputBorder(
                          //    borderSide:
                          //        BorderSide(color: kBio, width: 1),
                          //    borderRadius: BorderRadius.circular(8)),
                        )),
                  ),
                  Positioned(
                    top: 5,
                    right: 60,
                    child: SvgPicture.asset(
                      "images/camera.svg",
                      color: gray5,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 20,
                    child: SvgPicture.asset(
                      "images/send.svg",
                      color: gray5,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
