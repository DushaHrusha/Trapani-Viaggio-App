import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Inter',
      brightness: Brightness.light,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontFamily: 'Inter'),
        bodyMedium: TextStyle(fontFamily: 'Inter'),
        bodySmall: TextStyle(fontFamily: 'Inter'),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'Inter',
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontFamily: 'Inter'),
        bodyMedium: TextStyle(fontFamily: 'Inter'),
        bodySmall: TextStyle(fontFamily: 'Inter'),
      ),
    );
  }
}
