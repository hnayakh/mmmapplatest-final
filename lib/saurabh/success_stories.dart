import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:makemymarry/utils/text_styles.dart';

import '../utils/buttons.dart';
import 'hexcolor.dart';

class SuccessStories extends StatefulWidget {
  const SuccessStories({Key? key}) : super(key: key);

  @override
  State<SuccessStories> createState() => _SuccessStoriesState();
}

class _SuccessStoriesState extends State<SuccessStories> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var primaryColor = HexColor('C9184A');
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Sucess Stories', context: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            // Container(
            //   height: 200,
            //   width: screenSize.width,
            //   decoration: BoxDecoration(
            //       color: primaryColor,
            //       borderRadius:
            //           BorderRadius.only(bottomRight: Radius.circular(30))),
            //   child: Row(
            //     children: [
            //       Container(
            //         height: 32,
            //         width: 35,
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: Icon(Icons.arrow_back_ios),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text("Succes Stories",
            //           style: MmmTextStyles.heading4(textColor: Colors.white))
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: screenSize.height / 5,
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\"Lorem Ipsum is simply dummy text of the printing and typesetting industry\" ",
                    style: MmmTextStyles.cardNumber(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("-Shruti And Hasan "),
                ],
              )),

              //  PageView(
              //   physics: const ClampingScrollPhysics(),
              //   controller: _pageController,

              //   onPageChanged: (pageNum) {
              //     setState(() {
              //       currentPage = pageNum;
              //     });
              //   },
              //   children: <Widget>[
              //     Text("ok 1"),
              //     Center(child: Text("ok 2")),
              //     Text("ok 3"),
              //   ],
              // ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3,
                  (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            color: currentPage == index
                                ? primaryColor
                                : Colors.grey.withOpacity(0.5),
                            shape: BoxShape.circle),
                      )),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                    onPageChanged: (pageNum, _) {
                      setState(() {
                        currentPage = pageNum;
                      });
                    },
                    height: screenSize.height / 2.5,
                    viewportFraction: 0.6,
                    // aspectRatio: 5.8,
                    disableCenter: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    enlargeCenterPage: true),
                items: [1, 2, 3].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: screenSize.height / 7,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset(
                              'images/icons/female.png',
                              width: MediaQuery.of(context).size.width,
                              height: screenSize.height / 10,
                              fit: BoxFit.cover,
                            )
                            // Text(
                            //   'text $i',
                            //   style: TextStyle( fontFamily: 'MakeMyMarry', fontSize: 16.0),
                            // )

                            ),
                      );
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
