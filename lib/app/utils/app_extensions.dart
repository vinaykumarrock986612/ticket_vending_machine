import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/app_colors.dart';

extension NumX on num {
  double get invertSign => this * -1;
}

extension ThemeDataX on ThemeData {
  AppColors get colors => lightColors;
}

extension DateTimeX on DateTime {
  String format(String type) {
    final formatter = DateFormat(type);
    return formatter.format(this);
  }
}
