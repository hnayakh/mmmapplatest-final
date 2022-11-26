import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:makemymarry/utils/colors.dart';

class ChatScreenUi extends StatefulWidget {
  const ChatScreenUi({Key? key}) : super(key: key);

  @override
  _ChatScreenUIState createState() => _ChatScreenUIState();
}

class _ChatScreenUIState extends State<ChatScreenUi> {
  var primaryColor = HexColor('#EB5884');
  var secondarycolor = HexColor('#FF8FA3');
  var thirdColor = HexColor('#DDE1E6');

  static const styleSender = BubbleStyle(
      nip: BubbleNip.leftTop, alignment: Alignment.bottomLeft, showNip: true);

  static const styleReceiver = BubbleStyle(
      nip: BubbleNip.rightTop,
      margin: BubbleEdges.only(top: 5),
      alignment: Alignment.centerRight,
      showNip: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
            gradient: LinearGradient(
                colors: [kSecondary, kPrimary],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft),
          ),
        ),
        actions: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.asset(
                    'images/arrowchat.png',
                    width: 0,
                    // height: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  child: Image.asset(
                    'images/face.png',
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  child: const Text(
                    'Jacab Joney',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  child: Image.asset(
                    'images/video.png',
                    // width: 30,
                    height: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  child: Image.asset(
                    'images/audio.png',
                    width: 35,
                    height: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ],
        toolbarHeight: 180,
        backgroundColor: primaryColor,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                //bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(100))),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Baseline(
                      baseline: 40,
                      baselineType: TextBaseline.alphabetic,
                      child: Text(
                        'Yesterday',
                        style: TextStyle(fontSize: 16, color: Colors.black38),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      constraints: BoxConstraints(minWidth: 1, maxWidth: 200),
                      decoration: BoxDecoration(
                          color: secondarycolor,
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      margin: const EdgeInsets.fromLTRB(5.0, 1.0, 1.0, 5.0),
                      // ignore: prefer_const_constructors
                      child: Center(
                        child: const Text("Hey Alia How's u?",
                            maxLines: 100,
                            style: TextStyle(
                              height: 2,
                              fontSize: 18.0,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Baseline(
                        baseline: 5,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          '17:04',
                          style: TextStyle(color: Colors.black38),
                        )),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      constraints: BoxConstraints(minWidth: 1, maxWidth: 200),
                      decoration: BoxDecoration(
                          color: thirdColor,
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(20),
                          )),
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      margin: const EdgeInsets.fromLTRB(5.0, 1.0, 10, 5.0),
                      // ignore: prefer_const_constructors
                      child: Center(
                        child: const Text("i'm good. what about you?",
                            maxLines: 100,
                            style: TextStyle(
                              height: 2,
                              fontSize: 18.0,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Baseline(
                        baseline: 5,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          '17:04',
                          style: TextStyle(color: Colors.black38),
                        )),
                  ),
                  const Baseline(
                      baseline: 40,
                      baselineType: TextBaseline.alphabetic,
                      child: Text('Today',
                          style:
                              TextStyle(fontSize: 17, color: Colors.black38))),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      constraints: BoxConstraints(minWidth: 1, maxWidth: 300),
                      decoration: BoxDecoration(
                          color: secondarycolor,
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 1.0, 1.0, 5.0),
                      child: Center(
                        child: Container(
                          // height: 100,
                          child: const Text(
                              "Let's meet for coffee , what do you say ?",
                              //maxLines: 100,
                              style: TextStyle(
                                height: 2,
                                fontSize: 18.0,
                              )),
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Baseline(
                        baseline: 20,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          '17:04',
                          style: TextStyle(color: Colors.black38),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 450,
            height: 70,
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.black26)),
                  hintText: 'Type your message',
                  hintStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                  suffixIcon: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // added line
                    mainAxisSize: MainAxisSize.min, // added line
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: IconButton(
                          color: Colors.black12,
                          onPressed: () {},
                          // ignore: prefer_const_constructors
                          icon: Icon(Icons.camera_alt_outlined, size: 40.0),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: IconButton(
                          color: Colors.black12,
                          onPressed: () {},
                          icon: const Icon(Icons.send_rounded, size: 40.0),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
