import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_zone/shared/title_row.dart';
import 'package:sports_zone/styles/gradient_decoration.dart';
import 'package:sports_zone/widgets/card_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _saveAlreadySeen();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveAlreadySeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alreadySeen', true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Select Your Favourate Sport',
                        style: GoogleFonts.nunito(
                            color: Colors.blueGrey,
                            fontSize: 30,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: Container(
                        height: ScreenUtil().screenHeight * 4 / 5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 10.0,
                              blurRadius: 10.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        width: ScreenUtil().screenWidth,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().screenWidth * 0.05,
                              vertical: ScreenUtil().screenWidth * 0.04),
                          child: GridView.count(
                            crossAxisCount: ScreenUtil().screenWidth > 600 &&
                                    ScreenUtil().orientation ==
                                        Orientation.landscape
                                ? 4
                                : 2,
                            crossAxisSpacing: ScreenUtil().screenWidth * 0.04,
                            mainAxisSpacing: ScreenUtil().screenWidth * 0.04,
                            children: const [
                              CardCategory(
                                images: "assets/images/football_badge.png",
                                sportName: "Football",
                                brief: "cover all football leagaues",
                              ),
                              CardCategory(
                                images: "assets/images/tennis_badge.png",
                                sportName: "Tennis",
                                brief: "cover all tennis championships",
                              ),
                              CardCategory(
                                images: "assets/images/basketball_badge.png",
                                sportName: "Basketball",
                                brief: "cover all basketball teams",
                              ),
                              CardCategory(
                                images: "assets/images/cricket_badge.png",
                                sportName: "Cricket",
                                brief: "cover all cricket tournaments",
                              ),
                            ],
                          ),
                        )),
                  )),
                ],
              ))),
    );
  }
}
