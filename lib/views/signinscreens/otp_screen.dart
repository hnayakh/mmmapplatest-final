import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pin1Controller = TextEditingController();

  TextEditingController pin2Controller = TextEditingController();

  TextEditingController pin3Controller = TextEditingController();

  FocusNode pin1Node = FocusNode();

  FocusNode pin2Node = FocusNode();

  FocusNode pin3Node = FocusNode();

  FocusNode pin4Node = FocusNode();

  @override
  void initState() {
    super.initState();
    pin1Controller.addListener(() {
      if (pin1Controller.text != '' && pin1Node.hasFocus) {
        setState(() {
          FocusScope.of(context).requestFocus(pin2Node);
        });
      }
    });
    pin2Controller.addListener(() {
      if (pin2Controller.text != '' && pin2Node.hasFocus) {
        setState(() {
          FocusScope.of(context).requestFocus(pin3Node);
        });
      }
    });
    pin3Controller.addListener(() {
      if (pin3Controller.text != '' && pin3Node.hasFocus) {
        setState(() {
          FocusScope.of(context).requestFocus(pin4Node);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: Container(
          child: AppBar(
            toolbarHeight: 0.0,
            //title: Text(widget.title),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kPrimary, kSecondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
          ),
        ),
        //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 32,
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: InkWell(
                onTap: () {},
                child: ShaderMask(
                  shaderCallback: (bounds) => RadialGradient(
                    center: Alignment.center,
                    radius: 0.5,
                    colors: [kPrimary, kSecondary],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: SvgPicture.asset(
                    'images/leftArrow.svg',
                    color: Colors.white,
                    height: 24,
                    width: 24,
                  ),
                )),
          ),
          SizedBox(
            height: 26,
          ),
          Container(
            margin: EdgeInsets.only(left: 15.5),
            child: Text(
              'Mobile Verification',
              style: MmmTextStyles.heading2(textColor: gray2),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Text(
              'We have sent a 4 digit verification code on your \nregistered number +91-9856423565',
              style: MmmTextStyles.bodySmall(textColor: gray3),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Form(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  controller: pin1Controller,
                  focusNode: pin1Node,
                  //showCursor: false,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading3(),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.67)),
                      borderSide: BorderSide(color: gray3, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.67)),
                      borderSide: BorderSide(color: gray3, width: 1),
                    ),
                  ),
                ),
              ),
              Container(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  controller: pin2Controller,
                  focusNode: pin2Node,
                  //showCursor: false,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading3(),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.67)),
                      borderSide: BorderSide(color: gray3, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.67)),
                      borderSide: BorderSide(color: gray3, width: 1),
                    ),
                  ),
                ),
              ),
              Container(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  controller: pin3Controller,
                  focusNode: pin3Node,
                  //showCursor: false,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading3(),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.67)),
                      borderSide: BorderSide(color: gray3, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.67)),
                      borderSide: BorderSide(color: gray3, width: 1),
                    ),
                  ),
                ),
              ),
              Container(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  focusNode: pin4Node,
                  //showCursor: false,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading3(),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.67)),
                      borderSide: BorderSide(color: gray3, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.67)),
                      borderSide: BorderSide(color: gray3, width: 1),
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
