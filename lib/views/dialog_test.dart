import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({Key? key}) : super(key: key);

  @override
  _DialogScreenState createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  @override
  void initState() async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc('vh5jhBb92R3d5BqSHt7E')
        .collection('messages')
        .add({'title': 'new'});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('firebase')),
    );
  }
}
