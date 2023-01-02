// import 'package:flutter/material.dart';
// import 'package:intro_slider/intro_slider.dart';
// import 'package:makemymarry/datamodels/martching_profile.dart';
// import 'package:makemymarry/repo/user_repo.dart';
// import 'package:makemymarry/utils/colors.dart';
// import 'package:makemymarry/views/signinscreens/signin_page.dart';
//
// class IntroScreen extends StatefulWidget {
//   final UserRepository userRepository;
//
//   const IntroScreen({Key? key, required this.userRepository}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return IntroScreenState();
//   }
// }
//
// class IntroScreenState extends State<IntroScreen> {
//   List<ContentConfig> slides = [];
//
//   void onDonePress() {
//     // Do what you want
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => SignIn(userRepository: widget.userRepository)),
//     );
//   }
//
//   Widget renderNextBtn() {
//     return Icon(
//       Icons.navigate_next,
//       color: kPrimary,
//       size: 35.0,
//     );
//   }
//
//   Widget renderDoneBtn() {
//     return Icon(
//       Icons.done,
//       color: kPrimary,
//     );
//   }
//
//   Widget renderSkipBtn() {
//     return Icon(
//       Icons.skip_next,
//       color: kPrimary,
//     );
//   }
//
//   ButtonStyle myButtonStyle() {
//     return ButtonStyle(
//       shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
//       backgroundColor: MaterialStateProperty.all<Color>(Color(0x33F3B4BA)),
//       overlayColor: MaterialStateProperty.all<Color>(Color(0x33FFA8B0)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new IntroSlider(
//       // List slides
//       listContentConfig: this.slides,
//
//       // Skip button
//       renderSkipBtn: this.renderSkipBtn(),
//       skipButtonStyle: myButtonStyle(),
//
//       // Next button
//       renderNextBtn: this.renderNextBtn(),
//       nextButtonStyle: myButtonStyle(),
//
//       // Done button
//       renderDoneBtn: this.renderDoneBtn(),
//       onDonePress: this.onDonePress,
//       doneButtonStyle: myButtonStyle(),
//
//       // ,
//       // // Dot indicator
//       // colorDot: kSecondary,
//       // colorActiveDot: kPrimary,
//       // sizeDot: 13.0,
//       //
//       // // Show or hide status bar
//       // hideStatusBar: true,
//       // backgroundColorAllSlides: Colors.white,
//       // ,
//       //
//       // // Scrollbar
//       // verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     slides.add(
//       new ContentConfig(
//         title: "Management",
//         pathImage: "images/bio.jpg",
//         heightImage: 370,
//         widthImage: 400,
//
//         //pathImage: "images/bio.jpg",
//
//         backgroundColor: Colors.pink[200],
//         foregroundImageFit: BoxFit.none,
//         // title: "This is onboarding screen 1",
//         maxLineTitle: 2,
//         styleTitle: TextStyle(
//             color: kTextColor,
//             fontSize: 30.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'RobotoMono'),
//         description: "This is onboarding screen 1",
//         styleDescription: TextStyle(
//             color: kTextColor,
//             fontSize: 20.0,
//             fontStyle: FontStyle.italic,
//             fontFamily: 'Raleway'),
//         marginDescription:
//             EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
//         centerWidget: Text("Replace this with a custom widget",
//             style: TextStyle(color: Colors.white)),
//         //backgroundImage: "images/bio.jpg",
//
//         directionColorBegin: Alignment.topLeft,
//         directionColorEnd: Alignment.bottomRight,
//         onCenterItemPress: () {},
//       ),
//     );
//     slides.add(
//       new ContentConfig(
//         title: "CITY",
//         styleTitle: TextStyle(
//             color: Color(0xff7FFFD4),
//             fontSize: 30.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'RobotoMono'),
//         description:
//             "Ye indulgence unreserved connection alteration appearance",
//         styleDescription: TextStyle(
//             color: Color(0xff7FFFD4),
//             fontSize: 20.0,
//             fontStyle: FontStyle.italic,
//             fontFamily: 'Raleway'),
//         backgroundImage: "images/city.jpeg",
//         directionColorBegin: Alignment.topRight,
//         directionColorEnd: Alignment.bottomLeft,
//       ),
//     );
//     slides.add(
//       new ContentConfig(
//         title: "BEACH",
//         styleTitle: TextStyle(
//             color: Color(0xffFFDAB9),
//             fontSize: 30.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'RobotoMono'),
//         description:
//             "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
//         styleDescription: TextStyle(
//             color: Color(0xffFFDAB9),
//             fontSize: 20.0,
//             fontStyle: FontStyle.italic,
//             fontFamily: 'Raleway'),
//         backgroundImage: "images/beach.jpeg",
//         directionColorBegin: Alignment.topCenter,
//         directionColorEnd: Alignment.bottomCenter,
//         maxLineTextDescription: 3,
//       ),
//     );
//   }
// }
