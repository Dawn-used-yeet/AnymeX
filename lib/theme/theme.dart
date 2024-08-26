import 'package:flutter/material.dart';

final Color seedColor = Colors.indigo;

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
    bodySmall: TextStyle(color: Colors.white, fontSize: 12),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade300,
    hintStyle: TextStyle(color: Colors.grey.shade600),
    prefixIconColor: Colors.grey.shade700,
    suffixIconColor: Colors.grey.shade700,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: seedColor,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: seedColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black, // Default icon color for light mode
    size: 24, // Default icon size
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: seedColor,
    foregroundColor: Colors.white,
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(color: Colors.grey, fontSize: 12), // Updated to a lighter color
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade900,
    hintStyle: TextStyle(color: Colors.grey.shade400),
    prefixIconColor: Colors.grey.shade500,
    suffixIconColor: Colors.grey.shade500,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: seedColor,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: seedColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white, 
    size: 24, 
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: seedColor,
    foregroundColor: Colors.white,
  ),
);
