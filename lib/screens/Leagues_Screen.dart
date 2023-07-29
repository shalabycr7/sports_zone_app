// ignore_for_file: camel_case_types, unnecessary_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sports_zone/data/cubits/leagues_cubit/leagues_cubit.dart';

class LeaguesScreen extends StatefulWidget {
  const LeaguesScreen({
    super.key,
  });

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
                                color: Colors.white,
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
                                          for (int i = 0;
                                              i <
                                                  state.ourrresponse.result!
                                                      .length;
                                              i++)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                // decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             9)),
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        state
                                                                .ourrresponse
                                                                .result![i]
                                                                .leagueName ??
                                                            '',
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    10,
                                                                    10,
                                                                    10)),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      height: 60,
                                                      width: 60,

                                                      color: Colors.white,
                                                      // child: InkWell(
                                                      //   onTap: () => Navigator.push(
                                                      //       context,
                                                      //       MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             const MySports(),
                                                      //       )),
                                                      child: CachedNetworkImage(
                                                        imageUrl: state
                                                                .ourrresponse
                                                                .result![i]
                                                                .leagueLogo ??
                                                            'https://th.bing.com/th?id=OIP.SxfHLBiDEPcSBV-ncmz7gQHaJR&w=223&h=279&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                                                        // fit: BoxFit.cover,
                                                      ),
                                                      //            ),
                                                    ),
                                                  ],
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
