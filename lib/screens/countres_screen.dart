import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_zone/data/cubits/countries_cubit/countires_cubit.dart';
import 'package:sports_zone/screens/Leagues_Screen.dart';
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
    return Scaffold(
        body: SafeArea(
      child: Container(
          decoration: blueGradient,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select the country",
                      style: GoogleFonts.quicksand(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(Icons.arrow_circle_right_outlined,
                        color: Colors.white, size: 22.sp)
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      height: ScreenUtil().screenHeight * 4 / 5,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(246, 241, 248, 1),
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
                                    ScreenUtil().screenWidth > 600 ? 4 : 2,
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
                                                  const LeaguesScreen(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                radius: ScreenUtil()
                                                            .orientation ==
                                                        Orientation.landscape
                                                    ? ScreenUtil().screenWidth *
                                                        0.05
                                                    : ScreenUtil()
                                                            .screenHeight *
                                                        0.06,
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      state
                                                              .ourresponse
                                                              .result![i]
                                                              .countryLogo ??
                                                          'https://th.bing.com/th?id=OIP.SxfHLBiDEPcSBV-ncmz7gQHaJR&w=223&h=279&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2'), //NetworkImage
                                                  radius: ScreenUtil()
                                                              .orientation ==
                                                          Orientation.landscape
                                                      ? ScreenUtil()
                                                              .screenWidth *
                                                          0.05
                                                      : ScreenUtil()
                                                              .screenHeight *
                                                          0.06,
                                                ), //CircleAvatar
                                              ),
                                              Text(
                                                state.ourresponse.result![i]
                                                        .countryName ??
                                                    'Unknown',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 13.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: Text('error'),
                              );
                            }
                          },
                        ),
                      ))),
            ],
          )),
    ));
  }
}
