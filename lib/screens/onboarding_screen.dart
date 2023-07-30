import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Widget _buildImage(String assetName, double width) {
    return SvgPicture.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    var bodyStyle = GoogleFonts.quicksand(
      fontSize: 13.sp,
      color: Colors.black,
    );

    var pageDecoration = PageDecoration(
      titleTextStyle: GoogleFonts.quicksand(
          fontSize: 25.sp, color: Colors.black, fontWeight: FontWeight.w500),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: const Color.fromARGB(255, 245, 245, 245),
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
          allowImplicitScrolling: true,
          autoScrollDuration: 3000,
          infiniteAutoScroll: true,
          pages: [
            PageViewModel(
              title: "Find Leagues Info",
              body: "Get detailed info about your favourite team and players.",
              image: _buildImage('slider1.svg', 250.w),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Enjoy the game",
              body: "Find who is the top scorrer in any team.",
              image: _buildImage('slider2.svg', 250.w),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "See detailed info",
              body: "Find all the info you want about any player in any team.",
              image: _buildImage('slider3.svg', 250.w),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          back: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          skip: Text('Skip',
              style: GoogleFonts.quicksand(
                  fontSize: 13.0.sp,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600)),
          next: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).primaryColor,
          ),
          done: Text('Done',
              style: GoogleFonts.quicksand(
                  fontSize: 13.0.sp,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600)),
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
