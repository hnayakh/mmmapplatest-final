import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';

class Bio extends StatelessWidget {
  const Bio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(74.0),
          child: Container(
            child: AppBar(
              leading: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: BoxDecoration(
                    color: kLight2.withOpacity(0.60),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      MmmShadow.elevationbBackButton(
                          shadowColor: kShadowColorForWhite)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                          height: 32,
                          width: 32,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'images/arrowLeft.svg',
                            height: 17.45,
                            width: 17.45,
                            color: gray3,
                          )),
                    ),
                  ),
                ),
              ),
              toolbarHeight: 74.0,
              title: Text(
                'Bio',
                style: MmmTextStyles.heading4(textColor: kLight2),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
              gradient: LinearGradient(
                  colors: [kPrimary, kSecondary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
          ),
          //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: kMargin16,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About me',
                          style: MmmTextStyles.bodyRegular(textColor: kDark5),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                            height: 180,
                            width: 390,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: kBio),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                                maxLength: 200,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: 'A little bit about me ...',
                                  hintStyle:
                                      MmmTextStyles.bodySmall(textColor: gray4),
                                  border: InputBorder.none,
                                  //enabledBorder: OutlineInputBorder(
                                  //   borderSide:
                                  //       BorderSide(color: kBio, width: 1),
                                  //    borderRadius: BorderRadius.circular(8)),
                                  //  focusedBorder: OutlineInputBorder(
                                  //    borderSide:
                                  //        BorderSide(color: kBio, width: 1),
                                  //    borderRadius: BorderRadius.circular(8)),
                                )))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Photo',
                          style: MmmTextStyles.bodyRegular(textColor: kDark5),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 100,
                              width: 180,
                              decoration: BoxDecoration(
                                  border: Border.all(color: kBio),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    MmmShadow.elevation3(
                                        shadowColor: kShadowColorForWhite)
                                  ]),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'images/bio.jpg',
                                      fit: BoxFit.cover,
                                      width: 180,
                                      height: 100,
                                    ),
                                  ),
                                  Positioned(
                                    left: 150,
                                    top: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [kPrimary, kSecondary],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 20,
                                              width: 18,
                                              //padding: EdgeInsets.fromLTRB(14, 13, 12, 13),
                                              child: SvgPicture.asset(
                                                "images/Cross.svg",
                                                color: gray7,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15.26,
                            ),
                            Container(
                              height: 100,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    MmmShadow.elevation3(
                                        shadowColor: kShadowColorForWhite)
                                  ]),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Material(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          border: Border.all(
                                              width: 1.5, color: kBioSecondary),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: SvgPicture.asset(
                                          'images/plus.svg',
                                          color: kBioSecondary,
                                          height: 24,
                                          width: 22.88,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 100,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    MmmShadow.elevation3(
                                        shadowColor: kShadowColorForWhite)
                                  ]),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Material(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1.5,
                                                color: kBioSecondary)),
                                        child: SvgPicture.asset(
                                          'images/plus.svg',
                                          color: kBioSecondary,
                                          height: 24,
                                          width: 22.88,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.26,
                            ),
                            Container(
                              height: 100,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    MmmShadow.elevation3(
                                        shadowColor: kShadowColorForWhite)
                                  ]),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Material(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1.5,
                                                color: kBioSecondary)),
                                        child: SvgPicture.asset(
                                          'images/plus.svg',
                                          color: kBioSecondary,
                                          height: 24,
                                          width: 22.88,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MmmButtons.enabledRedButtonbodyMedium(
                        50, 'Submit your details')
                  ])),
        ));
  }
}
