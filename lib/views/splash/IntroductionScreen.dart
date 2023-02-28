import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/hexcolor.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/signinscreens/signin_page.dart';

class OnBoardingPage extends StatefulWidget {
  final UserRepository userRepository;

  const OnBoardingPage({Key? key, required this.userRepository})
      : super(key: key);
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignInPage()),
    );
  }

 int  pageIndex  = 0 ;
  Widget _buildFullscreenImage() {
    return Image.asset(
      'images/bio.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 500]) {
    return Container(
      width: 420,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Image.asset(
        'images/$assetName',
        height: 310,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 16.0,
    );

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyAlignment: Alignment(0.7, 0.5),
      pageColor: Colors.white,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
     onChange: (index) {
        setState(() {
          pageIndex = index;
        });
     },
      globalHeader: Align(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 0),
            child: _buildImage('frameUpadatedone.jpg', 300),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "This is  an onboarding screen 1",
          body:
              "Talk about one of the feature of your application & how it will help your users.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "This is an onboarding screen 2",
          body:
              "Talk about one of your feature of the application & how it will help your users.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "This is an onboarding screen 3",
          body:
              "Talk about one of the feature of your application & how it will help your users.",
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),

      showBackButton: true,

      nextFlex: 0,

      skipOrBackFlex: 2,

      back: Container(
        margin: EdgeInsets.fromLTRB(0, 170, 0, 0),
        child: const Text('Previous',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      ),

      next: Container(
        margin: EdgeInsets.fromLTRB(0, 160, 0, 0),
        height: 50,
        width: 70,
        decoration: MmmDecorations.primaryButtonDecoration(),
        child: Center(
          child: Text(
            'Next',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
          ),
        ),
      ),
      //const Icon(Icons.arrow_forward),
      //next: ElevatedButton(onPressed: () {}, child: Text("Next")),
      done: Container(
        margin: EdgeInsets.fromLTRB(0, 160, 0, 0),
        height: 50,
        width: 90,
        decoration: MmmDecorations.primaryButtonDecoration(),
        child: Center(
          child: const Text(
            'Continue',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
          ),
        ),
      ),
      dotsFlex: 2,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
      dotsDecorator: const DotsDecorator(
        size: Size(20.0, 6.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        spacing: EdgeInsets.all(5),
        color: Colors.grey,
        activeColor: kSecondary,
        activeSize: Size(30.0, 8.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        //color: kPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
