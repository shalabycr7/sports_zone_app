import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_zone/screens/teams_scores_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/cubits/cubit/cubit/players_cubit.dart';
import '../data/cubits/cubit/teams_scores_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final TextEditingController Search_player = TextEditingController();
//final int index = 0;

class Players_Screen extends StatefulWidget {
  final int in1;
  final String tmname;
  const Players_Screen({super.key, required this.in1, required this.tmname});

  @override
  State<Players_Screen> createState() => _Players_ScreenState();
}

var style = GoogleFonts.nunito(
  fontSize: 15.sp,
  color: Colors.black,
);

class _Players_ScreenState extends State<Players_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PlayersCubit>().getPlayer(widget.tmname);
  }

  @override
  Widget build(BuildContext context) {
    // String uppercaseText = widget.tmname.toUpperCase();
    var screensize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(body: BlocBuilder<PlayersCubit, PlayersState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${widget.tmname} Players",
                      style: GoogleFonts.nunito(
                        fontSize: 30,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: Container(
                      width: screensize.width * 0.96,
                      height: (screensize.width < 400)
                          ? screensize.height * 0.86
                          : screensize.height * (0.7),
                      //color: Colors.white,
                      decoration: BoxDecoration(
                        // Color.fromRGBO(246, 241, 248, 1)
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
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
                      ),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                         width: screensize.width * .8,
                                      height: screensize.height * .05,
                            child: TextFormField(
                              controller: Search_player,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                      //  width: 5,
                                      color: Colors.blueGrey), //<-- SEE HERE
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                labelText: 'Search...',
                                labelStyle: GoogleFonts.nunito(
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 197, 194, 194),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  color: Color.fromARGB(255, 197, 194, 194),
                                  iconSize: 18.sp,
                                  onPressed: () {
                                    if (Search_player.text != "")
                                      context
                                          .read<PlayersCubit>()
                                          .getPlayer1(Search_player.text);
                                    else
                                      context
                                          .read<PlayersCubit>()
                                          .getPlayer(widget.tmname);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (state is PlayersAll &&
                            state.ourresponse.result![widget.in1].players !=
                                null)
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.ourresponse.result![widget.in1]
                                    .players!.length,
                                itemBuilder: (BuildContext context, int i) {
                                  if (state.ourresponse.result![widget.in1]
                                              .players![i].playerImage !=
                                          null &&
                                      state.ourresponse.result![widget.in1]
                                              .players![i].playerName !=
                                          null &&
                                      state.ourresponse.result![widget.in1]
                                              .players![i].playerType !=
                                          null)
                                    return InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SingleChildScrollView(
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  title: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: state
                                                            .ourresponse
                                                            .result![widget.in1]
                                                            .players![i]
                                                            .playerImage!,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                                "assets/images/pngwing.com.png"),
                                                        width: (screensize
                                                                    .width <
                                                                400)
                                                            ? screensize.width *
                                                                (1 / 4)
                                                            : screensize.width *
                                                                (1 / 5),
                                                        height: (screensize
                                                                    .width <
                                                                400)
                                                            ? screensize.width *
                                                                (1 / 2)
                                                            : screensize.width *
                                                                (1 / 5),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 8),
                                                          child: Text(
                                                            state
                                                                .ourresponse
                                                                .result![
                                                                    widget.in1]
                                                                .players![i]
                                                                .playerName!,
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Player Number: ",
                                                                style: style,
                                                              ),
                                                              Text(
                                                                state
                                                                        .ourresponse
                                                                        .result![widget
                                                                            .in1]
                                                                        .players![
                                                                            i]
                                                                        .playerNumber ??
                                                                    "",
                                                                style: style,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Player Country: ",
                                                                style: style,
                                                              ),
                                                              Text(
                                                                state
                                                                        .ourresponse
                                                                        .result![widget
                                                                            .in1]
                                                                        .players![
                                                                            i]
                                                                        .playerCountry ??
                                                                    "",
                                                                style: style,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Player Position: ",
                                                                style: style,
                                                              ),
                                                              Text(
                                                                state
                                                                        .ourresponse
                                                                        .result![widget
                                                                            .in1]
                                                                        .players![
                                                                            i]
                                                                        .playerType ??
                                                                    "",
                                                                style: style,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Player Age: ",
                                                                style: style,
                                                              ),
                                                              Text(
                                                                state
                                                                        .ourresponse
                                                                        .result![widget
                                                                            .in1]
                                                                        .players![
                                                                            i]
                                                                        .playerAge ??
                                                                    "",
                                                                style: style,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Yellow Cards num: ",
                                                                style: style,
                                                              ),
                                                              Text(
                                                                state
                                                                        .ourresponse
                                                                        .result![widget
                                                                            .in1]
                                                                        .players![
                                                                            i]
                                                                        .playerYellowCards ??
                                                                    "",
                                                                style: style,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Red Cards num: ",
                                                                style: style,
                                                              ),
                                                              Text(
                                                                state
                                                                        .ourresponse
                                                                        .result![widget
                                                                            .in1]
                                                                        .players![
                                                                            i]
                                                                        .playerRedCards ??
                                                                    "",
                                                                style: style,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "player goals: ",
                                                                style: style,
                                                              ),
                                                              Text(
                                                                state
                                                                        .ourresponse
                                                                        .result![widget
                                                                            .in1]
                                                                        .players![
                                                                            i]
                                                                        .playerGoals ??
                                                                    "",
                                                                style: style,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ]),
                                                  actions: [
                                                    Center(
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .blueGrey),
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size(120,
                                                                      40)), // Adjust the width and height as needed
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Close",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16.sp,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        elevation: 0.0,
                                        child: Container(
                                          width: screensize.width * 0.5,
                                          height: (screensize.width < 400)
                                              ? screensize.height * (1 / 6)
                                              : screensize.height * 0.4,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: CachedNetworkImage(
                                                      imageUrl: state
                                                          .ourresponse
                                                          .result![widget.in1]
                                                          .players![i]
                                                          .playerImage!,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              "assets/images/pngwing.com.png"),
                                                      width: (screensize.width <
                                                              400)
                                                          ? screensize.width *
                                                              (1 / 4)
                                                          : screensize.width *
                                                              (1 / 7),
                                                      height: (screensize
                                                                  .width <
                                                              400)
                                                          ? screensize.width *
                                                              (1 / 4)
                                                          : screensize.height *
                                                              (1 / 4),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Expanded(
                                                    //  // playerName ,  playerType ,playerImage
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state
                                                              .ourresponse
                                                              .result![
                                                                  widget.in1!]
                                                              .players![i]
                                                              .playerName!,
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 21.sp,
                                                            color:
                                                                Colors.blueGrey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Team Position: ",
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                fontSize: 14.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              state
                                                                  .ourresponse
                                                                  .result![
                                                                      widget
                                                                          .in1!]
                                                                  .players![i]
                                                                  .playerType!,
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                fontSize: 14.sp,
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
                                      ),
                                    );
                                }),
                          )
                        else if (state is PlayersOne)
                          if (state.ourresponse1.result != null)
                            Card(
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              elevation: 0.0,
                              child: Container(
                                width: screensize.width * 0.98,
                                height: screensize.height * (1 / 6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: CachedNetworkImage(
                                            imageUrl: state.ourresponse1
                                                .result![0].playerImage!,
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/pngwing.com.png"),
                                            width: screensize.width * (1 / 4),
                                            height: screensize.width * (1 / 4),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          //  // playerName ,  playerType ,playerImage
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.ourresponse1.result![0]
                                                    .playerName!,
                                                style: GoogleFonts.nunito(
                                                  fontSize: 21,
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Team Position: ",
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 14.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    state
                                                            .ourresponse1
                                                            .result![0]
                                                            .playerType ??
                                                        "",
                                                    style: GoogleFonts.nunito(
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
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            )
                          else
                            Center(
                              child: Text(
                                "Not Found",
                                style: GoogleFonts.nunito(
                                  fontSize: 30.sp,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3.0,
                                ),
                              ),
                            )
                        else
                          Center(
                            child: CircularProgressIndicator(),
                          )
                      ]),
                      // TeamsScoresCubit TeamsScoresState
                      /*ListView.builder(
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {*/
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}