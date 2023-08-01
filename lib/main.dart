import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_zone/data/cubits/countries_cubit/countires_cubit.dart';
import 'package:sports_zone/data/cubits/leagues_cubit/leagues_cubit.dart';
import 'package:sports_zone/data/cubits/players_status_cubit/players_cubit.dart';
import 'package:sports_zone/data/cubits/teams_status_cubit/teams_scores_cubit.dart';
import 'package:sports_zone/data/firebase_api.dart';
import 'package:sports_zone/screens/home_screen.dart';
import 'package:sports_zone/screens/onboarding_screen.dart';
import 'package:sports_zone/styles/styles_variables.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseApi().intitNot();
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool alreadySeen = prefs.getBool('alreadySeen') ?? false;

  runApp(MyApp(alreadySeen: alreadySeen));
}

class MyApp extends StatelessWidget {
  final bool alreadySeen;

  const MyApp({Key? key, required this.alreadySeen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CountiresCubit()),
        BlocProvider(create: (_) => LeaguesCubit()),
        BlocProvider(create: (_) => TeamsScoresCubit()),
        BlocProvider(create: (_) => PlayersCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sports Zone',
            theme: ThemeData(
              primaryColor: primaryColor,
              dialogBackgroundColor: secondaryColor,
            ),
            home: AnimatedSplashScreen(
              duration: 3000,
              splash: SvgPicture.asset('assets/images/logo.svg'),
              splashIconSize: 100,
              nextScreen: alreadySeen ? const HomeScreen() : const OnBoardingScreen(),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: secondaryColor,
            ),
          );
        },
      ),
    );
  }
}