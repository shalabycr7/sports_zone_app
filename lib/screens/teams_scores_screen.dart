import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_zone/screens/players_screen.dart';

import '../data/cubits/cubit/teams_scores_cubit.dart';
import '../main.dart';

final TextEditingController Search = TextEditingController();

class TeamsScoresScreen extends StatefulWidget {
  const TeamsScoresScreen({super.key});

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
class _TeamsScoresScreen extends State<TeamsScoresScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TeamsScoresCubit>().getTeam();
  }

  @override
  Widget build(BuildContext context) {
    String text = 'Teams', tt = 'TopScorers';
    String uppercaseText = text.toUpperCase(), t1 = tt.toUpperCase();
    var screensize = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocBuilder<TeamsScoresCubit, TeamsScoresState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 75.0,
              actions: <Widget>[
                Container(
                    width: screensize.width * 0.5,
                    height: 75,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<TeamsScoresCubit>().getTeam();
                          },
                          style: ElevatedButton.styleFrom(
                            // blue grey
                            primary: (state is TeamsScoresTeams)
                                ? Colors.blueGrey
                                : Color.fromARGB(255, 197, 194, 194),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ), // Background color
                          ),
                          child: Text(
                            uppercaseText,
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: (state is TeamsScoresTeams)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )),
                    )),
                Container(
                    width: screensize.width * 0.5,
                    height: 75,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: (state is TeamsScoresTopScorers)
                                ? Colors.blueGrey
                                : Color.fromARGB(255, 197, 194, 194),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ), // Background color
                          ),
                          onPressed: () {
                            context.read<TeamsScoresCubit>().getTopScorers();
                          },
                          child: Text(
                            t1,
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: (state is TeamsScoresTopScorers)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )),
                    )),
              ],
            ),
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
                      child: Container(
                          width: screensize.width * 0.96,
                          height: screensize.height * 0.84,
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
                          ), // TeamsScoresCubit TeamsScoresState
                          /*ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {*/

                          child: Column(
                            children: [
                              if (state is TeamsScoresTeams)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: screensize.width * (296 / 375),
                                    height: screensize.height * (42 / 812),
                                    child: TextFormField(
                                      controller: Search,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: BorderSide(
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
                                          fontSize: 12,
                                          //fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 197, 194, 194),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.search),
                                          color: Color.fromARGB(
                                              255, 197, 194, 194),
                                          iconSize: 18,
                                          onPressed: () {
                                            if (Search.text != "")
                                              context
                                                  .read<TeamsScoresCubit>()
                                                  .getTeam();
                                            else
                                              context
                                                  .read<TeamsScoresCubit>()
                                                  .getTeam();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (state is TeamsScoresTeams)
                                Expanded(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 8.0,
                                    children: List.generate(
                                      state.ourresponse.result!.length,
                                      (index) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: InkWell(
                                              onTap: () {
                                                print(index);
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
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10), // Set the desired border radius value
                                                  ),
                                                  // Color.fromRGBO(246, 241, 248, 1)

                                                  child: Center(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          3.0),
                                                                  child: Image
                                                                      .network(
                                                                    state
                                                                        .ourresponse
                                                                        .result![
                                                                            index]
                                                                        .teamLogo!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ))),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3.0),
                                                            child: Text(
                                                              state
                                                                  .ourresponse
                                                                  .result![
                                                                      index]
                                                                  .teamName!,
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                fontSize: 15,
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
                                      },
                                    ),
                                  ),
                                )
                              else if (state is TeamsScoresTopScorers &&
                                  state.response.result != null)
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
                                                    screensize.height * (1 / 7),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        ClipOval(
                                                          child: Container(
                                                            // Set the background color
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .blueGrey, // Set the container background color
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      //screensize .width * (1 /16)
                                                                      30), // Set the border radius
                                                            ),
                                                            padding: EdgeInsets.all(
                                                                10), // Add some padding
                                                            width: screensize
                                                                    .width *
                                                                (1 / 4),
                                                            /*  height: screensize
                                                                    .width *
                                                                (1 /
                                                                    8),*/ // Set the width
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
                                                                        .playerName ??
                                                                    "",
                                                                style:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontSize: 21,
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
                                                                          14,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    state
                                                                            .response
                                                                            .result[i]
                                                                            .teamName ??
                                                                        "",
                                                                    style: GoogleFonts
                                                                        .nunito(
                                                                      fontSize:
                                                                          14,
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
                                            Text("shshs"),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                            ],
                          )),
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
