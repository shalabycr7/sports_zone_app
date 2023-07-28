// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_zone/data/cubits/Leagues_cubit/cubit/Leagues_cubit.dart';
import 'package:sports_zone/data/cubits/Leagues_cubit/cubit/leagues_state.dart';
import 'package:sports_zone/screens/countres_screen.dart';

class LeaguesScreen extends StatefulWidget {
  const LeaguesScreen({super.key});

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LeaguesCubit>().getLeagues();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 78, 84, 200),
                      Color.fromARGB(255, 67, 72, 169),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Leagues',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 4 / 5,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(246, 241, 248, 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60))),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * .08),
                              child: BlocBuilder<LeaguesCubit, LeaguesState>(
                                builder: (context, state) {
                                  // if (state is LeaguesInitial) {
                                  //   context.read<LeaguesCubit>().getLeagues();
                                  // } else
                                  if (state is LeaguesLoadind) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is LeaguesSussess)
                                    // ignore: curly_braces_in_flow_control_structures
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          for (int i = 0; i < 50; i++)
                                            Container(
                                              height: 60,
                                              width: 60,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: InkWell(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MySports(),
                                                    )),
                                                child: Center(
                                                  child: Text(
                                                    state.ourrresponse.result[i]
                                                            .countryName ??
                                                        '555555',
                                                    style: const TextStyle(
                                                        color: Colors.orange),
                                                  ),
                                                  // child: Image.network(
                                                  //   state.ourresponse.result[i]
                                                  //           .countryLogo ??
                                                  //       '',
                                                  //   height: 50.0,
                                                  //   width: 50.0,
                                                  // ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    );
                                  else {
                                    return const Center(
                                      child: Text('error'),
                                    );
                                  }
                                },
                              ),
                            ))),
                  ],
                ))));
  }
}
