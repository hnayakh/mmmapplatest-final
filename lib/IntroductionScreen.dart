import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/views/signinscreens/signin_screen1.dart';

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
      MaterialPageRoute(
          builder: (_) => SignIn(userRepository: widget.userRepository)),
    );
  }

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
    return Image.asset('images/$assetName', width: 800);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 18.0,
    );

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyAlignment: Alignment(0.7, 0.5),
      //imagePadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      //imageAlignment: Alignment.topCenter,

      //imageFlex: 1,
      //bodyFlex: 6,
      //imageFlex: 6,

      //  imagePadding: EdgeInsets.only(bottom: 55),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        //  alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 0),
            child: _buildImage('frameUpadatedone.jpg', 300),
          ),
        ),
      ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ),
      pages: [
        PageViewModel(
          title: "This is onboarding screen 1.",
          body:
              "Talk about one of the feature of the application & how it will help your users.",
          //  image: _buildImage('frameUpadatedone.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "This is onboarding screen 2.",
          body:
              "Talk about one of the feature of the application & how it will help your users.",
          // image: _buildImage('frameUpadatedone.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "This is onboarding screen 3.",
          body:
              "Talk about one of the feature of the application & how it will help your users.",
          // image: _buildImage('frameUpadatedone.jpg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      // You can override onSkip callback
      showSkipButton: true,
      nextFlex: 0,

      //rtl: true, // Display as right-to-left
      //  back:  Icon(Icons.arrow_back),
      skip: const Text('Previous',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),

      next: Container(
        height: 50,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: kPrimary,
          border: Border.all(color: kPrimary),
        ),
        child: Center(
          child: Text(
            'Next',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      //const Icon(Icons.arrow_forward),
      //next: ElevatedButton(onPressed: () {}, child: Text("Next")),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
      dotsFlex: 2,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(22.0, 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        spacing: EdgeInsets.all(10),
        color: Colors.grey,
        activeColor: kPrimary,
        activeSize: Size(35.0, 8.0),
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
