import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_zone/data/cubits/teams_status_cubit/teams_scores_cubit.dart';
import 'package:sports_zone/screens/players_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sports_zone/styles/styles_variables.dart';

final TextEditingController search = TextEditingController();
int k = 0;

class TeamsScoresScreen extends StatefulWidget {
  final int id;
  final String? name;
  const TeamsScoresScreen({super.key, required this.id, required this.name});

  @override
  State<TeamsScoresScreen> createState() => _TeamsScoresScreen();
}

class _TeamsScoresScreen extends State<TeamsScoresScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    super.initState();
    context.read<TeamsScoresCubit>().getTeam(widget.id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.index == 0) {
      search.text = "";
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
    Color overAllColor = primaryColor;

    return SafeArea(
      child: BlocBuilder<TeamsScoresCubit, TeamsScoresState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: overAllColor,
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
                  color: overAllColor,
                  child: TabBar(
                    indicatorColor: Colors.white,
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
                        search.text = "";
                        context.read<TeamsScoresCubit>().getTeam(widget.id);
                        // Handle home tab press action
                      } else if (index == 1) {
                        // Handle settings tab press action
                        search.text = "";
                        context
                            .read<TeamsScoresCubit>()
                            .getTopScorers(widget.id);
                      }
                    },
                  ),
                ),
              ),
            ),
            body: Container(
              color: overAllColor,
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
                          color: secondryColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Column(
                              children: [
                                if (state is TeamsScoresTeams)
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        (0.1),
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
                                if (state is TeamsScoresLoading)
                                  Center(
                                    child: CircularProgressIndicator(),
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
                                                          in1: index,
                                                          tmname: state
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
                                                                        .all(20),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: state
                                                                      .ourresponse
                                                                      .result![
                                                                          index]
                                                                      .teamLogo!,
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Image.asset(
                                                                          "assets/images/pngwing.com.png"),
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
                                else if (state is TeamsScoresTeams &&
                                    state.ourresponse.result!.length == 0)
                                  Center(child: Text("NOt found"))
                              ],
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  if (state is TeamsScoresLoading)
                                    Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  else if (state is TeamsScoresTopScorers)
                                    for (int i = 0;
                                        i < state.response.result.length;
                                        i++, k++)
                                      if (state.response.result[i].playerName !=
                                              null &&
                                          state.response.result[i].teamName !=
                                              null &&
                                          state.response.result[i].goals !=
                                              null)
                                        Container(
                                          // width: MediaQuery.of(context)
                                          //         .size
                                          //         .width *
                                          //     0.8,
                                          // height: MediaQuery.of(context)
                                          //         .size
                                          //         .height *
                                          //     0.6,
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
                                                backgroundColor: overAllColor,
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
                                                    fontSize: 15.sp,
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
                                                        color: overAllColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Team Name: ",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 14.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
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
                                  if (state is TeamsScoresError)
                                    Center(child: Text("not found")),
                                ],
                              ),
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
      ),
    );
  }
}
