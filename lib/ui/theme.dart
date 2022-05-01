// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

Color selectionColor = const Color.fromARGB(255, 23, 197, 224);

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    titleLarge: GoogleFonts.montserrat(
      fontSize: 40.0,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    labelLarge: GoogleFonts.montserrat(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    labelMedium: GoogleFonts.montserrat(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    titleLarge: GoogleFonts.montserrat(
      fontSize: 40.0,
      fontWeight: FontWeight.w200,
      color: Colors.white,
    ),
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    labelLarge: GoogleFonts.montserrat(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.montserrat(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme:
          CheckboxThemeData(fillColor: MaterialStateColor.resolveWith((states) {
        return Colors.black;
      })),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: lightTextTheme,
      primaryColor: Color.fromARGB(23, 0, 0, 0),
      useMaterial3: true,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
      primaryColor: Color.fromARGB(24, 255, 255, 255),
      useMaterial3: true,
    );
  }
}
