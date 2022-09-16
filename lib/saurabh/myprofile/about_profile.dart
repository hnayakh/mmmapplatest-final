import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:makemymarry/utils/colors.dart';

import '../../utils/buttons.dart';
import '../../utils/text_styles.dart';
import '../hexcolor.dart';

class ABoutProfile extends StatefulWidget {
  const ABoutProfile({Key? key}) : super(key: key);

  @override
  State<ABoutProfile> createState() => _ABoutProfileState();
}

class _ABoutProfileState extends State<ABoutProfile> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var primaryColor = HexColor('C9184A');
    return Scaffold(
        appBar: MmmButtons.appBarCurved('About', context: context),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    //padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      "About me",
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.cardNumber(textColor: kDark5),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    maxLength: 200,
                    // controller: controller,
                    // textCapitalization: textCapitalization,
                    keyboardType: TextInputType.text,
                    style: MmmTextStyles.bodyRegular(textColor: kDark5),
                    // cursorColor: kDark5,
                    // obscureText: isPassword,
                    decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kDark2, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: kInputBorder, width: 1)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        hintText: "A little bit about me",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle:
                            MmmTextStyles.bodyRegular(textColor: kDark2)),
                    maxLines: 10,
                    enabled: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Photo",
                    textScaleFactor: 1.0,
                    style: MmmTextStyles.cardNumber(textColor: kDark5),
                  ),
                  Row(
                    // crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6eSTakjPRBatCMcm9fiX2KON4RC-Pjox1L2hqotKsmqIZhNaTKCuBUZbHiw6lvms2uwc&usqp=CAU",
                            height: 120,
                            // width: 120,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 110,
                          // width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(Icons.add)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 110,
                          // width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(Icons.add)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 110,
                          // width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(Icons.add)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ])));
  }
}
