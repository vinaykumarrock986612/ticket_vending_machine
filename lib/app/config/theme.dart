import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import 'app_colors.dart';

ThemeData lightTheme() {
  final colorScheme = ColorScheme.light(
    primary: lightColors.primary,
  );
  return themeStyle(
    ThemeData(
      scaffoldBackgroundColor: lightColors.background,
      colorScheme: colorScheme,
      fontFamily: AppFonts.primaryFamily,
    ),
  );
}

ThemeData themeStyle(ThemeData data) {
  final colorScheme = data.colorScheme;

  return data.copyWith(
    colorScheme: colorScheme,
    textTheme: data.textTheme.copyWith(
      titleMedium: TextStyle(
        color: lightColors.primaryText,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
