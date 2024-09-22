import 'package:flutter/material.dart';

const lightColors = AppColors(
  primary: Color(0xff3864FF),
  secondary: Color(0xff3A21D0),
  background: Color(0xffffffff),
  secondaryBackground: Color(0xffF4F4F4),
  tertiaryBackground: Color(0xffE7E7E7),
  cardBackground: Color(0xffEFEFEF),
  primaryText: Color(0xff232323),
  secondaryText: Color(0xff020202),
  tertiaryText: Color(0xffA4A4A4),
  iconColor: Color(0xffA4A4A4),
  border: Color(0xffE6E6E6),
);

class AppColors {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color secondaryBackground;
  final Color tertiaryBackground;
  final Color cardBackground;
  final Color primaryText;
  final Color secondaryText;
  final Color tertiaryText;
  final Color iconColor;
  final Color border;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.secondaryBackground,
    required this.tertiaryBackground,
    required this.cardBackground,
    required this.primaryText,
    required this.secondaryText,
    required this.tertiaryText,
    required this.iconColor,
    required this.border,
  });

  final gradient = const <Color>[
    Color(0x66FBFF32),
    Color(0x66FF60E5),
    Color(0x66359EFF),
  ];


  final machineColor = const Color(0xff2F2F2F);
  final greenScreen = const Color(0xff8AD367);
}
