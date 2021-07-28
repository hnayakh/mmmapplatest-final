import 'package:flutter/material.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/widget_views.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Make My Marry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "MakeMyMarry",
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MmmText(
          'Widget List',
          MmmTextStyles.heading5(textColor: Colors.white),
        ),
      ),
      body: Container(
        padding: kMargin16,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Primary Button', style: MmmTextStyles.heading6()),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WidgetView(
                          pos: index,
                          title: 'Primary Button',
                        )));
              },
            );
          },
          itemCount: 1,
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
