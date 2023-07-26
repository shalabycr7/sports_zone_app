import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardCategory extends StatelessWidget {
  final String images;
  final String testName;
  final String? brief;

  CardCategory({
    Key? key,
    required this.images,
    required this.testName,
    this.brief,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        images,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        testName,
                        style: GoogleFonts.quicksand(
                          fontSize: 21,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        brief!,
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
