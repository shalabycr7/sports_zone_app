import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_zone/screens/countres_screen.dart';

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
              builder: (context) => const MySports(),
            ),
          );
        } else {
          showTextDialog(context, 'Coming Soon');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                images,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                sportName,
                style: GoogleFonts.quicksand(
                  fontSize: 21,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  brief,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
