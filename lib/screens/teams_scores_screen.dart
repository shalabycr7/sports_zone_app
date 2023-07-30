import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_zone/data/cubits/teams_status_cubit/teams_scores_cubit.dart';
import 'package:sports_zone/screens/players_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final TextEditingController search = TextEditingController();

class TeamsScoresScreen extends StatefulWidget {
  final int id;
  const TeamsScoresScreen({super.key, required this.id});

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
    var screensize = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocBuilder<TeamsScoresCubit, TeamsScoresState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              title: Center(
                  child: Text(
                "Select The Team",
                style: GoogleFonts.nunito(
                    color: Colors.blueGrey,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              )),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    indicatorColor: Colors.blueGrey,
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    tabs: [
                      Tab(
                          child: Text(
                        "Teams",
                        style: GoogleFonts.nunito(
                          color: (state is TeamsScoresTeams)
                              ? Colors.blueGrey
                              : Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: (state is TeamsScoresTeams)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      )),
                      Tab(
                          child: Text(
                        "Top Scorer",
                        style: GoogleFonts.nunito(
                          color: (state is TeamsScoresTopScorers)
                              ? Colors.blueGrey
                              : Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: (state is TeamsScoresTopScorers)
                              ? FontWeight.bold
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
              color: Colors.white,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        height: ScreenUtil().screenHeight * 0.8,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(246, 241, 248, 1),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Column(
                              children: [
                                if (state is TeamsScoresTeams)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: TextFormField(
                                      controller: search,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(
                                              color: Colors.blueGrey),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white60,
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
                                                    Search_player.text = "";
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Players_Screen(
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
                                                        color: Colors.white60,
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
                                                                  style: GoogleFonts
                                                                      .quicksand(
                                                                    fontSize:
                                                                        13.sp,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                      )),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Text('data');
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                else
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  )
                              ],
                            ),
                            Column(
                              children: [
                                if (state is TeamsScoresTopScorers)
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          for (int i = 0;
                                              i < state.response.result.length;
                                              i++)
                                            if (state.response.result[i]
                                                        .playerName !=
                                                    null &&
                                                state.response.result[i]
                                                        .teamName !=
                                                    null &&
                                                state.response.result[i]
                                                        .goals !=
                                                    null)
                                              Card(
                                                color: Colors.white,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                elevation: 0.0,
                                                child: Container(
                                                  width: screensize.width * 0.9,
                                                  height:
                                                      (screensize.width < 400)
                                                          ? screensize.height *
                                                              (1 / 7)
                                                          : screensize.height *
                                                              (1 / 3),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            // Set the background color
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .blueGrey, // Set the container background color
                                                              borderRadius: BorderRadius.circular((screensize
                                                                          .width <
                                                                      400)
                                                                  ? screensize
                                                                          .width *
                                                                      (1 / 16)
                                                                  : screensize
                                                                          .width *
                                                                      (1 /
                                                                          26)), // Set the border radius
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                        .all(
                                                                    10), // Add some padding
                                                            width: (screensize
                                                                        .width <
                                                                    400)
                                                                ? screensize
                                                                        .width *
                                                                    (1 / 8)
                                                                : screensize
                                                                        .width *
                                                                    (1 / 13),
                                                            height: (screensize
                                                                        .width <
                                                                    400)
                                                                ? screensize
                                                                        .width *
                                                                    (1 / 8)
                                                                : screensize
                                                                        .width *
                                                                    (1 /
                                                                        13), // Set the width
                                                            alignment: Alignment
                                                                .center, // Center the text horizontally
                                                            child: Text(
                                                              '${i + 1}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 20),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  state
                                                                      .response
                                                                      .result[i]
                                                                      .playerName!,
                                                                  style:
                                                                      GoogleFonts
                                                                          .nunito(
                                                                    fontSize:
                                                                        21.sp,
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "Team Name: ",
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                        fontSize:
                                                                            14.sp,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      state
                                                                          .response
                                                                          .result[
                                                                              i]
                                                                          .teamName!,
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                        fontSize:
                                                                            14.sp,
                                                                        color: Colors
                                                                            .black,
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
                                                                        fontSize:
                                                                            14.sp,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${state.response.result[i].goals!}",
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                        fontSize:
                                                                            14.sp,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            else
                                              const Text("shshs"),
                                        ],
                                      ),
                                    ),
                                  )
                                else
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  )
                              ],
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
