import 'package:flutter/material.dart';

import '../config/app_colors.dart';

extension NumX on num {
  double get invertSign => this * -1;
}

extension ThemeDataX on ThemeData {
  AppColors get colors => lightColors;


}
