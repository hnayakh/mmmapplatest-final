import 'package:flutter/material.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class DialogScreen extends StatelessWidget {
  const DialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MmmWidgets.acceptRequestWidget(context),
      ),
    );
  }
}
