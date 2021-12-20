import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:intl/intl.dart';

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
  var chats = FirebaseFirestore.instance.collection('chats');
  var chatDocId;
  final user1id = '12';
  final user2id = '45';
  var conState = 0;

  void findCollection() {
    chats
        .where('users', isEqualTo: {user1id: null, user2id: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            chatDocId = querySnapshot.docs.single.id;
            print('Existsdocumentids=$chatDocId');
          } else {
            chats.add({
              'users': {user1id: null, user2id: null}
            }).then((value) {
              chatDocId = value.id;
              print('Createddocumentid=$chatDocId');
            });
          }
        });
  }

  @override
  void initState() {
    findCollection();

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
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: chats
              .doc(chatDocId)
              .collection('messages')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                conState == 0) {
              conState = 1;
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (ctx, index) {
                              Timestamp now = snapshot.data!.docs[index]
                                  .data()['createdAt'];

                              String formattedTime =
                                  DateFormat.jm().format(now.toDate());
                              print(formattedTime);
                              // snapshot.data!.docs[index].data()['createdAt']
                              if (snapshot.data!.docs[index].data()['id'] ==
                                  user1id) {
                                return MmmWidgets.messageSent(
                                    snapshot.data!.docs[index].data()['text'],
                                    formattedTime);
                              } else {
                                return MmmWidgets.messageReceived(
                                    snapshot.data!.docs[index].data()['text'],
                                    formattedTime);
                              }
                            })),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: 70, maxHeight: 210),
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
              );
            } else {
              return Container();
            }
          },
        ));
  }

  void sendMsg() {
    chats.doc(chatDocId).collection('messages').add(
        //id =senders id
        {'text': cntrlr.text, 'createdAt': Timestamp.now(), 'id': user1id});
    cntrlr.clear();
    // setState(() {
    //   cntrlr.text = '';
    // });
  }
}
