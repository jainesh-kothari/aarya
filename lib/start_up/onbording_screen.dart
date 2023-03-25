import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../language/app_translations.dart';
import '../registration/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => new _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<StatefulWidget> {
  final introKey = GlobalKey<IntroductionScreenState>();

  PageDecoration pageDecoration(String imagePath) {
    return PageDecoration(
        titleTextStyle: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle:  const TextStyle(fontSize: 19.0),
        bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        imagePadding: EdgeInsets.zero,
        bodyAlignment: Alignment.bottomCenter,
        boxDecoration: BoxDecoration(image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)));
  }

  @override
  Widget build(BuildContext context) {

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [

        PageViewModel(
            title: AppTranslations.of(context)!.text("on_boarding_1"),
            body: AppTranslations.of(context)!.text("on_boarding_1_des"),
            decoration: pageDecoration("assets/images/onborading_one.jpg")),

        PageViewModel(
            title: AppTranslations.of(context)!.text("on_boarding_2"),
            body: AppTranslations.of(context)!.text("on_boarding_2_des"),
            decoration: pageDecoration("assets/images/onborading_two.jpg")),

        PageViewModel(
            title: AppTranslations.of(context)!.text("on_boarding_3"),
            body: AppTranslations.of(context)!.text("on_boarding_3_des"),
            decoration: pageDecoration("assets/images/onborading_three.jpg")),
      ],
      onDone: () => {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()))
      },
      onSkip: () => {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()))
      }, // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      // showBackButton: true,
      //rtl: true, // Display as right-to-left

      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}