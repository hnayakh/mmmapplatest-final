import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

class CheckboxIcon extends StatefulWidget {
  const CheckboxIcon({Key key}) : super(key: key);

  @override
  _CheckboxIconState createState() => _CheckboxIconState();
}

class _CheckboxIconState extends State<CheckboxIcon> {
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
                  color: isSelected ? null : Color(0xffF5F5F5),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: Color(0xff8B83AF),
                          width: 1,
                        )),
              child: isSelected
                  ? Container(
                      child: SvgPicture.asset(
                        'images/Check.svg',
                        color: Color(0xffFFFFFF),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
