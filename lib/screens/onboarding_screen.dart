import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sports_zone/screens/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 17.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color.fromARGB(255, 245, 240, 252),
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: const Color.fromARGB(255, 245, 240, 252),
          allowImplicitScrolling: true,
          autoScrollDuration: 3000,
          infiniteAutoScroll: true,

          pages: [
            PageViewModel(
              title: "Find Leagues Info",
              body: "Get detailed info about your favourite team and players.",
              image: _buildImage('slider1.svg'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Enjoy the game",
              body: "Find who is the top scorrer in any team.",
              image: _buildImage('slider2.svg'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "See detailed info",
              body: "Find all the info you want about any player in any team.",
              image: _buildImage('slider3.svg'),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () =>
              _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          //rtl: true, // Display as right-to-left
          back: const Icon(
            Icons.arrow_back,
            color: Color(0xFF6C63FF),
          ),
          skip: const Text('Skip',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF6C63FF),
              )),
          next: const Icon(
            Icons.arrow_forward,
            color: Color(0xFF6C63FF),
          ),
          done: const Text('Done',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF6C63FF),
              )),
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
        ),
      ),
    );
  }
}
