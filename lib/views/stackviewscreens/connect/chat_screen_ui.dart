import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatScreenUi extends StatefulWidget {
  const ChatScreenUi({Key? key}) : super(key: key);

  @override
  _ChatScreenUIState createState() => _ChatScreenUIState();
}

class _ChatScreenUIState extends State<ChatScreenUi> {
  var primaryColor = HexColor('#C9184A');
  //var primaryColor = HexColor('#FF4D6D');
  //var primaryColor = HexColor('#EB5B84');

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
        body: CustomScrollView(slivers: [
      SliverAppBar(
        actions: <Widget>[
          Row(
            children: [
              //Left Arrow Mark
              Container(
                //margin: const EdgeInsets.only(right: 30),
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              // Profile Image
              Container(
                child: ClipOval(
                  child: Image.asset(
                    'images/face.png',
                    width: 95,
                    height: 75,
                  ),
                ),
              ),

              const SizedBox(
                width: 5,
              ),
              //   Title
              Container(
                child: const Text(
                  'Phun Sukh Wangdu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 20,
              ),

              //Vedio Call
              Container(
                child: Image.asset(
                  'images/video.png',
                  width: 30,
                  height: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 15,
              ),

              //Audio Call
              Container(
                child: Image.asset(
                  'images/audio.png',
                  width: 30,
                  height: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ],

        //   App Bar Height
        toolbarHeight: 150,
        backgroundColor: primaryColor,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                //bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(100))),
      ),
      SliverFillRemaining(
          child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Baseline(
              baseline: 10,
              baselineType: TextBaseline.alphabetic,
              child: Text(
                'Yesterday',
                style: TextStyle(fontSize: 16),
              )),
          const SizedBox(height: 15),
          Bubble(
              alignment: Alignment.topLeft,
              color: primaryColor,
              radius: const Radius.elliptical(25, 15),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  top: 5,
                  bottom: 5,
                ),
                margin: const EdgeInsets.fromLTRB(5.0, 1.0, 1.0, 5.0),
                width: 200,
                child: const Text(
                  'Hey Aakash Whats-up !',
                  maxLines: 100,
                  style: TextStyle(
                    height: 2,
                    fontSize: 18.0,
                  ),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Baseline(
                baseline: 5,
                baselineType: TextBaseline.alphabetic,
                child: Text('17:05')),
          ),
          Bubble(
              style: styleReceiver,
              alignment: Alignment.centerRight,
              color: const Color.fromARGB(135, 158, 158, 158),
              radius: const Radius.elliptical(25, 15),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                margin: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
                width: 200,
                child: const Text(
                  'Me Good & Wht abt You',
                  maxLines: 100,
                  style: TextStyle(
                    height: 2,
                    fontSize: 18.0,
                  ),
                ),
              )),
          const Align(
            alignment: Alignment.center,
            child: Baseline(
                baseline: 20,
                baselineType: TextBaseline.alphabetic,
                child: Text('17:05')),
          ),
          const Baseline(
              baseline: 30,
              baselineType: TextBaseline.alphabetic,
              child: Text('Today', style: TextStyle(fontSize: 17))),
          const SizedBox(
            height: 5,
          ),
          Bubble(
              alignment: Alignment.topLeft,
              color: primaryColor,
              radius: const Radius.elliptical(25, 15),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  top: 5,
                  bottom: 5,
                ),
                margin: const EdgeInsets.fromLTRB(5.0, 1.0, 1.0, 5.0),
                width: 200,
                child: const Text(
                  'Hey Aakash Whats-up, where areb you going ?',
                  maxLines: 100,
                  style: TextStyle(
                    height: 2,
                    fontSize: 18.0,
                  ),
                ),
              )),
          const Align(
            alignment: Alignment.centerLeft,
            child: Baseline(
                baseline: 20,
                baselineType: TextBaseline.alphabetic,
                child: Text('17:05')),
          ),
          const TextField(
            decoration: InputDecoration(
              //filled: true,
              fillColor: Colors.black,
              // border: InputBorder.none,
              labelText: 'Type your Message',
            ),
          ),
        ],
      )),
    ]));
  }
}
