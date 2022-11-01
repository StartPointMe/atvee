import 'package:flutter/material.dart';

class MyTheme {
  final Color _darkGreen = const Color.fromARGB(255, 59, 82, 67);

  ThemeData appTheme() {
    return ThemeData(
      elevatedButtonTheme: _getButtonTheme(),
    );
  }

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
