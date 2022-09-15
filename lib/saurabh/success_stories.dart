import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:makemymarry/utils/text_styles.dart';

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
      body: Column(
        children: [
          Container(
            height: 200,
            width: screenSize.width,
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30))),
            child: Row(
              children: [
                Container(
                  height: 32,
                  width: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.arrow_back_ios),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Succes Stories",
                    style: MmmTextStyles.heading4(textColor: Colors.white))
              ],
            ),
          ),
          SizedBox(
            height: screenSize.height / 2.1,
            child: PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (pageNum) {
                setState(() {
                  currentPage = pageNum;
                });
              },
              children: <Widget>[
                Text("ok 1"),
                Text("ok 2"),
                Text("ok 3"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          color: currentPage == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle),
                    )),
          ),
          CarouselSlider(
            options: CarouselOptions(
                onPageChanged: (pageNum, _) {
                  setState(() {
                    currentPage = pageNum;
                  });
                },
                height: 400.0,
                viewportFraction: 0.6,
                enlargeCenterPage: true),
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Image.asset('images/icons/female.png')
                      // Text(
                      //   'text $i',
                      //   style: TextStyle(fontSize: 16.0),
                      // )

                      );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
