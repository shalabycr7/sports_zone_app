import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_zone/data/cubits/players_status_cubit/players_cubit.dart';
import 'package:sports_zone/data/cubits/teams_status_cubit/teams_scores_cubit.dart';

import 'package:sports_zone/screens/teams_scores_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Replace with your desired RGB values here (in this example, it's pure red: RGB(255, 0, 0))

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TeamsScoresCubit>(
                create: (context) => TeamsScoresCubit(),
              ),
              // PlayersCubit
              BlocProvider<PlayersCubit>(
                create: (context) => PlayersCubit(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sports Zone',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
                useMaterial3: true,
              ),
              home: const TeamsScoresScreen(),
            ),
          );
        });
  }
}
