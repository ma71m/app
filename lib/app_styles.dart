import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFFFFA500); // Orange
  static const Color secondaryColor = Color(0xFF686D76); // Grey
  static const Color darkOrange = Color(0xFFFF8F00); // Dark Orange
  static const Color lightGrey = Color(0xFFe0e0e0); // Light Grey
  static const Color white = Color(0xFFFFFFFF); // White
  static const Color black1 = Color(0xFF373A40); // Black

  static final TextStyle primaryFont = GoogleFonts.changaOne(
    fontWeight: FontWeight.w400,
    color: const Color(0xFF373A40),
  );

  static final TextStyle secondaryFont = GoogleFonts.bubblegumSans(
    fontWeight: FontWeight.w600,
    color: const Color(0xFF373A40),
  );

  static final TextStyle dealCardTitle = GoogleFonts.changaOne(
    fontWeight: FontWeight.w400,
    color: const Color(0xFF373A40),
    fontSize: 28,
  );

  static final TextStyle dealCardPrice = GoogleFonts.changaOne(
    fontWeight: FontWeight.w400,
    color: const Color(0xFF373A40),
    fontSize: 25,
  );

  static final TextStyle dealDetailTitle = GoogleFonts.bubblegumSans(
    fontWeight: FontWeight.bold,
    color: const Color(0xFF373A40),
    fontSize: 24,
  );

  static final TextStyle dealDetailDescription = GoogleFonts.bubblegumSans(
    fontWeight: FontWeight.w400,
    color: const Color(0xFF373A40),
    fontSize: 16,
  );

  static final TextStyle dealDetailPrice = GoogleFonts.bubblegumSans(
    fontWeight: FontWeight.bold,
    color: const Color(0xFF373A40),
    fontSize: 28,
  );

  static final TextStyle userProfileName = GoogleFonts.changaOne(
    fontWeight: FontWeight.w500,
    color: const Color(0xFF373A40),
    fontSize: 20,
  );

  static final TextStyle userProfileEmail = GoogleFonts.changaOne(
    fontWeight: FontWeight.w400,
    color: const Color(0xFF373A40),
    fontSize: 16,
  );

  static final TextStyle orderHistoryTitle = GoogleFonts.bubblegumSans(
    fontWeight: FontWeight.w500,
    color: darkOrange,
    fontSize: 18,
  );

  static final TextStyle orderHistoryPrice = GoogleFonts.bubblegumSans(
    fontWeight: FontWeight.bold,
    color: const Color(0xFF373A40),
    fontSize: 16,
  );

  static final TextStyle dealCardFrontPrice = GoogleFonts.bubblegumSans(
    fontWeight: FontWeight.bold,
    color: const Color(0xFF373A40),
    fontSize: 16,
  );
}
