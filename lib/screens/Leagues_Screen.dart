import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:sports_zone/data/cubits/leagues_cubit/leagues_cubit.dart';
import 'package:sports_zone/screens/teams_scores_screen.dart';
import 'package:sports_zone/shared/title_row.dart';
import 'package:sports_zone/styles/styles_variables.dart';

class LeaguesScreen extends StatefulWidget {
  final int loop;
  const LeaguesScreen({super.key, required this.loop});

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
    context.read<LeaguesCubit>().getLeagues();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Theme.of(context).colorScheme.primary,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 15.w),
                      child: const TitleRow(
                        title: 'Select the League',
                      )),
                  Expanded(
                      child: Container(
                          height: ScreenUtil().screenHeight * 4 / 5,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: const BorderRadius.vertical(
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
                                                        TeamsScoresScreen(
                                                      id: state
                                                          .ourrresponse
                                                          .result![i]
                                                          .leagueKey!,
                                                      name: state
                                                          .ourrresponse
                                                          .result![i]
                                                          .leagueName!,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: SlideTransition(
                                                position: _animation,
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
                                                              'Unknown',
                                                          style: GoogleFonts
                                                              .quicksand(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 80.h,
                                                        width: 80.w,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          radius: ScreenUtil()
                                                                      .orientation ==
                                                                  Orientation
                                                                      .landscape
                                                              ? ScreenUtil()
                                                                      .screenWidth *
                                                                  0.05
                                                              : ScreenUtil()
                                                                      .screenHeight *
                                                                  0.06,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: state
                                                                    .ourrresponse
                                                                    .result![i]
                                                                    .leagueLogo ??
                                                                "https://jetpunk.b-cdn.net/img/user-photo-library/d8/d8f21957be-235.png",
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                const CircularProgressIndicator(),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(
                                                              Icons.person,
                                                              size: 85,
                                                              color:
                                                                  primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            )));
  }
}
