import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_zone/data/cubits/countries_cubit/countires_cubit.dart';
import 'package:sports_zone/screens/leagues_Screen.dart';
import 'package:sports_zone/shared/title_row.dart';
import 'package:sports_zone/styles/gradient_decoration.dart';

class MySports extends StatefulWidget {
  const MySports({super.key});

  @override
  State<MySports> createState() => _MySportsState();
}

class _MySportsState extends State<MySports> {
  @override
  void initState() {
    super.initState();
    context.read<CountiresCubit>().getCountiers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              color: Color.fromARGB(255, 9, 113, 134),
              child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.all(20),
                      child: TitleRow(
                        title: 'Select the country',
                        textColor: Colors.white,
                      )),
                  Expanded(
                      child: Container(
                          height: ScreenUtil().screenHeight * 4 / 5,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 245, 245, 245),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                          ),
                          width: ScreenUtil().screenWidth,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().screenWidth * 0.05,
                                vertical: ScreenUtil().screenWidth * 0.04),
                            child: BlocBuilder<CountiresCubit, CountiresState>(
                              builder: (context, state) {
                                if (state is CountiresLoadind) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is CountiresSussess) {
                                  return GridView.count(
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
                                    children: <Widget>[
                                      for (int i = 0;
                                          i < state.ourresponse.result!.length;
                                          i++)
                                        if (state.ourresponse.result![i]
                                                .countryLogo !=
                                            null)
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LeaguesScreen(
                                                          loop: state
                                                              .ourresponse
                                                              .result![i]
                                                              .countryKey!),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: Colors.white60,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 9, 113, 134),
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
                                                    child: CachedNetworkImage(
                                                      imageUrl: state
                                                              .ourresponse
                                                              .result![i]
                                                              .countryLogo ??
                                                          'https://th.bing.com/th/id/R.067f7bad1bf48631ec7743ac1dec086f?rik=23KOzvBuYTRJPA&riu=http%3a%2f%2fimg1.wikia.nocookie.net%2f__cb20110529184849%2fusnw%2fimages%2f8%2f8b%2fPlaceholder_flag.png&ehk=ePhmjTY3X4FCyT2lCetvagb6l0lD%2bSs%2ftLmtrmf3cn4%3d&risl=&pid=ImgRaw&r=0',
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          const CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.network(
                                                              'https://th.bing.com/th/id/R.067f7bad1bf48631ec7743ac1dec086f?rik=23KOzvBuYTRJPA&riu=http%3a%2f%2fimg1.wikia.nocookie.net%2f__cb20110529184849%2fusnw%2fimages%2f8%2f8b%2fPlaceholder_flag.png&ehk=ePhmjTY3X4FCyT2lCetvagb6l0lD%2bSs%2ftLmtrmf3cn4%3d&risl=&pid=ImgRaw&r=0'),
                                                    ),
                                                  ),
                                                  Text(
                                                    state.ourresponse.result![i]
                                                            .countryName ??
                                                        'Unknown',
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontSize: 13.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    ],
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
              ))),
    );
  }
}
