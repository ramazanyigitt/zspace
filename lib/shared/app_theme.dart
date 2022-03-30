import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static AppTheme? _instance;

  AppTheme._();

  factory AppTheme() => _instance ??= AppTheme._();

  final primaryBlueColor = Color.fromARGB(255, 42, 75, 160);
  final primaryDarkBlueColor = Color.fromARGB(255, 21, 48, 117);
  final primaryColor = Color.fromARGB(255, 25, 202, 106);
  final darkPrimaryColor = Color.fromARGB(255, 15, 163, 83);
  final secondaryColor = Color.fromARGB(255, 252, 134, 90);
  final accentFirstColor = Color.fromARGB(255, 255, 212, 103);
  final accentSecondColor = Color.fromARGB(255, 77, 99, 34);
  final blackColor = Color.fromARGB(255, 55, 59, 66);
  final greyScale0 = Color.fromARGB(255, 30, 34, 43);
  final greyScale1 = Color.alphaBlend(
      Color.fromRGBO(0, 0, 0, 0.20), Color.fromARGB(255, 62, 69, 84));
  final greyScale2 = Color.fromARGB(255, 97, 106, 125);
  final greyScale3 = Color.fromARGB(255, 136, 145, 165);
  final greyScale4 = Color.fromARGB(255, 178, 187, 206);
  final greyScale5 = Color.fromARGB(255, 248, 249, 251);
  final greyScale6 = Color.fromARGB(255, 250, 251, 253);
  final lightBlueColor = Color.fromARGB(255, 209, 231, 237);
  final whiteColor = Color.fromARGB(255, 255, 255, 255);
  final bgColor = Color.fromARGB(255, 255, 255, 255);
  final gradientPrimary = LinearGradient(
    colors: [
      Color.fromARGB(255, 15, 163, 83).withOpacity(0.85),
      Color.fromARGB(255, 15, 163, 83).withOpacity(0.9),
      Color.fromARGB(255, 15, 163, 83).withOpacity(1),
    ],
  );

  final headingText = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
  final largeParagraphBoldText = GoogleFonts.inter(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  final paragraphBoldText = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  final paragraphSemiBoldText = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  final paragraphRegularText = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  final buttonText = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  final smallParagraphSemiBoldText = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
  final smallParagraphRegularText = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );
  final smallParagraphMediumText = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
  final extraSmallParagraphSemiBoldText = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
  final extraSmallParagraphRegularText = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  final extraSmallParagraphMediumText = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
}
