// ignore_for_file: camel_case_types, unnecessary_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:sports_zone/data/cubits/leagues_cubit/leagues_cubit.dart';
import 'package:sports_zone/screens/teams_scores_screen.dart';
import 'package:sports_zone/shared/title_row.dart';
import 'package:sports_zone/styles/gradient_decoration.dart';

int countriesKey = 0;

class LeaguesScreen extends StatefulWidget {
  final int loop;
  const LeaguesScreen({super.key, required this.loop});

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
    return SafeArea(
        child: Scaffold(
            body: Container(
                decoration: blueGradient,
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(20),
                        child: TitleRow(
                          title: 'Select the League',
                        )),
                    Expanded(
                        child: Container(
                            height: ScreenUtil().screenHeight * 4 / 5,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(246, 241, 248, 1),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            width: ScreenUtil().screenWidth,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().screenWidth * 0.05,
                                  vertical: ScreenUtil().screenWidth * 0.04),
                              child: BlocBuilder<LeaguesCubit, LeaguesState>(
                                builder: (context, state) {
                                  if (state is LeaguesLoadind) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is LeaguesSussess) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  state.ourrresponse.result!
                                                      .length;
                                              i++)
                                            if (state.ourrresponse.result![i]
                                                    .countryKey ==
                                                widget.loop)
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TeamsScoresScreen(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Colors.white60,
                                                  ),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          state
                                                                  .ourrresponse
                                                                  .result![i]
                                                                  .leagueName ??
                                                              'Unkown league',
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            fontSize: 14.sp,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 80.h,
                                                        width: 80.w,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: state
                                                                  .ourrresponse
                                                                  .result![i]
                                                                  .leagueLogo ??
                                                              "https://jetpunk.b-cdn.net/img/user-photo-library/d8/d8f21957be-235.png",
                                                          placeholder: (context,
                                                                  url) =>
                                                              const CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                            Icons.error,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Lottie.asset(
                                            'assets/icons/error_animation.json',
                                            width: 200.w,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'An error has occurred',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ))),
                  ],
                ))));
  }
}
