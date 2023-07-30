import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sports_zone/data/cubits/players_status_cubit/players_cubit.dart';
import 'package:sports_zone/styles/styles_variables.dart';

final TextEditingController searchPlayer = TextEditingController();

class PlayersScreen extends StatefulWidget {
  final int in1;
  final String tmname;
  final int id;
  const PlayersScreen(
      {super.key, required this.in1, required this.tmname, required this.id});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlayersCubit>().getPlayer(widget.tmname, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(body: BlocBuilder<PlayersCubit, PlayersState>(
        builder: (context, state) {
          return Container(
            color: Theme.of(context).primaryColor,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${widget.tmname} Players",
                      style: GoogleFonts.nunito(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    height: ScreenUtil().screenHeight * 0.88,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 245, 245),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: searchPlayer,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            hintText: 'Search',
                            hintStyle: GoogleFonts.nunito(
                              fontSize: 12.sp,
                              color: const Color.fromARGB(255, 197, 194, 194),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              color: const Color.fromARGB(255, 197, 194, 194),
                              iconSize: 18.sp,
                              onPressed: () {
                                if (searchPlayer.text != "") {
                                  context
                                      .read<PlayersCubit>()
                                      .getPlayer1(searchPlayer.text);
                                } else {
                                  context
                                      .read<PlayersCubit>()
                                      .getPlayer(widget.tmname, widget.id);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      if (state is PlayersAll &&
                          state.ourresponse.result![0].players != null)
                        Expanded(
                          child: ListView.builder(
                              itemCount:
                                  state.ourresponse.result![0].players!.length,
                              itemBuilder: (BuildContext context, int i) {
                                if (state.ourresponse.result![0].players![i]
                                            .playerImage !=
                                        null &&
                                    state.ourresponse.result![0].players![i]
                                            .playerName !=
                                        null &&
                                    state.ourresponse.result![0].players![i]
                                            .playerType !=
                                        null) {
                                  return InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child: SingleChildScrollView(
                                                  child: AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 30),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          radius: 75,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: state
                                                                .ourresponse
                                                                .result![0]
                                                                .players![i]
                                                                .playerImage!,
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
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                const CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    "assets/images/pngwing.com.png"),
                                                          ),
                                                        )),
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
                                                                  .result![0]
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
                                                                  style: nunitoStyle,
                                                                ),
                                                                Text(
                                                                  state
                                                                          .ourresponse
                                                                          .result![
                                                                              0]
                                                                          .players![
                                                                              i]
                                                                          .playerNumber ??
                                                                      "",
                                                                  style: nunitoStyle,
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
                                                                  style: nunitoStyle,
                                                                ),
                                                                Text(
                                                                  state
                                                                          .ourresponse
                                                                          .result![
                                                                              0]
                                                                          .players![
                                                                              i]
                                                                          .playerCountry ??
                                                                      "Unknown",
                                                                  style: nunitoStyle,
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
                                                                  style: nunitoStyle,
                                                                ),
                                                                Text(
                                                                  state
                                                                          .ourresponse
                                                                          .result![
                                                                              0]
                                                                          .players![
                                                                              i]
                                                                          .playerType ??
                                                                      "",
                                                                  style: nunitoStyle,
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
                                                                  style: nunitoStyle,
                                                                ),
                                                                Text(
                                                                  state
                                                                          .ourresponse
                                                                          .result![
                                                                              0]
                                                                          .players![
                                                                              i]
                                                                          .playerAge ??
                                                                      "",
                                                                  style: nunitoStyle,
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
                                                                  style: nunitoStyle,
                                                                ),
                                                                Text(
                                                                  state
                                                                          .ourresponse
                                                                          .result![
                                                                              0]
                                                                          .players![
                                                                              i]
                                                                          .playerYellowCards ??
                                                                      "",
                                                                  style: nunitoStyle,
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
                                                                  style: nunitoStyle,
                                                                ),
                                                                Text(
                                                                  state
                                                                          .ourresponse
                                                                          .result![
                                                                              0]
                                                                          .players![
                                                                              i]
                                                                          .playerRedCards ??
                                                                      "",
                                                                  style: nunitoStyle,
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
                                                                  style: nunitoStyle,
                                                                ),
                                                                Text(
                                                                  state
                                                                          .ourresponse
                                                                          .result![
                                                                              0]
                                                                          .players![
                                                                              i]
                                                                          .playerGoals ??
                                                                      "",
                                                                  style: nunitoStyle,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                    actions: [
                                                      Center(
                                                        child: SizedBox(
                                                          width:
                                                              screensize.width *
                                                                  0.3,
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
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
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
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
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 9, 113, 134),
                                              radius: ScreenUtil()
                                                          .orientation ==
                                                      Orientation.landscape
                                                  ? ScreenUtil().screenWidth *
                                                      0.05
                                                  : ScreenUtil().screenHeight *
                                                      0.06,
                                              child: CachedNetworkImage(
                                                imageUrl: state
                                                    .ourresponse
                                                    .result![0]
                                                    .players![i]
                                                    .playerImage!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/images/pngwing.com.png"),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state
                                                        .ourresponse
                                                        .result![0]
                                                        .players![i]
                                                        .playerName!,
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16.sp,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.h),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Team Position: ",
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: 14.sp,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        state
                                                            .ourresponse
                                                            .result![0]
                                                            .players![i]
                                                            .playerType!,
                                                        style:
                                                            GoogleFonts.nunito(
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
                                      ));
                                }
                                return null;
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
                                          errorWidget: (context, url, error) =>
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  state.ourresponse1.result![0]
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
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                    ]),
                    // TeamsScoresCubit TeamsScoresState
                    /*ListView.builder(
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {*/
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