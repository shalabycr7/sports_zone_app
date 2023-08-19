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
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _saveAlreadySeen();
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                child: const TitleRow(
                  title: 'Select your favourite sport',
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
                        (index) => FadeTransition(
                          opacity: _animation,
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
