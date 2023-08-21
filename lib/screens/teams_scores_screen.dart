import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_zone/data/cubits/teams_status_cubit/teams_scores_cubit.dart';
import 'package:sports_zone/screens/players_screen.dart';
import 'package:sports_zone/styles/styles_variables.dart';

final TextEditingController search = TextEditingController();

class TeamsScoresScreen extends StatefulWidget {
  final int id;
  final String? name;

  const TeamsScoresScreen({super.key, required this.id, required this.name});

  @override
  State<TeamsScoresScreen> createState() => _TeamsScoresScreen();
}

class _TeamsScoresScreen extends State<TeamsScoresScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
    super.initState();
    context.read<TeamsScoresCubit>().getTeam(widget.id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    search.clear();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.index == 0) {
      context.read<TeamsScoresCubit>().getTeam(widget.id);
      // Handle home tab press action
    } else if (_tabController.index == 1) {
      // Perform action for the second tab
      search.text = "";
      context.read<TeamsScoresCubit>().getTopScorers(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsScoresCubit, TeamsScoresState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: Center(
                child: Text(
              "${widget.name}",
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500),
            )),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                color: primaryColor,
                child: TabBar(
                  indicatorColor: Colors.white,
                  dividerColor: primaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  tabs: [
                    Tab(
                        child: Text(
                      "Teams",
                      style: GoogleFonts.nunito(
                        color: (state is TeamsScoresTeams)
                            ? Colors.white
                            : const Color.fromARGB(255, 240, 240, 240),
                        fontSize: 18.sp,
                        fontWeight: (state is TeamsScoresTeams)
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    )),
                    Tab(
                        child: Text(
                      "Top Scorer",
                      style: GoogleFonts.nunito(
                        color: (state is TeamsScoresTopScorers)
                            ? Colors.white
                            : const Color.fromARGB(255, 240, 240, 240),
                        fontSize: 18.sp,
                        fontWeight: (state is TeamsScoresTopScorers)
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    )),
                  ],
                  onTap: (index) {
                    if (index == 0) {
                      context.read<TeamsScoresCubit>().getTeam(widget.id);
                      // Handle home tab press action
                    } else if (index == 1) {
                      // Handle settings tab press action
                      search.text = "";
                      context.read<TeamsScoresCubit>().getTopScorers(widget.id);
                    }
                  },
                ),
              ),
            ),
          ),
          body: Container(
            color: primaryColor,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      height: ScreenUtil().screenHeight * 0.8,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          FadeTransition(
                            opacity: _animation,
                            child: Column(
                              children: [
                                if (state is TeamsScoresTeams)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: TextFormField(
                                      controller: search,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(
                                              color: Colors.blueGrey),
                                        ),
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 247, 247, 247),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        hintText: 'Search',
                                        hintStyle: GoogleFonts.nunito(
                                          fontSize: 12.sp,
                                          color: const Color.fromARGB(
                                              255, 197, 194, 194),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.search),
                                          color: const Color.fromARGB(
                                              255, 197, 194, 194),
                                          iconSize: 18.sp,
                                          onPressed: () {
                                            if (search.text != "") {
                                              context
                                                  .read<TeamsScoresCubit>()
                                                  .getTeam(widget.id);
                                            } else {
                                              context
                                                  .read<TeamsScoresCubit>()
                                                  .getTeam(widget.id);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                if (state is TeamsScoresTeams &&
                                    state.ourresponse.result != null)
                                  Expanded(
                                    child: GridView.count(
                                      crossAxisCount:
                                          ScreenUtil().screenWidth > 600 &&
                                                  ScreenUtil().orientation ==
                                                      Orientation.landscape
                                              ? 4
                                              : 2,
                                      crossAxisSpacing:
                                          ScreenUtil().screenWidth * 0.04,
                                      mainAxisSpacing:
                                          ScreenUtil().screenWidth * 0.04,
                                      children: List.generate(
                                        state.ourresponse.result!.length,
                                        (index) {
                                          if (state.ourresponse.result![index]
                                                      .teamName !=
                                                  null &&
                                              state.ourresponse.result![index]
                                                      .teamLogo !=
                                                  null) {
                                            return Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    searchPlayer.text = "";
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PlayersScreen(
                                                          teamId: state
                                                              .ourresponse
                                                              .result![index]
                                                              .teamKey!,
                                                          in1: index,
                                                          teamName: state
                                                              .ourresponse
                                                              .result![index]
                                                              .teamName!,
                                                          id: widget.id,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 245, 245, 245),
                                                      ),
                                                      child: Center(
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                  child:
                                                                      Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        20),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: state
                                                                      .ourresponse
                                                                      .result![
                                                                          index]
                                                                      .teamLogo!,
                                                                  errorWidget:
                                                                      (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(
                                                                    Icons
                                                                        .person,
                                                                    size: 85,
                                                                    color:
                                                                        primaryColor,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                child: Text(
                                                                  state
                                                                      .ourresponse
                                                                      .result![
                                                                          index]
                                                                      .teamName!,
                                                                  style: GoogleFonts.quicksand(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ]),
                                                      )),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const Text('data');
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                else if (search.text != '')
                                  Column(
                                    children: [
                                      Lottie.asset(
                                          'assets/icons/not_found_animation.json',
                                          width: 200.w,
                                          height: 100.h),
                                      Text(
                                        'Team not found',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  )
                              ],
                            ),
                          ),
                          if (state is TeamsScoresTopScorers)
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (int i = 0;
                                      i < state.response.result.length;
                                      i++)
                                    if (state.response.result[i].playerName !=
                                            null &&
                                        state.response.result[i].teamName !=
                                            null &&
                                        state.response.result[i].goals != null)
                                      FadeTransition(
                                        opacity: _animation,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white60,
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: primaryColor,
                                                radius: ScreenUtil()
                                                            .orientation ==
                                                        Orientation.landscape
                                                    ? ScreenUtil().screenWidth *
                                                        0.05
                                                    : ScreenUtil()
                                                            .screenHeight *
                                                        0.03,
                                                child: Text(
                                                  '${i + 1}',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 17.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ), //Text
                                              ),
                                              SizedBox(width: 20.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.response.result[i]
                                                          .playerName!,
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 18.sp,
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Team Name: ",
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            state
                                                                .response
                                                                .result[i]
                                                                .teamName!,
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Goals: ",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 14.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${state.response.result[i].goals!}",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 14.sp,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    else
                                      const Text("shshs"),
                                ],
                              ),
                            )
                          else
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
