// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/main.dart';
import 'package:sizer/sizer.dart';

class FontStyles {
  final headingFont = GoogleFonts.roboto(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: appColors.whiteColor,
  );
  final titleFont = GoogleFonts.roboto(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: appColors.whiteColor,
  );
  final bodyFont = GoogleFonts.roboto(
    fontSize: 14.sp,
    color: appColors.whiteColor,
  );

  final smallBodyFont = GoogleFonts.roboto(
    fontSize: 10.sp,
    color: appColors.whiteColor,
  );
}
