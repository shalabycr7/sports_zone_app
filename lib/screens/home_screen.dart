import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_zone/styles/gradient_decoration.dart';
import 'package:sports_zone/widgets/card_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: blueGradient,
        ),
        Positioned(
          left: 20,
          top: 75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Select your favourite sport",
                    style: GoogleFonts.quicksand(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 22,
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 245, 240, 252),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                CardCategory(
                  images: "assets/images/football_badge.jpg",
                  testName: "Football",
                  brief:
                      "cover topics such as cell structure and function, genetics, ecology",
                ),
                CardCategory(
                  images: "assets/images/football_badge.jpg",
                  testName: "Tennis",
                  brief:
                      "cover topics such as cell structure and function, genetics, ecology",
                ),
                CardCategory(
                  images: "assets/images/football_badge.jpg",
                  testName: "Basketball",
                  brief:
                      "cover topics such as cell structure and function, genetics, ecology",
                ),
                CardCategory(
                  images: "assets/images/football_badge.jpg",
                  testName: "Cricket",
                  brief:
                      "cover topics such as cell structure and function, genetics, ecology",
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
