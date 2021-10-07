import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';

import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int h = 2;
  TextEditingController cntrlr = TextEditingController();
  List<String> sentList = [];
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _controller.position.maxScrollExtent;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: Stack(
            children: [
              Container(
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
                  left: 55,
                  top: 55,
                  child: Row(
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
                      Text(
                        ' Kristen Stewart',
                        style: MmmTextStyles.heading4(textColor: kLight2),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.055,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "images/video.svg",
                            height: MediaQuery.of(context).size.height * 0.04,
                            color: gray5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "images/call.svg",
                              color: gray5,
                              height: MediaQuery.of(context).size.height * 0.04,
                              fit: BoxFit.cover,
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                controller: _controller,
                child: Container(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Yesterday',
                        style: MmmTextStyles.caption(textColor: kDark2),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      MmmWidgets.messageReceived('Hey Alia, How’s u?', '17:04'),
                      MmmWidgets.messageSent("I m good,What about u?", '17:05'),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Today',
                        style: MmmTextStyles.caption(textColor: kDark2),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      MmmWidgets.messageReceived(
                          'Let’s meet for coffee, what do you say?', '17:06'),
                      MmmWidgets.messageSent("Ok", '17:06'),
                      MmmWidgets.messageReceived(
                          'Let’s meet for coffee, what do you say?We can meet at CCD in Ashok Nagar at 8pm',
                          '17:06'),
                      MmmWidgets.messageSent("Ok.Just do it.", '17:06'),
                      sentList.length != 0
                          ? MmmWidgets.messageSent(
                              sentList[sentList.length - 1],
                              '17:06') // the list has to come from api , so the sequence of data is maintained and data is added to from users.
                          : Container()
                    ],
                  ),
                ),
              )),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 70, maxHeight: 210),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(25, 15, 0, 18),
                  decoration: BoxDecoration(
                      boxShadow: [MmmShadow.textFieldMessaging()],
                      color: kWhite,
                      borderRadius: BorderRadius.circular(36)),
                  child: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                          controller: cntrlr,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Type your message',
                            hintStyle:
                                MmmTextStyles.bodyMedium(textColor: kBio),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          )),
                    ),
                    Positioned(
                        top: 5,
                        right: 60,
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "images/camera.svg",
                                color: gray5,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ))),
                    Positioned(
                        top: 5,
                        right: 20,
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                sendMsg();
                              },
                              child: SvgPicture.asset(
                                "images/send.svg",
                                color: gray5,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            )))
                  ]),
                ),
              )
            ],
          ),
        ));
  }

  void sendMsg() {
    sentList.add(cntrlr.text);
    setState(() {
      cntrlr.text = '';
    });
  }
}
