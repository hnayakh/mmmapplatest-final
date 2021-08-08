import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';

class MeetIcon extends StatefulWidget {
  const MeetIcon({Key? key}) : super(key: key);

  @override
  _MeetIconState createState() => _MeetIconState();
}

class _MeetIconState extends State<MeetIcon> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [kPrimary, kSecondary],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)
                      : null,
                  color: isSelected ? null : gray3,
                ),
                child:
                    //isSelected?
                    SvgPicture.asset(
                  'images/meet.svg',
                  color: Color(0xffFFFFFF),
                )

                //: null,
                ),
          ),
        ),
      ),
    );
  }
}
