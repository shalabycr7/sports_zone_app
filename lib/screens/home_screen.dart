import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_zone/global/categories_data.dart';
import 'package:sports_zone/shared/title_row.dart';
import 'package:sports_zone/styles/styles_variables.dart';
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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveAlreadySeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alreadySeen', true);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtil().screenWidth;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: primaryColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                child: const TitleRow(
                  title: 'Select your favourite sport',
                  textColor: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  height: (4 / 5).sh,
                  decoration: BoxDecoration(
                    color: secondryColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  width: screenWidth,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenWidth * 0.04,
                    ),
                    child: GridView.count(
                      crossAxisCount: screenWidth > 600 &&
                              ScreenUtil().orientation == Orientation.landscape
                          ? 4
                          : 2,
                      crossAxisSpacing: screenWidth * 0.04,
                      mainAxisSpacing: screenWidth * 0.04,
                      children: [
                        for (int i = 0; i < categoriesImages.length; i++)
                          CardCategory(
                            images: categoriesImages[i],
                            sportName: categoriesTitle[i],
                            brief: categoriesSub[i],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
