import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: const Color(0xFFB0D25A),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: const Color(0xFFEEEEEE),
  backgroundColor: const Color(0xFF24242A),
  buttonColor: const Color(0xFF3AA348),
  bottomAppBarColor: const Color(0xFF181818),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      fontSize: 36,
      fontStyle: FontStyle.italic,
    ),
    bodyText1: TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    fillColor: Colors.white,
    filled: true,
  ),
  errorColor: Colors.red,
);
