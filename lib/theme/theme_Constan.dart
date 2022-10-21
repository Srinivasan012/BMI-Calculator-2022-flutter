import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color.fromARGB(255, 203, 202, 202),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.white,
    ));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color.fromARGB(255, 39, 2, 45));
