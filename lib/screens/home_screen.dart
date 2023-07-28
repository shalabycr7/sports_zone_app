import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_zone/styles/gradient_decoration.dart';
import 'package:sports_zone/widgets/card_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _saveAlreadySeen();
  }

  Future<void> _saveAlreadySeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alreadySeen', true);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: blueGradient,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.04,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select your favourite sport",
                    style: GoogleFonts.quicksand(
                      fontSize: screenHeight * 0.024,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: screenHeight * 0.03,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.04,
                ),
                width: screenWidth,
                height: screenHeight * 0.85,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 240, 252),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: GridView.count(
                  crossAxisCount: screenWidth > 600 ? 4 : 2,
                  crossAxisSpacing: screenWidth * 0.04,
                  mainAxisSpacing: screenWidth * 0.04,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
