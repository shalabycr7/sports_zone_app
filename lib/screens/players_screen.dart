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

class _PlayersScreenState extends State<PlayersScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
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
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
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
                    height: ScreenUtil().screenHeight * 0.86,
                    decoration: BoxDecoration(
                      color: secondryColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    child: FadeTransition(
                      opacity: _animation,
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
                              fillColor:
                                  const Color.fromARGB(255, 247, 247, 247),
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
                                itemCount: state
                                    .ourresponse.result![0].players!.length,
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
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      30),
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
                                                              imageBuilder:
                                                                  (context,
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
                                                                      bottom:
                                                                          8),
                                                              child: Text(
                                                                state
                                                                    .ourresponse
                                                                    .result![0]
                                                                    .players![i]
                                                                    .playerName!,
                                                                style:
                                                                    GoogleFonts
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
                                                                    style:
                                                                        nunitoStyle,
                                                                  ),
                                                                  Text(
                                                                    state
                                                                            .ourresponse
                                                                            .result![0]
                                                                            .players![i]
                                                                            .playerNumber ??
                                                                        "",
                                                                    style:
                                                                        nunitoStyle,
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
                                                                    style:
                                                                        nunitoStyle,
                                                                  ),
                                                                  Text(
                                                                    state
                                                                            .ourresponse
                                                                            .result![0]
                                                                            .players![i]
                                                                            .playerCountry ??
                                                                        "Unknown",
                                                                    style:
                                                                        nunitoStyle,
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
                                                                    style:
                                                                        nunitoStyle,
                                                                  ),
                                                                  Text(
                                                                    state
                                                                            .ourresponse
                                                                            .result![0]
                                                                            .players![i]
                                                                            .playerType ??
                                                                        "",
                                                                    style:
                                                                        nunitoStyle,
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
                                                                    style:
                                                                        nunitoStyle,
                                                                  ),
                                                                  Text(
                                                                    state
                                                                            .ourresponse
                                                                            .result![0]
                                                                            .players![i]
                                                                            .playerAge ??
                                                                        "",
                                                                    style:
                                                                        nunitoStyle,
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
                                                                    style:
                                                                        nunitoStyle,
                                                                  ),
                                                                  Text(
                                                                    state
                                                                            .ourresponse
                                                                            .result![0]
                                                                            .players![i]
                                                                            .playerYellowCards ??
                                                                        "",
                                                                    style:
                                                                        nunitoStyle,
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
                                                                    style:
                                                                        nunitoStyle,
                                                                  ),
                                                                  Text(
                                                                    state
                                                                            .ourresponse
                                                                            .result![0]
                                                                            .players![i]
                                                                            .playerRedCards ??
                                                                        "",
                                                                    style:
                                                                        nunitoStyle,
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
                                                                    style:
                                                                        nunitoStyle,
                                                                  ),
                                                                  Text(
                                                                    state
                                                                            .ourresponse
                                                                            .result![0]
                                                                            .players![i]
                                                                            .playerGoals ??
                                                                        "",
                                                                    style:
                                                                        nunitoStyle,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ]),
                                                      actions: [
                                                        Center(
                                                          child: SizedBox(
                                                            width: screensize
                                                                    .width *
                                                                0.3,
                                                            child:
                                                                ElevatedButton(
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
                                                                style:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontSize:
                                                                      16.sp,
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
                                                    : ScreenUtil()
                                                            .screenHeight *
                                                        0.06,
                                                child: CachedNetworkImage(
                                                  imageUrl: state
                                                      .ourresponse
                                                      .result![0]
                                                      .players![i]
                                                      .playerImage!,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
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
                                                              .playerName ??
                                                          "",
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 18.sp,
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
                                                                  .ourresponse
                                                                  .result![0]
                                                                  .players![i]
                                                                  .playerType ??
                                                              "",
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
                                        ));
                                  }
                                  return null;
                                }),
                          )
                        else if (state is PlayersOne &&
                            state.ourresponse1.result != null)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white60,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 9, 113, 134),
                                  radius: ScreenUtil().orientation ==
                                          Orientation.landscape
                                      ? ScreenUtil().screenWidth * 0.05
                                      : ScreenUtil().screenHeight * 0.06,
                                  child: CachedNetworkImage(
                                    imageUrl: state
                                        .ourresponse1.result![0].playerImage!,
                                    imageBuilder: (context, imageProvider) =>
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
                                    errorWidget: (context, url, error) =>
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
                                        state.ourresponse1.result![0]
                                                .playerName ??
                                            "",
                                        style: GoogleFonts.nunito(
                                          fontSize: 18.sp,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
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
                                                " ",
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
                          )
                        else if (searchPlayer.text != "")
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
