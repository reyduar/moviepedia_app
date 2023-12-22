import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkmode;

  AppTheme({this.isDarkmode = true});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: isDarkmode ? Colors.white : Colors.black,
      );

  AppTheme copyWith({bool? isDarkmode}) {
    return AppTheme(
      isDarkmode: isDarkmode ?? this.isDarkmode,
    );
  }
}
