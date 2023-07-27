import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_zone/screens/countries_screen.dart';

class CardCategory extends StatelessWidget {
  final String images;
  final String sportName;
  final String brief;

  const CardCategory({
    Key? key,
    required this.images,
    required this.sportName,
    required this.brief,
  }) : super(key: key);

  void showTextDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notice'),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (sportName == 'Football') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CountriesScreen(),
            ),
          );
        } else {
          showTextDialog(context, 'Coming Soon');
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        images,
                        width: 80,
                        height: 80,
                      ),
                      Text(
                        sportName,
                        style: GoogleFonts.quicksand(
                          fontSize: 21,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        textAlign: TextAlign.center,
                        brief,
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
