// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_zone/data/cubits/countries_cubit/countires_cubit.dart';

import 'package:sports_zone/screens/Leagues_Screen.dart';
import 'package:sports_zone/screens/countres_screen.dart';

import 'data/cubits/Leagues_cubit/cubit/leagues_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sports Zone',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MySports(),
      ),
    );
  }
}
