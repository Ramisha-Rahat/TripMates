import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF00796B),
    secondary: Color(0xFF2E9572),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFEFF6EE),
  ),
  scaffoldBackgroundColor: Color(0xFFEFF6EE), // Set scaffold background color
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF00796B),
    foregroundColor: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF00796B),
    textTheme: ButtonTextTheme.primary,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF00796B),
    secondary: Color(0xFF88CA73),
    surface: Color(0xFF1E1E1E), // Darker color for card backgrounds
    background: Color(0xFF121212), // Dark mode background color
  ),
  scaffoldBackgroundColor: Color(0xFF121212), // Set scaffold background color
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF00796B),
    foregroundColor: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF2E9572), // Button color for dark mode
    textTheme: ButtonTextTheme.primary,
  ),
);
