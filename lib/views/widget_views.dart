import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';

class WidgetView extends StatefulWidget {
  final int pos;
  final String title;

  const WidgetView({Key key, this.pos, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WidgetViewState();
  }
}

class WidgetViewState extends State<WidgetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: builUi(),
      ),
    );
  }

  Widget builUi() {
    switch (widget.pos) {
      case 0:
        return MmmButtons.primaryButton(widget.title, () {});
        break;
      default:
        return Container();
    }
  }
}
