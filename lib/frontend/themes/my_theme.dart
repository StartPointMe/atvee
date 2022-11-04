import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  final double _smallSize = 16;
  final double _smSize = 20;
  final double _mediumSize = 24;
  final double _largeSize = 32;

  final Color _lightGreen = const Color.fromARGB(255, 0, 141, 49);
  final Color _darkGreen = const Color.fromARGB(255, 59, 82, 67);
  final Color _white = Colors.white;
  final Color _black = Colors.black;

  ThemeData appTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _darkGreen,
      primaryColorLight: _lightGreen,
      backgroundColor: _white,
      textTheme: TextTheme(
        headline1: GoogleFonts.anton(
            fontSize: _largeSize, color: _white, fontStyle: FontStyle.italic),
        headline2: GoogleFonts.anton(fontSize: _smallSize, color: _darkGreen),
        subtitle1: GoogleFonts.anton(fontSize: _smSize, color: _white),
        subtitle2: GoogleFonts.anton(fontSize: _smSize, color: _darkGreen),
        bodyText1: GoogleFonts.anton(fontSize: _smSize, color: _white),
        bodyText2: GoogleFonts.anton(
            fontSize: _smallSize,
            color: _lightGreen,
            fontWeight: FontWeight.normal),
        button: GoogleFonts.anton(
            fontSize: _largeSize, color: _white, fontStyle: FontStyle.italic),
      ),
      inputDecorationTheme: _getInputTheme(),
      appBarTheme: _getAppBarTheme(),
      elevatedButtonTheme: _getButtonTheme(),
    );
  }

  AppBarTheme _getAppBarTheme() => AppBarTheme(
        backgroundColor: _darkGreen,
        centerTitle: true,
        titleTextStyle: GoogleFonts.anton(
            fontSize: _largeSize,
            color: Colors.white,
            fontStyle: FontStyle.italic),
      );

  InputDecorationTheme _getInputTheme() => InputDecorationTheme(
        hintStyle: TextStyle(fontSize: _smallSize, color: _darkGreen),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 3,
        ),
        filled: true,
        fillColor: _white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 3,
          borderSide: BorderSide(color: _darkGreen, width: 2),
        ),
        labelStyle: TextStyle(
            fontSize: _smSize,
            color: _darkGreen,
            fontWeight: FontWeight.normal),
        floatingLabelStyle: TextStyle(
            fontSize: _largeSize,
            color: _lightGreen,
            fontWeight: FontWeight.bold),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 3,
          borderSide: BorderSide(color: _lightGreen, width: 3),
        ),
      );

  ElevatedButtonThemeData _getButtonTheme() => ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_darkGreen),
          fixedSize: MaterialStateProperty.all<Size>(const Size(170, 50)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
}
