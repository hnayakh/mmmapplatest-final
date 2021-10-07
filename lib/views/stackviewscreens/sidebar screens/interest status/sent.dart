import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class SentScreen extends StatelessWidget {
  const SentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'images/bio.jpg',
                      height: MediaQuery.of(context).size.width * 0.28,
                      width: MediaQuery.of(context).size.width * 0.28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'MMY2346',
                            style: MmmTextStyles.bodySmall(textColor: kPrimary),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          SvgPicture.asset(
                            'images/Verified.svg',
                            color: kPrimary,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Abhishek Sharma',
                        style: MmmTextStyles.heading5(textColor: kDark5),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "23 Years; 5’5’’ Height; B.Tech in Compter \nScience; New Delhi, Delhi, India...",
                        style: MmmTextStyles.footer(textColor: gray3),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.31,
                      ),
                      MmmButtons.connectButton('Connect Now', action: () {}),
                      SizedBox(
                        width: 12,
                      ),
                      MmmButtons.cancelButtonInterestScreen()
                    ],
                  )
                ],
              ),
            );
          },
          itemCount: 8,
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
