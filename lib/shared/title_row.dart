import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final Color textColor;
  const TitleRow({super.key, required this.title, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: 17.sp,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Icon(Icons.arrow_circle_right_outlined, color: textColor, size: 20.sp)
      ],
    );
  }
}
