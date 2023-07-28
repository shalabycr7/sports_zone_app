import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/cubits/cubit/cubit/players_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PlayersCubit>().getcc();
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(child: BlocBuilder<PlayersCubit, PlayersState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state is Contry)
                for (int i = 0; i < state.ourresponse1.result!.length; i++)
                  Card(
                                        color: Colors.white,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        elevation: 0.0,
                                        child: Container(
                                          width: screensize.width * 0.5,
                                          height: screensize.height * (1 / 6),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    // Set the background color
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      image: DecorationImage(
                                                        image: NetworkImage(state
                                                                .ourresponse1
                                                                .result![
                                                                   i]
                                                               .countryLogo ??
                                                            "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Fdefault-avatar&psig=AOvVaw0vcnDtA5xmd5z-R8_-1nbk&ust=1690578954109000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMjyxcbnr4ADFQAAAAAdAAAAABAE"),
                                                        fit: BoxFit.cover,
                                                        onError: (exception,
                                                            stackTrace) {
                                                          // Handle image loading error
                                                          AssetImage(
                                                              'assets/images/pngwing.com.png');
                                                        },
                                                      ),
                                                      // Set the container background color
                                                      // Set the border radius
                                                    ),
                                                    padding: EdgeInsets.all(
                                                        10), // Add some padding
                                                    width: screensize.width *
                                                        (1 / 4),
                                                    height: screensize.width *
                                                        (1 /
                                                            4), // Set the width
                                                    alignment: Alignment
                                                        .center, // Center the text horizontally
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
                                                         
                                                              "dd",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 21,
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
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                             
                                                                  "dsd",
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                fontSize: 14,
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
            ],
          );
        },
      )),
    );
  }
}
