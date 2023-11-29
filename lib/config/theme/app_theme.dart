import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF6200EE),
          secondary: Color(0xFF03DAC6),
          surface: Color(0xFF121212),
          background: Color(0xFF121212),
          error: Color(0xFFB00020),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF000000),
          onSurface: Color(0xFFFFFFFF),
          onBackground: Color(0xFFFFFFFF),
          onError: Color(0xFF000000),
          brightness: Brightness.light,
        ),
      );
}
