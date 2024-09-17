import 'package:flutter/material.dart';

import '../utils/app_extensions.dart';
import 'app_inkwell.dart';
import 'base_widgets.dart';
import 'fixed_cross_axis_count_builder.dart';

class AppNumPad extends StatefulWidget {
  final TextEditingController controller;
  final int? maxLength;

  const AppNumPad({
    super.key,
    required this.controller,
    this.maxLength,
  });

  @override
  State<AppNumPad> createState() => _AppNumPadState();
}

class _AppNumPadState extends BaseState<AppNumPad> {
  final numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

  void onTap(String value) {
    if (widget.maxLength != null && widget.controller.text.length >= widget.maxLength!) return;


    widget.controller.text += value;
  }

  @override
  Widget build(BuildContext context) {
    return FixedCrossAxisCountBuilder(
      crossAxisCount: 3,
      itemCount: numbers.length,
      itemBuilder: (context, index) => button(numbers[index]),
      spacing: 10,
    );
  }

  Widget button(String value) {
    return AppInkWell(
      onTap: () => onTap(value),
      child: Container(
        height: 74,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.colors.tertiaryBackground,
          shape: BoxShape.circle,
        ),
        child: Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
