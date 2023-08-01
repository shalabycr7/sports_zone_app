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
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _saveAlreadySeen();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
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
    final crossAxisCount =
        screenWidth > 600 && ScreenUtil().orientation == Orientation.landscape
            ? 4
            : 2;

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
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenWidth * 0.04,
                    ),
                    child: GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: screenWidth * 0.04,
                      mainAxisSpacing: screenWidth * 0.04,
                      childAspectRatio: 1.0,
                      children: List.generate(
                        categoriesImages.length,
                        (index) => SlideTransition(
                          position: _animation,
                          child: CardCategory(
                            images: categoriesImages[index],
                            sportName: categoriesTitle[index],
                            brief: categoriesSub[index],
                          ),
                        ),
                      ),
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
