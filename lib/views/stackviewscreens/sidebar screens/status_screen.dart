import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Status', context: context),
      //    backgroundColor: Colors.black,
      body: Container(
        height: 372,
        padding: kMargin12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFFFF),
            boxShadow: [
              MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 24,
            ),
            Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08,
                      ),
                      Text(
                        'Select your Status',
                        style: MmmTextStyles.heading4(textColor: kDark5),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'images/scar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Abhishek Sharma',
              style: MmmTextStyles.heading5(textColor: kDark5),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MMY23456',
                  style: MmmTextStyles.bodySmall(textColor: gray4),
                ),
                SizedBox(
                  width: 5,
                ),
                SvgPicture.asset(
                  "images/Verified.svg",
                  height: 16,
                  width: 16,
                  color: Color(0xffC9184A),
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 0,
              width: 309.02,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Color(0xffF0EFF5),
                width: 0.5,
              )),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 42,
              child: Container(
                decoration: MmmDecorations.primaryButtonDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Keep me Online',
                          style: MmmTextStyles.bodyMedium(textColor: gray7),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xffDDE1E6))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        'Keep me Offline',
                        style: MmmTextStyles.bodyMedium(textColor: gray3),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    // Container(
    // height: 450,
    // width: 370,
    //   decoration: BoxDecoration(
    //       color: Colors.white, borderRadius: BorderRadius.circular(20)),
    //   child: Column(
    //     children: [
    //       const SizedBox(height: 70),
    //       const Text(
    //         "Select your Status",
    //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    //       ),
    //       const SizedBox(height: 30),
    //       ClipRRect(
    //         borderRadius: BorderRadius.circular(15), // Image border
    //         child: SizedBox.fromSize(
    //           size: const Size.fromRadius(42), // Image radius
    //           child: Image.asset('images/profile.png', fit: BoxFit.cover),
    //         ),
    //       ),
    //       const SizedBox(height: 20),
    //       const Text(
    //         "Abhishek Sharma",
    //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    //       ),
    //       const SizedBox(height: 8),
    //       Row(children: [
    //         Container(
    //           margin: const EdgeInsets.only(left: 130),
    //           child: const Text(
    //             "MMY23456",
    //             style: TextStyle(
    //               fontSize: 14,
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           width: 16,
    //         ),
    //         Container(
    //           child: SvgPicture.asset(
    //             'images/Verifiedred.svg',
    //             height: 20,
    //             width: 20,
    //           ),
    //         ),
    //       ]),
    //       const SizedBox(height: 6),
    //       const Divider(
    //         color: Color.fromARGB(248, 233, 217, 217),
    //         thickness: 1,
    //         indent: 15.0,
    //         endIndent: 15.0,
    //       ),
    //       const SizedBox(height: 18),
    //       // ignore: unnecessary_new, sized_box_for_whitespace
    //       new Container(
    //         child: MmmWidgets.selectStatusWidget(context),
    //         // child: TextField(
    //         //   textAlign: TextAlign.center,
    //         //   decoration: InputDecoration(
    //         //     filled: true,
    //         //     fillColor: const Color.fromARGB(255, 182, 40, 87),
    //         //     border: OutlineInputBorder(
    //         //       borderRadius: BorderRadius.circular(8),
    //         //     ),

    //         //     // filled: true,
    //         //     hintStyle: const TextStyle(
    //         //       color: Colors.white,
    //         //       fontSize: 18,
    //         //       height: .5,
    //         //     ),
    //         //     hintText: "Keep me Online",
    //         //   ),
    //         // ),
    //       ),
    //       const SizedBox(height: 17),
    //       // ignore: unnecessary_new, sized_box_for_whitespace
    //       new Container(
    //         width: 300,
    //         height: 42,
    //         child: TextField(
    //           textAlign: TextAlign.center,
    //           decoration: InputDecoration(
    //             filled: true,
    //             fillColor: Colors.white,
    //             border: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(8),
    //             ),

    //             // filled: true,
    //             hintStyle: const TextStyle(
    //               color: Colors.black,
    //               fontSize: 18,
    //               height: .5,
    //             ),
    //             hintText: "Keep me Offline",
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    //);
  }
}
