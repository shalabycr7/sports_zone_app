import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_zone/data/cubits/countries_cubit/countires_cubit.dart';
import 'package:sports_zone/screens/leagues_Screen.dart';
import 'package:sports_zone/shared/title_row.dart';
import 'package:sports_zone/styles/styles_variables.dart';

class MySports extends StatefulWidget {
  const MySports({super.key});

  @override
  State<MySports> createState() => _MySportsState();
}

class _MySportsState extends State<MySports> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Future<void> _refreshData() async {
    await context.read<CountiresCubit>().getCountiers();
  }

  Widget _buildGridView(var countries) {
    return GridView.count(
      crossAxisCount: ScreenUtil().screenWidth > 600 &&
              ScreenUtil().orientation == Orientation.landscape
          ? 4
          : 2,
      crossAxisSpacing: ScreenUtil().screenWidth * 0.04,
      mainAxisSpacing: ScreenUtil().screenWidth * 0.04,
      children: <Widget>[
        for (var country in countries)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LeaguesScreen(countryId: country.countryKey!),
                ),
              );
            },
            child: FadeTransition(
              opacity: _animation,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: ScreenUtil().orientation == Orientation.landscape
                          ? ScreenUtil().screenWidth * 0.05
                          : ScreenUtil().screenHeight * 0.06,
                      child: CachedNetworkImage(
                        imageUrl: country.countryLogo ??
                            'https://th.bing.com/th/id/R.067f7bad1bf48631ec7743ac1dec086f?rik=23KOzvBuYTRJPA&riu=http%3a%2f%2fimg1.wikia.nocookie.net%2f__cb20110529184849%2fusnw%2fimages%2f8%2f8b%2fPlaceholder_flag.png&ehk=ePhmjTY3X4FCyT2lCetvagb6l0lD%2bSs%2ftLmtrmf3cn4%3d&risl=&pid=ImgRaw&r=0',
                        imageBuilder: (context, imageProvider) => Container(
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
                        errorWidget: (context, url, error) => Image.network(
                          'https://th.bing.com/th/id/R.067f7bad1bf48631ec7743ac1dec086f?rik=23KOzvBuYTRJPA&riu=http%3a%2f%2fimg1.wikia.nocookie.net%2f__cb20110529184849%2fusnw%2fimages%2f8%2f8b%2fPlaceholder_flag.png&ehk=ePhmjTY3X4FCyT2lCetvagb6l0lD%2bSs%2ftLmtrmf3cn4%3d&risl=&pid=ImgRaw&r=0',
                        ),
                      ),
                    ),
                    Text(
                      country.countryName ?? 'Unknown',
                      style: GoogleFonts.quicksand(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CountiresCubit>().getCountiers();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SafeArea(
            child: Container(
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 15.w),
                        child: const TitleRow(
                          title: 'Select the country',
                        )),
                    Expanded(
                        child: Container(
                            height: ScreenUtil().screenHeight * 4 / 5,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            width: ScreenUtil().screenWidth,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.05.sw,
                                vertical: 0.04.sw,
                              ),
                              child:
                                  BlocBuilder<CountiresCubit, CountiresState>(
                                builder: (context, state) {
                                  if (state is CountiresLoadind) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is CountiresSussess) {
                                    return _buildGridView(
                                        state.ourresponse.result);
                                  } else {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      ),
                                    );
                                  }
                                },
                              ),
                            ))),
                  ],
                )),
          ),
        ));
  }
}
