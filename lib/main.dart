import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_zone/data/cubits/Leagues_cubit/cubit/Leagues_cubit.dart';
import 'package:sports_zone/data/cubits/countries_cubit/countires_cubit.dart';
import 'package:sports_zone/screens/home_screen.dart';
import 'package:sports_zone/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool alreadySeen = prefs.getBool('alreadySeen') ?? false;

  runApp(MyApp(alreadySeen: alreadySeen));
}

class MyApp extends StatelessWidget {
  final bool alreadySeen;

  const MyApp({super.key, required this.alreadySeen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountiresCubit(),
        ),
        BlocProvider(
          create: (context) => LeaguesCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sports Zone',
              theme: ThemeData(primaryColor: const Color(0xFF6C63FF)),
              home: AnimatedSplashScreen(
                  duration: 3000,
                  splash: const Icon(
                    Icons.sports_basketball,
                    size: 90,
                    color: Color(0xFF6C63FF),
                  ),
                  nextScreen: alreadySeen
                      ? const HomeScreen()
                      : const OnBoardingScreen(),
                  splashTransition: SplashTransition.fadeTransition,
                  backgroundColor: const Color.fromARGB(255, 245, 240, 252)));
        },
      ),
    );
  }
}
