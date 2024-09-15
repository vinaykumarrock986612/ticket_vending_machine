import 'package:flutter/material.dart';

ThemeData lightTheme() {
  final colorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.teal,
  );
  return themeStyle(
    ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      colorScheme: colorScheme,
    ),
  );
}


ThemeData themeStyle(ThemeData data) {
  final colorScheme = data.colorScheme;

  return data.copyWith(
    colorScheme: colorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const StadiumBorder(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        shape: const StadiumBorder(),
      ),
    ),
    listTileTheme: ListTileThemeData(
      style: ListTileStyle.list,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: colorScheme.surface,
      selectedColor: colorScheme.onPrimary,
      selectedTileColor: colorScheme.primary,
    ),
    visualDensity: VisualDensity.standard,
    shadowColor: const Color(0xFF868686),
  );
}
