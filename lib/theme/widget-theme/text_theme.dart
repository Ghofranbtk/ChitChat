import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class TTextTheme {
  //Mobile

  static TextTheme mobileTextTheme = TextTheme(
    headline1: GoogleFonts.plusJakartaSans(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline2: GoogleFonts.plusJakartaSans(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline3: GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline4: GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline5: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: kDarkBlueColor,
    ),
    headline6: GoogleFonts.plusJakartaSans(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: kDarkBlueColor,
    ),
    bodyText1: GoogleFonts.plusJakartaSans(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: kDarkBlueColor,
    ),
    bodyText2: GoogleFonts.plusJakartaSans(
      fontSize: 11,
      fontWeight: FontWeight.normal,
      color: kDarkBlueColor.withOpacity(0.7),
    ),
  );
}
