import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_zone/data/cubits/teams_status_cubit/teams_scores_cubit.dart';
import 'package:sports_zone/screens/players_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final TextEditingController Search = TextEditingController();

class TeamsScoresScreen extends StatefulWidget {
  final int id;
  const TeamsScoresScreen({super.key, required this.id});

  @override
  State<TeamsScoresScreen> createState() => _TeamsScoresScreen();
}

/*decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        offset: Offset(2, 2),
        blurRadius: 4,
      ),
    ],
  ), */
class _TeamsScoresScreen extends State<TeamsScoresScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
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
      Search.text = "";
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
              backgroundColor: Colors.blueGrey,
              title: Center(
                  child: Text(
                "Teams Screen",
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              )),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                          child: Text(
                        "TEAMS",
                        style: GoogleFonts.nunito(
                          color: (state is TeamsScoresTeams)
                              ? Colors.blueGrey
                              : Colors.grey,
                          fontSize: 18.sp,
                          fontWeight: (state is TeamsScoresTeams)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      )),
                      Tab(
                          child: Text(
                        "TOPSCORERS",
                        style: GoogleFonts.nunito(
                          color: (state is TeamsScoresTopScorers)
                              ? Colors.blueGrey
                              : Colors.grey,
                          fontSize: 18.sp,
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
                        Search.text = "";
                        context.read<TeamsScoresCubit>().getTopScorers(widget.id);
                      }
                    },
                  ),
                ),
              ),
            ),
            //  body:

            //backgroundColor: Colors.white,
            //   toolbarHeight: 75.0,

            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: SingleChildScrollView(
                        child: Container(
                          width: screensize.width * 0.96,
                          height: screensize.height * 0.8,
                          //color: Colors.white,
                          decoration: BoxDecoration(
                            // Color.fromRGBO(246, 241, 248, 1)
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 10.0,
                                blurRadius: 10.0,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ), // TeamsScoresCubit TeamsScoresState
                          /*ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {*/
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Column(
                                children: [
                                  if (state is TeamsScoresTeams)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: screensize.width * .8,
                                        height: screensize.height * .05,
                                        child: TextFormField(
                                          controller: Search,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              borderSide: const BorderSide(
                                                  //  width: 5,
                                                  color: Colors
                                                      .blueGrey), //<-- SEE HERE
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            labelText: 'Search...',
                                            labelStyle: GoogleFonts.nunito(
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 197, 194, 194),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: const Icon(Icons.search),
                                              color: const Color.fromARGB(
                                                  255, 197, 194, 194),
                                              iconSize: 18.sp,
                                              onPressed: () {
                                                if (Search.text != "") {
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
                                                      const EdgeInsets.all(2.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      print(index);
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
                                                    child: BlurryContainer(
                                                        blur: 8,
                                                        color: Colors.white,
                                                        /*  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10), // Set the desired border radius value
                                                    ),*/
                                                        // Color.fromRGBO(246, 241, 248, 1)

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
                                                                          3.0),
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
                                                                        .nunito(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
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
                                                i <
                                                    state
                                                        .response.result.length;
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
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          25))),
                                                  elevation: 0.0,
                                                  child: Container(
                                                    width:
                                                        screensize.width * 0.9,
                                                    height: (screensize.width <
                                                            400)
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
                                                                style:
                                                                    GoogleFonts
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
                                                                        .result[
                                                                            i]
                                                                        .playerName!,
                                                                    style: GoogleFonts
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
                                                                      height:
                                                                          10),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Team Name: ",
                                                                        style: GoogleFonts
                                                                            .nunito(
                                                                          fontSize:
                                                                              14.sp,
                                                                          color:
                                                                              Colors.black,
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
                                                                          fontSize:
                                                                              14.sp,
                                                                          color:
                                                                              Colors.black,
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
                                                                          color:
                                                                              Colors.black,
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
                                                                          color:
                                                                              Colors.black,
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
