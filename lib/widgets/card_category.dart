import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: Image.asset(
                images,
              ),
            ),
            Text(
              sportName,
              style: GoogleFonts.quicksand(
                fontSize: 17.sp,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  brief,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
